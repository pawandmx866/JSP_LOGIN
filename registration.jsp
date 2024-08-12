<!DOCTYPE html>
<html>
<head>
    <title>Registration Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            justify-content: center;
            align-items: center;
            background-color: #f4f4f4;
        }
        .navbar, .footer {
            background-color: #007BFF;
            color: white;
            text-align: center;
            padding: 10px;
            width: 100%;
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
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 100%;
            max-width: 600px;
        }
        table {
            margin: 0 auto;
            border-collapse: collapse;
            width: 100%;
        }
        td {
            padding: 10px;
        }
        .error {
            color: red;
        }
    </style>
    <script>
        function validateForm() {
            var isValid = true;
            var elements = document.forms["registrationForm"].elements;

            for (var i = 0; i < elements.length; i++) {
                if (elements[i].type !== "submit" && elements[i].value === "") {
                    isValid = false;
                    elements[i].nextElementSibling.innerHTML = "This field is required";
                } else {
                    elements[i].nextElementSibling.innerHTML = "";
                }
            }

            var password = document.forms["registrationForm"]["password"].value;
            if (password.length < 8) {
                isValid = false;
                document.getElementById("passwordError").innerHTML = "Password must be at least 8 characters long";
            } else {
                document.getElementById("passwordError").innerHTML = "";
            }

            return isValid;
        }
    </script>
</head>
<body>
    <div class="navbar">
        <a href="index.jsp">Home</a>
        <a href="about.jsp">About</a>
        <a href="contact.jsp">Contact</a>
    </div>

    <div class="content">
        <h2>Registration Form</h2>
        <form name="registrationForm" action="pro_registration.jsp" method="post" onsubmit="return validateForm()">
            <table>
                <tr>
                    <td>First Name:</td>
                    <td><input type="text" name="firstName" /><span class="error"></span></td>
                </tr>
                <tr>
                    <td>Last Name:</td>
                    <td><input type="text" name="lastName" /><span class="error"></span></td>
                </tr>
                <tr>
                    <td>Age:</td>
                    <td><input type="text" name="age" /><span class="error"></span></td>
                </tr>
                <tr>
                    <td>Gender:</td>
                    <td>
                        <select name="gender">
                            <option value="">Select</option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                        </select>
                        <span class="error"></span>
                    </td>
                </tr>
                <tr>
                    <td>Email:</td>
                    <td><input type="email" name="email" /><span class="error"></span></td>
                </tr>
                <tr>
                    <td>Mobile:</td>
                    <td><input type="text" name="mobile" /><span class="error"></span></td>
                </tr>
                <tr>
                    <td>Address:</td>
                    <td><input type="text" name="address" /><span class="error"></span></td>
                </tr>
                <tr>
                    <td>Zip/Pin:</td>
                    <td><input type="text" name="zipPin" /><span class="error"></span></td>
                </tr>
                <tr>
                    <td>Password:</td>
                    <td><input type="password" name="password" /><span id="passwordError" class="error"></span></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="Register" />
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <div class="footer">
     
        <p>&copy; 2024 Your Company. All rights reserved.</p>
    </div>
</body>
</html>
