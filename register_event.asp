<!-- #include file="databaseconn.asp" -->
<%
' Check login
If Session("user_id") = "" Then
    Response.Redirect "login.asp"
End If

Dim msg, sql, rs, userSerial, competitionId

' Get logged-in user’s Serial_no (from user_info)
Dim rsUser
Set rsUser = conn.Execute("SELECT Serial_no FROM user_info WHERE user_id = '" & Session("user_id") & "'")
If Not rsUser.EOF Then
    userSerial = rsUser("Serial_no")
End If
rsUser.Close
Set rsUser = Nothing

' Handle registration
If Request.QueryString("register_id") <> "" Then
    competitionId = Request.QueryString("register_id")

    ' Check if user already registered
    Dim rsCheck
    Set rsCheck = conn.Execute("SELECT * FROM registration WHERE reg_user_id = " & userSerial & " AND competition_id = " & competitionId)
    
    If Not rsCheck.EOF Then
        msg = "⚠️ You have already registered for this event."
    Else
        sql = "INSERT INTO registration (reg_user_id, competition_id, reg_datetime) VALUES (" & userSerial & ", " & competitionId & ", GETDATE())"
        conn.Execute(sql)
        msg = "✅ Successfully registered for the event!"
    End If

    rsCheck.Close
    Set rsCheck = Nothing
End If

' Fetch all competitions
Set rs = conn.Execute("SELECT comp_id, comp_title, comp_event_datetime, comp_description FROM competition ORDER BY comp_reg_deadline ASC")
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register for Events</title>
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
            text-align: center;
            padding: 20px;
        }

        .container {
            max-width: 900px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 6px 15px rgba(0,0,0,0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #74b9ff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f1f2f6;
        }

        a.register-btn {
            text-decoration: none;
            background-color: #00b894;
            color: white;
            padding: 8px 12px;
            border-radius: 5px;
        }

        a.register-btn:hover {
            background-color: #55efc4;
        }

        .msg {
            text-align: center;
            font-weight: bold;
            color: #2d3436;
            margin-bottom: 20px;
        }

        .back {
            text-align: center;
            margin-top: 20px;
        }

        .back a {
            text-decoration: none;
            color: #0984e3;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="header">
    <h1>Register for Events</h1>
</div>

<div class="container">
    <% If msg <> "" Then %>
        <div class="msg"><%= msg %></div>
    <% End If %>

    <table>
        <tr>
            <th>Competition Name</th>
            <th>Event Date</th>
            <th>Description</th>
            <th>Action</th>
        </tr>
        <%
        If Not rs.EOF Then
            Do Until rs.EOF
        %>
        <tr>
            <td><%= rs("comp_title") %></td>
            <td><%= rs("comp_event_datetime") %></td>
            <td><%= rs("comp_description") %></td>
            <td><a class="register-btn" href="register_event.asp?register_id=<%= rs("comp_id") %>">Register</a></td>
        </tr>
        <%
                rs.MoveNext
            Loop
        Else
        %>
        <tr><td colspan="4">No competitions available.</td></tr>
        <%
        End If
        rs.Close
        Set rs = Nothing
        %>
    </table>

    <div class="back">
        <a href="user_dashboard.asp">⬅ Back to Dashboard</a>
    </div>
</div>

</body>
</html>
