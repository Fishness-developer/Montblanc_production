package com.montblanc.montblanc.Repositories;

import com.montblanc.montblanc.Clases.Orders;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository // Optional but good practice
public interface OrdersRepository extends JpaRepository<Orders, Long> {
    // No additional methods needed for count()
}