package Controllers;

/**
 *
 * @author bayus
 */

import DAO.UsersDAO;
import DAO.AdminDAO;
import DAO.CustomerDAO;
import DAO.StaffDAO;
import Models.Admin;
import Models.Customer;
import Models.Staff;
import Models.Users;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "AdminRouterServlet", urlPatterns = {"/Admin"})
public class AdminRouterServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP GET and POST methods.
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // Uncomment for session validation
        // HttpSession session = request.getSession(false);
        // if (session == null || session.getAttribute("userId") == null) {
        //     response.sendRedirect("login.jsp");
        //     return;
        // }
        
        String page = request.getParameter("page");
        if (page == null) page = "home";
        
        try {
            switch (page) {
                case "home":
                    loadDashboardData(request);
                    request.setAttribute("content", "home");
                    break;
                case "statistik":
                    loadDashboardData(request);
                    request.setAttribute("content", "statistik");
                    break;
                case "barang":
                    loadDashboardData(request);
                    request.setAttribute("content", "barang");
                    break;
                case "manageuserstaff":
                    loadAllUserAdminPageData(request);
                    request.setAttribute("content", "manageuserstaff");
                    break;
                case "managecustomer":
                    loadAllUserCustomerPageData(request);
                    request.setAttribute("content", "manageusercommon");
                    break;
                case "setting":
                    loadDashboardData(request);
                    request.setAttribute("content", "setting");
                    break;
                default:
                    loadDashboardData(request);
                    request.setAttribute("content", "404");
                    break;
            }
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("Admin/index.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("Admin/index.jsp");
            dispatcher.forward(request, response);
        }
    }

    /**
     * Load dashboard data for admin home page
     */
    private void loadDashboardData(HttpServletRequest request) {
        try {
            UsersDAO userDAO = new UsersDAO();
            CustomerDAO customerDAO = new CustomerDAO();
            StaffDAO staffDAO = new StaffDAO();
            AdminDAO adminDAO = new AdminDAO();
            
            // Get counts for dashboard
            ArrayList<Users> allUsers = userDAO.get();
            ArrayList<Customer> allCustomers = customerDAO.getAllCustomers();
            ArrayList<Staff> allStaff = staffDAO.get();
            ArrayList<Admin> allAdmins = adminDAO.getAllAdmins();
            
            // Set dashboard statistics
            request.setAttribute("totalUsers", allUsers.size());
            request.setAttribute("totalCustomers", allCustomers.size());
            request.setAttribute("totalStaff", allStaff.size());
            request.setAttribute("totalAdmins", allAdmins.size());
            
            // Get recent activities or reports
            ArrayList<ArrayList<Object>> salesReport = adminDAO.getSalesReport();
            request.setAttribute("recentSales", salesReport);
            
        } catch (Exception e) {
            request.setAttribute("dashboardError", "Failed to load dashboard data: " + e.getMessage());
        }
    }
    
    /**
     * Load all Admin and Staff data for management page
     */
    private void loadAllUserAdminPageData(HttpServletRequest request) {
        try {
            AdminDAO adminDAO = new AdminDAO();
            StaffDAO staffDAO = new StaffDAO();
            UsersDAO userDAO = new UsersDAO();
            
            // Get all admins
            ArrayList<Admin> adminList = adminDAO.getAllAdmins();
            request.setAttribute("adminList", adminList);
            
            // Get all staff
            ArrayList<Staff> staffList = staffDAO.get();
            request.setAttribute("staffList", staffList);
            
            // Get combined admin and staff data for unified view
            ArrayList<ArrayList<Object>> combinedData = userDAO.getAdminAndStaffData();
            request.setAttribute("ListAllAdminStaff", combinedData);
            
            // Get staff performance data
            ArrayList<ArrayList<Object>> staffWorkload = staffDAO.getStaffWorkload();
            request.setAttribute("staffWorkload", staffWorkload);
            
            // Set success message
            request.setAttribute("message", "Admin and Staff data loaded successfully");
            
        } catch (Exception e) {
            request.setAttribute("error", "Failed to load admin/staff data: " + e.getMessage());
        }
    }
    
    /**
     * Load all Customer data for management page
     */
    private void loadAllUserCustomerPageData(HttpServletRequest request) {
        try {
            CustomerDAO customerDAO = new CustomerDAO();
            
            // Get all customers
            ArrayList<Customer> customerList = customerDAO.getAllCustomers();
            request.setAttribute("customerList", customerList);
            
            // Get customer statistics
            int totalCustomers = customerList.size();
            request.setAttribute("totalCustomers", totalCustomers);
            
            // Get customers with order statistics
            ArrayList<ArrayList<Object>> customerStats = new ArrayList<>();
            for (Customer customer : customerList) {
                int totalOrders = customerDAO.getCustomerTotalOrders(customer.getUserId());
                ArrayList<Object> customerStat = new ArrayList<>();
                customerStat.add(customer.getUserId());
                customerStat.add(customer.getUsername());
                customerStat.add(customer.getEmail());
                customerStat.add(customer.getPhone());
                customerStat.add(customer.getGender());
                customerStat.add(totalOrders);
                customerStat.add(customer.getRoleName());
                customerStats.add(customerStat);
            }
            request.setAttribute("ListAllCustomers", customerStats);
            
            // Get recent customer registrations (last 10)
            ArrayList<Customer> recentCustomers = customerDAO.getAllCustomers();
            if (recentCustomers.size() > 10) {
                recentCustomers = new ArrayList<>(recentCustomers.subList(0, 10));
            }
            request.setAttribute("recentCustomers", recentCustomers);
            
            // Set success message
            request.setAttribute("message", "Customer data loaded successfully");
            
        } catch (Exception e) {
            request.setAttribute("error", "Failed to load customer data: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Admin Router Servlet using DAO pattern with Models and DAO packages";
    }
}
