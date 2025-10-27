<!-- #include file="databaseconn.asp" -->
<%
' --- ASP code to fetch dashboard stats ---
Dim rs1, rs2, rs3, total_users, total_reg, total_comp
Set rs1 = conn.Execute("SELECT COUNT(*) AS total_users FROM user_info")
total_users = rs1("total_users")
Set rs2 = conn.Execute("SELECT COUNT(*) AS total_reg FROM registration") ' Assuming 'registration' table exists
total_reg = rs2("total_reg")
Set rs3 = conn.Execute("SELECT COUNT(*) AS total_comp FROM competition") ' Assuming 'competition' table exists
total_comp = rs3("total_comp")

' Clean up recordsets
rs1.Close : Set rs1 = Nothing
rs2.Close : Set rs2 = Nothing
rs3.Close : Set rs3 = Nothing
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Contain</title>
    <!-- Include Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8fafc; /* Light grey background */
            color: #1e293b; /* Dark text */
            padding: 2rem;
        }
        /* Style for the enhanced stat cards (Light Theme) */
        .stat-card {
            background-color: #ffffff; /* White background */
            border: 1px solid #e2e8f0; /* Subtle border */
            border-radius: 0.75rem; /* 12px */
            padding: 1.5rem; /* 24px */
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.07), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }
        .stat-icon-wrapper {
            background-color: #dbeafe; /* Lighter blue background */
            color: #2563eb; /* Blue icon color */
            padding: 0.75rem;
            border-radius: 9999px;
            flex-shrink: 0;
            display: inline-flex;
        }
        .stat-content {
            flex-grow: 1;
        }
        .stat-title {
            color: #64748b; /* Slate-500 */
            font-size: 0.875rem;
            font-weight: 500;
        }
        .stat-value {
            color: #0f172a; /* Slate-900 */
            font-size: 1.875rem; /* 30px */
            font-weight: 700;
            margin-top: 0.25rem;
        }

        /* Enhanced Light Table Styles */
        .styled-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 0.5rem; /* Vertical spacing */
            margin-top: 2.5rem;
        }
        .styled-table thead th {
            color: #4b5563; /* Medium gray header text */
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            padding: 0.75rem 1.5rem;
            text-align: left;
            border-bottom: 2px solid #e5e7eb; /* Light gray border */
        }
        .styled-table tbody tr {
             background-color: #ffffff; /* White rows */
             border-radius: 0.5rem;
             transition: background-color 0.2s ease-in-out;
             box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.03), 0 1px 2px 0 rgba(0, 0, 0, 0.02);
             border: 1px solid #e5e7eb; /* Row border */
        }
         .styled-table tbody tr:hover {
             background-color: #f0f9ff; /* Very light blue hover */
         }
        .styled-table tbody td {
            padding: 1rem 1.5rem;
            color: #334155; /* Slate-700 */
            font-size: 0.875rem;
            vertical-align: middle;
        }
         /* Add rounded corners to first and last cells */
         .styled-table tbody tr td:first-child { border-top-left-radius: 0.5rem; border-bottom-left-radius: 0.5rem; }
         .styled-table tbody tr td:last-child { border-top-right-radius: 0.5rem; border-bottom-right-radius: 0.5rem; }

    </style>
</head>
<body>
    <h1 class="text-3xl font-bold text-slate-800 mb-8">Dashboard Overview</h1>

    <!-- Cool Light Stats Section -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-10">
        <!-- Total Users Card -->
        <div class="stat-card">
            <div class="stat-icon-wrapper">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" /></svg>
            </div>
            <div class="stat-content">
                <h3 class="stat-title">Total Users</h3>
                <p class="stat-value"><%= total_users %></p>
            </div>
        </div>

        <!-- Registered Users Card -->
        <div class="stat-card">
             <div class="stat-icon-wrapper">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" /></svg>
            </div>
            <div class="stat-content">
                <h3 class="stat-title">Registered Users</h3>
                <p class="stat-value"><%= total_reg %></p>
            </div>
        </div>

        <!-- Total Competitions Card -->
        <div class="stat-card">
             <div class="stat-icon-wrapper">
                 <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M16.5 18.75h-9m9 0a3 3 0 013 3h-15a3 3 0 013-3m9 0v-4.5m-9 4.5v-4.5m0-6.75h9m-9 0a3 3 0 013-3h3a3 3 0 013 3m-9 0V3.75m9 6.75V3.75m0 0a3 3 0 00-3-3h-3a3 3 0 00-3 3m0 0h9" /></svg>
            </div>
            <div class="stat-content">
                <h3 class="stat-title">Total Competitions</h3>
                <p class="stat-value"><%= total_comp %></p>
            </div>
        </div>
    </div>

    <!-- Cool Light Table Section -->
    <div>
         <h2 class="text-xl font-semibold text-slate-700 mb-4">Summary Table</h2>
         <table class="styled-table">
            <thead>
                <tr>
                    <th>Metric</th>
                    <th>Value</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Total Users</td>
                    <td><%= total_users %></td>
                </tr>
                 <tr>
                    <td>Registered Users</td>
                    <td><%= total_reg %></td>
                </tr>
                 <tr>
                    <td>Total Competitions</td>
                    <td><%= total_comp %></td>
                </tr>
            </tbody>
         </table>
    </div>

</body>
</html>

