<%
    boolean isLoggedIn = (session != null && session.getAttribute("isLoggedIn") != null) ?
                         ((Boolean) session.getAttribute("isLoggedIn")).booleanValue() : false;

    if (isLoggedIn == false || !isLoggedIn) {
        response.sendRedirect("login.jsp?message=not_logged_in");
        return;
    }
    
    int userId = (session.getAttribute("user_id") != null) ? (Integer) session.getAttribute("user_id") : 0; // Default ID, e.g., 0 or -1
    String username = (session.getAttribute("username") != null) ? (String) session.getAttribute("username") : "Guest";
    String email = (session.getAttribute("email") != null) ? (String) session.getAttribute("email") : "guest@example.com";
    String fullName = (session.getAttribute("full_name") != null) ? (String) session.getAttribute("full_name") : "Pengguna Tidak Dikenal";
    int roleId = (session.getAttribute("role_id") != null) ? (Integer) session.getAttribute("role_id") : 0; // Default role ID, e.g., 0 for unknown
    String roleName = (session.getAttribute("role_name") != null) ? (String) session.getAttribute("role_name") : "Guest";
%> 