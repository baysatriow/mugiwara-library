package Controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author bayus
 */

@WebServlet(name = "AdminRouterServlet", urlPatterns = {"/Admin/SSS"})
public class AdminRouterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Parse the requested URI
        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        
        // Exclude login.jsp from processing to avoid infinite loop
        if (requestURI.endsWith("/login.jsp")) {
            // Login page should be served directly, not processed by the router
            return; // Let the default servlet handle this
        }
        
        // Get session data
        HttpSession session = request.getSession(false);
        Integer level = (session != null) ? (Integer) session.getAttribute("level") : null;
        
        // Check if user is logged in as admin
        if (level == null || level != 1) {
            response.sendRedirect(request.getContextPath() + "/Admin/login.jsp");
            return;
        }
        // Untuk debugging, cek lokasi sebenarnya
        String realPath = getServletContext().getRealPath("/");
        System.out.println("Context root real path: " + realPath);
        // Get page parameter
        String pg = request.getParameter("pg");
        String targetJsp =  "/Admin/index.jsp"; // default admin page
        
        if (pg != null) {
            switch (pg) {
                case "data_akun":
                    targetJsp = "/Admin/mod_akun/akun.jsp";
                    break;
                case "dataZakat":
                    targetJsp = "/Admin/mod_data_zakat/zakat.jsp";
                    break;
                case "dataPenerima":
                    targetJsp = "/Admin/mod_data_penerima/penerima.jsp";
                    break;
                case "settingZakat":
                    targetJsp = "/Admin/mod_setting_zakat/setting.jsp";
                    break;
            }
        }
        
        // Forward request to the target JSP
        try {
            request.getRequestDispatcher(targetJsp).forward(request, response);
        } catch (ServletException e) {
            // Log error and send a friendly error message
            System.err.println("Failed to forward to: " + targetJsp);
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                              "JSP file not found: " + targetJsp + realPath);
        }
    }
}