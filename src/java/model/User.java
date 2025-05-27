/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Date;
import java.sql.Timestamp;
/**
 *
 * @author ASUS
 */

public class User {
    private int id;
    private String name;
    private String email;
    private String password;
    private String phone;
    private Date dob;
    private String address;
    private boolean gender;
    private Role role;
    private Timestamp createdAt;
}
