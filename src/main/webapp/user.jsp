<%@ page language="java" import="java.sql.*, com.store.utils.DBConnection"%>
<%@ page session="true"%>
<%
Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <style>
        /* Styling */
        table {
            width: 80%;
            margin: 40px auto;
            border-collapse: collapse;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            border-radius: 8px;
        }

        table th, table td {
            padding: 12px 20px;
            text-align: center;
            border: 1px solid #ddd;
        }

        table th {
            background-color: #3498db;
            color: white;
        }

        table td {
            color: #555;
        }

        table tr:hover {
            background-color: #f1f1f1;
        }

        .logout-btn {
            background-color: #e74c3c;
            color: white;
            padding: 12px 20px;
            font-size: 1.1rem;
            border-radius: 4px;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .logout-btn:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
    <header>
    <div class="header-container" style="display: flex; justify-content: space-between; align-items: center; padding: 10px 20px;">
        <h1 style="color: white; margin: 0;">Welcome to the Book Store, <%= session.getAttribute("userName") %></h1>
        <nav>
            <p class="logout-text" style="margin: 0;">
                <!-- <a href="logout.jsp" class="logout-link" style="background-color: #e74c3c; color: white; padding: 12px 20px; font-size: 16px; border-radius: 4px; text-align: center; display: inline-block; text-decoration: none;">Logout</a> -->
                <a href="logout.jsp" class="logout-btn">Logout</a>
            </p>
        </nav>
    </div>
</header>
    <h2 style="text-align: center; color: #3498db;">Search for Books</h2>
<form action="UserServlet" method="get" style="width: 60%; margin: 20px auto; padding: 20px; background-color: #f9f9f9; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); border-radius: 8px;">
    <input type="hidden" name="action" value="search">
    <div style="display: flex; flex-direction: column; gap: 15px;">
        <!-- Note -->
        <p style="text-align: center; color: #555; font-style: italic; margin-bottom: 10px;">
            <span style="color:red">*</span> You can enter any one field (Title, Author, or Category) to search for books.
        </p>
        <!-- Title Field -->
        <div style="display: flex; align-items: center; gap: 10px;">
            <label for="title" style="flex: 1; font-weight: bold; color: #555;">Title:</label>
            <input type="text" id="title" name="title" placeholder="Enter book title" style="flex: 3; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 1rem;">
        </div>
        <!-- Author Field -->
        <div style="display: flex; align-items: center; gap: 10px;">
            <label for="author" style="flex: 1; font-weight: bold; color: #555;">Author:</label>
            <input type="text" id="author" name="author" placeholder="Enter author name" style="flex: 3; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 1rem;">
        </div>
        <!-- Category Field -->
        <div style="display: flex; align-items: center; gap: 10px;">
            <label for="category" style="flex: 1; font-weight: bold; color: #555;">Category:</label>
            <input type="text" id="category" name="category" placeholder="Enter book category" style="flex: 3; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 1rem;">
        </div>
        <!-- Submit Button -->
        <div style="text-align: center; margin-top: 20px;">
            <button type="submit" style="background-color: #3498db; color: white; padding: 12px 25px; font-size: 1rem; font-weight: bold; border: none; border-radius: 5px; cursor: pointer; transition: all 0.3s ease;">
                Search
            </button>
        </div>
    </div>
</form>



    <h2 style="color:#3498db">Your Books</h2>
    <table>
        <tr>
            <th>Book Title</th>
            <th>Author</th>
            <th>Category</th>
            <th>Quantity</th>
            <th>Price</th>
            <th>Action</th>
        </tr>
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
            <td><%= rs.getString("category") %></td>
            <td><%= rs.getString("quantity") %></td>
            <td><%= rs.getDouble("price") %></td>
            <td>
                <a href="UserServlet?action=addToCart&bookId=<%= rs.getInt("id") %>&quantity=1">Add to Cart</a>
            </td>
        </tr>
        <% 
            } 
        } catch (SQLException e) {
            out.println("<h3>Error connecting to the database: " + e.getMessage() + "</h3>");
        }
        %>
    </table>
</body>
</html>