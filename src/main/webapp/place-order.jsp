<%@ page language="java" import="java.util.*, com.store.models.Book, com.store.dao.BookDAO, jakarta.servlet.http.*, com.store.utils.DBConnection, java.sql.*" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
    <title>Place Order</title>
    <style>
        /* Basic styling */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 70%;
            margin: 20px auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #3498db;
            font-size: 32px;
            margin-bottom: 20px;
        }

        .book-details {
            margin-bottom: 30px;
            font-size: 16px;
        }

        .book-details p {
            margin: 10px 0;
            font-weight: 500;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            font-size: 18px;
            font-weight: 600;
            color: #333;
        }

        input[type="number"], textarea, select, input[type="text"] {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-top: 8px;
            background-color: #f9f9f9;
            color: #333;
            box-sizing: border-box;
        }

        input[type="number"]:focus, textarea:focus, select:focus, input[type="text"]:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.5);
        }

        button {
            width: 100%;
            background-color: #3498db;
            color: white;
            padding: 15px;
            font-size: 18px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #2980b9;
        }

        button:active {
            background-color: #2471a3;
        }

        .payment-details {
            display: none;
            margin-top: 30px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f9f9f9;
        }

        .payment-details h3 {
            color: #333;
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .payment-details input {
            margin-bottom: 15px;
        }

        .stock-error, .cart-empty-message {
            color: red;
            font-size: 16px;
            margin-bottom: 15px;
            font-weight: 600;
            text-align: center;
        }

        .cart-empty-message {
            font-size: 18px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        /* Responsive Design for Mobile Devices */
        @media (max-width: 768px) {
            .container {
                width: 90%;
                padding: 15px;
            }
            h1 {
                font-size: 26px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            button {
                font-size: 16px;
                padding: 12px;
            }
            .book-details p {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

<% 
    Integer userId = (Integer) session.getAttribute("userId");
    Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

    if (userId == null) {
        response.sendRedirect("login.jsp?message=Session expired. Please login again.");
        return;
    }

    if (cart == null || cart.isEmpty()) {
        response.getWriter().println("<p class='cart-empty-message'>Your cart is empty. Please add books to your cart.</p>");
        return;
    }

    // Retrieve first book from cart
    Integer bookId = cart.keySet().iterator().next(); // Get first book
    Integer quantity = cart.get(bookId); // Get quantity for that book

    // Fetch book details from database
    BookDAO bookDAO = new BookDAO();
    Book book = bookDAO.getBookById(bookId);

    if (book == null) {
        response.sendRedirect("cart.jsp?message=Book not found!");
        return;
    }

    // Calculate total amount
    double totalAmount = book.getPrice() * quantity;

    // Check stock availability
    if (quantity > book.getQuantity()) {
        response.getWriter().println("<p class='stock-error'>Sorry, we only have " + book.getQuantity() + " copies available in stock. Please reduce your order quantity.</p>");
        return;
    }
%>

<div class="container">
    <h1>Place Your Order</h1>

    <div class="book-details">
        <p><strong>Title:</strong> <%= book.getTitle() %></p>
        <p><strong>Author:</strong> <%= book.getAuthor() %></p>
        <p><strong>Price:</strong> Rs. <%= book.getPrice() %></p>
        <p><strong>Total Amount:</strong> Rs. <%= totalAmount %></p>
        <p><strong>Quantity:</strong> <%= quantity %></p>
    </div>

    <!-- Adding the hidden input for bookId -->
    <form action="PlaceOrderServlet" method="post">
        <input type="hidden" name="bookId" value="<%= book.getId() %>" />
        
        <div class="form-group">
            <label for="address">Address:</label>
            <textarea id="address" name="address" required></textarea>
        </div>
        <div class="form-group">
            <label for="payment_method">Payment Method:</label>
            <select id="payment_method" name="payment_method" required>
                <option value="">Select Payment Method</option>
                <option value="Credit Card">Credit Card</option>
                <option value="Debit Card">Debit Card</option>
                <option value="UPI">UPI</option>
                <option value="Cash on Delivery">Cash on Delivery</option>
            </select>
        </div>

        <!-- Payment details section -->
        <div class="payment-details" id="credit-card-details">
            <h3>Credit Card Details</h3>
            <input type="text" name="card_number" placeholder="Card Number" >
            <input type="text" name="card_holder_name" placeholder="Card Holder Name" >
            <input type="text" name="expiry_date" placeholder="Expiry Date (MM/YY)" >
            <input type="text" name="cvv" placeholder="CVV" >
        </div>

        <div class="payment-details" id="debit-card-details">
            <h3>Debit Card Details</h3>
            <input type="text" name="debit_card_number" placeholder="Card Number" >
            <input type="text" name="debit_card_holder_name" placeholder="Card Holder Name" >
            <input type="text" name="debit_expiry_date" placeholder="Expiry Date (MM/YY)" >
            <input type="text" name="debit_cvv" placeholder="CVV" >
        </div>

        <div class="payment-details" id="upi-details">
            <h3>UPI ID</h3>
            <input type="text" name="upi_id" placeholder="UPI ID" >
        </div>

        <button type="submit">Place Order</button>
    </form>
</div>

<script>
    document.getElementById('payment_method').addEventListener('change', function() {
        var selectedPaymentMethod = this.value;
        document.querySelectorAll('.payment-details').forEach(function(div) {
            div.style.display = 'none'; // Hide all payment details sections
        });

        if (selectedPaymentMethod === 'Credit Card') {
            document.getElementById('credit-card-details').style.display = 'block';
        } else if (selectedPaymentMethod === 'Debit Card') {
            document.getElementById('debit-card-details').style.display = 'block';
        } else if (selectedPaymentMethod === 'UPI') {
            document.getElementById('upi-details').style.display = 'block';
        }
    });
</script>

</body>
</html>
