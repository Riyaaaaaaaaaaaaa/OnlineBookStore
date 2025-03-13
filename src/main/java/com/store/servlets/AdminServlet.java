package com.store.servlets;

import com.store.utils.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");

		if ("login".equals(action)) {
			handleLogin(request, response);
		} else if ("addBook".equals(action)) {
			addBook(request, response);
		} else {
			response.sendRedirect("admin.jsp");
		}
	}

	private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password"); 

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM admins WHERE username = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("isAdmin",true);
                response.sendRedirect("admin.jsp");
            } else {
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("admin-login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error occurred", e);
        }
    }

	private void addBook(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		// Retrieve form parameters
		String title = request.getParameter("title");
		String author = request.getParameter("author");
		String publication = request.getParameter("publication");
		String category = request.getParameter("category");
		double price = Double.parseDouble(request.getParameter("price"));
		int quantity = Integer.parseInt(request.getParameter("quantity"));

		// Database insertion
		try (Connection conn = DBConnection.getConnection()) {
			String sql = "INSERT INTO books (title, author, publication, category, price, quantity) VALUES (?, ?, ?, ?, ?, ?)";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, title);
			stmt.setString(2, author);
			stmt.setString(3, publication);
			stmt.setString(4, category);
			stmt.setDouble(5, price);
			stmt.setInt(6, quantity);

			int rowsInserted = stmt.executeUpdate();
			if (rowsInserted > 0) {
				response.sendRedirect("admin.jsp");
			} else {
				request.setAttribute("error", "Failed to add the book.");
				request.getRequestDispatcher("admin.jsp").forward(request, response);
			}
		} catch (SQLException e) {
			throw new ServletException("Database error while adding the book", e);
		}
	}
}
//package com.store.servlets;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.*;
//import java.io.IOException;
//import java.sql.*;
//
//import com.store.utils.DBConnection;
//
//public class AdminServlet extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String username = request.getParameter("username");
//        String password = request.getParameter("password");
//
//        try (Connection conn = DBConnection.getConnection()) {
//            String sql = "SELECT * FROM admins WHERE username = ? AND password = ?";
//            PreparedStatement stmt = conn.prepareStatement(sql);
//            stmt.setString(1, username);
//            stmt.setString(2, password);
//            ResultSet rs = stmt.executeQuery();
//
//            if (rs.next()) {
//                HttpSession session = request.getSession();
//                session.setAttribute("isAdmin", true);
//                response.sendRedirect("admin.jsp");
//            } else {
//                request.setAttribute("error", "Invalid Username or Password");
//                request.getRequestDispatcher("admin-login.jsp").forward(request, response);
//            }
//        } catch (SQLException e) {
//            throw new ServletException("Database error occurred", e);
//        }
//    }
//}

//package com.store.servlets;
//
//import com.store.utils.DBConnection;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//import java.io.IOException;
//import java.sql.*;
//
//public class AdminServlet extends HttpServlet {
//    /**
//	 * 
//	 */
//	private static final long serialVersionUID = 1L;
//
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String action = request.getParameter("action");
//
//        if ("addBook".equals(action)) {
//            addBook(request, response);
//        }
//    }
//
//    private void addBook(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
//        String title = request.getParameter("title");
//        String author = request.getParameter("author");
//        String category = request.getParameter("category");
//        double price = Double.parseDouble(request.getParameter("price"));
//        int quantity = Integer.parseInt(request.getParameter("quantity"));
//
//        try (Connection conn = DBConnection.getConnection()) {
//            String sql = "INSERT INTO books (title, author, category, price, quantity) VALUES (?, ?, ?, ?, ?)";
//            PreparedStatement stmt = conn.prepareStatement(sql);
//            stmt.setString(1, title);
//            stmt.setString(2, author);
//            stmt.setString(3, category);
//            stmt.setDouble(4, price);
//            stmt.setInt(5, quantity);
//            stmt.executeUpdate();
//
//            response.sendRedirect("admin.jsp");
//        } catch (SQLException e) {
//            throw new ServletException("Database error", e);
//        }
//    }
//}
//
////package com.store.servlets;
////
////import java.io.IOException;
////import java.util.List;
////
////import com.mysql.cj.x.protobuf.MysqlxCrud.Order;
////import com.store.dao.OrderDAO;
////
////import jakarta.servlet.ServletException;
////import jakarta.servlet.annotation.WebServlet;
////import jakarta.servlet.http.HttpServlet;
////import jakarta.servlet.http.HttpServletRequest;
////import jakarta.servlet.http.HttpServletResponse;
////
////
////@WebServlet("/AdminServlet")
////public class AdminServlet extends HttpServlet {
////    private static final long serialVersionUID = 1L;
////
////    protected void doPost(HttpServletRequest request, HttpServletResponse response)
////            throws ServletException, IOException {
////        String action = request.getParameter("action");
////
////        if ("login".equals(action)) {
////            String username = request.getParameter("username");
////            String password = request.getParameter("password");
////
////            // Simulate authentication
////            if ("admin".equals(username) && "admin123".equals(password)) {
////                request.getSession().setAttribute("isAdmin", true);
////                response.sendRedirect("admin-orders.jsp");
////            } else {
////                request.setAttribute("error", "Invalid credentials");
////                request.getRequestDispatcher("admin-login.jsp").forward(request, response);
////            }
////        }
////    }
////
////    protected void doGet(HttpServletRequest request, HttpServletResponse response)
////            throws ServletException, IOException {
////        // Fetch all orders for admin
////        List<Order> orders = OrderDAO.getAllOrders();
////        request.setAttribute("orders", orders);
////        request.getRequestDispatcher("admin-orders.jsp").forward(request, response);
////    }
////}
////
