<!-- #include file="databaseconn.asp" -->
<%
Dim msg
If Request.Form("submit") <> "" Then
    Dim user, pass, sql, rs
    user = Trim(Request.Form("user"))
    pass = Trim(Request.Form("password"))

    sql = "SELECT * FROM user_info WHERE user_id='" & user & "' AND user_password='" & pass & "'"
    Set rs = conn.Execute(sql)

    If Not rs.EOF Then
        Session("user_id") = rs("user_id")
        Session("college_role") = rs("college_role")

        If LCase(rs("college_role")) = "host" Then
            Response.Redirect "home.asp"
        Else
            Response.Redirect "user_dashboard.asp"
        End If
    Else
        msg = "Invalid User ID or Password!"
    End If
End If
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Competition Portal</title>
    <!-- Include Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Optional: Include a modern font like Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif; /* Use Inter font if loaded */
        }
        /* Animation keyframes */
        @keyframes fadeInSlideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-fadeInSlideUp {
            animation: fadeInSlideUp 0.7s ease-out forwards;
        }

        /* Styles for 3D Flip Animation */
        .flipper-container {
            perspective: 1000px; /* Needed for 3D effect */
            /* Ensure the container keeps its space */
            min-height: 500px; /* Adjust as needed based on content height */
        }
        .flipper {
            transition: transform 0.6s;
            transform-style: preserve-3d;
            position: relative;
            width: 100%;
            height: 100%;
        }
        .front, .back {
            backface-visibility: hidden;
            -webkit-backface-visibility: hidden; /* Safari */
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            /* Removed fixed height, will rely on content */
        }
        .back {
            transform: rotateY(180deg);
        }
        .flipped .flipper {
            transform: rotateY(180deg);
        }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-100 to-indigo-200 flex items-center justify-center min-h-screen p-4">

    <!-- Apply animation class here, ADD flipper-container -->
    <div id="login-card-container" class="w-full max-w-md animate-fadeInSlideUp flipper-container">
        <!-- ADD flipper div -->
        <div class="flipper">
            <!-- Front Face (Participant Login) -->
            <div class="front">
                <div class="bg-white w-full p-8 rounded-xl shadow-lg">
                    <div class="text-center mb-8">
                        <!-- Simple Logo Placeholder -->
                        <div class="inline-block p-3 bg-blue-100 text-blue-600 rounded-full mb-4">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1" />
                            </svg>
                        </div>
                        <h2 id="form-title-front" class="text-3xl font-bold text-gray-800">Participant Login</h2>
                        <p class="text-gray-500 mt-1 text-sm">Welcome to the Competition Portal</p>
                    </div>

                    <!-- ASP Form with Tailwind Styling -->
                    <form method="post" class="space-y-6">
                        <div>
                            <label for="user" class="block text-sm font-medium text-gray-700 mb-1">User ID</label>
                            <input type="text" name="user" id="user" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" placeholder="Enter your user ID" required>
                        </div>
                        <div>
                            <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                            <input type="password" name="password" id="password" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" placeholder="Enter your password" required>
                        </div>
                        <input type="submit" name="submit" value="Login" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-4 rounded-lg cursor-pointer transition duration-300">
                    </form>

                    <!-- ASP Error Message - Styled with Tailwind -->
                    <% If msg <> "" Then %>
                        <div class="mt-4 text-center text-red-600 font-medium text-sm"><%=msg%></div>
                    <% End If %>

                    <!-- Toggle and Footer Links -->
                    <div class="mt-6 flex justify-between items-center text-sm">
                         <a href="#" class="text-gray-500 hover:underline">Forgot Password?</a>
                         <a href="#" id="role-toggle-front" class="font-semibold text-blue-600 hover:text-blue-700 hover:underline">Login as Host</a>
                    </div>
                    <div class="mt-8 text-center text-sm text-gray-600">
                        Don’t have an account? <a href="registration.asp" class="font-semibold text-blue-600 hover:text-blue-700 hover:underline">Register here</a>
                    </div>
                </div>
            </div>

            <!-- Back Face (Host Login) - Structure is identical, just title and toggle text change -->
             <div class="back">
                <div class="bg-white w-full p-8 rounded-xl shadow-lg">
                    <div class="text-center mb-8">
                        <div class="inline-block p-3 bg-blue-100 text-blue-600 rounded-full mb-4">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1" />
                            </svg>
                        </div>
                        <h2 id="form-title-back" class="text-3xl font-bold text-gray-800">Host Login</h2>
                        <p class="text-gray-500 mt-1 text-sm">Welcome to the Competition Portal</p>
                    </div>

                    <!-- ASP Form (Identical structure, names are the same so backend logic doesn't change) -->
                    <form method="post" class="space-y-6">
                        <div>
                            <label for="user-back" class="block text-sm font-medium text-gray-700 mb-1">User ID</label>
                            <input type="text" name="user" id="user-back" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" placeholder="Enter your Host ID" required>
                        </div>
                        <div>
                            <label for="password-back" class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                            <input type="password" name="password" id="password-back" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" placeholder="Enter your password" required>
                        </div>
                        <input type="submit" name="submit" value="Login" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-3 px-4 rounded-lg cursor-pointer transition duration-300">
                    </form>

                    <!-- ASP Error Message (Identical) -->
                    <% If msg <> "" Then %>
                        <div class="mt-4 text-center text-red-600 font-medium text-sm"><%=msg%></div>
                    <% End If %>

                    <!-- Toggle and Footer Links -->
                    <div class="mt-6 flex justify-between items-center text-sm">
                         <a href="#" class="text-gray-500 hover:underline">Forgot Password?</a>
                         <a href="#" id="role-toggle-back" class="font-semibold text-blue-600 hover:text-blue-700 hover:underline">Login as Participant</a>
                    </div>
                     <div class="mt-8 text-center text-sm text-gray-600">
                        Don’t have an account? <a href="registration.asp" class="font-semibold text-blue-600 hover:text-blue-700 hover:underline">Register here</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        const loginCardContainer = document.getElementById('login-card-container');
        const roleToggleFront = document.getElementById('role-toggle-front');
        const roleToggleBack = document.getElementById('role-toggle-back');
        const flipper = loginCardContainer.querySelector('.flipper'); // Get the flipper element

        function toggleFlip(e) {
            e.preventDefault();
            loginCardContainer.classList.toggle('flipped');

            // Adjust height after animation starts (optional, refine timing if needed)
            setTimeout(() => {
                 // Calculate height based on which face is currently visible
                 const frontFace = flipper.querySelector('.front > div');
                 const backFace = flipper.querySelector('.back > div');
                 if (loginCardContainer.classList.contains('flipped')) {
                     flipper.style.height = `${backFace.offsetHeight}px`;
                 } else {
                     flipper.style.height = `${frontFace.offsetHeight}px`;
                 }
            }, 50); // Small delay to allow flip to start
        }

        roleToggleFront.addEventListener('click', toggleFlip);
        roleToggleBack.addEventListener('click', toggleFlip);

        // Set initial height
        window.addEventListener('load', () => {
             const frontFace = flipper.querySelector('.front > div');
             flipper.style.height = `${frontFace.offsetHeight}px`;
        });
        // Adjust height on resize
        window.addEventListener('resize', () => {
             const frontFace = flipper.querySelector('.front > div');
             const backFace = flipper.querySelector('.back > div');
             if (loginCardContainer.classList.contains('flipped')) {
                 flipper.style.height = `${backFace.offsetHeight}px`;
             } else {
                 flipper.style.height = `${frontFace.offsetHeight}px`;
             }
        });

    </script>

</body>
</html>

