package Controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ErrorServlet", urlPatterns = {"/error"})
public class ErrorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleError(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleError(request, response);
    }
    
    private void handleError(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get error parameters
        String errorMessage = request.getParameter("message");
        String errorType = request.getParameter("type");
        String statusCode = request.getParameter("code");
        
        // Set attributes for error.jsp
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
        }
        if (errorType != null) {
            request.setAttribute("errorType", errorType);
        }
        if (statusCode != null) {
            request.setAttribute("statusCode", statusCode);
        }
        
        // Set request URI
        request.setAttribute("requestURI", request.getRequestURI());
        
        // Forward to error.jsp
        request.getRequestDispatcher("error.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Error Servlet for Mugiwara Library";
    }
}
