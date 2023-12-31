package com.assignments.ecomerce.controller;

import com.assignments.ecomerce.model.Category;
import com.assignments.ecomerce.model.Customer;
import com.assignments.ecomerce.model.Product;
import com.assignments.ecomerce.model.User;
import com.assignments.ecomerce.service.CustomerService;
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
import java.util.List;

@Controller
public class CustomerController {
    @Autowired
    UserDetailsService userDetailsService;
    @Autowired
    private CustomerService customerService;
    @GetMapping("/search-customer/{pageNo}")
    public String searchCustomer(@PathVariable("pageNo") int pageNo,
                                @RequestParam("keyword") String keyword,
                                Model model, Principal principal, HttpSession session) {

        Page<Customer> listCustomer = customerService.findByKeyword(pageNo, keyword);
        session.setAttribute("keyword", keyword);
        model.addAttribute("keyword", keyword);
        UserDetails userDetails = userDetailsService.loadUserByUsername(principal.getName());
        model.addAttribute("user", userDetails);
        model.addAttribute("size", listCustomer.getSize());
        model.addAttribute("listCustomer", listCustomer);
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", listCustomer.getTotalPages());
        model.addAttribute("customerNew", new Customer());
        return "customer";
    }

    @GetMapping("/search-customer-ByEmployee/{pageNo}")
    public String searchCustomerByEmployee(@PathVariable("pageNo") int pageNo,
                                 @RequestParam("keyword") String keyword,
                                 Model model, Principal principal, HttpSession session) {
        Page<Customer> listCustomer = customerService.findByKeyword(pageNo, keyword);
        session.setAttribute("keyword", keyword);
        model.addAttribute("keyword", keyword);
        model.addAttribute("size", listCustomer.getSize());
        model.addAttribute("listCustomer", listCustomer);
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", listCustomer.getTotalPages());
        UserDetails userDetails  = userDetailsService.loadUserByUsername(principal.getName());
        model.addAttribute("user", userDetails);
        model.addAttribute("customerNew", new Customer());
        return "CustomerManager";
    }

    @RequestMapping(value = "/block-customer", method = {RequestMethod.PUT, RequestMethod.GET})
    public String blockCustomer(Integer id, RedirectAttributes redirectAttributes, Principal principal) {
        try {
            customerService.blockCustomer(id);
            redirectAttributes.addFlashAttribute("success", "Enabled successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Enabled failed!");
        }
        return "redirect:/search-customer/0?keyword=";
    }

    @RequestMapping(value = "/unlock-customer", method = {RequestMethod.PUT, RequestMethod.GET})
    public String unlockCustomer(Integer id, RedirectAttributes redirectAttributes, Principal principal) {
        try {
            customerService.unlockCustomer(id);
            redirectAttributes.addFlashAttribute("success", "Enabled successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Enabled failed!");
        }
        return "redirect:/search-customer/0?keyword=";
    }
}
