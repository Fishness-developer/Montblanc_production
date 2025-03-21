package com.montblanc.montblanc.Repositories;

import com.montblanc.montblanc.Clases.Product;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<Product, Long> {
}
