<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <title>Create Software</title>
</head>
<body>
    <div class="container mt-5">
        <h1>Create Software</h1>
        <form action="createSoftware" method="post" class="mb-4">
            <div class="form-group">
                <label for="name">Software Name:</label>
                <input type="text" class="form-control" name="name" required>
            </div>
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea class="form-control" name="description" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Create</button>
        </form>

        <h2>Pending Requests</h2>
        <table class="table table-bordered table-striped">
            <thead class="thead-dark">
                <tr>
                    <th>Request ID</th>
                    <th>User ID</th>
                    <th>Software ID</th>
                    <th>Access Type</th>
                    <th>Reason</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try (Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/uam_db", "postgres", "KODNEST123");
                         PreparedStatement ps = con.prepareStatement("SELECT * FROM requests");
                         ResultSet rs = ps.executeQuery()) {

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
                        <form action="updateRequestStatus" method="post">
                            <input type="hidden" name="requestId" value="<%= rs.getInt("id") %>">
                            <button type="submit" class="btn btn-success" name="status" value="Approved">Approve</button>
                            <button type="submit" class="btn btn-danger" name="status" value="Rejected">Reject</button>
                            <button type="submit" class="btn btn-warning" name="status" value="Delete">Delete</button>
                        </form>
                    </td>
                </tr>
                <% 
                        } 
                    } catch (Exception e) { 
                        e.printStackTrace(); 
                    } 
                %>
            </tbody>
        </table>

        <h2>Manage Users</h2>
        <table class="table table-bordered table-striped">
            <thead class="thead-dark">
                <tr>
                    <th>User ID</th>
                    <th>Username</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try (Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/uam_db", "postgres", "KODNEST123");
                         Statement stmt = con.createStatement();
                         ResultSet rs = stmt.executeQuery("SELECT * FROM users")) {

                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("username") %></td>
                    <td><%= rs.getString("role") %></td>
                    <td>
                        <form action="manageUser" method="post" class="form-inline">
                            <input type="hidden" name="userId" value="<%= rs.getInt("id") %>">
                            <select name="role" class="form-control mr-2">
                                <option value="Employee" <%= rs.getString("role").equals("Employee") ? "selected" : "" %>>Employee</option>
                                <option value="Manager" <%= rs.getString("role").equals("Manager") ? "selected" : "" %>>Manager</option>
                                <option value="Admin" <%= rs.getString("role").equals("Admin") ? "selected" : "" %>>Admin</option>
                            </select>
                            <button type="submit" class="btn btn-primary">Update</button>
                            <button type="submit" class="btn btn-danger" name="deleteUser" value="Delete">Delete</button>
                        </form>
                    </td>
                </tr>
                <% 
                        } 
                    } catch (Exception e) { 
                        e.printStackTrace(); 
                    } 
                %>
            </tbody>
        </table>

        <a href="login.jsp" class="btn btn-secondary">Back To Login</a>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
