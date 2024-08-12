<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .navbar {
            background-color: #00f; /* Neon blue background */
            padding: 15px;
            color: #fff;
            text-align: center;
            font-size: 18px;
        }
        .navbar a {
            color: #fff;
            text-decoration: none;
            padding: 10px 20px;
            font-size: 16px;
        }
        .navbar a:hover {
            background-color: #00c; /* Darker neon blue on hover */
            border-radius: 5px;
        }
        .login-container {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 300px;
            margin: auto;
            margin-top: 50px; /* Space from the top */
        }
        .login-form {
            margin: 0;
        }
        .input-group {
            margin-bottom: 15px;
        }
        .input-group label {
            display: block;
            margin-bottom: 5px;
        }
        .input-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .login-button {
            width: 100%;
            padding: 10px;
            background-color: #00f; /* Neon blue background */
            border: none;
            border-radius: 5px;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
        }
        .login-button:hover {
            background-color: #00c; /* Darker neon blue on hover */
        }
        .link {
            margin-top: 15px;
            display: block;
        }
        .link a {
            text-decoration: none;
            color: #00f; /* Neon blue link */
            font-size: 14px;
        }
        .link a:hover {
            text-decoration: underline;
        }
        .footer {
            background-color: #00f; /* Neon blue background */
            color: #fff;
            text-align: center;
            padding: 10px;
            position: absolute;
            bottom: 0;
            width: 100%;
            font-size: 14px;
        }
        video {
            position: fixed;
            top: 50%;
            left: 50%;
            min-width: 100%;
            min-height: 100%;
            width: auto;
            height: auto;
            z-index: -1;
            transform: translate(-50%, -50%);
            background-size: cover;
            object-fit: cover; /* Ensures the video covers the entire viewport */
        }
    </style>
</head>
<body>
    <!-- Video Background -->
    <video class="video" autoplay muted loop controls>
        <source src="pika.mp4" type="video/mp4">
        <img src="fallback.jpg" alt="Fallback image">
        Your browser does not support the video tag.
    </video>
    <div class="navbar">
        <a href="index.jsp">Home</a>
        <a href="about.jsp">About</a>
        <a href="contact.jsp">Contact</a>
    </div>

    <div class="login-container">
        <form class="login-form" method="post">
            <h2>Login</h2>
            <div class="input-group">
                <label for="email">Email</label>
                <input type="text" id="email" name="email" required>
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="login-button">Login</button>
            <div class="link">
                <a href="registration.jsp">Register</a>
            </div>
        </form>
        <%
            if (request.getMethod().equalsIgnoreCase("post")) {
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String dbUrl = "jdbc:mysql://localhost:3306/jsp";
                String dbUser = "root";
                String dbPass = ""; 

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                    String sql = "SELECT * FROM register WHERE email = ? AND password = ?";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, email);
                    pstmt.setString(2, password);
                    ResultSet rs = pstmt.executeQuery();

                    if (rs.next()) {
                        String firstName = rs.getString("first_name");
                        response.sendRedirect("welcome.jsp?firstName=" + URLEncoder.encode(firstName, "UTF-8"));
                    } else {
                        out.println("<p>Invalid email or password.</p>");
                    }

                    rs.close();
                    pstmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Error occurred: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>

    <div class="footer">
        &copy; 2024 Your Company. All rights reserved.
    </div>
</body>
</html>
