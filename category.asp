<!-- #include file="databaseconn.asp" -->
<%
' --- SESSION CHECK ---
If Session("user_id") = "" Or LCase(Session("college_role")) <> "host" Then
    Response.Redirect "login.asp"
End If

' --- Handle Category Addition ---
Dim msg
If Request.Form("submit") <> "" Then
    Dim category_name, category_desc, sqlCheck, rsCheck, sqlInsert ' Added category_desc
    category_name = Trim(Request.Form("category_name"))
    category_desc = Trim(Request.Form("category_desc")) ' Get description from form

    ' Check if category already exists
    sqlCheck = "SELECT category_id FROM category WHERE category_name='" & Replace(category_name, "'", "''") & "'"
    Set rsCheck = conn.Execute(sqlCheck)

    If rsCheck.EOF Then
        ' Insert new category (including description)
        sqlInsert = "INSERT INTO category (category_name, category_description) VALUES ('" & Replace(category_name, "'", "''") & "', '" & Replace(category_desc, "'", "''") & "')" ' Added description to INSERT
        conn.Execute sqlInsert
        msg = "✅ Category '" & category_name & "' added successfully!"
    Else
        msg = "⚠️ Category '" & category_name & "' already exists."
    End If
    rsCheck.Close
    Set rsCheck = Nothing
End If

' --- Handle Category Deletion (Placeholder Logic) ---
If Request.QueryString("action") = "delete" And Request.QueryString("id") <> "" Then
    Dim deleteId, sqlDelete
    deleteId = Request.QueryString("id")
    ' --- Add check here to ensure ID is numeric ---
    If IsNumeric(deleteId) Then
        ' --- IMPORTANT: In a real app, check if category is in use before deleting! ---
        sqlDelete = "DELETE FROM category WHERE category_id=" & deleteId
        conn.Execute sqlDelete
        msg = "🗑️ Category deleted successfully!"
        ' Optional: Redirect back to category.asp to refresh list without message
        ' Response.Redirect "category.asp"
    End If
