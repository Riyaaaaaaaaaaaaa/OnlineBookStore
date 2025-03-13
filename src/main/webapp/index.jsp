<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Online Book Store</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"> <!-- Font Awesome -->
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f7fa;
            color: #34495e;
        }

        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            text-align: center;
            padding: 20px;
        }

        h1 {
            font-size: 2.5rem;
            color: #2c3e50;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        h1 .icon {
            font-size: 2.8rem;
            color: #2c3e50;
        }

        .intro-text {
            font-size: 1.1rem;
            color: #7f8c8d;
            margin-bottom: 30px;
            line-height: 1.6;
            max-width: 600px;
        }

        .navigation {
            margin-top: 20px;
        }

        .navigation a {
            text-decoration: none;
            font-size: 1.2rem;
            color: #ffffff;
            background-color: #3498db;
            padding: 10px 20px;
            margin: 0 10px;
            border-radius: 5px;
            transition: all 0.3s ease;
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.2);
        }

        .navigation a:hover {
            background-color: #2980b9;
            transform: scale(1.05);
        }

        .navigation a:focus {
            outline: none;
        }

        footer {
            position: absolute;
            bottom: 10px;
            width: 100%;
            text-align: center;
            color: #7f8c8d;
            font-size: 0.9rem;
        }

        footer a {
            color: #3498db;
            text-decoration: none;
        }

        footer a:hover {
            text-decoration: underline;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            h1 {
                font-size: 2rem;
            }

            h1 .icon {
                font-size: 2.5rem;
            }

            .intro-text {
                font-size: 1rem;
                max-width: 90%;
            }

            .navigation a {
                font-size: 1rem;
                padding: 10px 15px;
                margin: 5px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>
            <i class="fas fa-book icon"></i> Online Book Store
        </h1>
        <p class="intro-text">
            Explore a vast collection of books across genres and categories. Whether you're a student, a professional, or a book lover, we've got something special for you. Sign in to browse, or register to start your journey with us!
        </p>
        <div class="navigation">
            <a href="login.jsp">Login</a>
            <a href="register.jsp">Register</a>
            <a href="admin-login.jsp">Admin</a>
        </div>
        <footer>
            &copy; <%= java.time.LocalDate.now().getYear() %> Online Book Store. All rights reserved. <br>
            Designed by <a href="https://yourportfolio.com" target="_blank">Riya</a>.
        </footer>
    </div>
</body>
</html>
