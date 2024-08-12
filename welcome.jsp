<%@ page import="java.net.URLDecoder" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome</title>
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
        .panel {
            border: 2px solid #007BFF;
            border-radius: 8px;
            padding: 20px;
            width: 80%;
            max-width: 600px;
            background-color: #f9f9f9;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="index.jsp">Log out</a>
        <a href="alldata.jsp">View Data</a>
    </div>

    <div class="content">
        <div class="panel">
            <h1>Welcome</h1>
            <%
                String firstName = request.getParameter("firstName");
                if (firstName != null) {
                    firstName = URLDecoder.decode(firstName, "UTF-8");
                    out.println("<p>Welcome, " + firstName + "!</p>");
                } else {
                    out.println("<p>Welcome, guest!</p>");
                }
            %>
        </div>
    </div>

    <div class="footer">
       
        <p>&copy; 2024 Your Company. All rights reserved.</p>
    </div>
</body>
</html>
