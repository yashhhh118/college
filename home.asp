
<!-- #include file="databaseconn.asp" -->
<%
' --- SESSION CHECK - REMAINS UNCHANGED ---
If Session("user_id") = "" Or LCase(Session("college_role")) <> "host" Then
    Response.Redirect "login.asp"
End If
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Host Dashboard | Competition Portal</title>
<!-- Include Tailwind CSS -->
<script src="https://cdn.tailwindcss.com"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<!-- Add Heroicons for better icons -->
<script type="module" src="https://cdn.jsdelivr.net/npm/heroicons@2.1.3/24/outline/index.js"></script>
<style>
    body {
        margin: 0;
        font-family: 'Inter', sans-serif;
        background-color: #f1f5f9; /* Light grey background for the page */
        display: flex;
        height: 100vh;
        overflow: hidden; /* Prevent body scroll */
    }

    /* Professional Dark Sidebar */
    .sidebar {
        width: 260px; /* Slightly wider */
        background: #0f172a; /* Darker Slate base */
        color: #cbd5e1; /* Lighter slate text */
        display: flex;
        flex-direction: column;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        flex-shrink: 0;
        border-right: 1px solid #1e293b; /* Slightly lighter border */
    }

    .sidebar-header {
        padding: 20px 24px;
        border-bottom: 1px solid #1e293b;
        display: flex;
        align-items: center;
        gap: 12px; /* Space for logo */
    }
     /* Simple placeholder logo */
    .sidebar-logo {
        width: 32px;
        height: 32px;
        background-color: #3b82f6;
        border-radius: 8px;
        /* Add simple shape or initial */
    }

    .sidebar-header h2 {
        font-size: 18px;
        font-weight: 600;
        color: #ffffff;
    }

    .sidebar nav {
        flex-grow: 1;
        padding: 16px 12px; /* Padding around the nav links */
    }

    .sidebar a {
        color: #94a3b8; /* Muted text color */
        text-decoration: none;
        padding: 10px 16px; /* Adjusted padding */
        margin-bottom: 4px; /* Space between links */
        display: flex;
        align-items: center;
        gap: 12px;
        transition: all 0.2s ease-in-out;
        font-weight: 500;
        font-size: 14px; /* Slightly smaller font */
        border-radius: 6px; /* Slightly less rounded */
    }

    .sidebar a:hover {
        background: #1e293b; /* Hover background */
        color: #ffffff;
    }

    .sidebar a.active {
        background: #3b82f6; /* Blue background for active */
        color: #ffffff;
        font-weight: 600;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    }
     /* Style for icons */
    .sidebar a svg {
        width: 18px; /* Slightly smaller icons */
        height: 18px;
        flex-shrink: 0;
        opacity: 0.7; /* Start slightly less opaque */
        transition: opacity 0.2s ease-in-out;
    }
     .sidebar a:hover svg, .sidebar a.active svg {
        opacity: 1;
     }


    .sidebar .logout {
        margin: 12px; /* Consistent margin */
        padding: 10px 16px;
        background: transparent; /* Make transparent */
        border: 1px solid #ef4444; /* Red border */
        color: #f87171; /* Red text */
        text-align: center;
        border-radius: 6px;
        justify-content: center;
        font-size: 14px;
        transition: all 0.2s ease-in-out;
    }

    .sidebar .logout:hover {
        background: #ef4444; /* Solid red on hover */
        color: #ffffff;
    }
     .sidebar .logout svg {
          opacity: 1;
     }

    .main {
        flex-grow: 1;
        padding: 0;
        overflow-y: hidden;
        /* Add a subtle background */
        background-color: #f1f5f9;
    }

    iframe {
        width: 100%;
        height: 100vh;
        border: none;
        /* Let iframe background be set by the content page */
        background: transparent;
    }
</style>
</head>
<body>

