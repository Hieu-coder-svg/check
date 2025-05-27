/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class Order {
    private int id;
    private User user;
    private Timestamp orderDate;
    private BigDecimal totalAmount;
    private String paymentMethod;
    private String status;
    private User shipper;
    private List<OrderDetail> orderDetails;
    
}
