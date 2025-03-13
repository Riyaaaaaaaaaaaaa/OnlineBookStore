<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <script>
        function validateForm() {
            const password = document.getElementById("password").value;
            const confirmPassword = document.getElementById("confirmpassword").value;

            if (password !== confirmPassword) {
                alert("Passwords do not match!");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <header>
		<div class="header-container">
			<h1>User Registration</h1>
		</div>
	</header>
	
    <form action="UserServlet" method="post" onsubmit="return validateForm()">
        <input type="hidden" name="action" value="register">
        
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" placeholder="Enter your full name" required><br>
        
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" placeholder="Enter your email" required><br>
        
        <label for="phone">Phone Number:</label>
        <input type="tel" id="phone" name="phone" placeholder="Enter your phone number" pattern="[0-9]{10}" 
               title="Phone number must be 10 digits" required><br>
               
        <label for="address">Address:</label>
        <textarea id="address" name="address" placeholder="Enter your address" required></textarea><br>
        
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" placeholder="Create a password" required><br>
        
        <label for="confirmpassword">Confirm Password:</label>
        <input type="password" id="confirmpassword" name="confirmpassword" placeholder="Re-enter your password" required><br>
        
        <button type="submit">Register</button>
    </form>
    <p align="center">Already have an account?<a href="login.jsp"> Back to Login</a></p>
</body>
</html>
