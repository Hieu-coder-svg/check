<%-- 
    Document   : addAccount
    Created on : Jun 4, 2025, 3:19:51 PM
    Author     : Cuong
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <form action="post" method="AddUser">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name">
                <p class="note">Optional: Leave blank if no change needed.</p>
            </div>
            <div class="form-group">
                <label for="email">Email (required):</label>
                <input type="email" id="email" name="email">
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password">
                <p class="note">Optional: Leave blank to keep current password.</p>
            </div>
            <div class="form-group">
                <label for="phone">Phone:</label>
                <input type="text" id="phone" name="phone">
                <p class="note">Optional: Enter a valid phone number.</p>
            </div>
            <div class="form-group">
                <label for="dob">Date of Birth:</label>
                <input type="date" id="dob" name="dob">
                <p class="note">Optional: Format YYYY-MM-DD.</p>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address">
                <p class="note">Optional: Leave blank if no change needed.</p>
            </div>
            <div class="form-group">
                <label for="gender">Gender:</label>
                <select id="gender" name="gender">
                    <option value="1">Male</option>
                    <option value="0">Female</option>
                </select>
            </div>
            
            <div>
                <button type="submit" class="btn btn-submit">ADD</button>
                <button type="button" class="btn btn-back" onclick="location.href = 'DisplayAccount?idRole=${user.role.id}&page=1'">Back to List</button>
            </div>
        </form>
    </body>
</html>
