<!-- #include file="databaseconn.asp" -->
<%
' --- ASP CODE (UNCHANGED) ---
Dim msg, sql, rs, userSerial, competitionId

' 1. Check if user is logged in
If Session("user_id") = "" Then
    Response.Redirect "login.asp"
End If

' 2. Get logged-in user’s Serial_no (from user_info)
Dim rsUser
Set rsUser = conn.Execute("SELECT Serial_no FROM user_info WHERE user_id = '" & Replace(Session("user_id"),"'", "''") & "'")
If Not rsUser.EOF Then
    userSerial = rsUser("Serial_no")
End If
rsUser.Close
Set rsUser = Nothing

' 3. Handle registration
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

' 4. Fetch all competitions - *** UPDATED to include poster and category ***
Set rs = conn.Execute("SELECT comp_id, comp_title, comp_event_datetime, comp_reg_deadline, comp_description, comp_poster_image, comp_category FROM competition ORDER BY comp_reg_deadline ASC")
' --- END OF ASP CODE ---
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register for Events</title>
    <!-- Include Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            /* Light blue gradient background like login page */
            background: linear-gradient(135deg, #e0f2fe, #c7d2fe);
            color: #1f2937; /* Dark text */
            overflow: hidden; /* Hide main scrollbar */
        }
        
        /* Main container for scrolling */
        .scroll-container {
            scroll-snap-type: y mandatory;
            overflow-y: scroll;
            height: 100vh;
        }
        .event-section {
            height: 100vh;
            scroll-snap-align: start; /* Snap to the start of each section */
            display: flex;
            flex-direction: column; /* Mobile-first */
        }
        /* Desktop layout */
        @media (min-width: 768px) {
            .event-section {
                flex-direction: row; /* Side-by-side */
            }
        }

        /* Register Button Style - Changed to match theme */
        .register-btn {
            text-decoration: none;
            background-color: #2563eb; /* Blue */
            color: white;
            padding: 0.75rem 2rem; /* 12px 32px */
            border-radius: 9999px; /* Full */
            font-weight: 700;
            transition: all 0.3s ease;
            display: inline-block;
            text-align: center;
            box-shadow: 0 4px 10px rgba(59, 130, 246, 0.3);
        }
        .register-btn:hover {
            background-color: #1d4ed8; /* Darker blue */
            transform: scale(1.05);
        }
        
        /* Message Styling */
        .msg-toast {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 100;
            padding: 1rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: 500;
            animation: fadeIn 0.5s ease-out forwards;
        }
        .msg-success { color: #155724; background-color: #d4edda; border: 1px solid #c3e6cb; }
        .msg-error { color: #721c24; background-color: #f8d7da; border: 1px solid #f5c6cb; }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <!-- Main Scrolling Container -->
    <div class="scroll-container">

        <!-- Display Message (if any) - Now a "Toast" notification -->
        <% If msg <> "" Then %>
            <div class="<%= IIf(InStr(msg, "⚠️") > 0, "msg-error", "msg-success") %> msg-toast">
                <%= msg %>
            </div>
        <% End If %>

        <%
        If Not rs.EOF Then
            Do Until rs.EOF
                Dim posterUrl
                ' --- Check for poster and set a placeholder if missing ---
                If IsNull(rs("comp_poster_image")) OR rs("comp_poster_image") = "" Then
                    posterUrl = "https://placehold.co/800x1200/e0f2fe/1d4ed8?text=" & Server.URLEncode(rs("comp_title"))
                Else
                    posterUrl = rs("comp_poster_image")
                End If
        %>
            <!-- Event Section (Dynamically Generated) -->
            <section class="event-section">
                <!-- Left Panel (Poster) - **** GLITCH FIXED HERE **** -->
                <div class="w-full md:w-2/5 h-1/3 md:h-full bg-gray-200 flex items-center justify-center p-8 bg-cover bg-center" style="background-image: url('<%= posterUrl %>');">
                    <!-- Title is now on the poster side -->
                    <h2 class="text-5xl font-extrabold text-white text-center drop-shadow-lg z-10"><%= rs("comp_title") %></h2>
                </div>
                <!-- Right Panel (Details) -->
                <div class="w-full md:w-3/5 h-2/3 md:h-full bg-white text-gray-800 p-8 lg:p-16 flex flex-col justify-center">
                    <span class="text-sm font-semibold text-blue-700 bg-blue-100 px-3 py-1 rounded-full self-start"><%= rs("comp_category") %></span>
                    
                    <h2 class="text-4xl lg:text-5xl font-bold text-gray-900 mt-4"><%= rs("comp_title") %></h2>
                    
                    <p class="text-gray-600 mt-4 max-w-lg text-lg">
                        <%= rs("comp_description") %>
                    </p>

                    <div class="mt-8 space-y-4 text-gray-700">
                        <div class="flex items-center gap-4">
                            <svg class="w-6 h-6 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                            <span><span class="font-semibold">Event Date:</span> <%= FormatDateTime(rs("comp_event_datetime"), 2) %></span>
                        </div>
                        <div class="flex items-center gap-4">
                            <svg class="w-6 h-6 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                            <span><span class="font-semibold">Registration Deadline:</span> <%= FormatDateTime(rs("comp_reg_deadline"), 2) %></span>
                        </div>
                    </div>
                    
                    <div class="mt-10">
                         <!-- This link reloads the page with the register_id, triggering the ASP code at the top -->
                         <a class="register-btn" <a href="registration.asp" class="font-semibold text-blue-600 hover:text-blue-700 hover:underline">Register Now</a>
                    </div>
                </div>
            </section>
        <%
                rs.MoveNext
            Loop
        Else
        %>
            <!-- No Events Section -->
            <section class="event-section flex items-center justify-center">
                 <div class="text-center text-gray-500 p-10 bg-white rounded-lg shadow-sm">
                    <h2 class="text-3xl font-bold">No competitions available.</h2>
                    <p class="mt-2">Please check back later!</p>
                     <div class="mt-8">
                         <a href="user_dashboard.asp" class="font-semibold text-blue-600 hover:text-blue-700 hover:underline">⬅ Back to Dashboard</a>
                     </div>
                </div>
            </section>
        <%
        End If
        rs.Close
        Set rs = Nothing
        %>
    </div> <!-- End Scroll Container -->

</body>
</html>

