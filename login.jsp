<%@ page import="java.sql.*" %>
<%
            if (request.getMethod().equalsIgnoreCase("post")) {
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String dbUrl = "jdbc:mysql://localhost:3306/jsp";
                String dbUser = "root";
                String dbPass = ""; // replace with your actual database password

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                    String sql = "SELECT * FROM register WHERE email = ? AND password = ?";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, email);
                    pstmt.setString(2, password);
                    ResultSet rs = pstmt.executeQuery();

                    if (rs.next()) {
                        // Authentication successful
                        out.println("<p>Login successful! Welcome, " + rs.getString("first_name") + ".</p>");
                    } else {
                        // Authentication failed
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
