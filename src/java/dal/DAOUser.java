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

public class DAOUser {

    public static DAOUser INSTANCE = new DAOUser();
    private Connection con;
    private String status = "OK";

    public DAOUser() {
        con = new DBContext().connect;
    }
    
    public User login(String email,String password){
        
        String sql = "SELECT u.*, r.role_name FROM Users u LEFT JOIN Role r ON u.role_id = r.id "
                + "WHERE u.email = ? AND u.password = ? ";
        try { PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, email);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String mail = rs.getString("email");
                String pass = rs.getString("password");
                String phone = rs.getString("phone");
                Date dob = rs.getDate("dob");
                String address = rs.getString("address");
                boolean gender = rs.getBoolean("gender");
                Timestamp createdAt = rs.getTimestamp("created_at");

                int roleId = rs.getInt("role_id");
                String roleName = rs.getString("role_name");
                Role role = new Role(roleId, roleName);

                User u = new User(id, name, mail, pass, phone, dob, address, gender, role, createdAt);
                return u;
            }
            rs.close();
        } catch (Exception e) {
            status = "Error at read Users " + e.getMessage();
        }
           return null;
       
    }

    public ArrayList<User> getUser() {
        ArrayList<User> userList = new ArrayList<>();
        String sql = "SELECT u.*, r.role_name FROM Users u LEFT JOIN Role r ON u.role_id = r.id";
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
                String roleName = rs.getString("role_name");
                Role role = new Role(roleId, roleName);

                User u = new User(id, name, email, password, phone, dob, address, gender, role, createdAt);
                userList.add(u);
            }
            rs.close();
        } catch (Exception e) {
            status = "Error at read Users " + e.getMessage();
        }
        return userList;
    }

    public User getUserById(int id) {
        String sql = "SELECT u.*, r.role_name FROM Users u LEFT JOIN Role r ON u.role_id = r.id WHERE u.id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String password = rs.getString("password");
                    String phone = rs.getString("phone");
                    Date dob = rs.getDate("dob");
                    String address = rs.getString("address");
                    boolean gender = rs.getBoolean("gender");
                    Timestamp createdAt = rs.getTimestamp("created_at");

                    int roleId = rs.getInt("role_id");
                    String roleName = rs.getString("role_name");
                    Role role = new Role(roleId, roleName);

                    return new User(id, name, email, password, phone, dob, address, gender, role, createdAt);
                }
            }
        } catch (SQLException e) {
            status = "Error at getUserById: " + e.getMessage();
            System.err.println(status);
        }
        return null;
    }

    public ArrayList<User> getUsersByRoleId(int roleId) {
        ArrayList<User> userList = new ArrayList<>();
        String sql = "SELECT u.*, r.role_name FROM Users u LEFT JOIN Role r ON u.role_id = r.id WHERE u.role_id = ?";
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

                    String roleName = rs.getString("role_name");
                    Role role = new Role(roleId, roleName);

                    User u = new User(id, name, email, password, phone, dob, address, gender, role, createdAt);
                    userList.add(u);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error at getUsersByRoleId: " + e.getMessage());
        }
        return userList;
    }

    public boolean updateUser(User user) {
        String sql = "UPDATE Users SET name = ?, email = ?, password = ?, phone = ?, dob = ?, address = ?, gender = ?, role_id = ? WHERE id = ?";
        try {
            if (con == null) {
                status = "Error: Database connection is null";
                return false;
            }
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setDate(5, user.getDob());
            ps.setString(6, user.getAddress());
            ps.setBoolean(7, user.isGender());
            ps.setInt(8, user.getRole().getId());
            ps.setInt(9, user.getId());

            int rowsAffected = ps.executeUpdate();
            ps.close();
            if (rowsAffected > 0) {
                status = "OK: User with ID " + user.getId() + " updated successfully";
                return true;
            } else {
                status = "Error: No user found with ID " + user.getId();
                return false;
            }
        } catch (SQLException e) {
            status = "Error at updateUser: " + e.getMessage();
            System.err.println(status);
            return false;
        }
    }

    public boolean deleteUserById(int id) {
        try {
            if (con == null) {
                status = "Error: Database connection is null";
                return false;
            }
            con.setAutoCommit(false);

            String sqlProfile = "DELETE FROM Customer_Profile WHERE id = ?";
            PreparedStatement psProfile = con.prepareStatement(sqlProfile);
            psProfile.setInt(1, id);
            psProfile.executeUpdate();
            psProfile.close();

            String sqlCartItem = "DELETE FROM CartItem WHERE cart_id IN (SELECT id FROM Cart WHERE user_id = ?)";
            PreparedStatement psCartItem = con.prepareStatement(sqlCartItem);
            psCartItem.setInt(1, id);
            psCartItem.executeUpdate();
            psCartItem.close();

            String sqlCart = "DELETE FROM Cart WHERE user_id = ?";
            PreparedStatement psCart = con.prepareStatement(sqlCart);
            psCart.setInt(1, id);
            psCart.executeUpdate();
            psCart.close();

            String sqlOrderDetail = "DELETE FROM OrderDetail WHERE order_id IN (SELECT id FROM Orders WHERE user_id = ?)";
            PreparedStatement psOrderDetail = con.prepareStatement(sqlOrderDetail);
            psOrderDetail.setInt(1, id);
            psOrderDetail.executeUpdate();
            psOrderDetail.close();

            String sqlOrders = "DELETE FROM Orders WHERE user_id = ?";
            PreparedStatement psOrders = con.prepareStatement(sqlOrders);
            psOrders.setInt(1, id);
            psOrders.executeUpdate();
            psOrders.close();

            String sqlOrdersShipper = "UPDATE Orders SET shipper_id = NULL WHERE shipper_id = ?";
            PreparedStatement psOrdersShipper = con.prepareStatement(sqlOrdersShipper);
            psOrdersShipper.setInt(1, id);
            psOrdersShipper.executeUpdate();
            psOrdersShipper.close();

            String sqlFeedback = "DELETE FROM Feedback WHERE user_id = ?";
            PreparedStatement psFeedback = con.prepareStatement(sqlFeedback);
            psFeedback.setInt(1, id);
            psFeedback.executeUpdate();
            psFeedback.close();

            String sqlProposed = "DELETE FROM ProposedProduct WHERE nutritionist_id = ?";
            PreparedStatement psProposed = con.prepareStatement(sqlProposed);
            psProposed.setInt(1, id);
            psProposed.executeUpdate();
            psProposed.close();

            String sqlUser = "DELETE FROM Users WHERE id = ?";
            PreparedStatement psUser = con.prepareStatement(sqlUser);
            psUser.setInt(1, id);
            int rowsAffected = psUser.executeUpdate();
            psUser.close();

            if (rowsAffected > 0) {
                con.commit();
                status = "OK: User with ID " + id + " and related data deleted successfully";
                return true;
            } else {
                con.rollback();
                status = "Error: No user found with ID " + id;
                return false;
            }
        } catch (SQLException e) {
            try {
                con.rollback();
            } catch (SQLException rollbackEx) {
                status = "Error at rollback: " + rollbackEx.getMessage();
            }
            status = "Error at deleteUserById: " + e.getMessage();
            System.err.println(status);
            return false;
        } finally {
            try {
                con.setAutoCommit(true);
            } catch (SQLException e) {
                status = "Error at restoring auto-commit: " + e.getMessage();
                System.err.println(status);
            }
        }
    }

    public boolean checkEmailExists(String email, int userId) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ? AND id != ?";
        try {
            if (con == null) {
                status = "Error: Database connection is null";
                return false;
            }
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            rs.close();
            ps.close();
            status = "OK: Checked email existence";
        } catch (SQLException e) {
            status = "Error at checkEmailExists: " + e.getMessage();
            System.err.println(status);
        }
        return false;
    }

    public String getStatus() {
        return status;
    }

//    public static void main(String[] args) {
////        ArrayList<User> ulist = DAOUser.INSTANCE.getUsersByRoleId(6);
////        for (int i = 0; i < ulist.size(); i++) {
////            System.out.println(ulist.get(i).getName());
////        }
//            User u = DAOUser.INSTANCE.login("john.smith@example.com","password123");
//            System.out.println(u.getEmail()+"|"+u.getPassword()+"|" +u.getName());
//    }
}

