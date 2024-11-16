package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ManageUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String role = request.getParameter("role");

        try (Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/uam_db", "postgres", "KODNEST123")) {
            if (request.getParameter("deleteUser") != null) {
                // Delete user
                try (PreparedStatement ps = con.prepareStatement("DELETE FROM users WHERE id = ?")) {
                    ps.setInt(1, userId);
                    ps.executeUpdate();
                }
            } else {
                // Update user role
                try (PreparedStatement ps = con.prepareStatement("UPDATE users SET role = ? WHERE id = ?")) {
                    ps.setString(1, role);
                    ps.setInt(2, userId);
                    ps.executeUpdate();
                }
            }
            response.sendRedirect("createSoftware.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error updating user role: " + e.getMessage());
        }
    }
}
