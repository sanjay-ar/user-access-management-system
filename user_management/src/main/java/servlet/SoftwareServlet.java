package servlet;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class SoftwareServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String softwareName = request.getParameter("name");
        String description = request.getParameter("description");
        
        try {
        	 Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/uam_db", "postgres", "KODNEST123");
            PreparedStatement ps = con.prepareStatement("INSERT INTO software (name, description) VALUES (?, ?)");
            ps.setString(1, softwareName);
            ps.setString(2, description);
            ps.executeUpdate();
            response.sendRedirect("createSoftware.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error during software creation: " + e.getMessage());
        }
    }
}
