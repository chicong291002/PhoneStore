package com.assignments.ecomerce.controller;

import com.assignments.ecomerce.model.*;
import com.assignments.ecomerce.service.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.List;
import java.util.Locale;

@Controller
public class ProductController {
    @Autowired
    UserDetailsService userDetailsService;
    @Autowired
    private ProductService productService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private ReviewService reviewService;
    @Autowired
    private UserService userService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private OrderService orderService;

    @PostMapping("/add-review")
    public String add(@ModelAttribute("reviewNew") Review review, Model model, RedirectAttributes attributes) {
        try {
            Review exists = reviewService.existsByCustomerIdAndProductId(review.getCustomer().getId(), review.getProduct().getId());
            if (exists != null) {
                attributes.addFlashAttribute("error", "Người dùng đã đánh giá không thể đánh giá sản phẩm nữa!");
                return "redirect:/product-details/" + review.getProduct().getId();
            }

            reviewService.save(review);
            model.addAttribute("reviewNew", review);
            attributes.addFlashAttribute("success", "Added successfully");
        } catch (DataIntegrityViolationException e1) {
            e1.printStackTrace();
            attributes.addFlashAttribute("error", "Duplicate name of category, please check again!");
        } catch (Exception e2) {
            e2.printStackTrace();
            attributes.addFlashAttribute("error", "Error Server");
        }
        return "redirect:/product-details/" + review.getProduct().getId() + "#tab3";
    }

    @GetMapping("/product-details/{id}")
    public String DetailProduct(@PathVariable("id") Integer id, Model model, Principal principal) {
            if(principal == null){
                Product product = productService.findById(id);
                List<Product> productDtoList = productService.findAllByCategory(product.getCategory().getName());
                List<Category> categories = categoryService.getAllCategory();
                List<Review> reviews = reviewService.getByProduct(product);
                List<Product> productColor = productService.getListColorByNameProduct(product.getName());
                int countReview = reviewService.countReviews(product);
                Double calculateAverageRating = reviewService.calculateAverageRating(product);
                model.addAttribute("countReview", countReview);
                model.addAttribute("calculateAverageRating", calculateAverageRating);
                model.addAttribute("reviewNew", new Review());
                model.addAttribute("reviews", reviews);
                model.addAttribute("product", product);
                model.addAttribute("products", productDtoList);
                model.addAttribute("productDetail", product);
                model.addAttribute("productColor", productColor);
                model.addAttribute("categories", categories);
                return "product-detail";
            }else{
                UserDetails userDetails = userDetailsService.loadUserByUsername(principal.getName());
                User user = userService.findByEmail(principal.getName());
                Product product = productService.findById(id);
                List<Product> productDtoList = productService.findAllByCategory(product.getCategory().getName());
                List<Category> categories = categoryService.getAllCategory();
                List<Review> reviews = reviewService.getByProduct(product);
                List<Product> productColor = productService.getListColorByNameProduct(product.getName());
                int countReview = reviewService.countReviews(product);
                Double calculateAverageRating = reviewService.calculateAverageRating(product);
                List<Orders> completedOrders = orderService.findOrderByStatusAndEmailAndProductId(principal.getName(),product.getId());
                Customer customer = customerService.findByEmailCustomer(principal.getName());

                model.addAttribute("customer", customer);
                model.addAttribute("orders", completedOrders);
                model.addAttribute("user", userDetails);
                model.addAttribute("name", userDetails);
                model.addAttribute("userDetails", userDetails);
                model.addAttribute("userId", user.getId());
                model.addAttribute("countReview", countReview);
                model.addAttribute("calculateAverageRating", calculateAverageRating);
                model.addAttribute("reviewNew", new Review());
                model.addAttribute("reviews", reviews);
                model.addAttribute("product", product);
                model.addAttribute("products", productDtoList);
                model.addAttribute("productDetail", product);
                model.addAttribute("productColor", productColor);
                model.addAttribute("categories", categories);
                return "product-detail";
            }
    }

