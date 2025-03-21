package com.montblanc.montblanc.Clases;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderProducts {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "longtext")
    private String image;

    private String name;
    private String price;
    private String value;

    @ManyToOne
    @JoinColumn(name = "order_id")
    private Orders orders;
}