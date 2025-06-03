<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp, java.util.*, java.text.*" %>


<!DOCTYPE html>
<html>
    <head>
        <title>Product Detail</title>
        <meta charset="UTF-8">
        <style>
            .container {
                max-width: 800px;
                margin: 0 auto;
                padding: 20px;
            }
            .back-links {
                margin-bottom: 20px;
            }
            .back-link {
                margin-right: 10px;
                text-decoration: none;
                color: #333;
            }
            .product-details {
                display: flex;
                gap: 20px;
            }
            .product-img {
                max-width: 300px;
            }
            .quantity-controls {
                margin: 20px 0;
            }
            .quantity-controls input[type="text"] {
                width: 50px;
                text-align: center;
            }
            .error {
                color: red;
            }
            .success {
                color: green;
            }
        </style>
    </head>
    <body>
        <% 
                   Integer productId = (Integer) request.getAttribute("productId");
                   String productName = (String) request.getAttribute("productName");
                   String description = (String) request.getAttribute("description");
                   Integer stock = (Integer) request.getAttribute("stock");
                   Double price = (Double) request.getAttribute("price");
                   Double shelfLifeHours = (Double) request.getAttribute("time");
                   String img = (String) request.getAttribute("img");
                   String categoryName = (String) request.getAttribute("categoryName");
                   Integer categoryId = (Integer) request.getAttribute("categoryId");
                
                   String userName = (String)  request.getAttribute("userName");
                   Timestamp feedbackCreatedAt = (Timestamp)request.getAttribute("feedbackCreatedAt");
                   String feedbackContent = (String)  request.getAttribute("feedbackContent");
        %>
        <div class="container">
            <div class="back-links">
                <a href="${pageContext.request.contextPath}/home" class="back-link">Home</a>
                <a href="${pageContext.request.contextPath}/view/${pageContext.request.contextPath}/category?categoryId=<%= categoryId %>" class="back-link"><%= categoryName %></a>
            </div>

            <% 
                String error = (String) request.getAttribute("error");
                String message = (String) request.getAttribute("message");
                if (error != null) {
            %>
            <p class="error"><%= error %></p>
            <% } else if (message != null) { %>
            <p class="success"><%= message %></p>
            <% } %>

            <div class="product-details">
                <%           
                    if (productId != null) {
                %>
                <div>
                    <img src="<%= img %>" alt="<%= productName %>" class="product-img"/>
                </div>
                <div>
                    <h3><%= productName %></h3>
                    <p>Category: <%= categoryName %></p>
                    <p>Price: $<%= String.format("%.2f", price) %></p>
                    <p>Stock: <%= stock %></p>
                    <p>Description: <%= description %></p>
                    <p>Shelf Life: <%= shelfLifeHours %> hours</p>

                    <form action="${pageContext.request.contextPath}/productDetail" method="post">
                        <input type="hidden" name="productId" value="<%= productId %>">
                        <div class="quantity-controls">
                            <button type="button" onclick="updateQuantity(-1)">-</button>
                            <input type="text" name="number" id="quantity" value="1" readonly>
                            <button type="button" onclick="updateQuantity(1)">+</button>
                        </div>
                        <button type="submit">Add to Cart</button>
                    </form>
                </div>
                <h3>Feed Back</h3>
                <div>
                    <h5><%= userName %></h5>
                    <p><%= feedbackContent %></p>

                    <p><%= feedbackCreatedAt %></p>
                </div>   
                <% } else { %>
                <p class="error">Product not found.</p>
                <% } %>
            </div>
        </div>

        <script>
            function updateQuantity(change) {
                let quantityInput = document.getElementById('quantity');
                let currentQuantity = parseInt(quantityInput.value);
                let newQuantity = currentQuantity + change;
                if (newQuantity >= 1 && newQuantity <= <%= stock %>) {
                    quantityInput.value = newQuantity;
                }
            }
        </script>
    </body>
</html>