<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
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

    <!-- Header + Sidebar -->
    <jsp:include page="header.jsp"></jsp:include>
    <jsp:include page="SideBarOfSheller.jsp"></jsp:include>

<!-- Main content -->
<div class="container-fluid mt-4">
    <!-- Insert Product Button -->
    <div class="text-center mb-3">
        <a href="manageProduct?service=requestInsert" class="btn btn-primary">
            <i class="bi bi-plus-circle me-1"></i>Insert a New Product
        </a>
    </div>

    <!-- Search Product -->
    <c:if test="${showSearchProduct ne null}">
        <form action="manageProduct" class="input-group mb-4 shadow-sm justify-content-center" method="get" style="max-width: 600px; margin: auto;">
            <input type="hidden" name="service" value="searchByKeywords"/>
            <input type="text" class="form-control" name="keywords" placeholder="Search by name" value="${keywords}">
            <button class="btn btn-outline-secondary" type="submit">
                <i class="bi bi-search"></i>
            </button>
        </form>
    </c:if>

    <!-- Product Management Card -->
    <div class="d-flex justify-content-center">
        <div class="card shadow border-0" style="width: 90%;">
            <div class="card-header bg-success text-white fs-5">
                <i class="bi bi-box-seam me-2"></i>Product Management
            </div>
<div class="card-body">

    <!-- Thông báo Update thành công -->
    <c:if test="${UpdateDone ne null}">
        <div class="alert alert-success text-center fw-bold">${UpdateDone}</div>
    </c:if>

    <!-- Update Product Form -->

        <h4 class="text-center mb-4 text-primary fw-bold">Update Product</h4>
        <form action="manageProduct" id="updateProduct" class="mb-4">
            <input type="hidden" name="service" value="sendUpdateDetail"/>
            <div class="table-responsive">
                <table class="table table-bordered align-middle">
                    <thead class="table-light">
                        <tr class="text-center">
                            <th>ID</th>
                            <th>Product Name</th>
                            <th>Unit Price</th>
                            <th>Quantity In Stock</th>
                            <th>Release Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><input type="text" name="id" value="${productUpdate.id}" readonly class="form-control-plaintext text-center"/></td>
                            <td><input type="text" name="name" value="${productUpdate.name}" class="form-control"/></td>
                            <td><input type="number" name="price" value="${productUpdate.price}" class="form-control"/></td>
                            <td><input type="number" name="quantity" value="${productUpdate.quantity}" class="form-control"/></td>
                            <td><input type="text" name="release_date" value="${productUpdate.release_date}" class="form-control"/></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-success">
                    <i class="bi bi-save me-1"></i>Update
                </button>
            </div>
        </form>
    </c:if>-->

    <!-- Danh sách sản phẩm -->
    <c:if test="${not empty allProducts}">
        <h4 class="text-center mb-3 text-success fw-bold">All Products</h4>
        <div class="table-responsive">
            <table class="table table-striped table-bordered align-middle">
                <thead class="table-primary text-center">
                    <tr>
                        <th>ID</th>
                        <th>Product Name</th>
                        <th>Unit Price</th>
                        <th>Quantity In Stock</th>
                        <th>Release Date</th>
                        <th>Update</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${allProducts}" var="product">
                        <tr>
                            <td class="text-center">${product.id}</td>
                            <td>
                                <img src="${product.image_url}" alt="${product.name}" style="width: 50px;" class="me-2 rounded">
                                ${product.name}
                            </td>
                            <td class="text-end">${product.price}</td>
                            <td class="text-center">${product.quantity}</td>
                            <td class="text-center">${product.release_date}</td>
                            <td class="text-center">
                                <a href="manageProduct?service=requestUpdate&productId=${product.id}" class="btn btn-sm btn-warning">
                                    <i class="bi bi-pencil-square"></i>
                                </a>
                            </td>
                            <td class="text-center">
                                <a href="manageProduct?service=requestDelete&productId=${product.id}" 
                                   onclick="return confirmDelete(${product.id})" 
                                   class="btn btn-sm btn-danger">
                                    <i class="bi bi-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <script>
            function confirmDelete(productId) {
                return confirm("Are you sure you want to delete this product (ID = " + productId + ")?");
            }
        </script>
    </c:if>
</div>

                        
        </div>
    </div>
</div>


    <!-- Footer -->
    <%@include file="footer.jsp" %>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" 
        integrity="sha384-..." 
        crossorigin="anonymous"></script>
</body>
</html>
