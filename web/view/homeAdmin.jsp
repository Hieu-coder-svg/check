<%-- 
    Document   : homeAdmin
    Created on : May 31, 2025, 9:24:58 AM
    Author     : Cuong
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin - Role Management</title>
        <style>
            table {
                border-collapse: collapse;
                width: 50%;
                margin: 20px auto;
            }
            th, td {
                padding: 10px;
                text-align: left;
                border: 1px solid #ddd;
            }
            th {
                background-color: #f2f2f2;
            }
            tr:nth-child(even) {
                background-color: #f9f9f9;
            }
        </style>
    </head>
    <body>
        <div>
            <h2>Role List</h2>
            <table border="1">
                <thead>
                    <tr>
                        <th>Role ID</th>
                        <th>Role Name</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listRole}" var="p">
                        <tr>
                            <td>${p.id}</td>
                            <td>${p.roleName}</td>
                            <td>
                                <button onclick="location.href = 'DisplayAccount?idRole=${p.id}'">Display Accounts</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <button onclick="location.href = 'AddRole'">Add New Role</button>
        </div>
    </body>
</html>