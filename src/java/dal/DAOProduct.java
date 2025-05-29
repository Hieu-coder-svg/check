/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Category;
/**
 *
 * @author ASUS
 */
public class DAOProduct {
    public static DAOProduct INSTANCE= new DAOProduct();
    private Connection con;
    private String status="OK";

    public DAOProduct() {
        if (INSTANCE==null){
            con = new DBContext().connect;
        }else
            INSTANCE = this;
    }
    
//    public List<Products> getAll() {
//
//        List<Products> list = new ArrayList<>();
//        String sql = "select * from Products";
//        //chay lenhj truy van
//        try {
//            PreparedStatement st = connection.prepareStatement(sql);
//            ResultSet rs = st.executeQuery();
//            while (rs.next()) {
//                Products p = new Products();
//                p.setProductID(rs.getInt("ProductID"));
//                p.setProductName(rs.getString("ProductName"));
//                p.setPrice(rs.getDouble("Price"));
//                p.setQuantity(rs.getInt("Quantity"));
//                p.setDescription(rs.getString("Description"));
//                p.setImageURL(rs.getString("ImageURL"));
//                list.add(p);
//            }
//        } catch (SQLException e) {
//            System.out.println(e);
//        }
//        return list;
//    }
    public List<Product> getAllProduct(){
        List<Product> list = new ArrayList<>();
        String sql = "select * from Product";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setStock(rs.getInt("stock"));
                p.setImgUrl(rs.getString("image_url"));
                Category c = new Category();
                
                p.setShelfLifeHours(0);
            }
            
        } catch (SQLException e) {
        }
        return list;
    }
    
}
