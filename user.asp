<!-- #include file="databaseconn.asp" -->
<%
' --- SESSION CHECK ---
If Session("user_id") = "" Or LCase(Session("college_role")) <> "host" Then
    Response.Redirect "login.asp"
End If

Dim msg
If Request.Form("submit") <> "" Then
    ' --- ASP LOGIC (UNCHANGED) ---
    sql = "INSERT INTO user_info (user_id, full_name, email_id, user_password, college_name, year_college, contact_no, college_role) VALUES ('" & _
          Replace(Request("user_id"),"'", "''") & "','" & Replace(Request("full_name"),"'", "''") & "','" & Replace(Request("email_id"),"'", "''") & "','" & Replace(Request("user_password"),"'", "''") & "','" & _
          Replace(Request("college_name"),"'", "''") & "','" & Replace(Request("year_college"),"'", "''") & "','" & Replace(Request("contact_no"),"'", "''") & "','" & Replace(Request("college_role"),"'", "''") & "')"
    
    On Error Resume Next ' Basic error handling
    conn.Execute(sql)
    If Err.Number = 0 Then
        msg = "✅ User created successfully!"
    Else
        msg = "⚠️ Error: " & Err.Description ' Provide a more descriptive error
    End If
    On Error GoTo 0
End If
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Create User | Competition Portal</title>
<!-- Include Tailwind CSS -->
<script src="https://cdn.tailwindcss.com"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
    body {
        font-family: 'Inter', sans-serif;
        /* NEW: Added light blue gradient background */
        background: linear-gradient(135deg, #e0f2fe, #c7d2fe);
        color: #1f2937;
        padding: 2rem;
        min-height: 100vh; /* Ensure gradient covers full height */
    }
    /* Style for form/table cards */
    .content-card {
        background-color: #ffffff;
        border: 1px solid #e2e8f0;
        border-radius: 0.75rem; /* 12px */
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
        overflow: hidden; /* To contain header/table styles */
    }
    .card-header {
        padding: 1rem 1.5rem; /* 16px 24px */
        border-bottom: 1px solid #e2e8f0;
        display: flex;
        align-items: center;
        justify-content: space-between; /* NEW */
    }
    .card-header-title-wrap {
        display: flex;
        align-items: center;
        gap: 0.75rem; /* 12px */
    }
    .card-header-icon {
        width: 1.25rem; /* 20px */
        height: 1.25rem;
        color: #3b82f6; /* Blue icon */
    }
    .card-header-title {
        font-size: 1.125rem; /* 18px */
        font-weight: 600;
        color: #111827; /* Darker text for title */
    }
    .card-content {
        padding: 1.5rem; /* 24px */
    }

    .form-input, .form-select {
        background-color: #f3f4f6;
        border: 1px solid #d1d5db;
        color: #1f2937;
        border-radius: 0.5rem;
        transition: border-color 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        width: 100%;
        /* NEW: Add padding for icons */
        padding-left: 2.5rem; 
        padding-top: 0.75rem;
        padding-bottom: 0.75rem;
        padding-right: 1rem;
    }
    .form-input::placeholder { color: #9ca3af; }
    .form-input:focus, .form-select:focus {
        border-color: #3b82f6;
        outline: none;
        box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15);
    }
    select.form-select {
        color: #6b7280;
    }
     select.form-select:valid {
        color: #1f2937;
    }
     select option { color: #1f2937; background-color: #ffffff; }

    .form-button {
        background-color: #2563eb;
        color: #ffffff;
        border-radius: 0.5rem;
        padding: 0.75rem 1.25rem;
        font-weight: 600;
        transition: background-color 0.2s ease-in-out;
    }
    .form-button:hover { background-color: #1d4ed8; }
    
    /* Enhanced table styling */
    .styled-table {
        width: 100%;
        border-collapse: collapse;
    }
    .styled-table thead th {
        background-color: #f9fafb;
        color: #4b5563;
        font-size: 0.75rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        padding: 0.75rem 1.5rem;
        text-align: left;
        border-bottom: 2px solid #e5e7eb;
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
        padding: 1rem 1.5rem;
        color: #374151;
        font-size: 0.875rem;
        vertical-align: middle;
        border-bottom: 1px solid #e5e7eb;
    }
     .styled-table tbody tr:last-child td { border-bottom: none; }

    /* Action Button Styles */
    .action-button {
        padding: 0.25rem 0.5rem; /* 4px 8px */
        border-radius: 0.375rem; /* 6px */
        font-size: 0.75rem; /* 12px */
        font-weight: 500;
        transition: background-color 0.2s ease-in-out;
    }
    .edit-button { background-color: #eff6ff; color: #2563eb; }
    .edit-button:hover { background-color: #dbeafe; }
    .delete-button { background-color: #fee2e2; color: #dc2626; }
    .delete-button:hover { background-color: #fecaca; }

    /* Message Styling */
    .msg-success { color: #16a34a; font-weight: 500; margin-bottom: 1.5rem; padding: 0.75rem 1rem; background-color: #dcfce7; border: 1px solid #bbf7d0; border-radius: 0.5rem;}
    .msg-error { color: #dc2626; font-weight: 500; margin-bottom: 1.5rem; padding: 0.75rem 1rem; background-color: #fee2e2; border: 1px solid #fecaca; border-radius: 0.5rem;}
    
    /* NEW: Style radio buttons */
    .radio-label-box div {
         border: 2px solid #e5e7eb;
         color: #6b7280;
         padding: 0.75rem 1rem;
         border-radius: 0.5rem;
         transition: all 0.2s ease-in-out;
    }
    .radio-label-box input:checked + div {
         background-color: #eff6ff; /* Light blue bg */
         border-color: #2563eb; /* Blue border */
         color: #1d4ed8; /* Dark blue text */
         font-weight: 600;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(15px); }
        to { opacity: 1; transform: translateY(0); }
    }
    .animate-fadeIn{ animation: fadeIn 0.5s ease-out forwards; }
</style>
</head>

<body>
<div class="max-w-7xl mx-auto"> <!-- Widest container -->
    <div class="flex justify-between items-center mb-8">
        <h3 class="text-3xl font-bold text-gray-800">User Management</h3>
        <!-- NEW "Add User" Button -->
        <button id="add-user-btn" class="form-button flex items-center gap-2 cursor-pointer">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd" /></svg>
            Add New User
        </button>
    </div>
    
    <% If msg <> "" Then %>
        <div class="<%= IIf(InStr(msg, "Error") > 0, "msg-error", "msg-success") %> text-center animate-fadeIn max-w-lg mx-auto">
            <%= msg %>
        </div>
    <% End If %>

    <!-- Card: Existing Users Table (Now full width) -->
    <div class="content-card">
        <div class="card-header">
             <div class="card-header-title-wrap">
                 <svg xmlns="http://www.w3.org/2000/svg" class="card-header-icon" viewBox="0 0 20 20" fill="currentColor"><path d="M9 6a3 3 0 11-6 0 3 3 0 016 0zM17 6a3 3 0 11-6 0 3 3 0 016 0zM12.93 17c.046-.327.07-.66.07-1a6.97 6.97 0 00-1.5-4.33A5 5 0 0110 13c-1.89 0-3.54.9-4.57 2.25A6.968 6.968 0 008 16c0 .34.024.673.07 1h4.86zM6.03 15.09A5.024 5.024 0 014 13c0-1.89.9-3.54 2.25-4.57A6.968 6.968 0 004 16c0 .34.024.673.07 1h1.96zM17.75 12.43A5 5 0 0116 13c-1.89 0-3.54.9-4.57 2.25A6.968 6.968 0 0012 16c0 .34.024.673.07 1h1.96c.046-.327.07-.66.07-1a6.97 6.97 0 00-1.5-4.33z" /></svg>
                <h4 class="card-header-title">Existing Users</h4>
             </div>
             <!-- Optional: Add a Search Bar here -->
             <div class="relative w-1/3">
                 <input type="text" class="form-input !py-2 !pl-8" placeholder="Search users...">
                 <span class="absolute left-2.5 top-2.5 text-gray-400">
                     <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd" /></svg>
                 </span>
             </div>
        </div>
        <div class="overflow-x-auto">
            <table class="styled-table min-w-full">
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Name</th>
                        <th>Role</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-100">
                <%
                Set rs = conn.Execute("SELECT user_id, full_name, college_role FROM user_info ORDER BY full_name")
                If rs.EOF Then
                    Response.Write "<tr><td colspan='4' class='text-center text-gray-500 py-6'>No users found.</td></tr>"
                Else
                    Do While Not rs.EOF
                        Response.Write "<tr>"
                        Response.Write "<td class='font-medium text-gray-900'>" & rs("user_id") & "</td>"
                        Response.Write "<td>" & Server.HTMLEncode(rs("full_name")) & "</td>"
                        Response.Write "<td class='text-sm text-gray-500'>" & Server.HTMLEncode(rs("college_role")) & "</td>"
                        ' Add placeholder Action buttons
                        Response.Write "<td class='text-center space-x-2'>"
                        Response.Write "<a href='#' class='action-button edit-button'>Edit</a>"
                        Response.Write "<a href='#' class='action-button delete-button'>Delete</a>"
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

<!-- NEW: Add User Modal -->
<div id="add-user-modal" class="fixed inset-0 bg-gray-900 bg-opacity-50 backdrop-blur-sm flex items-center justify-center p-4 z-50 hidden animate-fadeIn">
    <!-- Modal Content -->
    <div class="bg-white w-full max-w-2xl rounded-xl shadow-lg m-auto">
        <!-- Modal Header -->
        <div class="card-header">
            <div class="card-header-title-wrap">
                <svg xmlns="http://www.w3.org/2000/svg" class="card-header-icon" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd" />
                </svg>
                <h4 class="card-header-title">Add New User</h4>
            </div>
            <button id="close-modal-btn" class="text-gray-400 hover:text-gray-600">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" /></svg>
            </button>
        </div>
        <!-- Modal Body with Form -->
        <form method="post" class="card-content" action="user.asp">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-x-6 gap-y-4">
                <div class->
                    <label for="user_id_modal" class="block text-sm font-medium text-gray-700 mb-1">User ID:</label>
                    <div class="relative">
                        <span class="absolute left-3 top-2.5 text-gray-400">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd" /></svg>
                        </span>
                        <input type="text" name="user_id" id="user_id_modal" class="form-input" required>
                    </div>
                </div>
                <div class->
                    <label for="full_name_modal" class="block text-sm font-medium text-gray-700 mb-1">Full Name:</label>
                     <div class="relative">
                        <span class="absolute left-3 top-2.5 text-gray-400">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-6-3a2 2 0 11-4 0 2 2 0 014 0zm-2 4a5 5 0 00-4.546 2.916A5.986 5.986 0 0010 16a5.986 5.986 0 004.546-2.084A5 5 0 0010 11z" clip-rule="evenodd" /></svg>
                        </span>
                        <input type="text" name="full_name" id="full_name_modal" class="form-input" required>
                    </div>
                </div>
                <div class->
                    <label for="email_id_modal" class="block text-sm font-medium text-gray-700 mb-1">Email ID:</label>
                     <div class="relative">
                        <span class="absolute left-3 top-2.5 text-gray-400">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path d="M2.003 5.884L10 10.884l7.997-5H2.003zM18 7.116l-8 5-8-5V14a2 2 0 002 2h12a2 2 0 002-2V7.116z" /></svg>
                        </span>
                        <input type="text" name="email_id" id="email_id_modal" class="form-input" required>
                    </div>
                </div>
                <div class->
                    <label for="user_password_modal" class="block text-sm font-medium text-gray-700 mb-1">Password:</label>
                    <div class="relative">
                        <span class="absolute left-3 top-2.5 text-gray-400">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd" /></svg>
                        </span>
                        <input type="password" name="user_password" id="user_password_modal" class="form-input" required>
                    </div>
                </div>
                <div class->
                    <label for="college_name_modal" class="block text-sm font-medium text-gray-700 mb-1">College Name:</label>
                     <div class="relative">
                        <span class="absolute left-3 top-2.5 text-gray-400">
                           <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z" /></svg>
                        </span>
                        <input type="text" name="college_name" id="college_name_modal" class="form-input">
                    </div>
                </div>
                <div class->
                    <label for="year_college_modal" class="block text-sm font-medium text-gray-700 mb-1">Year of College:</label>
                    <div class="relative">
                        <span class="absolute left-3 top-2.5 text-gray-400">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd" /></svg>
                        </span>
                        <input type="text" name="year_college" id="year_college_modal" class="form-input">
                    </div>
                </div>
                <div class="relative">
                    <label for="contact_no_modal" class="block text-sm font-medium text-gray-700 mb-1">Contact No:</label>
                    <span class="absolute left-3 top-2.5 text-gray-400">
                       <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path d="M2 3a1 1 0 011-1h2.153a1 1 0 01.986.836l.74 4.435a1 1 0 01-.54 1.06l-1.548.773a11.037 11.037 0 006.105 6.105l.774-1.548a1 1 0 011.059-.54l4.435.74a1 1 0 01.836.986V17a1 1 0 01-1 1h-2C7.82 18 2 12.18 2 5V3z" /></svg>
                    </span>
                    <input type="text" name="contact_no" id="contact_no_modal" class="form-input">
                </div>
                <div class="relative">
                    <label for="college_role_modal" class="block text-sm font-medium text-gray-700 mb-1">Role:</label>
                    <span class="absolute left-3 top-2.5 text-gray-400">
                       <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M10 2a1 1 0 00-1 1v1a1 1 0 002 0V3a1 1 0 00-1-1zM4 4a1 1 0 000 2v1h1V6a1 1 0 10-2 0v1a1 1 0 001 1h1v1H4a1 1 0 100 2h1v1H4a1 1 0 100 2h1v1H4a1 1 0 100 2h1v1a1 1 0 102 0v-1h1a1 1 0 100-2H7v-1h1a1 1 0 100-2H7v-1h1a1 1 0 100-2H7V6h1a1 1 0 100-2H4zm10 0a1 1 0 000 2v1h1V6a1 1 0 10-2 0v1a1 1 0 001 1h1v1h-1a1 1 0 100 2h1v1h-1a1 1 0 100 2h1v1h-1a1 1 0 100 2h1v1a1 1 0 102 0v-1h1a1 1 0 100-2h-1v-1h1a1 1 0 100-2h-1v-1h1a1 1 0 100-2h-1V6h1a1 1 0 100-2h-3z" clip-rule="evenodd" /></svg>
                    </span>
                    <select name="college_role" id="college_role_modal" class="form-select mt-1">
                        <option value="host">Host</option>
                        <option value="student" selected>Student</option>
                    </select>
                </div>
            </div>
            <div class="pt-6 text-right border-t border-gray-200 mt-6">
                <button type="button" id="cancel-btn" class="bg-white py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                    Cancel
                </button>
                <input type="submit" name="submit" value="Create User" class="form-button cursor-pointer inline-block w-auto ml-3">
            </div>
        </form>
    </div>
</div>


<script>
    const links = document.querySelectorAll('.sidebar nav a');
    links.forEach(link => {
        link.addEventListener('click', (event) => {
            links.forEach(l => l.classList.remove('active'));
            link.classList.add('active');
        });
    });

    // --- NEW Modal JavaScript ---
    const addUserModal = document.getElementById('add-user-modal');
    const addUserBtn = document.getElementById('add-user-btn');
    const closeModalBtn = document.getElementById('close-modal-btn');
    const cancelBtn = document.getElementById('cancel-btn');

    function openModal() {
        addUserModal.classList.remove('hidden');
    }
    function closeModal() {
        addUserModal.classList.add('hidden');
    }

    addUserBtn.addEventListener('click', openModal);
    closeModalBtn.addEventListener('click', closeModal);
    cancelBtn.addEventListener('click', closeModal);

    // Optional: Close modal when clicking outside the box
    addUserModal.addEventListener('click', (e) => {
        if (e.target === addUserModal) {
            closeModal();
        }
    });

</script>

</body>
</html>

i want that you change the colour theme of this code only 
and make it look more good 
just dont make a changes in working of this code 
and change the select option of role in boxes like we did on another page

