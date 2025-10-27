<%
If Session("user_id") = "" Or LCase(Session("college_role")) <> "host" Then
    Response.Redirect "login.asp"
End If
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Host Dashboard | Competition Portal</title>
<style>
    body {
        margin: 0;
        font-family: "Segoe UI", Arial, sans-serif;
        background-color: #f4f6f9;
        display: flex;
        height: 100vh;
    }

    .sidebar {
        width: 230px;
        background: #0984e3;
        color: #fff;
        display: flex;
        flex-direction: column;
        padding-top: 20px;
        box-shadow: 2px 0 10px rgba(0,0,0,0.1);
    }

    .sidebar h2 {
        text-align: center;
        font-size: 20px;
        margin-bottom: 30px;
        letter-spacing: 1px;
    }

    .sidebar a {
        color: #fff;
        text-decoration: none;
        padding: 12px 20px;
        display: block;
        transition: background 0.3s;
        font-weight: 500;
    }

    .sidebar a:hover, .sidebar a.active {
        background: #74b9ff;
    }

    .logout {
        margin-top: auto;
        background: #d63031;
        text-align: center;
    }

    .logout:hover {
        background: #e17055;
    }

    .main {
        flex-grow: 1;
        padding: 0;
        overflow-y: hidden;
    }

    iframe {
        width: 100%;
        height: 100vh;
        border: none;
        background: #fff;
    }
</style>
</head>
<body>

<div class="sidebar">
    <h2>Host Panel</h2>
    <a href="dashboard_content.asp" target="contentFrame" class="active">🏠 Dashboard</a>
    <a href="user.asp" target="contentFrame">👤 User Creation</a>
    <a href="category.asp" target="contentFrame">📂 Category</a>
    <a href="competition.asp" target="contentFrame">🏆 Competition</a>
    <a href="login.asp" class="logout">🚪 Logout</a>
</div>

<div class="main">
    <iframe name="contentFrame" src="dashboard_content.asp"></iframe>
</div>

<script>
    const links = document.querySelectorAll('.sidebar a');
    links.forEach(link => {
        link.addEventListener('click', () => {
            links.forEach(l => l.classList.remove('active'));
            link.classList.add('active');
        });
    });
</script>

</body>
</html>
