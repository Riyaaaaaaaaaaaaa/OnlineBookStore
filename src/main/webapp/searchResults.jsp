<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.List, com.store.models.Book"%>
<!DOCTYPE html>
<html>
<head>
    <title>Search Results</title>
    <style>
        /* General Styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            color: #3498db;
            margin-top: 20px;
        }

        /* Table Styling */
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
            text-transform: uppercase;
            font-weight: bold;
        }

        table td {
            color: #555;
            font-size: 14px;
        }

        table tr:hover {
            background-color: #f9f9f9;
        }

        /* Button Styling */
        a.add-to-cart-btn {
            background-color: #2ecc71;
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            font-size: 14px;
            border-radius: 4px;
            display: inline-block;
        }

        a.add-to-cart-btn:hover {
            background-color: #27ae60;
        }
    </style>
</head>
<body>
    
    <h1>Search Results</h1>
    <table>
        <tr>
            <th>Title</th>
            <th>Author</th>
            <th>Category</th>
            <th>Quantity</th>
            <th>Price</th>
            <th>Add to Cart</th>
        </tr>
        <% 
            List<Book> books = (List<Book>) request.getAttribute("books");
            if (books != null && !books.isEmpty()) {
                for (Book book : books) {
        %>
        <tr>
            <td><%= book.getTitle() %></td>
            <td><%= book.getAuthor() %></td>
            <td><%= book.getCategory() %></td>
            <td><%= book.getQuantity() %></td>
            <td><%= String.format("$%.2f", book.getPrice()) %></td>
            <td>
                <a class="add-to-cart-btn" href="CartServlet?action=addToCart&bookId=<%= book.getId() %>&quantity=1">
                    Add to Cart
                </a>
            </td>
        </tr>
        <% 
                }
            } else {
        %>
        <tr>
            <td colspan="5">No books found matching your search criteria.</td>
        </tr>
        <% } %>
    </table>
</body>
</html>
