registration page 

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
            /* New Color Theme: Dark Blue background */
            background-color: #050f2a;
            background-image: linear-gradient(-45deg, #050f2a, #1a2955, #050f2a);
            background-size: 400% 400%;
            animation: gradient 15s ease infinite;
        }

        @keyframes gradient {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .form-input {
            background: rgba(184, 169, 255, 0.1); /* Lavender transparent background */
            border: 1px solid rgba(184, 169, 255, 0.2); /* Lavender border */
            color: #f2fdff; /* Near white text */
        }
        .form-input::placeholder {
             color: rgba(242, 253, 255, 0.5); /* Lighter placeholder */
        }
        .form-input:focus {
            background: rgba(184, 169, 255, 0.2);
            border-color: #7bbbff; /* Light Blue focus */
            outline: none;
        }
         /* Style for Select dropdown */
        select.form-input {
             color: #f2fdff; /* Make sure select text is white */
        }
        select option {
            background-color: #050f2a; /* Dark background for options */
            color: #f2fdff;
        }

        .form-button {
            background-color: #7bbbff; /* Light Blue button */
            color: #050f2a; /* Dark Blue text */
        }
        .form-button:hover {
             background-color: #6aaee6; /* Slightly darker blue on hover */
        }

         /* Style radio buttons */
        .radio-label div {
             border: 2px solid rgba(184, 169, 255, 0.4); /* Lavender border */
             color: #b8a9ff; /* Lavender text */
        }
        .radio-label input:checked + div {
             background-color: #7bbbff; /* Light blue background when checked */
             color: #050f2a; /* Dark text when checked */
             border-color: #7bbbff;
        }
    </style>
</head>
<body class="flex items-center justify-center min-h-screen p-4" style="color: #f2fdff;">

    <div class="bg-black/20 backdrop-blur-lg border rounded-xl shadow-lg w-full max-w-lg p-8" style="border-color: rgba(184, 169, 255, 0.2);">
        <div class="text-center mb-8">
            <h2 class="text-3xl font-bold" style="color: #f2fdff;">Create Your Account</h2>
            <p class="text-slate-400 mt-1 text-sm">Join the Competition Portal</p>
        </div>

        <!-- Registration Form -->
        <form method="post" class="space-y-4">
            <div>
                <label for="full_name" class="block text-sm font-medium text-slate-300 mb-1">Full Name</label>
                <input type="text" name="full_name" id="full_name" class="w-full px-4 py-3 rounded-lg form-input focus:ring-2 focus:ring-blue-400" placeholder="Enter your full name" required>
            </div>

             <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                 <div>
                    <label for="user_id" class="block text-sm font-medium text-slate-300 mb-1">User ID</label>
                    <input type="text" name="user_id" id="user_id" class="w-full px-4 py-3 rounded-lg form-input focus:ring-2 focus:ring-blue-400" placeholder="Choose a User ID" required>
                 </div>
                  <div>
                    <label for="email" class="block text-sm font-medium text-slate-300 mb-1">Email Address</label>
                    <input type="email" name="email" id="email" class="w-full px-4 py-3 rounded-lg form-input focus:ring-2 focus:ring-blue-400" placeholder="Enter your email" required>
                 </div>
            </div>

            <div>
                <label for="password" class="block text-sm font-medium text-slate-300 mb-1">Password</label>
                <input type="password" name="password" id="password" class="w-full px-4 py-3 rounded-lg form-input focus:ring-2 focus:ring-blue-400" placeholder="Create a password" required>
            </div>
             
             <div>
                <label class="block text-sm font-medium text-slate-300 mb-1">Register as</label>
                <div class="flex gap-4">
                     <label class="flex items-center space-x-2 radio-label cursor-pointer">
                        <input type="radio" name="role" value="Participant" class="sr-only" checked>
                        <div class="px-4 py-2 rounded-lg transition-colors">Participant</div>
                    </label>
                     <label class="flex items-center space-x-2 radio-label cursor-pointer">
                        <input type="radio" name="role" value="Host" class="sr-only">
                         <div class="px-4 py-2 rounded-lg transition-colors">Host</div>
                    </label>
                </div>
            </div>

            <hr class="my-4" style="border-color: rgba(184, 169, 255, 0.2);">

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label for="college_name" class="block text-sm font-medium text-slate-300 mb-1">College Name</label>
                    <input type="text" name="college_name" id="college_name" class="w-full px-4 py-3 rounded-lg form-input focus:ring-2 focus:ring-blue-400" placeholder="Your college name">
                </div>
                 <div>
                    <label for="year_of_study" class="block text-sm font-medium text-slate-300 mb-1">Year of Study</label>
                    <select name="year_of_study" id="year_of_study" class="w-full px-4 py-3 rounded-lg form-input focus:ring-2 focus:ring-blue-400">
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
                <label for="contact_number" class="block text-sm font-medium text-slate-300 mb-1">Contact Number</label>
                <input type="tel" name="contact_number" id="contact_number" class="w-full px-4 py-3 rounded-lg form-input focus:ring-2 focus:ring-blue-400" placeholder="Your phone number">
            </div>


            <input type="submit" name="register" value="Register" class="w-full form-button font-bold py-3 px-4 rounded-lg cursor-pointer transition duration-300 mt-6">
        </form>

        <!-- Display Registration Message -->
        <%-- Simulate message display for preview --%>
        <!-- 
        <% If regMsg <> "" Then %>
            <div class="mt-4 text-center font-medium text-sm <%= IIf(regMsgType = "success", "text-green-400", "text-red-400") %>">
                <%= regMsg %>
            </div>
        <% End If %> 
        -->
        
        <!-- Example messages for preview -->
        <!-- <div class="mt-4 text-center font-medium text-sm text-green-400">Registration successful! You can now log in.</div> -->
        <!-- <div class="mt-4 text-center font-medium text-sm text-red-400">User ID or Email already exists. Please choose another or log in.</div> -->


        <div class="mt-8 text-center text-sm text-slate-400">
            Already have an account? <a href="login.asp" class="font-semibold hover:underline" style="color: #b8a9ff;">Login here</a>
        </div>
    </div>
    
    <script>
        // Basic interactivity for radio buttons in preview
        document.querySelectorAll('input[name="role"]').forEach(radio => {
            radio.addEventListener('change', () => {
                document.querySelectorAll('input[name="role"]').forEach(r => {
                    const div = r.nextElementSibling;
                    if (r.checked) {
                        div.style.backgroundColor = '#7bbbff';
                        div.style.color = '#050f2a';
                        div.style.borderColor = '#7bbbff';
                    } else {
                        div.style.backgroundColor = 'transparent';
                        div.style.color = '#b8a9ff'; // Lavender text
                        div.style.borderColor = 'rgba(184, 169, 255, 0.4)'; // Lavender border
                    }
                });
            });
             // Initial check style
            if(radio.checked) {
                 const div = radio.nextElementSibling;
                 div.style.backgroundColor = '#7bbbff';
                 div.style.color = '#050f2a';
                 div.style.borderColor = '#7bbbff';
            }
        });
    </script>

</body>
</html>
