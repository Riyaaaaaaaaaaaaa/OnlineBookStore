<%@ page language="java" import="java.util.*, jakarta.servlet.http.*, com.store.utils.DBConnection, java.sql.*" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
    <title>Your Shopping Cart</title>
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
        .actions {
            text-align: center;
            margin-top: 20px;
        }
        .checkout-btn {
            background-color: #2ecc71;
            color: white;
            padding: 10px 20px;
            font-size: 1.1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .checkout-btn:hover {
            background-color: #27ae60;
        }
        .remove-btn {
            background-color: #e74c3c;
            color: white;
            padding: 5px 10px;
            font-size: 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .remove-btn:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
<header>
    <div class="header-container">
        <h2 style="color: white; margin: 0;" align="center">Your Shopping Cart</h2>
    </div>
</header>

<%
    Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
    if (cart == null || cart.isEmpty()) {
%>
    <p>Your cart is empty.</p>
<%
    } else {
        double total = 0;
%>
    <table>
        <tr>
            <th>Book Title</th>
            <th>Author</th>
            <th>Category</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total</th>
            <th>Action</th>
        </tr>
        <%
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                int bookId = entry.getKey();
                int quantity = entry.getValue();
                
                try (Connection conn = DBConnection.getConnection()) {
                    String sql = "SELECT * FROM books WHERE id = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, bookId);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        String title = rs.getString("title");
                        String author = rs.getString("author");
                        String category = rs.getString("category");
                        double price = rs.getDouble("price");
                        double itemTotal = price * quantity;
                        total += itemTotal;
        %>
        <tr>
            <td><%= title %></td>
            <td><%= author %></td>
            <td><%= category %></td>
            <td><%= price %></td>
            <td>
                <form action="CartServlet" method="post">
                    <input type="hidden" name="action" value="updateQuantity">
                    <input type="hidden" name="bookId" value="<%= bookId %>">
                    <input type="number" name="quantity" value="<%= quantity %>" min="1" max="99">
                    <button type="submit">Update Quantity</button>
                </form>
            </td>
            <td><%= itemTotal %></td>
            <td>
                <form action="CartServlet" method="post">
                    <input type="hidden" name="action" value="removeFromCart">
                    <input type="hidden" name="bookId" value="<%= bookId %>">
                    <button type="submit" class="remove-btn">Remove</button>
                </form>
            </td>
        </tr>
        <%
                    }
                } catch (SQLException e) {
                    out.println("<h3>Error retrieving book details: " + e.getMessage() + "</h3>");
                }
            }
        %>
    </table>

    <div class="actions">
        <h3 style="color: black">Total: <%= total %> </h3>
        <form action="CartServlet" method="post">
            <input type="hidden" name="action" value="checkout">
            <button type="submit" class="checkout-btn">Proceed to Checkout</button>
        </form>
    </div>
<%
    }
%>
</body>
</html>
