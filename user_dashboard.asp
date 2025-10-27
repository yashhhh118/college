<!-- #include file="databaseconn.asp" -->
<%
If Session("user_id") = "" Then
    Response.Redirect "login.asp"
End If

Dim userId, userRole
userId = Session("user_id")
userRole = Session("college_role")
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #dff9fb;
            margin: 0;
            padding: 0;
        }

        .header {
            background-color: #0984e3;
            color: white;
            padding: 20px;
            text-align: center;
        }

        .container {
            margin: 40px auto;
            max-width: 600px;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.1);
        }

        .logout {
            float: right;
            margin-top: -35px;
        }

        .logout a {
            color: white;
            text-decoration: none;
            font-weight: bold;
            padding: 10px 15px;
            background-color: #d63031;
            border-radius: 5px;
        }

        .logout a:hover {
            background-color: #e17055;
        }

        h2 {
            color: #0984e3;
        }
    </style>
</head>
<body>

<div class="header">
    <h1>User Dashboard</h1>
    <div class="logout">
        <a href="login.asp">Logout</a>
    </div>
</div>

<div class="container">
    <h2>Welcome, <%= userId %>!</h2>
    <p>Your role is: <strong><%= userRole %></strong></p>

    <p>This is your user dashboard. Here, you can:</p>
    <ul>
        <li><a href="register_event.asp">Register for events</a></li>
    </ul>
</div>

</body>
</html>
