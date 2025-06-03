<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Check Order</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .card-header {
            font-weight: bold;
        }
    </style>
</head>
<body>

    <!-- Header -->
    <jsp:include page="header.jsp" />

    <!-- Sidebar Offcanvas -->
    <jsp:include page="SideBarOfSheller.jsp" />

    <!-- Main Content -->
    <div class="container-fluid mt-3">
        <div class="row">

            <!-- Main Area -->
            <div class="col-md-9 py-4">
                <div class="card mb-4 shadow-sm">
                    <div class="card-header bg-warning text-dark">
                        <i class="bi bi-truck me-2"></i>Check Orders
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty orders}">
                            <table class="table table-bordered table-hover">
                                <thead class="table-warning">
                                    <tr>
                                        <th>#</th>
                                        <th>Customer Name</th>
                                        <th>Phone</th>
                                        <th>Address</th>
                                        <th>Order Date</th>
                                        <th>Status</th>
                                        <th>Total (VNĐ)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${orders}" varStatus="loop">
                                        <tr>
                                            <td>${loop.index + 1}</td>
                                            <td>${order.customerName}</td>
                                            <td>${order.phone}</td>
                                            <td>${order.address}</td>
                                            <td>${order.orderDate}</td>
                                            <td>${order.status}</td>
                                            <td>${order.totalAmount}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                        <c:if test="${empty orders}">
                            <p class="text-muted">Không có đơn hàng nào.</p>
                        </c:if>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