End If
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Create Category | Competition Portal</title>
<!-- Include Tailwind CSS -->
<script src="https://cdn.tailwindcss.com"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
    body {
        font-family: 'Inter', sans-serif;
        /* Background matches the light iframe background */
        background-color: #f8fafc;
        color: #1f2937; /* Dark text for light bg */
        padding: 2rem;
    }
    /* Style for input fields - matching login */
    .form-input, .form-textarea, .form-select {
        background-color: #f3f4f6; /* Light gray */
        border: 1px solid #d1d5db; /* Gray border */
        color: #1f2937;
        border-radius: 0.5rem; /* Rounded */
        padding: 0.75rem 1rem; /* Padding */
        transition: border-color 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        width: 100%; /* Make inputs full width */
    }
    .form-input::placeholder, .form-textarea::placeholder {
        color: #9ca3af;
    }
    .form-input:focus, .form-textarea:focus, .form-select:focus {
        border-color: #3b82f6; /* Blue focus border */
        outline: none;
        box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15); /* Softer focus ring */
    }
    /* Style for the button - matching login */
    .form-button {
        background-color: #2563eb; /* Strong blue */
        color: #ffffff;
        border-radius: 0.5rem;
        padding: 0.75rem 1.25rem;
        font-weight: 600;
        transition: background-color 0.2s ease-in-out;
    }
    .form-button:hover {
        background-color: #1d4ed8; /* Darker blue */
    }
    /* Action Button Styles */
    .action-button {
        padding: 0.25rem 0.5rem;
        border-radius: 0.375rem; /* Smaller radius */
        font-size: 0.75rem; /* Smaller font */
        font-weight: 500;
        transition: background-color 0.2s ease-in-out;
    }
    .edit-button { background-color: #eff6ff; color: #2563eb; }
    .edit-button:hover { background-color: #dbeafe; }
    .delete-button { background-color: #fee2e2; color: #dc2626; }
    .delete-button:hover { background-color: #fecaca; }

    /* Enhanced table styling */
    .styled-table {
        width: 100%;
        border-collapse: collapse; /* Cleaner look */
        margin-top: 1.5rem;
        border: 1px solid #e5e7eb; /* Table border */
        border-radius: 0.5rem;
        overflow: hidden; /* Clip rounded corners */
        box-shadow: 0 1px 2px rgba(0,0,0,0.05);
    }
    .styled-table thead th {
        background-color: #f9fafb; /* Very light gray header */
        color: #4b5563; /* Medium gray text */
        font-size: 0.75rem; /* 12px */
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        padding: 0.75rem 1.5rem; /* 12px 24px */
        text-align: left;
        border-bottom: 2px solid #e5e7eb; /* Header bottom border */
    }
    .styled-table tbody tr {
         background-color: #ffffff;
         transition: background-color 0.15s ease-in-out;
    }
     .styled-table tbody tr:nth-child(even) {
         background-color: #f9fafb; /* Zebra striping */
     }
     .styled-table tbody tr:hover {
         background-color: #f0f9ff; /* Light blue hover */
     }
    .styled-table tbody td {
        padding: 1rem 1.5rem; /* 16px 24px */
        color: #374151; /* Darker gray text */
        font-size: 0.875rem; /* 14px */
        vertical-align: middle;
        border-bottom: 1px solid #e5e7eb; /* Row separator */
    }
     .styled-table tbody tr:last-child td {
        border-bottom: none; /* No border on last row */
     }

    /* Success/Error Message Styling */
    .msg-success { color: #16a34a; font-weight: 500; margin-bottom: 1.5rem; padding: 0.75rem 1rem; background-color: #dcfce7; border: 1px solid #bbf7d0; border-radius: 0.5rem;}
    .msg-error { color: #dc2626; font-weight: 500; margin-bottom: 1.5rem; padding: 0.75rem 1rem; background-color: #fee2e2; border: 1px solid #fecaca; border-radius: 0.5rem;}

    /* Animation */
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(15px); }
        to { opacity: 1; transform: translateY(0); }
    }
    .animate-fadeIn{
         animation: fadeIn 0.5s ease-out forwards;
    }

</style>
</head>
<body>

<div class="max-w-4xl mx-auto"> <!-- Wider container -->
    <h3 class="text-3xl font-bold text-gray-800 mb-8">Manage Categories</h3>

    <!-- Display Message -->
    <% If msg <> "" Then %>
        <div class="<%= IIf(InStr(msg, "⚠️") > 0, "msg-error", "msg-success") %> text-center animate-fadeIn">
            <%= msg %>
        </div>
    <% End If %>

    <!-- Add Category Form in a Card -->
    <div class="bg-white border border-gray-200 rounded-lg p-6 mb-8 shadow-sm">
        <h4 class="text-lg font-semibold text-gray-700 mb-4">Add New Category</h4>
        <form method="post" class="space-y-4">
            <div>
                 <label for="category_name" class="block text-sm font-medium text-gray-700 mb-1">Category Name:</label>
                 <input type="text" name="category_name" id="category_name" class="form-input" required placeholder="Enter category name">
            </div>
             <div>
                 <label for="category_desc" class="block text-sm font-medium text-gray-700 mb-1">Description (Optional):</label>
                 <textarea name="category_desc" id="category_desc" rows="3" class="form-textarea" placeholder="Briefly describe this category"></textarea>
            </div>
            <div class="text-right">
                <input type="submit" name="submit" value="Add Category" class="form-button cursor-pointer">
            </div>
        </form>
    </div>

    <!-- Available Categories Table in a Card -->
    <div class="bg-white border border-gray-200 rounded-lg p-6 shadow-sm">
        <h4 class="text-xl font-semibold text-gray-700 mb-4">Available Categories</h4>
        <div class="overflow-x-auto">
            <table class="styled-table min-w-full">
                <thead>
                    <tr>
                        <th class="w-16">ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th class="w-32 text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                ' Include Description in SELECT
                Set rs = conn.Execute("SELECT category_id, category_name, category_description FROM category ORDER BY category_id ")
                If rs.EOF Then
                    Response.Write "<tr><td colspan='4' class='text-center text-gray-500 py-6'>No categories found. Add one above!</td></tr>"
                Else
                    Do While Not rs.EOF
                        Response.Write "<tr>"
                        Response.Write "<td>" & rs("category_id") & "</td>"
                        Response.Write "<td class='font-medium'>" & Server.HTMLEncode(rs("category_name")) & "</td>"
                        ' Display Description (handle if NULL or empty)
                        Dim descDisplay
                        If IsNull(rs("category_description")) OR rs("category_description") = "" Then
                            descDisplay = "<span class='text-gray-400 italic'>No description</span>"
                        Else
                            descDisplay = Server.HTMLEncode(rs("category_description"))
                        End If
                        Response.Write "<td class='text-sm text-gray-600'>" & descDisplay & "</td>"
                        
                        ' Action Buttons Placeholder
                        Response.Write "<td class='text-center space-x-2'>"
                        Response.Write "<a href='edit_category.asp?id=" & rs("category_id") & "' class='action-button edit-button'>Edit</a>" ' Placeholder link
                        Response.Write "<a href='category.asp?action=delete&id=" & rs("category_id") & "' class='action-button delete-button' onclick='return confirm(""Are you sure you want to delete this category?"");'>Delete</a>" ' Placeholder link with confirm
                        Response.Write "</td>"
                        
                        Response.Write "</tr>"
                        rs.MoveNext
                    Loop
                End If
                rs.Close
                Set rs = Nothing
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>

