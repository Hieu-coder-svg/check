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
    private static Connection con;
    private String status="OK";

    public DAOProduct() {
        if (INSTANCE==null){
            con = new DBContext().connect;
        }else
            INSTANCE = this;
    }
   
    public List<Product> getAllProduct(){
        List<Product> productList = new ArrayList<>();
        String sql = "select p.id as product_id, p.name as product_name, p.description, p.price, p.stock, p.image_url, p.shelf_life_hours, "
                +"c.id as category_id, c.name as category_name "
                +"FROM Product p "
                +"INNER JOIN Category c ON p.category_id = c.id"
                ;
        try {
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                Product p = new Product();
                p.setId(rs.getInt("product_id"));
                p.setName(rs.getString("product_name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setStock(rs.getInt("stock"));
                p.setImgUrl(rs.getString("image_url"));
                p.setShelfLifeHours(rs.getDouble("shelf_life_hours"));
                
                Category c = new Category();
                c.setId(rs.getInt("category_id"));
                c.setName(rs.getString("category_name"));
                
                p.setCategory(c);
                productList.add(p);              
            }
            
        } catch (SQLException e) {
        }
        return productList;

    }
    public  Product getProductById(int productId) {
        Product product = null;
        try {
            String sql = "SELECT * "
                    + "FROM Product p"
                    + "INNER JOIN Category c on c.id = p.category_id WHERE id = ?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, productId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                 Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setStock(rs.getInt("stock"));
                p.setImgUrl(rs.getString("image_url"));
                p.setShelfLifeHours(0);         
                
                Category c = new Category();
                c.setId(rs.getInt("category_id"));
                c.setName(rs.getString("category_name"));
                
                p.setCategory(c);                         
            }

            rs.close();
            statement.close();
        } catch (SQLException ex) {
            
        }
        return product;
    }
}
