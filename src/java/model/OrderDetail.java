/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.math.BigDecimal;
import java.sql.Timestamp;
/**
 *
 * @author ASUS
 */
public class OrderDetail {
    private int id;
    private Order order;
    private Product product;
    private int quantity;
    private BigDecimal price;
    private int rating;
    private String comment;
    private Timestamp CreatedAt;
}
