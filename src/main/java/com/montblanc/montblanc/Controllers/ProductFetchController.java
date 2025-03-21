package com.montblanc.montblanc.Controllers;

import com.montblanc.montblanc.Clases.Product;
import com.montblanc.montblanc.Repositories.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class ProductFetchController {
    @Autowired
    private ProductRepository productRepository;

    @GetMapping("/products")
    @ResponseBody // Returns JSON instead of representation
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }
}
