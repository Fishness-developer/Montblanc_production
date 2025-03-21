package com.montblanc.montblanc.Controllers;

import com.montblanc.montblanc.EmailService;
import com.montblanc.montblanc.Clases.OrderProducts;
import com.montblanc.montblanc.Clases.Orders;
import com.montblanc.montblanc.Repositories.OrdersRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class OrderController {

    @Autowired
    OrdersRepository ordersRepository;

    @Autowired
    private EmailService emailService;

    @PostMapping("/order")
    public String order(@RequestBody Orders orders) {
        List<OrderProducts> productList = new ArrayList<>(orders.getProducts());

        for (OrderProducts product : productList) {
            product.setOrders(orders);
        }

        try {
            System.out.println("Processing order for email: " + orders.getEmail());
            StringBuilder productNames = new StringBuilder();
            for (OrderProducts orderProducts : productList) {
                String formatted = String.format(
                        "<div style='margin: 10px 0'> " +
                                "<div style='display:inline-flex; padding:5px 10px; border: 1px solid #000'>%s: </div>" +
                                "<div style='display:inline-flex; padding:5px 10px; border: 1px solid #000; border-left:0!important'>%s₪</div><" +
                                "/div>",
                        orderProducts.getName(), orderProducts.getPrice());
                productNames.append(formatted);
            }

            String orderList = String.format(
                    "<h1 style='color:#46BB22;'>Your Order:</h1> " +
                            "<div> %s</div> " +
                            "<h2 style='background:#46BB22; color:#fff; display:inline-flex; padding:5px 10px;'> Total: %s ₪</h2> " +
                            "<h4> Delivery: %s </h4><h4> Payment: %s</h4>",
                    productNames, orders.getTotal(), orders.getDelivery(), orders.getPayment());

            ordersRepository.save(orders);
            System.out.println("Before sending email to: " + orders.getEmail());
            emailService.sendMultipartMessage(orders.getEmail(), "Order № " + orders.getId() + " from MontBlanc", orderList);
            System.out.println("After sending email to: " + orders.getEmail());
            return "Success";
        } catch (Exception e) {
            System.err.println("Error in order processing: " + e.getMessage());
            e.printStackTrace();
            return "Sending ERROR";
        }
    }


    @DeleteMapping("/deleteOrder/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, String>> deleteOrder(@PathVariable("id") Long id) {
        Map<String, String> response = new HashMap<>();
        try {
            System.out.println("Received DELETE request for order ID: " + id);
            if (ordersRepository.existsById(id)) {
                ordersRepository.deleteById(id);
                System.out.println("Order with ID " + id + " deleted successfully");
                response.put("status", "success");
                response.put("message", "Order deleted");
                return ResponseEntity.ok(response);
            } else {
                System.out.println("Order with ID " + id + " not found");
                response.put("status", "error");
                response.put("message", "Order with ID " + id + " not found");
                return ResponseEntity.status(404).body(response);
            }
        } catch (Exception e) {
            System.err.println("Error deleting order with ID " + id + ": " + e.getMessage());
            response.put("status", "error");
            response.put("message", "Error while deleting: " + e.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }
}