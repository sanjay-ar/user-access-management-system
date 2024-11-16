package servlet;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/uam_db", "postgres", "KODNEST123");
            PreparedStatement ps = con.prepareStatement("SELECT id, role FROM users WHERE username=? AND password=?");
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("id");
                String role = rs.getString("role");

                // Create a session and store the user information
                HttpSession session = request.getSession(true); // Creates a new session if it doesn't exist
                session.setAttribute("userId", userId);
                session.setAttribute("username", username);
                session.setAttribute("role", role);
                session.setMaxInactiveInterval(30 * 60); // 30-minute session timeout

                // Debugging output
                System.out.println("Session created. UserID: " + session.getAttribute("userId"));

                // Redirect based on user role
                switch (role) {
                    case "Employee":
                        response.sendRedirect("requestAccess.jsp");
                        break;
                    case "Manager":
                        response.sendRedirect("pendingRequests.jsp");
                        break;
                    case "Admin":
                        response.sendRedirect("createSoftware.jsp");
                        break;
                }
            } else {
                response.sendRedirect("login.jsp?error=Invalid credentials");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error during login: " + e.getMessage());
        }
    }
}
