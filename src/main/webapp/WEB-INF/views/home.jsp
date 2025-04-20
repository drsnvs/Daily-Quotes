<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daily Quote</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #333;
        }
        .container {
            max-width: 800px;
            padding: 2rem;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h1 {
            color: #2c3e50;
            margin-bottom: 2rem;
        }
        .quote-container {
            padding: 2rem;
            background-color: #f9f9f9;
            border-radius: 8px;
            margin-bottom: 2rem;
        }
        .quote {
            font-size: 1.5rem;
            line-height: 1.5;
            font-style: italic;
            margin-bottom: 1rem;
        }
        .refresh-btn {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.3s;
        }
        .refresh-btn:hover {
            background-color: #2980b9;
        }
        footer {
            margin-top: 2rem;
            color: #7f8c8d;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Quote of the Day</h1>
        
        <div class="quote-container">
            <p class="quote">${quote}</p>
        </div>
        
        <button class="refresh-btn" onclick="location.reload()">Refresh</button>
        
        <footer>
            <p>Quotes are updated daily at 10:00 AM</p>
        </footer>
    </div>
</body>
</html> 