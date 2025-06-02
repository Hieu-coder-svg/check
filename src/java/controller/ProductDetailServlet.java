
package controller;
import dal.DAOOrder;
import dal.DAOProduct;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import model.Product;

/**
 *
 * @author HP
 */
public class ProductDetailServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet productDetailServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet productDetailServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
           String productIdStr = request.getParameter("productIdStr");
        int productId;
        try {
            productId = Integer.parseInt(productIdStr);
        } catch (NumberFormatException e) {
            request.getRequestDispatcher("productDetail.jsp").forward(request, response);
            return;
        }
        DAOProduct dao = new DAOProduct();
        Product product = dao.getProductById(productId);
        String productName = product.getName() ;
        String description = product.getDescription();
        Double price = product.getPrice();
        int stock = product.getStock();
        String img = product.getImgUrl();
        double shelfLifeHours = product.getShelfLifeHours();
        String category = product.getCategory().getName();
        
        request.setAttribute("productId", product.getId());
        request.setAttribute("productName", productName);
        request.setAttribute("description", description);
        request.setAttribute("price", price);
        request.setAttribute("stock", stock);
        request.setAttribute("img", img);
        request.setAttribute("time", shelfLifeHours);
        request.setAttribute("category", category);
        request.getRequestDispatcher("productDetail.jsp").forward(request, response);
        
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         String productIdStr = request.getParameter("productId");      
        int productId;
        try {
            productId = Integer.parseInt(productIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid product id.");
            request.getRequestDispatcher("productDetail.jsp").forward(request, response);
            return;
        }

  
        String numberStr = request.getParameter("number");
        int number;
        try {
            number = Integer.parseInt(numberStr);
            if (number <= 0) {
                throw new NumberFormatException("Number must be greater than 0.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid number.");
            request.getRequestDispatcher("productDetail.jsp").forward(request, response);
            return;
        }       
      

//        boolean success = DAOOrder.orderProduct(user.getId(), productId, numberOfPeople, totalPrice);
//        if (success) {
//            request.setAttribute("message", "Booking successful!");
//        } else {
//            request.setAttribute("error", "Failed to book the product. Please try again.");
//        }

        request.getRequestDispatcher("productDetail.jsp").forward(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