    @GetMapping("/ViewByCategory/{pageNo}")
    public String ViewByCategory(@PathVariable("pageNo") int pageNo,
                                 @RequestParam("categoryId") Integer categoryId, Model model, Principal principal) {

        if (principal == null) {
            List<Category> categories = categoryService.getAllCategory();
            Page<Product> listProducts = productService.pageProductByCategory(pageNo, categoryId);
            Category category = categoryService.findById(categoryId);
            model.addAttribute("category", category);
            model.addAttribute("categories", categories);
            model.addAttribute("size", listProducts.getSize());
            model.addAttribute("currentPage", pageNo);
            model.addAttribute("totalPages", listProducts.getTotalPages());
            model.addAttribute("listProducts", listProducts.getContent());
            return "subcategory";
        } else {
            User user = userService.findByEmail(principal.getName());
            List<Category> categories = categoryService.getAllCategory();
            Page<Product> listProducts = productService.pageProductByCategory(pageNo, categoryId);
            Category category = categoryService.findById(categoryId);
            UserDetails userDetails = null;
            userDetails = userDetailsService.loadUserByUsername(principal.getName());
            model.addAttribute("name", userDetails);
            model.addAttribute("userId", user.getId());
            model.addAttribute("userDetails", userDetails);
            model.addAttribute("category", category);
            model.addAttribute("categories", categories);
            model.addAttribute("size", listProducts.getSize());
            model.addAttribute("currentPage", pageNo);
            model.addAttribute("totalPages", listProducts.getTotalPages());
            model.addAttribute("listProducts", listProducts.getContent());
            return "subcategory";
        }
    }

    @GetMapping("/product")
    public String getAllProducts(Model model) {
        List<Category> categories = categoryService.getAllCategory();
        List<Product> listProducts = productService.getAllProducts();
        model.addAttribute("listProducts", listProducts);
        model.addAttribute("categories", categories);
        return "product";
    }

    @RequestMapping(value = "/findByIdProduct/{id}", method = {RequestMethod.PUT, RequestMethod.GET})
    @ResponseBody
    public Product findById(@PathVariable("id") Integer id) {
        return productService.findById(id);
    }


    @GetMapping("/product/{pageNo}")
    public String pageProduct(@PathVariable("pageNo") int pageNo, Model model, Principal principal) {

        Page<Product> listProducts = productService.pageProducts(pageNo);
        List<Category> categories = categoryService.getAllCategory();
        model.addAttribute("categories", categories);
        model.addAttribute("size", listProducts.getSize());
        model.addAttribute("listProducts", listProducts);
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", listProducts.getTotalPages());
        model.addAttribute("productNew", new Product());
        return "product";
    }

    @GetMapping("/search-productByAdmin/{pageNo}")
    public String searchProductByAdmin(@PathVariable("pageNo") int pageNo,
                                       @RequestParam("keyword") String keyword,
                                       Model model, HttpSession session, Principal principal) {

        Page<Product> listProducts = productService.findProductByAdmin(pageNo, keyword);
        List<Category> categories = categoryService.getAllCategory();
        UserDetails userDetails = userDetailsService.loadUserByUsername(principal.getName());
        model.addAttribute("user", userDetails);
        session.setAttribute("keyword", keyword);
        model.addAttribute("keyword", keyword);
        model.addAttribute("categories", categories);
        model.addAttribute("size", listProducts.getSize());
        model.addAttribute("listProducts", listProducts);
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", listProducts.getTotalPages());
        model.addAttribute("productNew", new Product());
        return "product";
    }

    @GetMapping("/search-products/{pageNo}")
    public String searchProduct(@PathVariable("pageNo") int pageNo,
                                @RequestParam("keyword") String keyword,
                                Model model, HttpSession session) {

        Page<Product> listProducts = productService.searchProducts(pageNo, keyword);
        List<Category> categories = categoryService.getAllCategory();
        session.setAttribute("keyword", keyword);
        model.addAttribute("keyword", keyword);
        model.addAttribute("categories", categories);
        model.addAttribute("size", listProducts.getSize());
        model.addAttribute("listProducts", listProducts);
        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", listProducts.getTotalPages());
        model.addAttribute("productNew", new Product());
        return "product";
    }


