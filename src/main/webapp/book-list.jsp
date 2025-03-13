<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Book List</title>
</head>
<body>
    <h1>All Books</h1>
    
    <c:forEach var="book" items="${bookList}">
        <div>
            <h2>${book.title}</h2>
            <p>Author: ${book.author}</p>
            <p>Category: ${book.category}</p>
            <p>Price: ${book.price}</p>
            <form action="BookServlet" method="get">
                <input type="hidden" name="action" value="addToCart">
                <input type="hidden" name="bookId" value="${book.id}">
                <input type="number" name="quantity" value="1" min="1" required>
                <button type="submit">Add to Cart</button>
            </form>
        </div>
    </c:forEach>
</body>
</html>
