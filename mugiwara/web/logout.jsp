<%
    if (session != null) {
        session.invalidate();
    }
    response.sendRedirect("login.jsp?message=logout_success");
%>