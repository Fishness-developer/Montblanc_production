package com.montblanc.montblanc.Controllers;

import com.montblanc.montblanc.Clases.User;
import com.montblanc.montblanc.Repositories.OrdersRepository;
import com.montblanc.montblanc.Repositories.ProductRepository;
import com.montblanc.montblanc.Repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminPanelController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private OrdersRepository ordersRepository;

    @Autowired
    private ProductRepository productRepository;

    @GetMapping("/adminPanel")
    public String home(Model model) {
        User adminUser = userRepository.findByLogin("admin");
        model.addAttribute("adminLogin", adminUser.getLogin());

        long orderCount = ordersRepository.count();
        model.addAttribute("orderCount", orderCount);

        // Fetch the total number of products
        long productCount = productRepository.count();
        model.addAttribute("productCount", productCount);

        return "/WEB-INF/views/adminPanel.jsp";
    }
}