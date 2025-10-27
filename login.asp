<!-- #include file="databaseconn.asp" -->
<%
Dim msg
If Request.Form("submit") <> "" Then
    Dim user, pass, sql, rs
    user = Trim(Request.Form("user"))
    pass = Trim(Request.Form("password"))

    sql = "SELECT * FROM user_info WHERE user_id='" & user & "' AND user_password='" & pass & "'"
    Set rs = conn.Execute(sql)

    If Not rs.EOF Then
        Session("user_id") = rs("user_id")
        Session("college_role") = rs("college_role")

        If LCase(rs("college_role")) = "host" Then
            Response.Redirect "home.asp"
        Else
            Response.Redirect "user_dashboard.asp"
        End If
    Else
        msg = "Invalid User ID or Password!"
    End If
End If
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Login | Competition Portal</title>
<style>
    body {
        font-family: "Segoe UI", Arial, sans-serif;
        background: linear-gradient(135deg, #74b9ff, #0984e3);
        height: 100vh;
        margin: 0;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .login-container {
        background: #fff;
        padding: 40px 50px;
        border-radius: 12px;
        box-shadow: 0px 6px 15px rgba(0,0,0,0.2);
        width: 350px;
        text-align: center;
    }

    .login-container h2 {
        color: #0984e3;
        margin-bottom: 25px;
        font-size: 26px;
        letter-spacing: 1px;
    }

    .input-group {
        margin-bottom: 20px;
        text-align: left;
    }

    label {
        display: block;
        font-weight: 600;
        color: #333;
        margin-bottom: 5px;
    }

    input[type="text"], input[type="password"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 6px;
        font-size: 15px;
        outline: none;
        transition: all 0.2s ease-in-out;
    }

    input[type="text"]:focus, input[type="password"]:focus {
        border-color: #0984e3;
        box-shadow: 0 0 5px rgba(9,132,227,0.3);
    }

    .btn {
        background-color: #0984e3;
        color: #fff;
        border: none;
        padding: 10px 0;
        width: 100%;
        font-size: 16px;
        font-weight: bold;
        border-radius: 6px;
        cursor: pointer;
        transition: 0.3s;
    }

    .btn:hover {
        background-color: #74b9ff;
    }

    .error {
        color: red;
        margin-top: 10px;
        font-size: 14px;
    }

    .footer-text {
        margin-top: 25px;
        font-size: 13px;
        color: #666;
    }

    .footer-text a {
        color: #0984e3;
        text-decoration: none;
        font-weight: 600;
    }

    .footer-text a:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>

<div class="login-container">
    <h2>Competition Portal</h2>
    <form method="post">
        <div class="input-group">
            <label for="user">User ID</label>
            <input type="text" name="user" id="user" placeholder="Enter your user ID" required>
        </div>

        <div class="input-group">
            <label for="password">Password</label>
            <input type="password" name="password" id="password" placeholder="Enter your password" required>
        </div>

        <input type="submit" name="submit" value="Login" class="btn">
    </form>

    <% If msg <> "" Then %>
        <div class="error"><%=msg%></div>
    <% End If %>

    <div class="footer-text">
        Don’t have an account? <a href="registration.asp">Register here</a>
    </div>
</div>

</body>
</html>
