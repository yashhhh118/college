<!-- #include file="databaseconn.asp" -->
<%
Dim msg
If Request.Form("submit") <> "" Then

    Dim eventDT, regDT
    eventDT = Replace(Request("comp_event_datetime"), "T", " ")
    regDT = Replace(Request("comp_reg_deadline"), "T", " ")

    sql = "INSERT INTO competition (comp_host_id, comp_title, comp_description, comp_event_datetime, comp_reg_deadline, comp_poster_image, comp_category) VALUES (" & _
          "(SELECT TOP 1 Serial_no FROM user_info WHERE user_id='" & Session("user_id") & "'), '" & _
          Replace(Request("comp_title"),"'", "''") & "', '" & Replace(Request("comp_description"),"'", "''") & "', '" & _
          eventDT & "', '" & regDT & "', '" & Replace(Request("comp_poster_image"),"'", "''") & "', '" & _
          Request("comp_category") & "')"

  '  Response.Write("SQL = " & sql & "<br>") ' debug

    On Error Resume Next
    conn.Execute(sql)
    If Err.Number <> 0 Then
        msg = "❌ Error creating competition: " & Err.Description
    Else
        msg = "✅ Competition created successfully!"
    End If
    On Error GoTo 0
End If
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Create Competition | Competition Portal</title>
<style>
    body {
        font-family: "Segoe UI", Arial, sans-serif;
        background: #f4f6f9;
        margin: 0;
        padding: 40px;
        color: #333;
    }

    .container {
        background: #fff;
        max-width: 850px;
        margin: auto;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        padding: 35px 45px;
        animation: fadeIn 0.8s ease;
    }

    h3, h4 {
        color: #0984e3;
        margin-top: 0;
    }

    label {
        display: block;
        margin-top: 12px;
        font-weight: 600;
    }

    input[type=text], 
    input[type=datetime-local],
    textarea, 
    select {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 15px;
        margin-top: 5px;
        transition: border-color 0.2s ease;
        box-sizing: border-box;
    }

    textarea {
        height: 80px;
        resize: vertical;
    }

    input:focus, textarea:focus, select:focus {
        border-color: #0984e3;
        outline: none;
        box-shadow: 0 0 4px rgba(9,132,227,0.3);
    }

    input[type=submit] {
        background-color: #0984e3;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 6px;
        font-size: 15px;
        cursor: pointer;
        transition: background 0.3s ease;
        font-weight: 600;
        margin-top: 20px;
    }

    input[type=submit]:hover {
        background-color: #74b9ff;
    }

    .msg {
        color: green;
        font-weight: 600;
        margin-bottom: 15px;
    }

    hr {
        margin: 30px 0;
        border: none;
        height: 1px;
        background: #eee;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
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
    <h3>Create Competition</h3>

    <% If msg <> "" Then %>
        <div class="msg"><%=msg%></div>
    <% End If %>

    <form method="post">
        <label>Title:</label>
        <input type="text" name="comp_title" required>

        <label>Description:</label>
        <textarea name="comp_description" required></textarea>

        <label>Event Date:</label>
        <input type="datetime-local" name="comp_event_datetime" required>

        <label>Registration Deadline:</label>
        <input type="datetime-local" name="comp_reg_deadline" required>

        <label>Poster Image URL:</label>
        <input type="text" name="comp_poster_image" placeholder="https://example.com/poster.jpg">

        <label>Category:</label>
        <select name="comp_category" required>
            <%
            Set rs = conn.Execute("SELECT * FROM category ORDER BY category_name")
            Do While Not rs.EOF
                Response.Write "<option value='" & rs("category_name") & "'>" & rs("category_name") & "</option>"
                rs.MoveNext
            Loop
            rs.Close
            %>
        </select>

        <input type="submit" name="submit" value="Create Competition">
    </form>

    <hr>

    <h4>Existing Competitions</h4>
    <table>
        <tr><th>Title</th><th>Event Date</th><th>Deadline</th></tr>
        <%
        Set rs = conn.Execute("SELECT comp_title, comp_event_datetime, comp_reg_deadline FROM competition ORDER BY comp_event_datetime DESC")
        Do While Not rs.EOF
            Response.Write "<tr><td>" & rs("comp_title") & "</td><td>" & rs("comp_event_datetime") & "</td><td>" & rs("comp_reg_deadline") & "</td></tr>"
            rs.MoveNext
        Loop
        rs.Close
        %>
    </table>
</div>
</body>
</html>
