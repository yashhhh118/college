<!-- #include file="databaseconn.asp" -->
<%
Dim msg, sql, userSerial, rsUser

' ✅ Step 1: Check if user is logged in
If Session("user_id") = "" Then
    Response.Redirect "login.asp"
End If

' ✅ Step 2: Get logged-in user's Serial_no (primary key)
Set rsUser = conn.Execute("SELECT Serial_no FROM user_info WHERE user_id='" & Replace(Session("user_id"),"'", "''") & "'")
If Not rsUser.EOF Then
    userSerial = rsUser("Serial_no")
Else
    msg = "⚠️ User not found. Please log in again."
End If
rsUser.Close
Set rsUser = Nothing

' ✅ Step 3: Handle registration form submission
If Request.Form("submit") <> "" And msg = "" Then
    Dim compID
    compID = Request("competition_id")

    ' Check if already registered
    Dim rsCheck
    Set rsCheck = conn.Execute("SELECT * FROM registration WHERE reg_user_id=" & userSerial & " AND competition_id=" & compID)
    If Not rsCheck.EOF Then
        msg = "⚠️ You are already registered for this competition!"
    Else
      sql = "INSERT INTO registration (reg_user_id, competition_id, reg_datetime) VALUES (" & userSerial & ", " & compID & ", GETDATE())"
        conn.Execute(sql)
        msg = "? You have successfully registered!"
    End If
    rsCheck.Close
    Set rsCheck = Nothing
End If
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Competition Registration</title>
<style>
    body {
        font-family: 'Segoe UI', Arial, sans-serif;
        background: linear-gradient(135deg, #74b9ff, #0984e3);
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    .register-box {
        background: #fff;
        padding: 40px 50px;
        border-radius: 12px;
        box-shadow: 0 6px 25px rgba(0,0,0,0.15);
        width: 400px;
        text-align: center;
        animation: fadeIn 0.6s ease;
    }
    h3 {
        margin-bottom: 25px;
        color: #2d3436;
        font-size: 26px;
        border-bottom: 3px solid #0984e3;
        display: inline-block;
        padding-bottom: 6px;
    }
    select, input[type="submit"] {
        width: 100%;
        padding: 12px;
        margin-top: 15px;
        border-radius: 8px;
        border: 1px solid #ccc;
        font-size: 16px;
    }
    select:focus, input:focus {
        outline: none;
        border-color: #0984e3;
        box-shadow: 0 0 5px rgba(9,132,227,0.3);
    }
    input[type="submit"] {
        background: #0984e3;
        color: white;
        font-weight: bold;
        cursor: pointer;
        border: none;
        transition: 0.3s;
    }
    input[type="submit"]:hover {
        background: #74b9ff;
        transform: scale(1.02);
    }
    .msg {
        margin-top: 20px;
        color: green;
        font-weight: bold;
        animation: fadeIn 0.5s ease;
    }
    .error {
        color: red;
        font-weight: bold;
        margin-top: 20px;
    }
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(15px); }
        to { opacity: 1; transform: translateY(0); }
    }
</style>
</head>
<body>
    <div class="register-box">
        <h3>Register for Competition</h3>
        <form method="post">
            <label for="competition_id" style="display:block; margin-bottom:8px; font-weight:500; color:#2d3436;">Select Competition:</label>
            <select name="competition_id" id="competition_id" required>
                <option value="">-- Choose Competition --</option>
                <%
                Dim rs
                Set rs = conn.Execute("SELECT comp_id, comp_title FROM competition ORDER BY comp_event_datetime ASC")
                Do While Not rs.EOF
                    Response.Write "<option value='" & rs("comp_id") & "'>" & rs("comp_title") & "</option>"
                    rs.MoveNext
                Loop
                rs.Close
                Set rs = Nothing
                %>
            </select>

            <input type="submit" name="submit" value="Register">
        </form>

        <% 
        If msg <> "" Then
            If InStr(msg, "⚠️") > 0 Then
                Response.Write "<div class='error'>" & msg & "</div>"
            Else
                Response.Write "<div class='msg'>" & msg & "</div>"
            End If
        End If
        %>
    </div>
</body>
</html>
