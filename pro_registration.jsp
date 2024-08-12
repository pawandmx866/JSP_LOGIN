<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="registration-container">
        <%
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String ageStr = request.getParameter("age");
            String gender = request.getParameter("gender");
            String email = request.getParameter("email");
            String mobile = request.getParameter("mobile");
            String address = request.getParameter("address");
            String zipPin = request.getParameter("zipPin");
            String password = request.getParameter("password");

            Connection con = null;
            PreparedStatement pstmt = null;

            try {
                // Basic input validation
                if (firstName == null || lastName == null || ageStr == null || gender == null || email == null || mobile == null || address == null || zipPin == null || password == null ||
                    firstName.isEmpty() || lastName.isEmpty() || ageStr.isEmpty() || gender.isEmpty() || email.isEmpty() || mobile.isEmpty() || address.isEmpty() || zipPin.isEmpty() || password.isEmpty()) {
                    out.println("<p>All fields are required.</p>");
                    return;
                }

                int age = Integer.parseInt(ageStr);

                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp", "root", "");
                String query = "INSERT INTO register(first_name, last_name, age, gender, email, mobile, address, zip_pin, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                pstmt = con.prepareStatement(query);

                pstmt.setString(1, firstName);
                pstmt.setString(2, lastName);
                pstmt.setInt(3, age);
                pstmt.setString(4, gender);
                pstmt.setString(5, email);
                pstmt.setString(6, mobile);
                pstmt.setString(7, address);
                pstmt.setString(8, zipPin);
                pstmt.setString(9, password);

                int row = pstmt.executeUpdate();
                if (row > 0) {
                    // Redirect to index.jsp after successful registration
                    response.sendRedirect("success.jsp");
                } else {
                    out.println("<p>Registration failed. Please try again.</p>");
                }
            } catch (NumberFormatException e) {
                out.println("<p>Invalid age format. Please enter a valid number.</p>");
            } catch (Exception e) {
                out.println("<p>Error occurred: Please try again later.</p>");
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    // Log the exception
                }
            }
        %>
    </div>
</body>
</html>
