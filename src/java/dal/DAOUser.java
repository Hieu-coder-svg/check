/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import model.Role;

/**
 *
 * @author ASUS
 */
public class DAOUser {

    public static DAOUser INSTANCE = new DAOUser();
    private Connection con;
    private String status = "OK";

    public DAOUser() {
        if (INSTANCE == null) {
            con = new DBContext().connect;
        } else {
            INSTANCE = this;
        }
    }

    public ArrayList<User> getUser() {
        ArrayList<User> userList = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try {
            PreparedStatement ps = con.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String phone = rs.getString("phone");
                Date dob = rs.getDate("dob");
                String address = rs.getString("address");
                boolean gender = rs.getBoolean("gender");
                Timestamp createdAt = rs.getTimestamp("created_at");

                int roleId = rs.getInt("role_id");
                Role role = new Role();
                role.setId(roleId);

                User u = new User(id, name, email, password, phone, dob, address, gender, role, createdAt);
                userList.add(u);
            }
            rs.close();
        } catch (Exception e) {
            status = "Error at read Users " + e.getMessage();
        }
        return userList;
    }

    public ArrayList<User> getUsersByRoleId(int roleId) {
        ArrayList<User> userList = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE role_id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, roleId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String phone = rs.getString("phone");
                Date dob = rs.getDate("dob");
                String address = rs.getString("address");
                boolean gender = rs.getBoolean("gender");
                Timestamp createdAt = rs.getTimestamp("created_at");

                Role role = new Role();

                User u = new User(id, name, email, password, phone, dob, address, gender, role, createdAt);
                userList.add(u);
            }
            rs.close();
        } catch (Exception e) {
            status = "Error at getUsersByRoleId: " + e.getMessage();
        }
        return userList;
    }

}
