package controllers;

import DAO.UsersDAO;
import DAO.AdminDAO;
import DAO.CustomerDAO;
import DAO.StaffDAO;
import Models.Admin;
import Models.Customer;
import Models.Staff;
import Models.Users;
import Models.UserRoles;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet for handling user management operations (CRUD)
 */
@WebServlet(name = "UserManagementServlet", urlPatterns = {"/UserManagement"})
public class UserManagementServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        if (action == null) action = "list";
        
        try {
            switch (action) {
                case "list":
                    listUsers(request, response);
                    break;
                case "add":
                    addUser(request, response);
                    break;
                case "edit":
                    editUser(request, response);
                    break;
                case "delete":
                    deleteUser(request, response);
                    break;
                case "search":
                    searchUsers(request, response);
                    break;
                default:
                    listUsers(request, response);
                    break;
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("Admin/error.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userType = request.getParameter("type");
        
        if ("customer".equals(userType)) {
            CustomerDAO customerDAO = new CustomerDAO();
            ArrayList<Customer> customers = customerDAO.getAllCustomers();
            request.setAttribute("users", customers);
            request.setAttribute("userType", "customer");
        } else if ("staff".equals(userType)) {
            StaffDAO staffDAO = new StaffDAO();
            ArrayList<Staff> staff = staffDAO.get();
            request.setAttribute("users", staff);
            request.setAttribute("userType", "staff");
        } else if ("admin".equals(userType)) {
            AdminDAO adminDAO = new AdminDAO();
            ArrayList<Admin> admins = adminDAO.getAllAdmins();
            request.setAttribute("users", admins);
            request.setAttribute("userType", "admin");
        } else {
            UsersDAO userDAO = new UsersDAO();
            ArrayList<Users> users = userDAO.get();
            request.setAttribute("users", users);
            request.setAttribute("userType", "all");
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("Admin/userList.jsp");
        dispatcher.forward(request, response);
    }
    
    private void addUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String method = request.getMethod();
        
        if ("GET".equals(method)) {
            // Show add user form
            RequestDispatcher dispatcher = request.getRequestDispatcher("Admin/addUser.jsp");
            dispatcher.forward(request, response);
        } else if ("POST".equals(method)) {
            // Process add user
            String userType = request.getParameter("userType");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            try {
                if ("customer".equals(userType)) {
                    Customer customer = new Customer(username, email);
                    customer.setPassword(password);
                    customer.setPhone(request.getParameter("phone"));
                    
                    CustomerDAO customerDAO = new CustomerDAO();
                    customerDAO.insert();
                    
                } else if ("staff".equals(userType)) {
                    Staff staff = new Staff(username, email, request.getParameter("phone"));
                    staff.setPassword(password);
                    staff.setPosition(request.getParameter("position"));
                    
                    StaffDAO staffDAO = new StaffDAO();
                    staffDAO.insert();
                    
                } else if ("admin".equals(userType)) {
                    Admin admin = new Admin(username, email, password);
                    
                    AdminDAO adminDAO = new AdminDAO();
                    adminDAO.insert();
                }
                
                request.setAttribute("success", "Users added successfully");
                response.sendRedirect("UserManagement?action=list&type=" + userType);
                
            } catch (Exception e) {
                request.setAttribute("error", "Failed to add user: " + e.getMessage());
                RequestDispatcher dispatcher = request.getRequestDispatcher("Admin/addUser.jsp");
                dispatcher.forward(request, response);
            }
        }
    }
    
    private void editUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String userType = request.getParameter("userType");
        String method = request.getMethod();
        
        if ("GET".equals(method)) {
            // Show edit form
            Object user = null;
            
            if ("customer".equals(userType)) {
                CustomerDAO customerDAO = new CustomerDAO();
                user = customerDAO.find(userId);
            } else if ("staff".equals(userType)) {
                StaffDAO staffDAO = new StaffDAO();
                user = staffDAO.find(userId);
            } else if ("admin".equals(userType)) {
                AdminDAO adminDAO = new AdminDAO();
                user = adminDAO.find(userId);
            }
            
            request.setAttribute("user", user);
            request.setAttribute("userType", userType);
            RequestDispatcher dispatcher = request.getRequestDispatcher("Admin/editUser.jsp");
            dispatcher.forward(request, response);
            
        } else if ("POST".equals(method)) {
            // Process edit
            try {
                if ("customer".equals(userType)) {
                    CustomerDAO customerDAO = new CustomerDAO();
                    Customer customer = (Customer) customerDAO.find(userId);
                    if (customer != null) {
                        customer.setUsername(request.getParameter("username"));
                        customer.setEmail(request.getParameter("email"));
                        customer.setPhone(request.getParameter("phone"));
                        customerDAO.update();
                    }
                } else if ("staff".equals(userType)) {
                    StaffDAO staffDAO = new StaffDAO();
                    Staff staff = (Staff) staffDAO.find(userId);
                    if (staff != null) {
                        staff.setStaffName(request.getParameter("username"));
                        staff.setEmail(request.getParameter("email"));
                        staff.setPhone(request.getParameter("phone"));
                        staff.setPosition(request.getParameter("position"));
                        staffDAO.update();
                    }
                } else if ("admin".equals(userType)) {
                    AdminDAO adminDAO = new AdminDAO();
                    Admin admin = (Admin) adminDAO.find(userId);
                    if (admin != null) {
                        admin.setUsername(request.getParameter("username"));
                        admin.setEmail(request.getParameter("email"));
                        adminDAO.update();
                    }
                }
                
                request.setAttribute("success", "Users updated successfully");
                response.sendRedirect("UserManagement?action=list&type=" + userType);
                
            } catch (Exception e) {
                request.setAttribute("error", "Failed to update user: " + e.getMessage());
                RequestDispatcher dispatcher = request.getRequestDispatcher("Admin/editUser.jsp");
                dispatcher.forward(request, response);
            }
        }
    }
    
    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String userType = request.getParameter("userType");
        
        try {
            if ("customer".equals(userType)) {
                CustomerDAO customerDAO = new CustomerDAO();
                Customer customer = (Customer) customerDAO.find(userId);
                if (customer != null) {
                    customerDAO.delete();
                }
            } else if ("staff".equals(userType)) {
                StaffDAO staffDAO = new StaffDAO();
                Staff staff = (Staff) staffDAO.find(userId);
                if (staff != null) {
                    staffDAO.delete();
                }
            } else if ("admin".equals(userType)) {
                AdminDAO adminDAO = new AdminDAO();
                Admin admin = (Admin) adminDAO.find(userId);
                if (admin != null) {
                    adminDAO.delete();
                }
            }
            
            request.setAttribute("success", "Users deleted successfully");
            response.sendRedirect("UserManagement?action=list&type=" + userType);
            
        } catch (Exception e) {
            request.setAttribute("error", "Failed to delete user: " + e.getMessage());
            response.sendRedirect("UserManagement?action=list&type=" + userType);
        }
    }
    
    private void searchUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String userType = request.getParameter("type");
        
        ArrayList<?> searchResults = new ArrayList<>();
        
        if ("customer".equals(userType)) {
            CustomerDAO customerDAO = new CustomerDAO();
            // Implement search in CustomerDAO if needed
        } else if ("staff".equals(userType)) {
            StaffDAO staffDAO = new StaffDAO();
            searchResults = staffDAO.searchStaff(keyword);
        } else if ("admin".equals(userType)) {
            AdminDAO adminDAO = new AdminDAO();
            // Implement search in AdminDAO if needed
        } else {
            UsersDAO userDAO = new UsersDAO();
            searchResults = userDAO.searchUsers(keyword);
        }
        
        request.setAttribute("users", searchResults);
        request.setAttribute("keyword", keyword);
        request.setAttribute("userType", userType);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("Admin/userList.jsp");
        dispatcher.forward(request, response);
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
        return "Users Management Servlet";
    }
}
