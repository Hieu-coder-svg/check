/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import model.User;
import java.sql.Connection;
import java.util.ArrayList;
/**
 *
 * @author ASUS
 */
public class DAOUser {
    public static DAOUser INSTANCE= new DAOUser();
    private Connection con;
    private String status="OK";

    public DAOUser() {
        if (INSTANCE==null){
            con = new DBContext().connect;
        }else
            INSTANCE = this;
    }
}
