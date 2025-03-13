package com.store.servlets;

import com.store.utils.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;

import com.store.models.Book;

public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Handle requests
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
         
        if ("search".equals(action)) {
            searchBooks(request, response);
        }else if ("addToCart".equals(action)) {
            addToCart(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            loginUser(request, response);
        } else if ("register".equals(action)) {
            registerUser(request, response);
        } 
    }

    // Handle login
    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("userId", rs.getInt("id"));
                session.setAttribute("userName", rs.getString("name"));
                session.setAttribute("userEmail", rs.getString("email"));
                session.setAttribute("userAddress", rs.getString("address"));
                session.setAttribute("userPhone", rs.getString("phone"));

                response.sendRedirect("user.jsp"); // Redirect to the user dashboard
            } else {
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    // Handle registration
    private void registerUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        try (Connection conn = DBConnection.getConnection()) {
            // Check if the email already exists
            String checkSql = "SELECT * FROM users WHERE email = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, email);

            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                response.getWriter().println("<h3>Email already registered! <a href='login.jsp'>Login here</a></h3>");
                return;
            }

            // Insert the new user into the database
            String sql = "INSERT INTO users (name, email, password, address, phone) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.setString(4, address);
            stmt.setString(5, phone);
            stmt.executeUpdate();

            response.getWriter().println("<h3>Registration successful! <a href='login.jsp'>Login here</a></h3>");
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
    
    private void searchBooks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String category = request.getParameter("category");

        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE title LIKE ? AND author LIKE ? AND category LIKE ?";

        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + title + "%");
            stmt.setString(2, "%" + author + "%");
            stmt.setString(3, "%" + category + "%");

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt("id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setCategory(rs.getString("category"));
                book.setPrice(rs.getDouble("price"));
                books.add(book);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }

        request.setAttribute("books", books);
        RequestDispatcher dispatcher = request.getRequestDispatcher("searchResults.jsp");
        dispatcher.forward(request, response);
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        HttpSession session = request.getSession();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart == null) {
            cart = new HashMap<>();
        }
        
        // Add the book to the cart, incrementing quantity if it already exists
        cart.put(bookId, cart.getOrDefault(bookId, 0) + quantity);
        
        // Store the cart back into the session
        session.setAttribute("cart", cart);

        response.sendRedirect("cart.jsp");  // Redirect to the cart page
    }
}
