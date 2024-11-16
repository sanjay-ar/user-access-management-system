package servlet;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class ApprovalServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int requestId = Integer.parseInt(request.getParameter("requestId"));
        String status = request.getParameter("status"); // "Approved" or "Rejected"

        try {
        	Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/uam_db", "postgres", "KODNEST123");
            PreparedStatement ps = con.prepareStatement("UPDATE requests SET status=? WHERE id=?");
            ps.setString(1, status);
            ps.setInt(2, requestId);
            ps.executeUpdate();
            response.sendRedirect("pendingRequests.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error during approval: " + e.getMessage());
        }
    }
}
