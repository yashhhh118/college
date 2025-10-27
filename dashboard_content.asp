<!-- #include file="databaseconn.asp" -->
<%
Set rs1 = conn.Execute("SELECT COUNT(*) AS total_users FROM user_info")
Set rs2 = conn.Execute("SELECT COUNT(*) AS total_reg FROM registration")
Set rs3 = conn.Execute("SELECT COUNT(*) AS total_comp FROM competition")
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Dashboard | Competition Portal</title>
<style>
    body {
        font-family: "Segoe UI", Arial, sans-serif;
        background: linear-gradient(135deg, #6c5ce7, #0984e3);
        margin: 0;
        height: 100vh;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        color: #fff;
    }

    .dashboard-container {
        background: #fff;
        color: #333;
        width: 80%;
        max-width: 800px;
        border-radius: 16px;
        box-shadow: 0 6px 20px rgba(0,0,0,0.2);
        padding: 40px;
        text-align: center;
        animation: fadeIn 1s ease;
    }

    h2 {
        color: #0984e3;
        margin-bottom: 25px;
        font-size: 28px;
        letter-spacing: 1px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    th, td {
        padding: 14px 10px;
        border-bottom: 1px solid #ddd;
        font-size: 16px;
    }

    th {
        background-color: #0984e3;
        color: white;
        border-top-left-radius: 8px;
        border-top-right-radius: 8px;
    }

    tr:nth-child(even) {
        background-color: #f8f9fa;
    }

    tr:hover {
        background-color: #eaf2ff;
    }

    .card-container {
        display: flex;
        justify-content: space-around;
        flex-wrap: wrap;
        margin-top: 25px;
    }

    .card {
        background: linear-gradient(#74b9ff, #0984e3);
        color: #fff;
        width: 200px;
        margin: 15px;
        border-radius: 12px;
        box-shadow: 0px 6px 12px rgba(0,0,0,0.2);
        padding: 20px;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .card:hover {
        transform: translateY(-8px);
        box-shadow: 0px 10px 20px rgba(0,0,0,0.3);
    }

    .card h3 {
        font-size: 22px;
        margin-bottom: 8px;
    }

    .card p {
        font-size: 28px;
        font-weight: bold;
        margin: 0;
    }

    .logout-btn {
        margin-top: 25px;
        background-color: #d63031;
        color: white;
        border: none;
        padding: 10px 25px;
        border-radius: 8px;
        cursor: pointer;
        font-size: 15px;
        transition: background-color 0.3s ease;
    }

    .logout-btn:hover {
        background-color: #ff7675;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>
</head>
<body>

<div class="dashboard-container">
    <h2>Dashboard Overview</h2>

    <div class="card-container">
        <div class="card">
            <h3>Total Users</h3>
            <p><%=rs1("total_users")%></p>
        </div>
        <div class="card">
            <h3>Registered Users</h3>
            <p><%=rs2("total_reg")%></p>
        </div>
        <div class="card">
            <h3>Total Competitions</h3>
            <p><%=rs3("total_comp")%></p>
        </div>
    </div>

    <table>
        <tr><th>Total Users</th><th>Registered Users</th><th>Total Competitions</th></tr>
        <tr>
            <td><%=rs1("total_users")%></td>
            <td><%=rs2("total_reg")%></td>
            <td><%=rs3("total_comp")%></td>
        </tr>
    </table>

   <!-- <form method="post" action="login.asp">
        <button class="logout-btn">Logout</button>
    </form>-->
</div>

</body>
</html>
