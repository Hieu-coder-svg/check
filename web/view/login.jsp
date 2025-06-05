<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Login Form</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/login.css" />
</head>
<body>
  <div class="center">
    <h1>Login</h1>
    <form action="" method="POST">
      <div class="txt_field">
        <input type="text" name="username" placeholder="Username" required />
      </div>
      <div class="txt_field">
        <input type="password" name="password" placeholder="Password" required />
      </div>
      <input type="submit" value="Login" />
      <div class="register">
        Don't have an account? <a href="signup.php">Register</a>
      </div>
    </form>
  </div>
</body>
</html>
