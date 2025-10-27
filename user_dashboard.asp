<!-- #include file="databaseconn.asp" -->
<%
If Session("user_id") = "" Then
    Response.Redirect "login.asp"
End If

Dim userId, userRole
userId = Session("user_id")
userRole = Session("college_role")
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <!-- Include Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            /* Light blue gradient background like login page */
            background: linear-gradient(135deg, #f0f4ff, #e0f2fe);
            color: #1f2937;
            min-height: 100vh;
            padding: 0;
            margin: 0;
        }

        .dashboard-main {
            padding: 2rem 1.5rem;
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }

        /* Enhanced Welcome Banner */
        .welcome-banner {
            background-color: #ffffff;
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 2.5rem;
            border: 1px solid #e5e7eb;
        }

        .welcome-text {
            color: #2563eb; /* Blue accent */
            font-size: 2.25rem; /* 36px */
            font-weight: 800;
        }

        /* Action Cards */
        .action-card {
            background: #ffffff;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-decoration: none;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            border: 1px solid #e5e7eb;
        }
        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(59, 130, 246, 0.2);
        }
        
        .card-icon-bg {
            padding: 1rem;
            border-radius: 50%;
            margin-bottom: 1rem;
            width: 56px;
            height: 56px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .card-title {
            font-size: 1.125rem; /* 18px */
            font-weight: 600;
            color: #1f2937;
        }

        /* Specific Card Styles */
        .card-register { background-color: #dbeafe; color: #1e40af; } /* Blue light */
        .card-track { background-color: #d1fae5; color: #065f46; } /* Green light */
        .card-certs { background-color: #fef3c7; color: #b45309; } /* Amber light */

        /* Logout Button Style */
        .logout-btn {
            background-color: #dc2626; /* Red */
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            font-weight: 600;
            transition: background-color 0.3s ease;
            text-decoration: none;
            display: flex; /* Added flex for alignment */
            align-items: center;
            gap: 8px;
        }
        .logout-btn:hover {
            background-color: #b91c1c;
        }
    </style>
</head>
<body>

<div class="dashboard-main">
    
    <!-- TOP HEADER / WELCOME BANNER -->
    <div class="welcome-banner">
        <div class="flex justify-between items-start mb-4">
            <div>
                <p class="text-sm font-medium text-gray-500">Welcome back,</p>
                <h2 class="welcome-text">Hello, <%= userId %>!</h2>
            </div>
            <!-- Logout Button - Moved from top header -->
            <a href="login.asp" class="logout-btn">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" /></svg>
                Logout
            </a>
        </div>
        <p class="text-gray-600">Your role: <strong class="text-gray-700 uppercase"><%= userRole %></strong></p>
    </div>

    <h3 class="text-2xl font-bold mb-6 text-gray-800">Quick Actions</h3>

    <!-- Action Card Grid -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        
        <!-- 1. Register for Events -->
        <a href="register_event.asp" class="action-card">
            <div class="card-icon-bg card-register">
                 <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M9 14l6 -6" /><path d="M12 5v14" /><path d="M5 12h14" /></svg>
            </div>
            <div class="card-title">Register for New Events</div>
            <p class="text-sm text-gray-500 mt-1">Discover and sign up for upcoming competitions.</p>
        </a>
        
        <!-- 2. Track My Events -->
        <a href="my_registrations.asp" class="action-card">
            <div class="card-icon-bg card-track">
                 <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M3 12h1m8 -9v1m8 8h1m-15.4 -6.4l.7 .7m12.1 -.7l-.7 .7" /><path d="M12 12a4 4 0 1 0 0 8a4 4 0 0 0 0 -8" /><path d="M12 17v-4" /></svg>
            </div>
            <div class="card-title">Track My Events</div>
            <p class="text-sm text-gray-500 mt-1">View registration status and deadlines.</p>
        </a>
        
        <!-- 3. View Certificates -->
        <a href="#" class="action-card">
            <div class="card-icon-bg card-certs">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M15 7l-4 4v3.5m0 0V21a2 2 0 01-2 2H5a2 2 0 01-2-2V4a2 2 0 012-2h8a2 2 0 012 2v3m0 0l-4-4" /></svg>
            </div>
            <div class="card-title">View My Certificates</div>
            <p class="text-sm text-gray-500 mt-1">Download certificates from past events.</p>
        </a>

    </div>
</div>

</body>
</html>
