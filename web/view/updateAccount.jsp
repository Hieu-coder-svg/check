<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Account</title>
        <style>
            .container {
                width: 50%;
                margin: 20px auto;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            h2 {
                text-align: center;
                color: #333;
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
                color: #555;
            }
            input[type="text"],
            input[type="email"],
            input[type="password"],
            input[type="date"] {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
            }
            .error {
                color: red;
                text-align: center;
                margin: 10px 0;
            }
            .btn {
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                margin: 5px;
            }
            .btn-submit {
                background-color: #4CAF50;
                color: white;
            }
            .btn-submit:hover {
                background-color: #45a049;
            }
            .btn-back {
                background-color: #2196F3;
                color: white;
            }
            .btn-back:hover {
                background-color: #0b7dda;
            }
            .note {
                color: #666;
                font-size: 12px;
                margin-top: 5px;
            }
            .read-only {
                background-color: #f9f9f9;
                border: none;
                padding: 8px;
                border-radius: 4px;
                display: block;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Update Account</h2>
            <c:if test="${not empty error}">
                <p class="error">${error}</p>
            </c:if>
            <form action="UpdateAccount" method="post">
                <input type="hidden" name="id" value="${user.id}">
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" value="${user.name}">
                    <p class="note">Optional: Leave blank if no change needed.</p>
                </div>
                <div class="form-group">
                    <label for="email">Email (required):</label>
                    <input type="email" id="email" name="email" value="${user.email}" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" value="${user.password}">
                    <p class="note">Optional: Leave blank to keep current password.</p>
                </div>
                <div class="form-group">
                    <label for="phone">Phone:</label>
                    <input type="text" id="phone" name="phone" value="${user.phone}">
                    <p class="note">Optional: Enter a valid phone number.</p>
                </div>
                <div class="form-group">
                    <label for="dob">Date of Birth:</label>
                    <input type="date" id="dob" name="dob" value="${user.dob != null ? user.dob : ''}">
                    <p class="note">Optional: Format YYYY-MM-DD.</p>
                </div>
                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address" value="${user.address}">
                    <p class="note">Optional: Leave blank if no change needed.</p>
                </div>
                <div class="form-group">
                    <label for="gender">Gender:</label>
                    <select id="gender" name="gender">
                        <option value="1" ${user.gender ? 'selected' : ''}>Male</option>
                        <option value="0" ${user.gender ? '' : 'selected'}>Female</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Role (Read-only):</label>
                    <input type="text" class="read-only" value="${user.role.roleName}" readonly>
                    <input type="hidden" name="roleId" value="${user.role.id}">
                </div>
                <div>
                    <button type="submit" class="btn btn-submit">Update</button>
                    <button type="button" class="btn btn-back" onclick="location.href='DisplayAccount?idRole=${user.role.id}'">Back to List</button>
                </div>
            </form>
        </div>
    </body>
</html>