package com.store.servlets;

import java.io.IOException;
import java.sql.*;
import java.util.Map;

import com.store.dao.BookDAO;
import com.store.models.Book;
import com.store.utils.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get session and user details
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        // If user is not logged in, redirect to login page
        if (userId == null) {
            response.sendRedirect("login.jsp?message=Session expired. Please login again.");
            return;
        }

        // Get order details from the form
        String bookIdStr = request.getParameter("bookId");
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("payment_method");
        
        // Optional: Get specific payment method details
        String cardNumber = request.getParameter("card_number");
        String cardHolderName = request.getParameter("card_holder_name");
        String expiryDate = request.getParameter("expiry_date");
        String cvv = request.getParameter("cvv");

        // Validate the form data
        if (bookIdStr == null || address == null || paymentMethod == null || address.trim().isEmpty()) {
            response.sendRedirect("error.jsp?message=Missing%20input%20data");
            return;
        }

        try {
            // Parse book ID and validate
            Integer bookId = Integer.parseInt(bookIdStr);

            // Get the cart from session
            Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

            // Check if the cart has the book and its quantity
            if (cart == null || !cart.containsKey(bookId)) {
                response.sendRedirect("cart.jsp?message=Invalid%20cart");
                return;
            }

            Integer quantity = cart.get(bookId);
            
            // Get book details from DB
            BookDAO bookDAO = new BookDAO();
            Book book = bookDAO.getBookById(bookId);
            
            if (book == null) {
                response.sendRedirect("cart.jsp?message=Book%20not%20found!");
                return;
            }

            // Check stock availability
            if (quantity > book.getQuantity()) {
                response.sendRedirect("error.jsp?message=Not%20enough%20stock%20available");
                return;
            }

            // Calculate total amount
            double totalAmount = book.getPrice() * quantity;

            // Insert the order into the database
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "INSERT INTO orders (user_id, book_id, quantity, payment_method, address, order_date) VALUES (?, ?, ?, ?, ?, NOW())";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, userId);
                stmt.setInt(2, bookId);
                stmt.setInt(3, quantity);
                stmt.setString(4, paymentMethod);
                stmt.setString(5, address);

                // Execute the insert query
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    // Redirect to order success page
                    response.sendRedirect("order-success.jsp?message=Order%20placed%20successfully");
                } else {
                    // Something went wrong
                    response.sendRedirect("error.jsp?message=Order%20could%20not%20be%20placed");
                }
            }
        } catch (NumberFormatException e) {
            // Handle invalid input (non-integer book ID)
            response.sendRedirect("error.jsp?message=Invalid%20book%20ID");
        } catch (SQLException e) {
            // Handle SQL exceptions
            response.sendRedirect("error.jsp?message=Database%20error");
        }
    }
}
