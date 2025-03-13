<%@ page language="java" import="java.sql.*, com.store.utils.DBConnection"%>
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
<title>Admin Dashboard</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>

	<header>
    <div class="header-container" style="display: flex; justify-content: space-between; align-items: center; padding: 10px 20px;">
        <h1 style="color: white; margin: 0;">Admin Dashboard</h1>
        <nav>
            <p class="logout-text" style="margin: 0;">
                <a href="logout.jsp" class="logout-link" style="background-color: #e74c3c; color: white; padding: 12px 20px; font-size: 16px; border-radius: 4px; text-align: center; display: inline-block; text-decoration: none;">Logout</a>
            </p>
        </nav>
    </div>
</header>


	<div class="container">

		<!-- Add Book Form Section -->
		<section class="form-section">
			<h3 class="section-title" style="color: #333; fontweight: bold; fontsize:20px">Add a New Book</h3>
			<form action="AdminServlet" method="post" class="add-book-form">
				<input type="hidden" name="action" value="addBook">
				<div class="form-group">
					<label for="title">Title:</label>
					<input type="text" name="title" id="title" required>
				</div>
				<div class="form-group">
					<label for="author">Author:</label>
					<input type="text" name="author" id="author" required>
				</div>
				<div class="form-group">
					<label for="publication">Publication:</label>
					<input type="text" name="publication" id="publication" required>
				</div>
				<div class="form-group">
					<label for="category">Category/Genre:</label>
					<input type="text" name="category" id="category" required>
				</div>
				<div class="form-group">
					<label for="price">Price:</label>
					<input type="number" name="price" id="price" step="0.01" required>
				</div>
				<div class="form-group">
					<label for="quantity">Quantity:</label>
					<input type="number" name="quantity" id="quantity" required>
				</div>
				<button type="submit" class="submit-btn">Add Book</button>
			</form>
		</section>

		<!-- Current Books Table Section -->
		<section class="table-section">
			<h3 class="section-title" style="color: #333; fontweight: bold; fontsize:20px">Current Books</h3>
			<table class="books-table">
				<thead>
					<tr>
						<th>Title</th>
						<th>Author</th>
						<th>Publication</th>
						<th>Category</th>
						<th>Price</th>
						<th>Quantity</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<%
                        try (Connection conn = DBConnection.getConnection()) {
                            String sql = "SELECT * FROM books";
                            PreparedStatement stmt = conn.prepareStatement(sql);
                            ResultSet rs = stmt.executeQuery();

                            while (rs.next()) {
                    %>
					<tr>
						<td><%= rs.getString("title") %></td>
						<td><%= rs.getString("author") %></td>
						<td><%= rs.getString("publication") %></td>
						<td><%= rs.getString("category") %></td>
						<td>Rs. <%= rs.getDouble("price") %></td>
						<td><%= rs.getInt("quantity") %></td>
						<td class="action-links">
							<a href="EditBookServlet?id=<%= rs.getInt("id") %>" class="action-link">Edit</a>
							<!-- <a href="DeleteBookServlet?id=<%= rs.getInt("id") %>" class="action-link">Delete</a> -->
						</td>
					</tr>
					<%
					}
					} catch (SQLException e) {
					out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
					}
					%>
				</tbody>
			</table>
		</section>

		<!-- Order Management Section -->
		<section class="order-management">
			<h3 class="section-title" style="color: #333; fontweight: bold; fontsize:20px">Order Management</h3>
			<p align="center">Manage all customer orders from a dedicated page.</p>
			<p align="center"><a href="admin-orders.jsp" class="button">Go to Orders Page</a></p>
		</section>

	</div>

</body>
</html>
