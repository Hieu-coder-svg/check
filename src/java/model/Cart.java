/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class Cart {
    private int id;
    private  User user;
    private Timestamp createdAt;
    private List<CartItem> items;
}
