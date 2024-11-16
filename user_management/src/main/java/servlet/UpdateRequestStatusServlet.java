package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class UpdateRequestStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int requestId = Integer.parseInt(request.getParameter("requestId"));
        String status = request.getParameter("status");

        try (Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/uam_db", "postgres", "KODNEST123")) {
            if (status.equals("Delete")) {
                // Delete request
                try (PreparedStatement ps = con.prepareStatement("DELETE FROM requests WHERE id = ?")) {
                    ps.setInt(1, requestId);
                    ps.executeUpdate();
                }
            } else {
                // Update request status
                try (PreparedStatement ps = con.prepareStatement("UPDATE requests SET status = ? WHERE id = ?")) {
                    ps.setString(1, status);
                    ps.setInt(2, requestId);
                    ps.executeUpdate();
                }
            }
            // Redirect back to createSoftware.jsp to display all requests
            response.sendRedirect("createSoftware.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error updating request status: " + e.getMessage());
        }
    }
}
