package com.store.servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Map;
import java.util.HashMap;

public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleRequest(request, response); // Handle all actions
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleRequest(request, response); // Handle all actions
    }

    private void handleRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");

        if ("addToCart".equals(action)) {
            addToCart(request, response);
        } else if ("removeFromCart".equals(action)) {
            removeFromCart(request, response);
        } else if ("updateQuantity".equals(action)) {
            updateQuantity(request, response);
        } else if ("checkout".equals(action)) {
            checkout(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
        }
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart == null) {
            cart = new HashMap<>(); // Initialize if it's null
        }

        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // Update cart with new quantity or add new item
            cart.put(bookId, cart.getOrDefault(bookId, 0) + quantity);

            session.setAttribute("cart", cart); // Save updated cart in session
            response.sendRedirect("cart.jsp?message=Book added to cart.");
        } catch (NumberFormatException e) {
            response.sendRedirect("cart.jsp?error=Invalid book ID or quantity.");
        }
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart != null) {
            try {
                int bookId = Integer.parseInt(request.getParameter("bookId"));
                cart.remove(bookId); // Remove the item from the cart
                session.setAttribute("cart", cart); // Update session
                response.sendRedirect("cart.jsp?message=Item removed from cart.");
            } catch (NumberFormatException e) {
                response.sendRedirect("cart.jsp?error=Invalid book ID.");
            }
        } else {
            response.sendRedirect("cart.jsp?error=Your cart is empty.");
        }
    }

    private void updateQuantity(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart != null) {
            try {
                int bookId = Integer.parseInt(request.getParameter("bookId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                if (quantity > 0) {
                    cart.put(bookId, quantity); // Update quantity in the cart
                    session.setAttribute("cart", cart); // Save updated cart in session
                }

                response.sendRedirect("cart.jsp");
            } catch (NumberFormatException e) {
                response.sendRedirect("cart.jsp?error=Invalid quantity.");
            }
        } else {
            response.sendRedirect("cart.jsp?error=Your cart is empty.");
        }
    }

    private void checkout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp?error=Your cart is empty.");
            return;
        }

        // Prepare cart data for the checkout page
        session.setAttribute("checkoutCart", cart);

        // Redirect to checkout page
        response.sendRedirect("place-order.jsp");
    }
}
