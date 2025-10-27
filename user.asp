<!-- #include file="databaseconn.asp" -->
<%
Dim msg
If Request.Form("submit") <> "" Then
    sql = "INSERT INTO user_info (user_id, full_name, email_id, user_password, college_name, year_college, contact_no, college_role) VALUES ('" & _
        Replace(Request("user_id"),"'", "''") & "','" & Replace(Request("full_name"),"'", "''") & "','" & Replace(Request("email_id"),"'", "''") & "','" & Replace(Request("user_password"),"'", "''") & "','" & _
        Replace(Request("college_name"),"'", "''") & "','" & Replace(Request("year_college"),"'", "''") & "','" & Replace(Request("contact_no"),"'", "''") & "','" & Replace(Request("college_role"),"'", "''") & "')"
    conn.Execute(sql)
    msg = "✅ User created successfully!"
End If
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Create User | Competition Portal</title>
<style>
    body {
        font-family: "Segoe UI", Arial, sans-serif;
        background: linear-gradient(135deg, #74b9ff, #0984e3);
        margin: 0;
        padding: 40px 0;
        display: flex;
        flex-direction: column;
        align-items: center;
        color: #333;
    }

    .container {
        background: #fff;
        width: 90%;
        max-width: 850px;
        border-radius: 16px;
        box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        padding: 40px;
        animation: fadeIn 0.8s ease;
    }

    h3, h4 {
        color: #0984e3;
        text-align: center;
        margin-top: 0;
    }

    .msg {
        text-align: center;
        color: green;
        font-weight: bold;
        margin-bottom: 15px;
    }

    form {
        background: #f8f9fa;
        border-radius: 12px;
        padding: 25px 30px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        margin-bottom: 35px;
    }

    label {
        display: block;
        margin-top: 12px;
        font-weight: 600;
        color: #2c3e50;
    }

    input[type=text], 
    input[type=password], 
    select {
        width: 100%;
        padding: 10px 12px;
        border: 1px solid #ccc;
        border-radius: 8px;
        font-size: 15px;
        margin-top: 6px;
        box-sizing: border-box;
        transition: border-color 0.3s ease, box-shadow 0.3s ease;
    }

    input:focus, select:focus {
        border-color: #0984e3;
        box-shadow: 0 0 6px rgba(9,132,227,0.25);
        outline: none;
    }

    input[type=submit] {
        background-color: #0984e3;
        color: white;
        border: none;
        padding: 12px;
        border-radius: 8px;
        cursor: pointer;
        font-size: 16px;
        font-weight: 600;
        margin-top: 20px;
        width: 100%;
        transition: background 0.3s ease, transform 0.2s ease;
    }

    input[type=submit]:hover {
        background-color: #74b9ff;
        transform: translateY(-2px);
    }

    hr {
        border: none;
        border-top: 1px solid #eee;
        margin: 40px 0 25px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        background: #fff;
    }

    th, td {
        padding: 14px 15px;
        text-align: left;
        border-bottom: 1px solid #f0f0f0;
    }

    th {
        background-color: #0984e3;
        color: #fff;
        font-weight: 600;
        text-transform: uppercase;
        font-size: 14px;
    }

    tr:nth-child(even) {
        background-color: #f9fcff;
    }

    tr:hover {
        background-color: #eaf3ff;
        transition: 0.2s ease;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }

    @media (max-width: 600px) {
        body {
            padding: 20px;
        }
        .container {
            padding: 25px;
        }
        form {
            padding: 20px;
        }
    }
</style>
</head>

<body>
<div class="container">
    <h3>Create User</h3>
    <% If msg <> "" Then %>
        <div class="msg"><%= msg %></div>
    <% End If %>

    <form method="post">
        <label>User ID:</label>
        <input type="text" name="user_id" required>

        <label>Full Name:</label>
        <input type="text" name="full_name" required>

        <label>Email ID:</label>
        <input type="text" name="email_id" required>

        <label>Password:</label>
        <input type="password" name="user_password" required>

        <label>College Name:</label>
        <input type="text" name="college_name">

        <label>Year of College:</label>
        <input type="text" name="year_college">

        <label>Contact No:</label>
        <input type="text" name="contact_no">

        <label>Role:</label>
        <select name="college_role">
            <option value="host">Host</option>
            <option value="student">Student</option>
        </select>

        <input type="submit" name="submit" value="Create User">
    </form>

    <h4>Existing Users</h4>
    <table>
        <tr>
            <th>User ID</th>
            <th>Name</th>
            <th>Role</th>
        </tr>
        <%
        Set rs = conn.Execute("SELECT user_id, full_name, college_role FROM user_info ORDER BY full_name")
        Do While Not rs.EOF
            Response.Write "<tr><td>" & rs("user_id") & "</td><td>" & rs("full_name") & "</td><td>" & rs("college_role") & "</td></tr>"
            rs.MoveNext
        Loop
        rs.Close
        %>
    </table>
</div>
</body>
</html>
