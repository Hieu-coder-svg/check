
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   
    <body>
         <a href="${pageContext.request.contextPath}/view/home.jsp" class="back-link">Home</a>
          <a href="${pageContext.request.contextPath}/view/product/vegetable.jsp" class="back-link">Vegetable</a>
    </body>
      <div class="">
            <%
            Integer productId = (Integer) request.getAttribute("tourId");
            String productName = (String) request.getAttribute("tourName");       
            String description = (String) request.getAttribute("description");
            Integer stock = (Integer) request.getAttribute("stock");
            Double price = (Double) request.getAttribute("price");     
            Integer time = (Integer) request.getAttribute("time")
            String img = (String) request.getAttribute("img")
    %>
        <div class="">
            <h3><%= ProductName %></h3>  
            <img src="<%= img %>" alt="alt"/> 
            <p>Price: <%= price %></p>
            <p><%= stock %></p>
            <p>Description: <%= description %></p>
            <p><%= time %></p>  
        </div>
        <div>
            <input type="button" value="-">
            <input type="text" name="name" value="1">
            <input type="button" value="+">
        </div> 

        </div>
</html>
