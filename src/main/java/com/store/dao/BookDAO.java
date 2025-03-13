package com.store.dao;

import com.store.models.Book;
import com.store.utils.DBConnection;

import java.sql.*;

public class BookDAO {

    public Book getBookById(int bookId) {
        Book book = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM books WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, bookId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                book = new Book();
                book.setId(rs.getInt("id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPublication(rs.getString("publication"));
                book.setQuantity(rs.getInt("quantity"));
                book.setCategory(rs.getString("category"));
                book.setPrice(rs.getDouble("price"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return book;
    }
}
