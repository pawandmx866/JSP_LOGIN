<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Registrations</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .navbar, .footer {
            background-color: #007BFF;
            color: white;
            text-align: center;
            padding: 10px;
        }
        .navbar a, .footer a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            font-weight: bold;
        }
        .navbar a:hover, .footer a:hover {
            text-decoration: underline;
        }
        .content {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 18px;
            text-align: left;
        }
        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f4f4f4;
        }
        .update-btn {
            display: block;
            width: 200px;
            margin: 20px auto;
            padding: 10px;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            background-color: #4CAF50;
        }
        .update-form {
            display: none;
            margin-top: 20px;
        }
        .update-form input {
            margin-bottom: 10px;
            padding: 8px;
            width: calc(100% - 20px);
        }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="index.jsp">Logout</a>
        <a href="alldata.jsp">View Data</a>
    </div>

    <div class="content">
        <h2>All Registrations</h2>
        <form id="updateForm" method="post">
            <button type="submit" class="update-btn">Update All Data</button>
        </form>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Age</th>
                    <th>Gender</th>
                    <th>Email</th>
                    <th>Mobile</th>
                    <th>Address</th>
                    <th>Zip Pin</th>
                    <th>Created At</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection con = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp", "root", "");
                        String query = "SELECT * FROM register";
                        stmt = con.createStatement();
                        rs = stmt.executeQuery(query);

                        while (rs.next()) {
                            int id = rs.getInt("id"); 
                            String firstName = rs.getString("first_name");
                            String lastName = rs.getString("last_name");
                            int age = rs.getInt("age");
                            String gender = rs.getString("gender");
                            String email = rs.getString("email");
                            String mobile = rs.getString("mobile");
                            String address = rs.getString("address");
                            String zipPin = rs.getString("zip_pin");
                            Timestamp createdAt = rs.getTimestamp("created_at");
                %>
                <tr>
                    <td><%= id %></td>
                    <td><%= firstName %></td>
                    <td><%= lastName %></td>
                    <td><%= age %></td>
                    <td><%= gender %></td>
                    <td><%= email %></td>
                    <td><%= mobile %></td>
                    <td><%= address %></td>
                    <td><%= zipPin %></td>
                    <td><%= createdAt %></td>
                    <td>
                        <button type="button" class="update-btn" onclick="showUpdateForm(<%= id %>, '<%= firstName %>', '<%= lastName %>', <%= age %>, '<%= gender %>', '<%= email %>', '<%= mobile %>', '<%= address %>', '<%= zipPin %>')">Update</button>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='11'>Error occurred: " + e.getMessage() + "</td></tr>");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (con != null) con.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </tbody>
        </table>

        <div id="updateFormContainer" class="update-form">
            <h3>Update Record</h3>
            <form id="formUpdate" method="post">
                <input type="hidden" id="updateId" name="updateId">
                <label>First Name:</label>
                <input type="text" id="updateFirstName" name="firstName">
                <label>Last Name:</label>
                <input type="text" id="updateLastName" name="lastName">
                <label>Age:</label>
                <input type="number" id="updateAge" name="age">
                <label>Gender:</label>
                <input type="text" id="updateGender" name="gender">
                <label>Email:</label>
                <input type="email" id="updateEmail" name="email">
                <label>Mobile:</label>
                <input type="text" id="updateMobile" name="mobile">
                <label>Address:</label>
                <input type="text" id="updateAddress" name="address">
                <label>Zip Pin:</label>
                <input type="text" id="updateZipPin" name="zipPin">
                <button type="submit" class="update-btn">Save Changes</button>
            </form>
        </div>

        <script>
            function showUpdateForm(id, firstName, lastName, age, gender, email, mobile, address, zipPin) {
                document.getElementById('updateId').value = id;
                document.getElementById('updateFirstName').value = firstName;
                document.getElementById('updateLastName').value = lastName;
                document.getElementById('updateAge').value = age;
                document.getElementById('updateGender').value = gender;
                document.getElementById('updateEmail').value = email;
                document.getElementById('updateMobile').value = mobile;
                document.getElementById('updateAddress').value = address;
                document.getElementById('updateZipPin').value = zipPin;
                document.getElementById('updateFormContainer').style.display = 'block';
            }
        </script>
    </div>

    <div class="footer">
        <p>&copy; 2024 Your Company. All rights reserved.</p>
    </div>

    <%
        String updateId = request.getParameter("updateId");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String ageStr = request.getParameter("age");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String address = request.getParameter("address");
        String zipPin = request.getParameter("zipPin");

        PreparedStatement pstmt = null;

        if (updateId != null && !updateId.isEmpty()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp", "root", "");
                String updateQuery = "UPDATE register SET first_name = ?, last_name = ?, age = ?, gender = ?, email = ?, mobile = ?, address = ?, zip_pin = ? WHERE id = ?";
                pstmt = con.prepareStatement(updateQuery);

                pstmt.setString(1, firstName);
                pstmt.setString(2, lastName);
                pstmt.setInt(3, Integer.parseInt(ageStr));
                pstmt.setString(4, gender);
                pstmt.setString(5, email);
                pstmt.setString(6, mobile);
                pstmt.setString(7, address);
                pstmt.setString(8, zipPin);
                pstmt.setInt(9, Integer.parseInt(updateId));

                int rowsUpdated = pstmt.executeUpdate();

                if (rowsUpdated > 0) {
                    out.println("<p>Record updated successfully.</p>");
                } else {
                    out.println("<p>Update failed.</p>");
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</body>
</html>
