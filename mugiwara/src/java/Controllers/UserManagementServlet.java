package Controllers;

import DAO.UsersDao;
import Models.*;
import Config.ValidationConf;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UserManagementServlet", urlPatterns = {"/UserManagement"})
public class UserManagementServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        String userType = request.getParameter("userType");
        
        if (action == null) action = "list";
        
        try {
            switch (action) {
                case "list":
                    handleListUsers(request, response, userType);
                    break;
                case "add":
                    handleAddUser(request, response);
                    break;
                case "edit":
                    handleEditUser(request, response);
                    break;
                case "update":
                    handleUpdateUser(request, response);
                    break;
                case "delete":
                    handleDeleteUser(request, response);
                    break;
                case "view":
                    handleViewUser(request, response);
                    break;
                case "getUser":
                    handleGetUserAjax(request, response);
                    break;
                default:
                    handleListUsers(request, response, userType);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("Admin/index.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    /**
     * Handle listing users based on type
     */
    private void handleListUsers(HttpServletRequest request, HttpServletResponse response, String userType) 
            throws ServletException, IOException {
        
        if ("customer".equals(userType)) {
            response.sendRedirect("Admin?page=managecustomer");
        } else {
            response.sendRedirect("Admin?page=manageuserstaff");
        }
    }
    
    /**
     * Handle add user form display
     */
    private void handleAddUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String type = request.getParameter("type");
        request.setAttribute("action", "add");
        request.setAttribute("userType", type);
        request.setAttribute("content", "user-form");
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("Admin/index.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * Handle edit user form display
     */
    private void handleEditUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userId = request.getParameter("userId");
        String userType = request.getParameter("userType");
        
        if (ValidationConf.isEmpty(userId)) {
            setNotificationMessage(request, "error", "User ID tidak valid");
            response.sendRedirect("UserManagement?userType=" + userType);
            return;
        }
        
        UsersDao userDao = new UsersDao();
        
        if ("customer".equals(userType)) {
            Customer customer = userDao.getCustomerById(Integer.parseInt(userId));
            if (customer != null) {
                request.setAttribute("customer", customer);
                request.setAttribute("action", "edit");
                request.setAttribute("userType", userType);
                request.setAttribute("content", "customer-form");
            } else {
                setNotificationMessage(request, "error", "Customer tidak ditemukan");
                response.sendRedirect("UserManagement?userType=" + userType);
                return;
            }
        } else {
            Users user = userDao.getUserById(Integer.parseInt(userId));
            if (user != null) {
                request.setAttribute("user", user);
                request.setAttribute("action", "edit");
                request.setAttribute("userType", userType);
                request.setAttribute("content", "user-form");
            } else {
                setNotificationMessage(request, "error", "User tidak ditemukan");
                response.sendRedirect("UserManagement?userType=" + userType);
                return;
            }
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("Admin/index.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * Handle AJAX request to get user data
     */
    private void handleGetUserAjax(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userId = request.getParameter("userId");
        String userType = request.getParameter("userType");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        if (!ValidationConf.isEmpty(userId)) {
            UsersDao userDao = new UsersDao();
            
            if ("customer".equals(userType)) {
                Customer customer = userDao.getCustomerById(Integer.parseInt(userId));
                if (customer != null) {
                    String json = customerToJson(customer);
                    response.getWriter().write(json);
                } else {
                    response.getWriter().write("{\"error\":\"Customer not found\"}");
                }
            } else {
                Users user = userDao.getUserById(Integer.parseInt(userId));
                if (user != null) {
                    String json = userToJson(user);
                    response.getWriter().write(json);
                } else {
                    response.getWriter().write("{\"error\":\"User not found\"}");
                }
            }
        } else {
            response.getWriter().write("{\"error\":\"Invalid user ID\"}");
        }
    }
    
    /**
     * Handle update user - SIMPLIFIED tanpa address
     */
    private void handleUpdateUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userId = request.getParameter("userId");
        String userType = request.getParameter("userType");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String gender = request.getParameter("gender");
        String birthDate = request.getParameter("birthDate");
        String password = request.getParameter("password");
        
        // Customer specific fields (tanpa address)
        // String phone = request.getParameter("phone");
        
        // Validation
        if (ValidationConf.isEmpty(userId) || ValidationConf.isEmpty(username) || ValidationConf.isEmpty(email)) {
            setNotificationMessage(request, "error", "User ID, Username, dan Email harus diisi");
            response.sendRedirect("UserManagement?action=edit&userId=" + userId + "&userType=" + userType);
            return;
        }
        
        UsersDao userDao = new UsersDao();
        
        try {
            // Parse birth date
            Date birthDateParsed = null;
            if (!ValidationConf.isEmpty(birthDate)) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                birthDateParsed = sdf.parse(birthDate);
            }
            
            boolean result = false;
            
            if ("customer".equals(userType)) {
                // Update Customer dengan phone (tanpa address)
                if (!ValidationConf.isEmpty(password)) {
                    result = userDao.updateCustomerWithPassword(Integer.parseInt(userId), username, email, 
                        fullName, gender, birthDateParsed, password);
                } else {
                    result = userDao.updateCustomer(Integer.parseInt(userId), username, email, 
                        fullName, gender, birthDateParsed);
                }
            } else {
                // Update Admin/Staff tanpa phone dan address
                if (!ValidationConf.isEmpty(password)) {
                    result = userDao.updateUserWithPassword(Integer.parseInt(userId), username, email, 
                        fullName, gender, birthDateParsed, password);
                } else {
                    result = userDao.updateUser(Integer.parseInt(userId), username, email, 
                        fullName, gender, birthDateParsed);
                }
            }
            
            if (result) {
                setNotificationMessage(request, "success", userDao.getMessage());
            } else {
                setNotificationMessage(request, "error", userDao.getMessage());
            }
            
        } catch (Exception e) {
            setNotificationMessage(request, "error", "Error: " + e.getMessage());
        }
        
        response.sendRedirect("UserManagement?userType=" + userType);
    }
    
    /**
     * Handle delete user
     */
    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userId = request.getParameter("userId");
        String userType = request.getParameter("userType");
        
        if (ValidationConf.isEmpty(userId)) {
            setNotificationMessage(request, "error", "User ID tidak valid");
            response.sendRedirect("UserManagement?userType=" + userType);
            return;
        }
        
        UsersDao userDao = new UsersDao();
        boolean result = userDao.deleteUser(Integer.parseInt(userId));
        
        if (result) {
            setNotificationMessage(request, "success", userDao.getMessage());
        } else {
            setNotificationMessage(request, "error", userDao.getMessage());
        }
        
        response.sendRedirect("UserManagement?userType=" + userType);
    }
    
    /**
     * Handle view user details
     */
    private void handleViewUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userId = request.getParameter("userId");
        String userType = request.getParameter("userType");
        
        if (ValidationConf.isEmpty(userId)) {
            setNotificationMessage(request, "error", "User ID tidak valid");
            response.sendRedirect("UserManagement?userType=" + userType);
            return;
        }
        
        UsersDao userDao = new UsersDao();
        
        if ("customer".equals(userType)) {
            Customer customer = userDao.getCustomerById(Integer.parseInt(userId));
            if (customer != null) {
                request.setAttribute("customer", customer);
                request.setAttribute("userType", userType);
                request.setAttribute("content", "customer-detail");
            } else {
                setNotificationMessage(request, "error", "Customer tidak ditemukan");
                response.sendRedirect("UserManagement?userType=" + userType);
                return;
            }
        } else {
            Users user = userDao.getUserById(Integer.parseInt(userId));
            if (user != null) {
                request.setAttribute("user", user);
                request.setAttribute("userType", userType);
                request.setAttribute("content", "user-detail");
            } else {
                setNotificationMessage(request, "error", "User tidak ditemukan");
                response.sendRedirect("UserManagement?userType=" + userType);
                return;
            }
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("Admin/index.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * Convert user object to JSON string
     */
    private String userToJson(Users user) {
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"userId\":").append(user.getUserId()).append(",");
        json.append("\"username\":").append(user.getUsername() != null ? "\"" + user.getUsername() + "\"" : "null").append(",");
        json.append("\"email\":").append(user.getEmail() != null ? "\"" + user.getEmail() + "\"" : "null").append(",");
        json.append("\"fullName\":").append(user.getFullName() != null ? "\"" + user.getFullName().replace("\"", "\\\"") + "\"" : "null").append(",");
        json.append("\"gender\":").append(user.getGender() != null ? "\"" + user.getGender() + "\"" : "null").append(",");
        json.append("\"birthDate\":").append(user.getBirthDate() != null ? "\"" + new SimpleDateFormat("yyyy-MM-dd").format(user.getBirthDate()) + "\"" : "null").append(",");
        json.append("\"imagePath\":").append(user.getImagePath() != null ? "\"" + user.getImagePath() + "\"" : "null").append(",");
        json.append("\"roleId\":").append(user.getRole().getRoleId()).append(",");
        json.append("\"roleName\":").append("\"" + user.getRole().getRoleName() + "\"");
        json.append("}");
        return json.toString();
    }
    
    /**
     * Convert customer object to JSON string (tanpa address)
     */
    private String customerToJson(Customer customer) {
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"userId\":").append(customer.getUserId()).append(",");
        json.append("\"username\":").append(customer.getUsername() != null ? "\"" + customer.getUsername() + "\"" : "null").append(",");
        json.append("\"email\":").append(customer.getEmail() != null ? "\"" + customer.getEmail() + "\"" : "null").append(",");
        json.append("\"fullName\":").append(customer.getFullName() != null ? "\"" + customer.getFullName().replace("\"", "\\\"") + "\"" : "null").append(",");
        json.append("\"gender\":").append(customer.getGender() != null ? "\"" + customer.getGender() + "\"" : "null").append(",");
        json.append("\"birthDate\":").append(customer.getBirthDate() != null ? "\"" + new SimpleDateFormat("yyyy-MM-dd").format(customer.getBirthDate()) + "\"" : "null").append(",");
        json.append("\"phone\":").append(customer.getPhone() != null ? "\"" + customer.getPhone() + "\"" : "null").append(",");
        json.append("\"imagePath\":").append(customer.getImagePath() != null ? "\"" + customer.getImagePath() + "\"" : "null").append(",");
        json.append("\"roleId\":").append(customer.getRole().getRoleId()).append(",");
        json.append("\"roleName\":").append("\"" + customer.getRole().getRoleName() + "\"");
        json.append("}");
        return json.toString();
    }
    
    /**
     * Set notification message in session
     */
    private void setNotificationMessage(HttpServletRequest request, String type, String message) {
        request.getSession().setAttribute("notificationMsg", message);
        request.getSession().setAttribute("notificationType", type);
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
        return "User Management Servlet for CRUD operations";
    }
}
