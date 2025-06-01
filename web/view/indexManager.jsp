<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manager Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .sidebar {
            min-height: 100vh;
            background-color: #343a40;
        }
        .sidebar a {
            color: #ffffff;
            padding: 12px 20px;
            display: block;
            text-decoration: none;
        }
        .sidebar a:hover {
            background-color: #495057;
            color: #ffc107;
        }
        .card-header {
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">

        <!-- Sidebar -->
        <div class="col-md-3 sidebar">
            <h4 class="text-white text-center py-3">Manager Dashboard</h4>
            <a href="manageCustomer"><i class="bi bi-people-fill me-2"></i>Customer Manager</a>
            <a href="manageProduct"><i class="bi bi-box-seam me-2"></i>Product Manager</a>
            <a href="manageBill"><i class="bi bi-receipt me-2"></i>Bill Manager</a>
        </div>

        <!-- Main Content -->
        <div class="col-md-9 py-4">
            <!-- Customer Section -->
            <c:if test="${manageCustomer ne null}">
                <c:if test="${not empty allCustomers}">
                    <div class="card mb-4">
                        <div class="card-header bg-primary text-white">
                            Customer Manager
                        </div>
                        <div class="card-body">
                            <p>Danh sách khách hàng sẽ hiển thị ở đây.</p>
                            <%-- <%@ include file="customerManager.jsp" %> --%>
                        </div>
                    </div>
                </c:if>
            </c:if>

            <!-- Product Section -->
            <c:if test="${manageProduct ne null}">
                <div class="card mb-4">
                    <div class="card-header bg-success text-white">
                        Product Manager
                    </div>
                    <div class="card-body">
                        <p>Danh sách sản phẩm sẽ hiển thị ở đây.</p>
                        <%-- <%@ include file="productManager.jsp" %> --%>
                    </div>
                </div>
            </c:if>

            <!-- Bill Section -->
            <c:if test="${manageBill ne null}">
                <div class="card mb-4">
                    <div class="card-header bg-warning text-dark">
                        Bill Manager
                    </div>
                    <div class="card-body">
                        <p>Danh sách hóa đơn sẽ hiển thị ở đây.</p>
                        <%-- <%@ include file="billManager.jsp" %> --%>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
