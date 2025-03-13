<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Edit Book</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">
<style>
/* General Page Styles */

form {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.form-group {
    display: flex;
    flex-direction: column;
}

.form-group label {
    font-size: 16px;
    font-weight: bold;
    color: #333;
}

.form-group input {
    padding: 10px;
    font-size: 14px;
    border: 1px solid #ddd;
    border-radius: 4px;
    width: 100%;
    box-sizing: border-box;
}

.form-group input:focus {
    outline: none;
    border-color: #3498db;
    box-shadow: 0 0 5px rgba(52, 152, 219, 0.5);
}

button.submit-btn {
    padding: 12px 20px;
    background-color: #3498db;
    color: white;
    font-size: 16px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

button.submit-btn:hover {
    background-color: #2980b9;
}

button.submit-btn:focus {
    outline: none;
}

</style>
</head>
<body>
    <header>
        <div class="header-container">
            <h1>Edit Book</h1>
        </div>
    </header>

    <div class="container">
        <%
            ResultSet book = (ResultSet) request.getAttribute("book");
            if (book != null) {
        %>
        <form action="EditBookServlet" method="post" class="edit-book-form">
            <input type="hidden" name="id" value="<%= book.getInt("id") %>">
            
            <div class="form-group">
                <label for="title">Title:</label>
                <input type="text" id="title" name="title" value="<%= book.getString("title") %>" required>
            </div>
            
            <div class="form-group">
                <label for="author">Author:</label>
                <input type="text" id="author" name="author" value="<%= book.getString("author") %>" required>
            </div>
            
            <div class="form-group">
                <label for="publication">Publication:</label>
                <input type="text" id="publication" name="publication" value="<%= book.getString("publication") %>" required>
            </div>
            
            <div class="form-group">
                <label for="category">Category:</label>
                <input type="text" id="category" name="category" value="<%= book.getString("category") %>" required>
            </div>
            
            <div class="form-group">
                <label for="price">Price:</label>
                <input type="text" id="price" name="price" value="<%= book.getDouble("price") %>" required>
            </div>
            
            <div class="form-group">
                <label for="quantity">Quantity:</label>
                <input type="text" id="quantity" name="quantity" value="<%= book.getInt("quantity") %>" required>
            </div>
            
            <button type="submit" class="submit-btn">Update Book</button>
        </form>
        <%
            } else {
                out.println("<div class='error-message'>Error: Book not found!</div>");
            }
        %>
    </div>
</body>
</html>
