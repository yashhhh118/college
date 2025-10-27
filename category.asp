<!-- #include file="databaseconn.asp" -->


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Create Category | Competition Portal</title>
<style>
    body {
        font-family: "Segoe UI", Arial, sans-serif;
        background: #f7f9fc;
        margin: 0;
        padding: 40px;
        color: #333;
    }

    h3, h4 {
        color: #0984e3;
    }

    .container {
        background: #fff;
        max-width: 700px;
        margin: auto;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        padding: 30px 40px;
        animation: fadeIn 0.8s ease;
    }

    form {
        margin-bottom: 25px;
    }

    label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        color: #333;
    }

    input[type=text] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 15px;
        margin-bottom: 15px;
        transition: border-color 0.2s ease-in-out;
    }

    input[type=text]:focus {
        border-color: #0984e3;
        outline: none;
        box-shadow: 0 0 5px rgba(9,132,227,0.3);
    }

    input[type=submit] {
        background-color: #0984e3;
        color: white;
        border: none;
        padding: 10px 18px;
        border-radius: 6px;
        font-size: 15px;
        cursor: pointer;
        transition: background 0.3s ease;
        font-weight: 600;
    }

    input[type=submit]:hover {
        background-color: #74b9ff;
    }

    .msg {
        color: green;
        font-weight: 600;
        margin-bottom: 20px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 15px;
        background: #fff;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }

    th, td {
        padding: 12px 15px;
        border-bottom: 1px solid #eee;
        text-align: left;
        font-size: 15px;
    }

    th {
        background-color: #0984e3;
        color: white;
        font-weight: 600;
    }

    tr:hover {
        background-color: #f1f9ff;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(15px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>
</head>
<body>

<div class="container">
    <h3>Create Category</h3>

    <% If msg <> "" Then %>
        <div class="msg"><%=msg%></div>
    <% End If %>

    <form method="post">
        <label>Category Name:</label>
        <input type="text" name="category_name" required>
        <input type="submit" name="submit" value="Add">
    </form>

    <hr>

    <h4>Available Categories</h4>
    <table>
        <tr><th>ID</th><th>Name</th></tr>
        <%
        Set rs = conn.Execute("SELECT * FROM category ORDER BY category_id ")
        Do While Not rs.EOF
            Response.Write "<tr><td>" & rs("category_id") & "</td><td>" & rs("category_name") & "</td></tr>"
            rs.MoveNext
        Loop
        rs.Close
        %>
    </table>
</div>

</body>
</html>
