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
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, roleId);
            try (ResultSet rs = ps.executeQuery()) {
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
                    role.setId(roleId);

                    User u = new User(id, name, email, password, phone, dob, address, gender, role, createdAt);
                    userList.add(u);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error at getUsersByRoleId: " + e.getMessage());
        }
        return userList;
    }

    public boolean deleteUserById(int id) {
        try {
            if (con == null) {
                status = "Error: Database connection is null";
                return false;
            }
            // Bắt đầu transaction để đảm bảo tính toàn vẹn dữ liệu
            con.setAutoCommit(false);

            // Xóa bản ghi trong Customer_Profile
            String sqlProfile = "DELETE FROM Customer_Profile WHERE id = ?";
            PreparedStatement psProfile = con.prepareStatement(sqlProfile);
            psProfile.setInt(1, id);
            psProfile.executeUpdate();
            psProfile.close();

            // Xóa bản ghi trong CartItem (liên quan qua Cart)
            String sqlCartItem = "DELETE FROM CartItem WHERE cart_id IN (SELECT id FROM Cart WHERE user_id = ?)";
            PreparedStatement psCartItem = con.prepareStatement(sqlCartItem);
            psCartItem.setInt(1, id);
            psCartItem.executeUpdate();
            psCartItem.close();

            // Xóa bản ghi trong Cart
            String sqlCart = "DELETE FROM Cart WHERE user_id = ?";
            PreparedStatement psCart = con.prepareStatement(sqlCart);
            psCart.setInt(1, id);
            psCart.executeUpdate();
            psCart.close();

            // Xóa bản ghi trong OrderDetail (liên quan qua Orders)
            String sqlOrderDetail = "DELETE FROM OrderDetail WHERE order_id IN (SELECT id FROM Orders WHERE user_id = ?)";
            PreparedStatement psOrderDetail = con.prepareStatement(sqlOrderDetail);
            psOrderDetail.setInt(1, id);
            psOrderDetail.executeUpdate();
            psOrderDetail.close();

            // Xóa bản ghi trong Orders
            String sqlOrders = "DELETE FROM Orders WHERE user_id = ?";
            PreparedStatement psOrders = con.prepareStatement(sqlOrders);
            psOrders.setInt(1, id);
            psOrders.executeUpdate();
            psOrders.close();

            // Cập nhật shipper_id thành NULL nếu shipper bị xóa
            String sqlOrdersShipper = "UPDATE Orders SET shipper_id = NULL WHERE shipper_id = ?";
            PreparedStatement psOrdersShipper = con.prepareStatement(sqlOrdersShipper);
            psOrdersShipper.setInt(1, id);
            psOrdersShipper.executeUpdate();
            psOrdersShipper.close();

            // Xóa bản ghi trong Feedback
            String sqlFeedback = "DELETE FROM Feedback WHERE user_id = ?";
            PreparedStatement psFeedback = con.prepareStatement(sqlFeedback);
            psFeedback.setInt(1, id);
            psFeedback.executeUpdate();
            psFeedback.close();

            // Xóa bản ghi trong ProposedProduct
            String sqlProposed = "DELETE FROM ProposedProduct WHERE nutritionist_id = ?";
            PreparedStatement psProposed = con.prepareStatement(sqlProposed);
            psProposed.setInt(1, id);
            psProposed.executeUpdate();
            psProposed.close();

            // Cuối cùng, xóa người dùng trong Users
            String sqlUser = "DELETE FROM Users WHERE id = ?";
            PreparedStatement psUser = con.prepareStatement(sqlUser);
            psUser.setInt(1, id);
            int rowsAffected = psUser.executeUpdate();
            psUser.close();

            if (rowsAffected > 0) {
                // Commit transaction nếu mọi thứ thành công
                con.commit();
                status = "OK: User with ID " + id + " and related data deleted successfully";
                return true;
            } else {
                // Rollback nếu không xóa được người dùng
                con.rollback();
                status = "Error: No user found with ID " + id;
                return false;
            }
        } catch (SQLException e) {
            try {
                // Rollback transaction nếu có lỗi
                con.rollback();
            } catch (SQLException rollbackEx) {
                status = "Error at rollback: " + rollbackEx.getMessage();
            }
            status = "Error at deleteUserById: " + e.getMessage();
            System.err.println(status);
            return false;
        } finally {
            try {
                // Khôi phục chế độ auto-commit
                con.setAutoCommit(true);
            } catch (SQLException e) {
                status = "Error at restoring auto-commit: " + e.getMessage();
                System.err.println(status);
            }
        }
    }

    public String getStatus() {
        return status;
    }

    public static void main(String[] args) {
        ArrayList<User> ulist = DAOUser.INSTANCE.getUsersByRoleId(6);
        for (int i = 0; i < ulist.size(); i++) {
            System.out.println(ulist.get(i).getName());
        }
    }

}
