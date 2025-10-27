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
        /* Light blue gradient background like login page */
        background: linear-gradient(135deg, #e0f2fe, #c7d2fe); /* Tailwind: from-blue-100 to-indigo-200 */
        display: flex;
        height: 100vh;
        overflow: hidden; /* Prevent body scroll */
        color: #1f2937; /* Default dark text */
    }

    /* Sidebar with Login Page Theme */
    .sidebar {
        width: 250px; /* Adjusted width */
        background: #2563eb; /* Blue like login button */
        color: #ffffff; /* White text */
        display: flex;
        flex-direction: column;
        box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        flex-shrink: 0;
        /* Removed border-right, relying on shadow */
    }

    .sidebar-header {
        padding: 24px 20px;
        text-align: center;
        border-bottom: 1px solid rgba(255, 255, 255, 0.2); /* White transparent border */
    }
     .sidebar-logo {
        width: 32px;
        height: 32px;
        background-color: #ffffff; /* White logo bg */
        border-radius: 8px;
        margin: 0 auto 12px; /* Center logo */
         display: flex;
         align-items: center;
         justify-content: center;
         color: #2563eb; /* Blue icon */
    }
    .sidebar-header h2 {
        font-size: 18px;
        font-weight: 600;
        color: #ffffff;
    }

    .sidebar nav {
        flex-grow: 1;
        padding: 16px 12px;
    }

    .sidebar a {
        color: #dbeafe; /* Lighter blue text */
        text-decoration: none;
        padding: 10px 16px;
        margin-bottom: 4px;
        display: flex;
        align-items: center;
        gap: 12px;
        transition: all 0.2s ease-in-out;
        font-weight: 500;
        font-size: 14px;
        border-radius: 6px;
    }

    .sidebar a:hover {
        background: rgba(255, 255, 255, 0.1); /* Slight white hover */
        color: #ffffff;
    }

    .sidebar a.active {
        background: #ffffff; /* White background for active */
        color: #1d4ed8; /* Darker blue text for active */
        font-weight: 600;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
    }
    .sidebar a svg {
        width: 18px;
        height: 18px;
        flex-shrink: 0;
        opacity: 0.8;
        transition: opacity 0.2s ease-in-out;
    }
     .sidebar a:hover svg {
        opacity: 1;
        color: #ffffff; /* Ensure icon is white on hover */
     }
      .sidebar a.active svg {
        opacity: 1;
        color: #1d4ed8; /* Darker blue icon for active */
     }

    .sidebar .logout {
        margin: 12px;
        padding: 10px 16px;
        background: transparent;
        border: 1px solid rgba(255, 255, 255, 0.3); /* White transparent border */
        color: #dbeafe; /* Light blue text */
        text-align: center;
        border-radius: 6px;
        justify-content: center;
        font-size: 14px;
        transition: all 0.2s ease-in-out;
        display: flex; /* Ensure flex for alignment */
        align-items: center; /* Align icon vertically */
        gap: 12px; /* Space between icon and text */
    }

    .sidebar .logout:hover {
        background: rgba(255, 255, 255, 0.1);
        color: #ffffff;
    }
     .sidebar .logout svg {
          opacity: 1;
     }

    .main {
        flex-grow: 1;
        padding: 0;
        overflow-y: hidden;
        background-color: #f8fafc; /* Keep content area light */
    }

    iframe {
        width: 100%;
        height: 100vh;
        border: none;
        background: transparent; /* Let body show through */
    }
</style>
</head>
<body>

<div class="sidebar">
    <div class="sidebar-header">
        <div class="sidebar-logo"> <!-- Added simple icon -->
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M3 6a3 3 0 013-3h10a1 1 0 01.8 1.6L14.25 8l2.55 3.4A1 1 0 0116 13H6a3 3 0 01-3-3V6zm3-1a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd" /></svg>
        </div>
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
    <a href="logout.asp" class="logout"> <!-- Ensure logout link points to correct file if different -->
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

