<%-- 
    Document   : home
    Created on : May 29, 2025, 5:25:36 PM
    Author     : ASUS
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="${pageContext.request.contextPath}/CSS/home.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

            <!-- Main Content -->
            <div>
                <h1>Welcome to Healthy Food!</h1>
                <p>Enjoy shopping fresh and nutritious food tailored to your health goals.</p>
            </div>

            <div class="content-main">
                <div class="content-left">
                    <div>
                        <i>Price Filter</i>
                    </div>
                </div>

                <!-- hien thi product -->
                <div class="content-right">
                    <div class="list-title">
                        <h2>Product List:</h2>
                    </div>

                    <div class="product-list">                  
                        <c:forEach items="${requestScope.productList}" var="o">
                            <div class="card">
                                <img class="card-img" src="${o.imgUrl}" alt="Product Image">
                                <div class="card-body">
                                    <p>Product: ${o.name}</p>
                                    
                                    <p>Price: ${o.price}</p>
                                    <p>Stock: ${o.stock}</p>
                                    <p>Shelf Life Hours: ${o.shelfLifeHours} hours</p>
                                </div>
                            </div>
                    </c:forEach>
                    </div>
                </div>    
            </div>







        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
