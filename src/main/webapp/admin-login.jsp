<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
<header>
		<div class="header-container">
			<h1>Admin Login</h1>
		</div>
	</header>
    <div class="login-container">
        
        <form action="AdminServlet" method="post" value>
            <label for="username">User Name:</label>
            <input type="text" id="username" name="username" required><br>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br>
            <input type="hidden" name="action" value="login">
            <button type="submit">Login</button>
        </form>
        <%-- Display error message --%>
        <% String error = (String) request.getAttribute("error"); 
           if (error != null) { %>
           <p class="error"><%= error %></p>
        <% } %>
    </div>
</body>
</html>
