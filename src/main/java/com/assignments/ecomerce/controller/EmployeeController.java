package com.assignments.ecomerce.controller;

import com.assignments.ecomerce.model.Category;
import com.assignments.ecomerce.model.Coupon;
import com.assignments.ecomerce.model.Customer;
import com.assignments.ecomerce.model.Employee;
import com.assignments.ecomerce.service.CustomerService;
import com.assignments.ecomerce.service.EmployeeService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
@Controller
public class EmployeeController {
    @Autowired
    UserDetailsService userDetailsService;
    @Autowired
    private EmployeeService employeeService;
    @GetMapping("/search-employee/{pageNo}")
    public String searchCustomer(@PathVariable("pageNo") int pageNo,
                                 @RequestParam("keyword") String keyword,
                                 Model model, Principal principal, HttpSession session) {

        Page<Employee> listEmployee = employeeService.searchEmployee(pageNo, keyword);
        UserDetails userDetails = userDetailsService.loadUserByUsername(principal.getName());
        model.addAttribute("user", userDetails);
        session.setAttribute("keyword", keyword);
        model.addAttribute("keyword", keyword);
        model.addAttribute("size", listEmployee.getSize());
        model.addAttribute("listEmployee", listEmployee);
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", listEmployee.getTotalPages());
        model.addAttribute("employeeNew", new Employee());
        return "employee";
    }

    @RequestMapping(value = "/findByIdEmployee/{id}", method = {RequestMethod.PUT, RequestMethod.GET})
    @ResponseBody
    public Employee findById(@PathVariable("id") Integer id){
        return employeeService.findById(id);
    }

    @GetMapping("/update-employee")
    public String update(Employee employee, RedirectAttributes attributes) {
        try {
            employeeService.update(employee);
            attributes.addFlashAttribute("success", "Updated successfully");
        } catch (DataIntegrityViolationException e) {
            e.printStackTrace();
            attributes.addFlashAttribute("failed", "Failed to update because duplicate name");
        } catch (Exception e) {
            e.printStackTrace();
            attributes.addFlashAttribute("failed", "Error server");
        }
        return "redirect:/search-employee/0?keyword=";
    }

    @RequestMapping(value = "/delete-employee", method = {RequestMethod.PUT, RequestMethod.GET})
    public String deletedProduct(Integer id, RedirectAttributes redirectAttributes, Principal principal) {
        try {
            employeeService.deleteById(id);
            redirectAttributes.addFlashAttribute("success", "Deleted successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Deleted failed!");
        }

        return "redirect:/search-employee/0?keyword=";
    }

    @PostMapping("/add-employee")
        public String add(@ModelAttribute("employeeNew") Employee employee,
                      Model model,
                      RedirectAttributes attributes) {
        try {
            Employee employee1 = employeeService.findByPhoneAndEmail(employee.getPhone(),employee.getEmail());
            if (employee1 == null) {
                employeeService.save(employee);
            } else if(employee1.getStatus() == 0){
                employeeService.updateStatus(employee1.getId());
            }else if(employee1.getStatus() == 1){
                attributes.addFlashAttribute("failed", "Tên Danh Mục Đã Tồn Tại Vui lòng nhập tên khác!");
                return "redirect:/search-employee/0?keyword=";
            }

            model.addAttribute("employeeNew", employee);
            attributes.addFlashAttribute("success", "Added successfully");
        } catch (DataIntegrityViolationException e1) {
            e1.printStackTrace();
            attributes.addFlashAttribute("failed", "Duplicate name of category, please check again!");
        } catch (Exception e2) {
            e2.printStackTrace();
            attributes.addFlashAttribute("failed", "Error Server");
        }
        return "redirect:/search-employee/0?keyword=";
    }
}
