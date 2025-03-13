<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <header>
		<div class="header-container">
			<h1>User Login</h1>
		</div>
	</header>
    <form action="UserServlet" method="post">
        <input type="hidden" name="action" value="login">
        <label>Email:</label>
        <input type="email" name="email" required><br>
        <label>Password:</label>
        <input type="password" name="password" required><br>
        <button type="submit">Login</button>
    </form>
    <p align="center"><a href="register.jsp">Don't have an account? Register here</a></p>
    <% String error = (String) request.getAttribute("error"); 
           if (error != null) { %>
           <p class="error"><%= error %></p>
        <% } %>
</body>
</html>
