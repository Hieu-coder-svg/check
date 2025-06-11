<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="java.sql.Timestamp, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Product Detail</title>
        <meta charset="UTF-8">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f6fff8;
                color: #2e4d32;
                margin: 0;
                padding: 0;
            }
            .container {
                
                margin: 30px auto;
                padding: 20px;
                background-color: #ffffff;
                border-radius: 15px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            }
            .back-links {
                margin-bottom: 20px;
            }
            .back-link {
                margin-right: 10px;
                text-decoration: none;
                color: #4CAF50;
                font-weight: bold;
            }

            .back-link:hover {
                text-decoration: underline;
            }

            .product-details {
                display: flex;
                gap: 20px;
                flex-wrap: wrap;
            }

            .product-img {
                max-width: 400px;
                border-radius: 10px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            }

            .product-details .name-rate {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-top: 0;
            }

            .product-details h3 {
                margin: 0;
                color: #3e7d4d;
            }

            .product-details p {
                margin: 8px 0;
            }

            .quantity-controls {
                margin: 20px 0;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .quantity-controls input[type="text"] {
                width: 50px;
                text-align: center;
                padding: 5px;
                border: 1px solid #c1e1c1;
                border-radius: 5px;
            }

            .quantity-controls button {
                padding: 6px 12px;
                background-color: #a8e6a1;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-weight: bold;
            }

            .quantity-controls button:hover {
                background-color: #7ed957;
            }

            button[type="submit"] {
                padding: 10px 20px;
                background-color: #4CAF50;
                color: #fff;
                font-weight: bold;
                border: none;
                border-radius: 6px;
                cursor: pointer;
            }

            button[type="submit"]:hover {
                background-color: #3c8d40;
            }

            .error {
                color: red;
                font-weight: bold;
            }

            .success {
                color: green;
                font-weight: bold;
            }

            .product-list {
                margin-top: 40px;
            }

            .feedback-card {
                background-color: #f1fff0;
                border: 1px solid #d9f5dc;
                border-radius: 10px;
                padding: 15px;
                margin-bottom: 15px;
            }

            .feedback-card h3 {
                margin: 0 0 5px 0;
                color: #4CAF50;
            }

            textarea[name="content"] {
                width: 100%;
                min-height: 100px;
                padding: 10px;
                border: 1px solid #cdeccd;
                border-radius: 8px;
                resize: vertical;
                margin-top: 10px;
                font-size: 14px;
                font-family: inherit;
            }

            .no-results {
                color: #888;
                font-style: italic;
                margin-top: 10px;
            }
            .breadcrumb-separator {
                margin: 0 8px;
                color: #6a9e6d;
                font-weight: bold;
            }
            .stars {
                display: flex;
                flex-direction: row-reverse;
                justify-content: flex-end;
            }
            .stars input {
                display: none;
            }
            .stars label {
                font-size: 2rem;
                color: #ccc;
                cursor: pointer;
            }
            .stars input:checked ~ label,
            .stars label:hover,
            .stars label:hover ~ label {
                color: gold;
            }
        </style>
    </head>
    <body>

        <jsp:include page="header.jsp"></jsp:include>

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
            Double rate = (Double) request.getAttribute("rate");
        %>

        <div class="container">
            <div class="back-links">
                <a href="${pageContext.request.contextPath}/home" class="back-link">Home</a>
                <span class="breadcrumb-separator">»</span>
                <a href="${pageContext.request.contextPath}/category?categoryId=<%= categoryId %>" class="back-link"><%= categoryName %></a>
            </div>

            <%
                String message = (String) request.getAttribute("message");
                if (message != null) {
            %>
            <p class="success"><%= message %></p>
            <% } %>

            <div class="product-details">
                <% if (productId != null) { %>
                <div>
                    <img src="<%= img %>" alt="<%= productName %>" class="product-img"/>
                </div>
                <div>
                    <div class="name-rate">
                        <h3><%= productName %></h3>
                        <p><%= String.format("%.1f", rate) %> ★</p> 
                    </div>
                  
                    <p>Category: <%= categoryName %></p>
                    <p>Price: $<%= String.format("%.2f", price) %></p>
                    <p>Stock: <%= stock %></p>
                    <p>Description: <%= description %></p>
                    <p>Shelf Life: <%= shelfLifeHours %> hours</p>

                    <form action="${pageContext.request.contextPath}/productDetail" method="post">
                        <input type="hidden" name="productId" value="<%= productId %>">
                        <div class="quantity-controls">
                            <button type="button" onclick="updateQuantity(-1)">-</button>
                            <input type="text" name="number" id="quantity" value="1" min="1" max="<%= stock %>">
                            <button type="button" onclick="updateQuantity(1)">+</button>
                        </div>
                        <%
                            String error = (String) request.getAttribute("error");
                            if (error != null) {
                        %>
                        <p class="error"><%= error %></p>
                        <% } %>
                        <button type="submit" value="addCart">🛒 Add to Cart</button>
                        <button type="submit" value="buy">💰 Buy</button>
                    </form>
                </div>
                <% } else { %>
                <p class="error">Product not found.</p>
                <% } %>
            </div>

            <div class="product-list">
                <%
                    ArrayList<Feedback> feedback = (ArrayList<Feedback>) request.getAttribute("feedbackList");
                    if (feedback != null && !feedback.isEmpty()) {
                        for (Feedback f : feedback) {
                %>
                <div class="feedback-card">
                    <div>
                        <h3><%= f.getUser().getName() %></h3>
                        <p><%= f.getContent() %></p>
                        <p><%= f.getCreatedAt() %></p>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <p class="no-results">This product doesn't have feedback.</p>
                <% } %>

                <form method="post" action="${pageContext.request.contextPath}/productDetail">
                    <input type="hidden" name="productId" value="<%= productId %>">
                    <div class="stars">
                        <input type="radio" id="star5" name="rating" value="1"><label for="star5">★</label>
                        <input type="radio" id="star4" name="rating" value="2"><label for="star4">★</label>
                        <input type="radio" id="star3" name="rating" value="3"><label for="star3">★</label>
                        <input type="radio" id="star2" name="rating" value="4"><label for="star2">★</label>
                        <input type="radio" id="star1" name="rating" value="5"><label for="star1">★</label>
                    </div>
                    <textarea name="content" placeholder="Write your comment..." required></textarea>
                    <button type="submit" name="action" value="comment">Submit Comment</button>
                </form>
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

        <jsp:include page="footer.jsp"></jsp:include>

    </body>
</html>