package com.store.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

import com.store.utils.DBConnection;

@WebServlet("/EditBookServlet")
public class EditBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM books WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, bookId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                request.setAttribute("book", rs);
                request.getRequestDispatcher("edit-book.jsp").forward(request, response);
            } else {
                response.sendRedirect("admin.jsp");
            }
        } catch (SQLException e) {
            throw new ServletException("Error retrieving book", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publication = request.getParameter("publication");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE books SET title = ?, author = ?, publication = ?, category = ?, price = ?, quantity = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, title);
            stmt.setString(2, author);
            stmt.setString(3, publication);
            stmt.setString(4, category);
            stmt.setDouble(5, price);
            stmt.setInt(6, quantity);
            stmt.setInt(7, bookId);

            stmt.executeUpdate();
            response.sendRedirect("admin.jsp");
        } catch (SQLException e) {
            throw new ServletException("Error updating book", e);
        }
    }
}