    @GetMapping("/search-productByOption/{pageNo}")
    public String searchProductByOption(@PathVariable("pageNo") int pageNo,
                                        @RequestParam(value = "category") String category,
                                        @RequestParam("sortOption") String sortOption,
                                        @RequestParam("color") String color,
                                        @RequestParam(value = "minPrice", required = false) Double minPrice,
                                        @RequestParam(value = "maxPrice", required = false) Double maxPrice,
                                        @RequestParam(value = "defaultMinPrice", required = false) Double defaultMinPrice,
                                        @RequestParam(value = "defaultMaxPrice", required = false) Double defaultMaxPrice,
                                        Model model, Principal principal) {
        if(principal == null){
            if (minPrice == null) {
                minPrice = 0.0;
            }

            if (maxPrice == null) {
                maxPrice = Double.MAX_VALUE;
            }
            List<Category> categories = categoryService.getAllCategory();
            Page<Product> listProducts = productService.searchProductByOption(pageNo, category, sortOption, color, minPrice, maxPrice);
            model.addAttribute("color", color);
            model.addAttribute("minPrice", minPrice);
            model.addAttribute("maxPrice", maxPrice);
            model.addAttribute("defaultMinPrice", defaultMinPrice);
            model.addAttribute("defaultMaxPrice", defaultMaxPrice);
            model.addAttribute("sortOption", sortOption);
            model.addAttribute("category", category);
            model.addAttribute("categories", categories);
            model.addAttribute("size", listProducts.getSize());
            model.addAttribute("currentPage", pageNo);
            model.addAttribute("totalPages", listProducts.getTotalPages());
            model.addAttribute("productNew", new Product());
            model.addAttribute("listProducts", listProducts.getContent());
            return "searchByOption";
        }else{
            if (minPrice == null) {
                minPrice = 0.0;
            }

            if (maxPrice == null) {
                maxPrice = Double.MAX_VALUE;
            }
            List<Category> categories = categoryService.getAllCategory();
            Page<Product> listProducts = productService.searchProductByOption(pageNo, category, sortOption, color, minPrice, maxPrice);
            UserDetails userDetails = null;
            if (principal != null) {
                userDetails = userDetailsService.loadUserByUsername(principal.getName());
            }
            User user = userService.findByEmail(principal.getName());
            model.addAttribute("name", userDetails);
            model.addAttribute("userId", user.getId());
            model.addAttribute("userDetails", userDetails);
            model.addAttribute("color", color);
            model.addAttribute("minPrice", minPrice);
            model.addAttribute("maxPrice", maxPrice);
            model.addAttribute("defaultMinPrice", defaultMinPrice);
            model.addAttribute("defaultMaxPrice", defaultMaxPrice);
            model.addAttribute("sortOption", sortOption);
            model.addAttribute("category", category);
            model.addAttribute("categories", categories);
            model.addAttribute("size", listProducts.getSize());
            model.addAttribute("currentPage", pageNo);
            model.addAttribute("totalPages", listProducts.getTotalPages());
            model.addAttribute("productNew", new Product());
            model.addAttribute("listProducts", listProducts.getContent());
            return "searchByOption";
        }
    }

    @GetMapping("/search-productByKeyword/{pageNo}")
    public String searchProductByCategory(@PathVariable("pageNo") int pageNo,
                                          @RequestParam("keyword") String keyword,
                                          Model model, HttpSession session, Principal principal) {
        if (principal == null) {
            Page<Product> listProducts = productService.searchProducts(pageNo, keyword);
            List<Category> categories = categoryService.getAllCategory();
            double minPrice = productService.getMinPrice(listProducts);
            double maxPrice = productService.getMaxPrice(listProducts);
            double defaultMinPrice = productService.getMinPrice(listProducts);
            double defaultMaxPrice = productService.getMaxPrice(listProducts);
            session.setAttribute("keyword", keyword);
            model.addAttribute("keyword", keyword);
            model.addAttribute("categories", categories);
            model.addAttribute("size", listProducts.getSize());
            model.addAttribute("currentPage", pageNo);
            model.addAttribute("totalPages", listProducts.getTotalPages());
            model.addAttribute("listProducts", listProducts.getContent());
            model.addAttribute("minPrice", minPrice);
            model.addAttribute("maxPrice", maxPrice);
            model.addAttribute("defaultMinPrice", 9490000);
            model.addAttribute("defaultMaxPrice", 35000000);
            return "searchCategory";
        } else {
            Page<Product> listProducts = productService.searchProducts(pageNo, keyword);
            List<Category> categories = categoryService.getAllCategory();
            double minPrice = productService.getMinPrice(listProducts);
            double maxPrice = productService.getMaxPrice(listProducts);
            double defaultMinPrice = productService.getMinPrice(listProducts);
            double defaultMaxPrice = productService.getMaxPrice(listProducts);
            UserDetails userDetails = null;
            userDetails = userDetailsService.loadUserByUsername(principal.getName());
            model.addAttribute("name", userDetails);
            User user = userService.findByEmail(principal.getName());
            model.addAttribute("userId", user.getId());
            model.addAttribute("userDetails", userDetails);
            session.setAttribute("keyword", keyword);
            model.addAttribute("keyword", keyword);
            model.addAttribute("categories", categories);
            model.addAttribute("size", listProducts.getSize());
            model.addAttribute("currentPage", pageNo);
            model.addAttribute("totalPages", listProducts.getTotalPages());
            model.addAttribute("listProducts", listProducts.getContent());
            model.addAttribute("minPrice", minPrice);
            model.addAttribute("maxPrice", maxPrice);
            model.addAttribute("defaultMinPrice", 9490000);
            model.addAttribute("defaultMaxPrice", 35000000);
            return "searchCategory";
        }
    }

