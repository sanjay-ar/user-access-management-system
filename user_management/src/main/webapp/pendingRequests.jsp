<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Pending Requests</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="container mt-5">
        <h1>Pending Access Requests</h1>
        <table class="table table-bordered table-striped">
            <thead class="thead-light">
                <tr>
                    <th>Request ID</th>
                    <th>User ID</th>
                    <th>Software ID</th>
                    <th>Access Type</th>
                    <th>Reason</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
    <%
        // Fetch pending requests from the database
        try {
            try (Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/uam_db", "postgres", "KODNEST123");
                 PreparedStatement ps = con.prepareStatement("SELECT * FROM requests WHERE status='Pending'");
                 ResultSet rs = ps.executeQuery()) {

                // Check if any results were found
                if (rs.isBeforeFirst()) { // Data found
                    while (rs.next()) {
    %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getInt("user_id") %></td>
                <td><%= rs.getInt("software_id") %></td>
                <td><%= rs.getString("access_type") %></td>
                <td><%= rs.getString("reason") %></td>
                <td><%= rs.getString("status") %></td>
                <td>
                    <form action="approveRequest" method="post">
                        <input type="hidden" name="requestId" value="<%= rs.getInt("id") %>">
                        <button type="submit" class="btn btn-success" name="status" value="Approved">Approve</button>
                        <button type="submit" class="btn btn-danger" name="status" value="Rejected">Reject</button>
                    </form>
                </td>
            </tr>
    <%
                    } // End of while(rs.next())
                } else { // No results found
    %>
            <tr>
                <td colspan="7" class="text-center">No pending requests found.</td>
            </tr>
    <%
                }
            } // End of try-with-resources
        } catch (Exception e) {
            e.printStackTrace();
    %>
            <tr>
                <td colspan="7" class="text-center">Error fetching pending requests: <%= e.getMessage() %></td>
            </tr>
    <%
        } // End of catch
    %>
            </tbody>
        </table>
        <a href="login.jsp" class="btn btn-primary">Back To Login</a>
    </div>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
</body>
</html>
