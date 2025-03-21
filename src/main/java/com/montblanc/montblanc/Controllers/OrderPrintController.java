package com.montblanc.montblanc.Controllers;

import com.montblanc.montblanc.Clases.Orders;
import com.montblanc.montblanc.Repositories.OrdersRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class OrderPrintController {

    @Autowired
    OrdersRepository ordersRepository;

    @GetMapping("/allOrders")
    public String showOrders(Model model) {

        List<Orders> allOrders = ordersRepository.findAll();

        model.addAttribute("orders", allOrders);

        return "/WEB-INF/views/allOrders.jsp";
    }
}
