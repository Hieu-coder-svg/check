/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
/**
 *
 * @author ASUS
 */
public class DAOOrder {
    public static DAOOrder INSTANCE= new DAOOrder();
    private static Connection con;
    private String status="OK";

    public DAOOrder() {
        if (INSTANCE==null){
            con = new DBContext().connect;
        }else
            INSTANCE = this;
    }
    
}
