<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Request Access</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>Request Software Access</h2>

        <form action="requestAccess" method="post">
            <!-- Software Selection Dropdown -->
            <div class="form-group">
                <label for="softwareId">Select Software:</label>
                <select name="softwareId" id="softwareId" class="form-control" required>
                    <option value="">--Select Software--</option>
                    <%
                        // Connecting to the database to fetch software list
                        try {
                            Class.forName("org.postgresql.Driver");
                            Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/uam_db", "postgres", "KODNEST123");
                            PreparedStatement ps = con.prepareStatement("SELECT id, name FROM software");
                            ResultSet rs = ps.executeQuery();

                            // Loop through software entries and populate the dropdown
                            while (rs.next()) {
                                int softwareId = rs.getInt("id");
                                String softwareName = rs.getString("name");
                    %>
                                <option value="<%= softwareId %>"><%= softwareName %></option>
                    <%
                            }
                            con.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                    %>
                            <option value="">Error loading software</option>
                    <%
                        }
                    %>
                </select>
            </div>

            <!-- Access Type -->
            <div class="form-group">
                <label for="accessType">Access Type:</label>
                <input type="text" name="accessType" id="accessType" class="form-control" required>
            </div>

            <!-- Reason for Request -->
            <div class="form-group">
                <label for="reason">Reason for Access:</label>
                <textarea name="reason" id="reason" class="form-control" rows="4" required></textarea>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary">Submit Request</button>
        </form>

        <!-- Optional link to go back -->
        <br>
        <a href="login.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
