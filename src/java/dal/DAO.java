package dal;

import model.*;
import java.sql.*;
import java.util.ArrayList;

public class DAO {
    public static DAO INSTANCE= new DAO();
    private Connection con;
    private String status="OK";
    
    private DAO(){
        if (INSTANCE==null){
            con = new DBContext().connect;
        }else
            INSTANCE = this;
    }
    
    public void loadDB() {
        System.out.println("Loading data...");
        String sql = "select * from users";        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                int id = rs.getInt("id");
                String lastname = rs.getString("lName");
                String name = rs.getString("fName");
                System.out.println(id + " - " + name +" "+lastname);
            }
            rs.close();
        } catch (Exception e) {
            status = "Error at read Users "+e.getMessage();
        }       
    }
    
//    public ArrayList getUser(){
//        ArrayList<User> userList = new ArrayList();
//        String sql ="select * from users";
//        try {
//            PreparedStatement ps = con.prepareCall(sql);
//            ResultSet rs = ps.executeQuery();
//            while(rs.next()){
//                int id= rs.getInt("id");
//                String firstname= rs.getString("fName");
//                String lastname= rs.getString("lName");
//                userList.add(new User(id, firstname, lastname));
//            }
//            rs.close();
//        } catch (Exception e) {
//            status = "Error at read Users "+e.getMessage();
//        }
//        return userList;
//    }
    public static void main(String[] args) {
        //DAO.INSTANCE.loadDB();
//        ArrayList<User> users = DAO.INSTANCE.getUser();
//        System.out.println(users);
//        System.out.println("----");
    }
}