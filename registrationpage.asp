<!-- #include file="databaseconn.asp" -->
<%
Dim regMsg, regMsgType ' Variables for registration feedback
If Request.Form("register") <> "" Then
    ' --- ASP Logic to handle registration ---
    ' 1. Get all form data (user_id, password, full_name, email, role, etc.)
    Dim userId, pass, fullName, email, role, college, year, contact
    userId = Trim(Request.Form("user_id"))
    pass = Trim(Request.Form("password")) ' Should be hashed before saving!
    fullName = Trim(Request.Form("full_name"))
    email = Trim(Request.Form("email"))
    role = Trim(Request.Form("role")) ' 'Participant' or 'Host'
    college = Trim(Request.Form("college_name"))
    year = Trim(Request.Form("year_of_study"))
    contact = Trim(Request.Form("contact_number"))

    ' 2. Check if user_id or email already exists in database (prevent duplicates)
    Dim checkSql, rsCheck
    checkSql = "SELECT user_id FROM user_info WHERE user_id='" & userId & "' OR email='" & email & "'"
    Set rsCheck = conn.Execute(checkSql)

    If rsCheck.EOF Then
        ' 3. If not duplicate, INSERT the new user into the user_info table
        Dim insertSql
        insertSql = "INSERT INTO user_info (user_id, user_password, full_name, email, college_role, college_name, year_of_study, contact_number) VALUES ('" & userId & "', '" & pass & "', '" & fullName & "', '" & email & "', '" & role & "', '" & college & "', '" & year & "', '" & contact & "')"
        
        On Error Resume Next ' Basic error handling
        conn.Execute insertSql
        
        If Err.Number = 0 Then
             regMsg = "Registration successful! You can now log in."
             regMsgType = "success" ' For styling the message
        Else
             regMsg = "An error occurred during registration. Please try again. Error: " & Err.Description
             regMsgType = "error"
        End If
        On Error GoTo 0 ' Turn off error resuming

    Else
        ' 4. If duplicate, show an error message
        regMsg = "User ID or Email already exists. Please choose another or log in."
        regMsgType = "error"
    End If
    
    Set rsCheck = Nothing
End If
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | Competition Portal</title>
    <!-- Include Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Optional: Include a modern font like Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
        /* Animation keyframes */
        @keyframes fadeInSlideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-fadeInSlideUp {
            animation: fadeInSlideUp 0.7s ease-out forwards;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-100 to-indigo-200 flex items-center justify-center min-h-screen p-4">

    <div class="bg-white w-full max-w-lg p-8 rounded-xl shadow-lg animate-fadeInSlideUp">
        <div class="text-center mb-8">
            <h2 class="text-3xl font-bold text-gray-800">Create Your Account</h2>
            <p class="text-gray-500 mt-1 text-sm">Join the Competition Portal</p>
        </div>

        <!-- Registration Form -->
        <form method="post" class="space-y-4">
            <div>
                <label for="full_name" class="block text-sm font-medium text-gray-700 mb-1">Full Name</label>
                <input type="text" name="full_name" id="full_name" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" placeholder="Enter your full name" required>
            </div>

             <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                 <div>
                    <label for="user_id" class="block text-sm font-medium text-gray-700 mb-1">User ID</label>
                    <input type="text" name="user_id" id="user_id" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" placeholder="Choose a User ID" required>
                 </div>
                  <div>
                    <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
                    <input type="email" name="email" id="email" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" placeholder="Enter your email" required>
                 </div>
            </div>

            <div>
                <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                <input type="password" name="password" id="password" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" placeholder="Create a password" required>
            </div>
             
             <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Register as</label>
                <div class="flex gap-4">
                     <label class="flex items-center space-x-2">
                        <input type="radio" name="role" value="Participant" class="form-radio text-blue-600" checked>
                        <span>Participant</span>
                    </label>
                     <label class="flex items-center space-x-2">
                        <input type="radio" name="role" value="Host" class="form-radio text-blue-600">
                        <span>Host</span>
                    </label>
                </div>
            </div>

            <hr class="my-4">

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label for="college_name" class="block text-sm font-medium text-gray-700 mb-1">College Name</label>
                    <input type="text" name="college_name" id="college_name" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" placeholder="Your college name">
                </div>
                 <div>
                    <label for="year_of_study" class="block text-sm font-medium text-gray-700 mb-1">Year of Study</label>
                    <select name="year_of_study" id="year_of_study" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent bg-white text-gray-500">
                         <option value="">Select Year</option>
                         <option>First Year</option>
                         <option>Second Year</option>
                         <option>Third Year</option>
                         <option>Final Year</option>
                         <option>Faculty/Staff</option>
                         <option>Other</option>
                    </select>
                </div>
            </div>
             <div>
                <label for="contact_number" class="block text-sm font-medium text-gray-700 mb-1">Contact Number</label>
                <input type="tel" name="contact_number" id="contact_number" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" placeholder="Your phone number">
            </div>


            <input type="submit" name="register" value="Register" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-4 rounded-lg cursor-pointer transition duration-300 mt-6">
        </form>

        <!-- Display Registration Message -->
        <% If regMsg <> "" Then %>
            <div class="mt-4 text-center font-medium text-sm <%= IIf(regMsgType = "success", "text-green-600", "text-red-600") %>">
                <%= regMsg %>
            </div>
        <% End If %>

        <div class="mt-8 text-center text-sm text-gray-600">
            Already have an account? <a href="login.asp" class="font-semibold text-blue-600 hover:text-blue-700 hover:underline">Login here</a>
        </div>
    </div>

</body>
</html>
```

### 2. Adding Navigation Bars

Adding a navigation bar to *every* page (including login and registration) isn't standard practice, as those pages usually have a focused purpose. Typically, the navigation bar appears *after* the user logs in, on pages like the dashboard.

However, if you want it, the best way to add a navigation bar consistently in ASP is to:
1.  **Create a separate file** (e.g., `navbar.asp`) that contains *only* the HTML and CSS for your navigation bar.
2.  **Use an include directive** at the top of each page where you want the navbar to appear:
    ```asp
    <!-- #include file="navbar.asp" --> 
    
