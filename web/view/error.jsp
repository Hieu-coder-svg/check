<%-- 
    Document   : error
    Created on : Jun 1, 2025, 1:43:00 AM
    Author     : Cuong
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error</title>
        <style>
            .error {
                color: red;
                text-align: center;
                margin: 20px;
            }
            button {
                padding: 5px 10px;
                margin: 20px auto;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 3px;
                cursor: pointer;
                display: block;
            }
            button:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <div>
            <h2>Error</h2>
            <p class="error">${error}</p>
            <button onclick="location.href='HomeAdmin'">Back to Role List</button>
        </div>
    </body>
</html>