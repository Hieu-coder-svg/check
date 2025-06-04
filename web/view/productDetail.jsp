<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Product Detail</title>
    <meta charset="UTF-8">
    <style>
        .container { max-width: 800px; margin: 0 auto; padding: 20px; }
        .back-links { margin-bottom: 20px; }
        .back-link { margin-right: 10px; text-decoration: none; color: #333; }
        .product-details { display: flex; gap: 20px; }
        .product-img { max-width: 300px; }
        .quantity-controls { margin: 20px 0; }
        .quantity-controls input[type="text"] { width: 50px; text-align: center; }
        .error { color: red; }
        .success { color: green; }
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
                %>
    <div class="container">
        <div class="back-links">
            <a href="${pageContext.request.contextPath}/view/home" class="back-link">Home</a>
            <a href="${pageContext.request.contextPath}/view/${pageContext.request.contextPath}/category?categotyId=<%= categoryId %>" class="back-link"><%= categoryName %></a>
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
                        <input type="text" name="number" id="quantity" value="1" min ="1" max="${product.stock}">
                        <button type="button" onclick="updateQuantity(1)">+</button>
                    </div>
                    <button type="submit">Add to Cart</button>
                </form>
            </div>
            <% } else { %>
                <p class="error">Product not found.</p>
            <% } %>
        </div>
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
            <p class="no-results">This product don't have feedback.</p>
            <%
                }
            %>
             <form method="post" action="${pageContext.request.contextPath}/productDetail">
                <input type="hidden" name="productId" value="<%= productId %>">
                <textarea name="content" placeholder="Write your comment..." required></textarea>
                <button type="submit" name="action" value="comment">Submit Comment</button>
            </form>
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