    @GetMapping("/detail-product/{id}")
    public String DetailProducts(@PathVariable("id") Integer id, Model model, Principal principal) {
        Product newProduct = productService.getById(id);
        List<Category> categories = categoryService.getAllCategory();
        UserDetails userDetails = null;
        if (principal != null) {
            userDetails = userDetailsService.loadUserByUsername(principal.getName());
        }
        model.addAttribute("user", userDetails);
        model.addAttribute("userDetails", userDetails);
        model.addAttribute("categories", categories);
        model.addAttribute("listProducts", newProduct);
        return "detail";
    }

    @PostMapping("/add-product")
    public String addProduct(@ModelAttribute("productNew") Product product,
                             @RequestParam("photo_file") MultipartFile photo,
                             Model model, Principal principal,
                             RedirectAttributes attributes) {
        try {
            productService.save(photo, product);
            model.addAttribute("productNew", product);
            attributes.addFlashAttribute("success", "Added successfully");
        } catch (DataIntegrityViolationException e1) {
            e1.printStackTrace();
            attributes.addFlashAttribute("failed", "Duplicate name of category, please check again!");
        } catch (Exception e2) {
            e2.printStackTrace();
            attributes.addFlashAttribute("failed", "Error Server");
        }
        return "redirect:/search-productByAdmin/0?keyword=";
    }

    @GetMapping("/update-product/{id}")
    public String updateProduct(@PathVariable("id") Integer id, Model model,Principal principal) {
        Product product = productService.getById(id);
        String productImage = product.getImage();
        List<Category> categories = categoryService.getAllCategory();

        DecimalFormatSymbols decimalFormatSymbols = new DecimalFormatSymbols(Locale.getDefault());
        decimalFormatSymbols.setGroupingSeparator('.');
        DecimalFormat decimalFormat = new DecimalFormat("#,###", decimalFormatSymbols);
        String formattedPrice = decimalFormat.format(product.getPrice());

        UserDetails userDetails = userDetailsService.loadUserByUsername(principal.getName());
        model.addAttribute("user", userDetails);
        model.addAttribute("formattedPrice", formattedPrice);
        model.addAttribute("categories", categories);
        model.addAttribute("newProduct", product);
        model.addAttribute("productImage", productImage);
        return "update-product";
    }

    @PostMapping("/update-product/{id}")
    public String processUpdateProduct(@PathVariable("id") Integer id, @ModelAttribute("newProduct")
    Product product, @RequestParam("photo_file") MultipartFile photo_file, RedirectAttributes attributes) {
        try {
            productService.update(photo_file, product);
            attributes.addFlashAttribute("success", "Update successfully");
        } catch (Exception e) {
            e.printStackTrace();
            attributes.addFlashAttribute("error", "Failed to update");
        }
        return "redirect:/search-productByAdmin/0?keyword=";
    }

    @RequestMapping(value = "/status-product", method = {RequestMethod.PUT, RequestMethod.GET})
    public String deletedProduct(Integer id, RedirectAttributes redirectAttributes, Principal principal) {
        try {
            productService.deleteById(id);
            redirectAttributes.addFlashAttribute("success", "Deleted successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Deleted failed!");
        }

        return "redirect:/search-productByAdmin/0?keyword=";
    }
}
