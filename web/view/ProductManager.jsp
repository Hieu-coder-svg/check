<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Manager</title>
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

    <!-- Header + Sidebar Menu -->
    <jsp:include page="header.jsp"></jsp:include>
    <jsp:include page="SideBarOfSheller.jsp"></jsp:include>

    <!-- Main content -->
    <div class="container mt-4">
        <div class="row">
            <div class="col-12">

                <!-- Product Management Section -->
                <div class="card mb-4 shadow-sm">
                    <div class="card-header bg-success text-white">
                        <i class="bi bi-box-seam me-2"></i>Product Management
                    </div>
                    <div class="card-body">
                        <c:if test="${manageCustomer ne null}">
                            <c:if test="${not empty allCustomers}">
                                <p>Danh sách sản phẩm sẽ hiển thị tại đây.</p>
                                <%-- <%@ include file="customerManager.jsp" %> --%>
                            </c:if>
                        </c:if>
                    </div>
                </div>

               

            </div>
        </div>
    </div>

    <!-- Footer -->
    <%@include file="footer.jsp" %>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
