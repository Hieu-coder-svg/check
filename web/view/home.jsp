<%-- 
    Document   : home
    Created on : May 29, 2025, 5:25:36 PM
    Author     : ASUS
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
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
                        <form action="pricefilter" method="get">
                            <table border="1">
                                <th>
                                    <b>Price Filter:</b></th>
                                <tr>
                                <td>Min price:</td>
                                <td><input type="number" name="minPrice" value="${minPrice}" min="0" max="1000" placeholder="Enter min price"></td>
                                </tr>
                                <tr>
                                <td>Max price:</td>
                                <td><input type="number" name="maxPrice" value="${maxPrice}" min="0" max="1000" placeholder="Enter max price"></td>
                                </tr>

                            </table>
                                        <c:if test="${not empty eMessage}">
                                            <div style="color:red">${eMessage}</div>
                                        </c:if>

                                        <c:if test="${not empty notFoundMessage}">
                                            <div style="color:red">${notFoundMessage}</div>
                                        </c:if>
                                <input type="submit" value="Filter">
                        </form>
                    </div>
                    <div>
                        <b>Sort Product:</b>
                        <button onclick="location.href='sortproduct?orderBy=desc'">Descending</button>
                        <button onclick="location.href='sortproduct?orderBy=Asc'">Ascending</button>
                    </div>
                </div>

                <!-- hien thi product -->
                <div class="content-right">
                    <div class="list-title">
                        <h2>Product List:</h2>
                    <%  if(request.getAttribute("errorMessage")!=null){
                        String em =(String)request.getAttribute("errorMessage"); 
                    %>
                        <h2><%= em%> </h2>
                    <% 
                        }    
                    %>
                    </div>

                    <div class="product-list">                  
                        <c:forEach items="${requestScope.productList}" var="o">
                            <div class="card">
                                <a href="${pageContext.request.contextPath}/productDetail?productId=${o.id}">
                                <img class="card-img" src="${o.imgUrl}" alt="Product">
                                </a>
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
