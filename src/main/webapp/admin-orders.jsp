<%@ page language="java"
	import="java.sql.*, com.store.utils.DBConnection"%>
<%@ page session="true"%>
<%
Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
if (isAdmin == null || !isAdmin) {
	response.sendRedirect("admin-login.jsp");
	return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Order Management</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">
<style>

.container {
	width: 100%; 
	max-width: 1200px; 
	margin: 0 auto; 
	padding: 20px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin: 20px 0;
	background-color: white;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

th, td {
	padding: 12px;
	text-align: center;
	border-bottom: 1px solid #ddd;
}

th {
	background-color: #333;
	color: white;
}

tr:hover {
	background-color: #f5f5f5;
}

.back-link {
	text-align: center;
	margin-top: 20px;
}

.back-link a {
	background-color: #3498db;
	color: white;
	padding: 10px 20px;
	text-decoration: none;
	border-radius: 5px;
	font-size: 16px;
}

</style>
</head>
<body>
	<header>
		<div class="header-container">
			<h1>Order Management</h1>
		</div>
	</header>

	<div class="container">
		<table>
			<tr>
				<th>Order ID</th>
				<th>User Name</th>
				<th>Email</th>
				<th>Phone</th>
				<th>Book Title</th>
				<th>Quantity</th>
				<th>Payment Method</th>
				<th>Address</th>
				<th>Order Date</th>
			</tr>
			<%
			try (Connection conn = DBConnection.getConnection()) {
				String sql = "SELECT o.id, u.name, u.email, u.phone, b.title, o.quantity, o.payment_method, o.address, o.order_date "
				+ "FROM orders o " + "JOIN users u ON o.user_id = u.id " + "JOIN books b ON o.book_id = b.id";
				PreparedStatement stmt = conn.prepareStatement(sql);
				ResultSet rs = stmt.executeQuery();

				while (rs.next()) {
			%>
			<tr>
				<td><%=rs.getInt("id")%></td>
				<td><%=rs.getString("name")%></td>
				<td><%=rs.getString("email")%></td>
				<td><%=rs.getString("phone")%></td>
				<td><%=rs.getString("title")%></td>
				<td><%=rs.getInt("quantity")%></td>
				<td><%=rs.getString("payment_method")%></td>
				<td><%=rs.getString("address")%></td>
				<td><%=rs.getTimestamp("order_date")%></td>
			</tr>
			<%
			}
			} catch (SQLException e) {
			out.println("<tr><td colspan='9' class='error'>Error: " + e.getMessage() + "</td></tr>");
			}
			%>
		</table>

		<div class="back-link">
			<p>
				<a href="admin.jsp">Back to Dashboard</a>
			</p>
		</div>
	</div>
</body>
</html>
