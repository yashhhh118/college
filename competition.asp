<!-- #include file="databaseconn.asp" -->
<%
' --- SESSION CHECK ---
If Session("user_id") = "" Or LCase(Session("college_role")) <> "host" Then
    Response.Redirect "login.asp"
End If

Dim msg

' --- Handle Competition Deletion ---
If Request.QueryString("action") = "delete" And Request.QueryString("id") <> "" Then
    Dim deleteCompId, sqlDeleteComp
    deleteCompId = Request.QueryString("id")
    ' --- Add check here to ensure ID is numeric ---
    If IsNumeric(deleteCompId) Then
        ' --- IMPORTANT: Consider related data (registrations) before deleting! ---
        ' --- Simple Delete (Might fail if registrations exist depending on FK constraints) ---
        sqlDeleteComp = "DELETE FROM competition WHERE comp_id=" & deleteCompId
        On Error Resume Next ' Basic error handling
        conn.Execute sqlDeleteComp
        If Err.Number = 0 Then
             msg = "🗑️ Competition deleted successfully!"
        Else
             msg = "❌ Error deleting competition: " & Err.Description & ". Check if participants are registered."
        End If
        On Error GoTo 0
    End If
End If

' --- Handle Competition Creation ---
If Request.Form("submit") <> "" Then

    Dim eventDT, regDT, sql
    eventDT = Replace(Request("comp_event_datetime"), "T", " ")
    regDT = Replace(Request("comp_reg_deadline"), "T", " ")

    ' --- Fetch host's Serial_no ---
    Dim hostSerial, rsHost
    Set rsHost = conn.Execute("SELECT TOP 1 Serial_no FROM user_info WHERE user_id='" & Replace(Session("user_id"),"'", "''") & "'")
    If Not rsHost.EOF Then
        hostSerial = rsHost("Serial_no")
    Else
        hostSerial = "NULL" ' Or handle error
    End If
    rsHost.Close
    Set rsHost = Nothing
    ' --- End Fetch host's Serial_no ---


    sql = "INSERT INTO competition (comp_host_id, comp_title, comp_description, comp_event_datetime, comp_reg_deadline, comp_poster_image, comp_category) VALUES (" & _
          hostSerial & ", '" & Replace(Request("comp_title"),"'", "''") & "', '" & Replace(Request("comp_description"),"'", "''") & "', '" & _
          eventDT & "', '" & regDT & "', '" & Replace(Request("comp_poster_image"),"'", "''") & "', '" & _
          Request("comp_category") & "')"

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
<!-- Include Tailwind CSS -->
<script src="https://cdn.tailwindcss.com"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
    body {
        font-family: 'Inter', sans-serif;
        background-color: #f8fafc;
        color: #1f2937;
        padding: 2rem;
    }
    .form-input, .form-textarea, .form-select {
        background-color: #f3f4f6; border: 1px solid #d1d5db; color: #1f2937;
        border-radius: 0.5rem; padding: 0.75rem 1rem; transition: border-color 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        width: 100%; margin-top: 0.25rem;
    }
    .form-input::placeholder, .form-textarea::placeholder { color: #9ca3af; }
    .form-input:focus, .form-textarea:focus, .form-select:focus {
        border-color: #3b82f6; outline: none; box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15);
    }
     select.form-select {
        appearance: none; background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
        background-position: right 0.5rem center; background-repeat: no-repeat; background-size: 1.5em 1.5em; padding-right: 2.5rem; color: #6b7280;
    }
     select.form-select:valid { color: #1f2937; }
     select.form-select:required:invalid { color: #9ca3af; }
     select option { color: #1f2937; background-color: #ffffff; }
    .form-button {
        background-color: #2563eb; color: #ffffff; border-radius: 0.5rem; padding: 0.75rem 1.25rem;
        font-weight: 600; transition: background-color 0.2s ease-in-out;
    }
    .form-button:hover { background-color: #1d4ed8; }
    .styled-table { width: 100%; border-collapse: collapse; margin-top: 1.5rem; border: 1px solid #e5e7eb; border-radius: 0.5rem; overflow: hidden; box-shadow: 0 1px 2px rgba(0,0,0,0.05); }
    .styled-table thead th {
        background-color: #f9fafb; color: #4b5563; font-size: 0.75rem; font-weight: 600; text-transform: uppercase;
        letter-spacing: 0.05em; padding: 0.75rem 1.5rem; text-align: left; border-bottom: 2px solid #e5e7eb;
    }
    .styled-table tbody tr { background-color: #ffffff; transition: background-color 0.15s ease-in-out; }
    .styled-table tbody tr:nth-child(even) { background-color: #f9fafb; }
    .styled-table tbody tr:hover { background-color: #f0f9ff; }
    .styled-table tbody td {
        padding: 1rem 1.5rem; color: #374151; font-size: 0.875rem; vertical-align: middle; border-bottom: 1px solid #e5e7eb;
    }
    .styled-table tbody tr:last-child td { border-bottom: none; }
    .msg-success { color: #16a34a; font-weight: 500; margin-bottom: 1.5rem; padding: 0.75rem 1rem; background-color: #dcfce7; border: 1px solid #bbf7d0; border-radius: 0.5rem;}
    .msg-error { color: #dc2626; font-weight: 500; margin-bottom: 1.5rem; padding: 0.75rem 1rem; background-color: #fee2e2; border: 1px solid #fecaca; border-radius: 0.5rem;}
    @keyframes fadeIn { from { opacity: 0; transform: translateY(15px); } to { opacity: 1; transform: translateY(0); } }
    .animate-fadeIn{ animation: fadeIn 0.5s ease-out forwards; }
    /* Action Button Styles */
    .action-button { padding: 0.25rem 0.5rem; border-radius: 0.375rem; font-size: 0.75rem; font-weight: 500; transition: background-color 0.2s ease-in-out; display: inline-block; }
    .edit-button { background-color: #eff6ff; color: #2563eb; }
    .edit-button:hover { background-color: #dbeafe; }
    .delete-button { background-color: #fee2e2; color: #dc2626; }
    .delete-button:hover { background-color: #fecaca; }
</style>
</head>
<body>

<div class="max-w-4xl mx-auto">
    <h3 class="text-3xl font-bold text-gray-800 mb-8">Create Competition</h3>

    <% If msg <> "" Then %>
        <div class="<%= IIf(InStr(msg, "❌") > 0 Or InStr(msg, "Error") > 0, "msg-error", "msg-success") %> text-center animate-fadeIn">
            <%= msg %>
        </div>
    <% End If %>

    <div class="bg-white border border-gray-200 rounded-lg p-6 mb-8 shadow-sm">
        <h4 class="text-lg font-semibold text-gray-700 mb-4 border-b pb-3 border-gray-200">Add New Competition</h4>
        <form method="post" class="space-y-4 pt-4">
            <div>
                <label for="comp_title" class="block text-sm font-medium text-gray-700">Title:</label>
                <input type="text" name="comp_title" id="comp_title" class="form-input" required placeholder="e.g., Annual Startup Pitch">
            </div>
            <div>
                <label for="comp_description" class="block text-sm font-medium text-gray-700">Description:</label>
                <textarea name="comp_description" id="comp_description" rows="4" class="form-textarea" required placeholder="Describe the competition..."></textarea>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label for="comp_event_datetime" class="block text-sm font-medium text-gray-700">Event Date & Time:</label>
                    <input type="datetime-local" name="comp_event_datetime" id="comp_event_datetime" class="form-input" required>
                </div>
                 <div>
                    <label for="comp_reg_deadline" class="block text-sm font-medium text-gray-700">Registration Deadline:</label>
                    <input type="datetime-local" name="comp_reg_deadline" id="comp_reg_deadline" class="form-input" required>
                </div>
            </div>
            <div>
                <label for="comp_poster_image" class="block text-sm font-medium text-gray-700">Poster Image URL:</label>
                <input type="text" name="comp_poster_image" id="comp_poster_image" class="form-input" placeholder="https://example.com/poster.jpg">
            </div>
            <div>
                <label for="comp_category" class="block text-sm font-medium text-gray-700">Category:</label>
                <select name="comp_category" id="comp_category" class="form-select" required>
                    <option value="" disabled selected>-- Choose Category --</option>
                    <%
                    Set rsCat = conn.Execute("SELECT category_name FROM category ORDER BY category_name")
                    Do While Not rsCat.EOF
                        Response.Write "<option value='" & Server.HTMLEncode(rsCat("category_name")) & "'>" & Server.HTMLEncode(rsCat("category_name")) & "</option>"
                        rsCat.MoveNext
                    Loop
                    rsCat.Close
                    Set rsCat = Nothing
                    %>
                </select>
            </div>
            <div class="text-right pt-2">
                <input type="submit" name="submit" value="Create Competition" class="form-button cursor-pointer">
            </div>
        </form>
    </div>

    <hr class="border-gray-200 my-8">

     <div class="bg-white border border-gray-200 rounded-lg shadow-sm overflow-hidden">
         <div class="px-6 py-4 border-b border-gray-200">
             <h4 class="text-xl font-semibold text-gray-700">Existing Competitions</h4>
         </div>
        <div class="overflow-x-auto">
            <table class="styled-table min-w-full">
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Event Date</th>
                        <th>Deadline</th>
                        <th class="text-center w-32">Actions</th> <!-- Added Actions Header -->
                    </tr>
                </thead>
                <tbody>
                <%
                ' **** Added comp_id to SELECT ****
                Set rsComp = conn.Execute("SELECT comp_id, comp_title, comp_event_datetime, comp_reg_deadline FROM competition ORDER BY comp_event_datetime DESC")
                 If rsComp.EOF Then
                    Response.Write "<tr><td colspan='4' class='text-center text-gray-500 py-6'>No competitions created yet.</td></tr>" ' Changed colspan to 4
                 Else
                    Do While Not rsComp.EOF
                        Response.Write "<tr>"
                        Response.Write "<td class='font-medium text-gray-900'>" & Server.HTMLEncode(rsComp("comp_title")) & "</td>"
                        Dim formattedEventDate, formattedRegDate
                        On Error Resume Next
                        formattedEventDate = FormatDateTime(rsComp("comp_event_datetime"), 2)
                        formattedRegDate = FormatDateTime(rsComp("comp_reg_deadline"), 2)
                        If Err.Number <> 0 Then
                            formattedEventDate = rsComp("comp_event_datetime")
                            formattedRegDate = rsComp("comp_reg_deadline")
                        End If
                        On Error GoTo 0
                        Response.Write "<td>" & formattedEventDate & "</td>"
                        Response.Write "<td>" & formattedRegDate & "</td>"
                        ' **** Added Actions Cell with Delete Button ****
                        Response.Write "<td class='text-center space-x-2'>"
                        Response.Write "<a href='edit_competition.asp?id=" & rsComp("comp_id") & "' class='action-button edit-button'>Edit</a>" ' Placeholder Edit link
                        <a href="competition.asp?action=delete&id=<%=rsComp("comp_id")%>" class="action-button delete-button" onclick="return confirm('Are you sure you want to delete this competition?');">
   Delete
</a>
                        Response.Write "</td>"

                        Response.Write "</tr>"
                        rsComp.MoveNext
                    Loop
                 End If
                rsComp.Close
                Set rsComp = Nothing
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>

