<!DOCTYPE html>
<html>
<head>
    <title>Order Success</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .success-container {
            text-align: center;
            background-color: #ffffff;
            padding: 30px 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 90%;
        }

        .success-container h1 {
            font-size: 2rem;
            color: #27ae60;
            margin-bottom: 20px;
        }

        .success-container p {
            font-size: 1rem;
            color: #7f8c8d;
            margin-bottom: 20px;
        }

        .success-container a {
            text-decoration: none;
            font-size: 1rem;
            color: #ffffff;
            background-color: #3498db;
            padding: 10px 20px;
            border-radius: 5px;
            display: inline-block;
            transition: background-color 0.3s ease;
        }

        .success-container a:hover {
            background-color: #2980b9;
        }

        .success-container a:focus {
            outline: none;
        }

        .success-container .icon {
            font-size: 4rem;
            color: #27ae60;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="success-container">
        <div class="icon">&#x2714;</div>
        <h1>Order Placed Successfully!</h1>
        <p>Thank you for shopping with us. Your order has been received and will be processed soon.</p>
        <a href="user.jsp">Go Back to Dashboard</a>
    </div>
</body>
</html>
