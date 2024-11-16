package servlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class RequestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String softwareId = request.getParameter("softwareId");
        String accessType = request.getParameter("accessType");
        String reason = request.getParameter("reason");

        HttpSession session = request.getSession(false); // Only retrieves the session if it exists

        if (session == null) {
            System.out.println("Session is null.");
            response.sendRedirect("login.jsp");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            System.out.println("userId is null in session.");
            response.sendRedirect("login.jsp");
            return;
        }

        System.out.println("Session exists. userId: " + userId); // Confirm session details

        try {
            Class.forName("org.postgresql.Driver");

            try (Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/uam_db", "postgres", "KODNEST123");
                 PreparedStatement ps = con.prepareStatement("INSERT INTO requests (user_id, software_id, access_type, reason, status) VALUES (?, ?, ?, ?, 'Pending')")) {

                ps.setInt(1, userId);
                ps.setInt(2, Integer.parseInt(softwareId));
                ps.setString(3, accessType);
                ps.setString(4, reason);

                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    response.sendRedirect("requestAccess.jsp");
                } else {
                    response.getWriter().write("Error: No rows affected during the access request.");
                }
            }
        } catch (NumberFormatException nfe) {
            response.getWriter().write("Invalid input: " + nfe.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error during access request: " + e.getMessage());
        }
    }
}
