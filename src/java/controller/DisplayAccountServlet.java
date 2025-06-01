package controller;

import dal.DAOUser;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.User;

public class DisplayAccountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        HttpSession session = request.getSession(false);
//        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
//            response.sendRedirect("login");
//            return;
//        }
        try {
            String roleId = request.getParameter("idRole");
            if (roleId == null || roleId.trim().isEmpty()) {
                request.setAttribute("error", "Role ID is missing");
                request.getRequestDispatcher("view/error.jsp").forward(request, response);
                return;
            }
            int rId = Integer.parseInt(roleId);
            ArrayList<User> uList = DAOUser.INSTANCE.getUsersByRoleId(rId);
            if (uList == null) {
                request.setAttribute("error", "Error retrieving users from database");
                request.getRequestDispatcher("view/error.jsp").forward(request, response);
                return;
            }
            request.setAttribute("uList", uList);
            request.setAttribute("roleId", rId);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("view/displayAccounts.jsp");
            requestDispatcher.forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid Role ID");
            request.getRequestDispatcher("view/error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("view/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}