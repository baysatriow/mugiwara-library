package Config;

import java.io.PrintWriter;
import java.io.StringWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import java.io.IOException;

public class ErrorHandler {
    
    /**
     * Handle database errors
     */
    public static void handleDatabaseError(HttpServletRequest request, HttpServletResponse response, 
                                         String message, Exception e) 
            throws ServletException, IOException {
        
        request.setAttribute("errorMessage", message);
        request.setAttribute("errorType", "database");
        request.setAttribute("statusCode", "500");
        
        if (e != null) {
            request.setAttribute("exceptionMessage", e.getMessage());
            request.setAttribute("stackTrace", getStackTrace(e));
        }
        
        request.getRequestDispatcher("error.jsp").forward(request, response);
    }
    
    /**
     * Handle validation errors
     */
    public static void handleValidationError(HttpServletRequest request, HttpServletResponse response, 
                                           String message) 
            throws ServletException, IOException {
        
        request.setAttribute("errorMessage", message);
        request.setAttribute("errorType", "validation");
        request.setAttribute("statusCode", "400");
        
        request.getRequestDispatcher("error.jsp").forward(request, response);
    }
    
    /**
     * Handle authentication errors
     */
    public static void handleAuthenticationError(HttpServletRequest request, HttpServletResponse response, 
                                               String message) 
            throws ServletException, IOException {
        
        request.setAttribute("errorMessage", message);
        request.setAttribute("errorType", "authentication");
        request.setAttribute("statusCode", "401");
        
        request.getRequestDispatcher("error.jsp").forward(request, response);
    }
    
    /**
     * Handle authorization errors
     */
    public static void handleAuthorizationError(HttpServletRequest request, HttpServletResponse response, 
                                              String message) 
            throws ServletException, IOException {
        
        request.setAttribute("errorMessage", message);
        request.setAttribute("errorType", "authorization");
        request.setAttribute("statusCode", "403");
        
        request.getRequestDispatcher("error.jsp").forward(request, response);
    }
    
    /**
     * Handle not found errors
     */
    public static void handleNotFoundError(HttpServletRequest request, HttpServletResponse response, 
                                         String message) 
            throws ServletException, IOException {
        
        request.setAttribute("errorMessage", message);
        request.setAttribute("errorType", "notfound");
        request.setAttribute("statusCode", "404");
        
        request.getRequestDispatcher("error.jsp").forward(request, response);
    }
    
    /**
     * Handle general errors
     */
    public static void handleGeneralError(HttpServletRequest request, HttpServletResponse response, 
                                        String message, int statusCode, Exception e) 
            throws ServletException, IOException {
        
        request.setAttribute("errorMessage", message);
        request.setAttribute("statusCode", String.valueOf(statusCode));
        
        if (e != null) {
            request.setAttribute("exceptionMessage", e.getMessage());
            request.setAttribute("stackTrace", getStackTrace(e));
        }
        
        request.getRequestDispatcher("error.jsp").forward(request, response);
    }
    
    /**
     * Redirect to error page with parameters
     */
    public static void redirectToError(HttpServletResponse response, String message, 
                                     String type, int statusCode) 
            throws IOException {
        
        StringBuilder url = new StringBuilder("error?");
        
        if (message != null) {
            url.append("message=").append(java.net.URLEncoder.encode(message, "UTF-8"));
        }
        
        if (type != null) {
            url.append("&type=").append(type);
        }
        
        url.append("&code=").append(statusCode);
        
        response.sendRedirect(url.toString());
    }
    
    /**
     * Get stack trace as string
     */
    private static String getStackTrace(Exception e) {
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);
        return sw.toString();
    }
    
    /**
     * Check if running in development mode
     */
    public static boolean isDevelopmentMode() {
        return "development".equals(System.getProperty("environment", "development"));
    }
}
