package Controllers;

import Config.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
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

@WebServlet(name = "AdminRouterServlet", urlPatterns = {"/Admin"})
public class AdminRouterServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
//        HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("userId") == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
        
        String page = request.getParameter("page");
        if (page == null) page = "home";
        
        DBConnection db = new DBConnection();
        db.connect();
        
        try {
            switch (page) {
                case "home":
                    loadDashboardData(request, db);
                    request.setAttribute("content", "home");
                    break;
                case "statistik":
                    loadDashboardData(request, db);
                    request.setAttribute("content", "statistik");
                    break;
                case "barang":
                    loadDashboardData(request, db);
                    request.setAttribute("content", "barang");
                    break;
                case "manageuser":
                    loadAllUserData(request, db);
                    request.setAttribute("content", "manageuser");
                    break;
                case "setting":
                    loadDashboardData(request, db);
                    request.setAttribute("content", "setting");
                    break;
                default:
                    loadDashboardData(request, db);
                    request.setAttribute("content", "404");
                    break;
            }
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("Admin/index.jsp");
            dispatcher.forward(request, response);
            
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("Admin/index.jsp");
            dispatcher.forward(request, response);
        } finally {
            db.disconnect();
        }
    }

    private void loadDashboardData(HttpServletRequest request, DBConnection db) throws SQLException {
//        String query = "SELECT * FROM alarm ORDER BY time ASC";
//        ResultSet rs = db.getData(query);
//        request.setAttribute("dashboardData", rs);
    }
    
    private void loadAllUserData(HttpServletRequest request, DBConnection db) throws SQLException {
        String query = "SELECT u.user_id, u.username, u.email, u.full_name, u.gender, ur.role_name AS role FROM users AS u JOIN user_role AS ur ON u.role_id = ur.role_id";
        ResultSet rs = db.getData(query);
        request.setAttribute("ListAllUser", rs);
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
