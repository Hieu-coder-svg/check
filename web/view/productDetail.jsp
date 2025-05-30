<%-- 
    Document   : productPage
    Created on : May 30, 2025, 12:52:18 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   
    <body>
         <a href="${pageContext.request.contextPath}/view/home.jsp" class="back-link">Home</a>
          <a href="${pageContext.request.contextPath}/view/product/vegetable.jsp" class="back-link">Vegetable</a>
    </body>
      <div class="tour-list">
            <%
                List<Product> products = (List<Product>) request.getAttribute("product");
                if (product != null && !product.isEmpty()) {
                    for (Tours tour : tours) {
            %>
            <div class="product-card">  
                <div><img src="images/<%= tour. getImages() %>" alt="alt"class="image"></div>
                <div>
                   
                </div>
                <a href="${pageContext.request.contextPath}/view/product?id=<%= product.getId() %>"></a>
            </div>
            <%
                    }
                } else {
            %>
            <p class="no-results">No tours found matching your criteria.</p>
            <%
                }
            %>
        </div>
</html>