<div class="sidebar">
    <div class="sidebar-header">
        <div class="sidebar-logo"></div> <!-- Added Logo Placeholder -->
        <h2>Host Panel</h2>
    </div>
    <nav>
        <!-- Using Heroicons Outline SVGs -->
        <a href="dashboard_content.asp" target="contentFrame" class="active">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6A2.25 2.25 0 016 3.75h2.25A2.25 2.25 0 0110.5 6v2.25a2.25 2.25 0 01-2.25 2.25H6a2.25 2.25 0 01-2.25-2.25V6zM3.75 15.75A2.25 2.25 0 016 13.5h2.25a2.25 2.25 0 012.25 2.25V18a2.25 2.25 0 01-2.25 2.25H6A2.25 2.25 0 013.75 18v-2.25zM13.5 6a2.25 2.25 0 012.25-2.25H18A2.25 2.25 0 0120.25 6v2.25A2.25 2.25 0 0118 10.5h-2.25a2.25 2.25 0 01-2.25-2.25V6zM13.5 15.75a2.25 2.25 0 012.25-2.25H18a2.25 2.25 0 012.25 2.25V18A2.25 2.25 0 0118 20.25h-2.25A2.25 2.25 0 0113.5 18v-2.25z" /></svg>
            Dashboard
        </a>
        <a href="user.asp" target="contentFrame">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M18 18.72a9.094 9.094 0 003.741-.479 3 3 0 00-4.682-2.72m-7.5-2.962a3.75 3.75 0 015.962 0L14.25 18l-2.962 2.962a3.75 3.75 0 01-5.962 0L5.32 18.72m-1.58-1.58a9.094 9.094 0 01.479-3.741 3 3 0 012.72 4.682l-2.962 2.962a3.75 3.75 0 010-5.962L18 5.32M5.32 5.32l2.962 2.962a3 3 0 01-4.682 2.72 9.094 9.094 0 01-3.741-.479m18.72 1.58a9.094 9.094 0 00-.479-3.741 3 3 0 00-2.72-4.682l2.962-2.962a3.75 3.75 0 000 5.962L5.32 18m1.58 1.58l-2.962-2.962a3 3 0 004.682-2.72 9.094 9.094 0 003.741.479" /></svg>
            User Creation
        </a>
        <a href="category.asp" target="contentFrame">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M3.75 9.776c.112-.017.227-.026.344-.026h15.812c.117 0 .232.009.344.026m-16.5 0a2.25 2.25 0 00-1.883 2.542l.857 6a2.25 2.25 0 002.227 1.932H19.05l.857-6a2.25 2.25 0 00-1.883-2.542m-16.5 0l-.229-.015a2.25 2.25 0 01-2.083-2.226V5.25a2.25 2.25 0 012.25-2.25h15M5.25 9.75l-.229-.015a2.25 2.25 0 00-2.083 2.226V18a2.25 2.25 0 002.25 2.25h13.5A2.25 2.25 0 0019.5 18V12.016a2.25 2.25 0 00-2.083-2.226l-.229.015m-16.5 0H18m-12.75 0h1.5m-1.5 0c0 .69.56 1.25 1.25 1.25H9.75m-4.5-1.25c0-.69-.56-1.25-1.25-1.25H3.75M9.75 9.75h1.5m-1.5 0c0-.69.56-1.25 1.25-1.25H15m-5.25-1.25c0 .69.56 1.25 1.25 1.25h1.5" /></svg>
            Category
        </a>
        <a href="competition.asp" target="contentFrame">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M16.5 18.75h-9m9 0a3 3 0 013 3h-15a3 3 0 013-3m9 0v-4.5m-9 4.5v-4.5m0-6.75h9m-9 0a3 3 0 013-3h3a3 3 0 013 3m-9 0V3.75m9 6.75V3.75m0 0a3 3 0 00-3-3h-3a3 3 0 00-3 3m0 0h9" /></svg>
            Competition
        </a>
    </nav>
    <a href="login.asp" class="logout">
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M15.75 9V5.25A2.25 2.25 0 0013.5 3h-6a2.25 2.25 0 00-2.25 2.25v13.5A2.25 2.25 0 007.5 21h6a2.25 2.25 0 002.25-2.25V15M12 9l-3 3m0 0l3 3m-3-3h12.75" /></svg>
        Logout
    </a>
</div>

<div class="main">
    <iframe name="contentFrame" src="dashboard_content.asp"></iframe>
</div>

<script>
    const links = document.querySelectorAll('.sidebar nav a'); // Select only nav links
    links.forEach(link => {
        link.addEventListener('click', (event) => {
            links.forEach(l => l.classList.remove('active'));
            link.classList.add('active');
        });
    });
</script>

</body>
</html>

