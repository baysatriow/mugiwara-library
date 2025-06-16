package Controllers;

import DAO.UsersDao;
import DAO.BarangDao;
import Models.*;
import Config.ValidationConf;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminRouterServlet", urlPatterns = {"/Admin"})
public class AdminRouterServlet extends HttpServlet {

private static final int ITEMS_PER_PAGE = 10;

protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    
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
                loadBarangPageData(request);
                request.setAttribute("content", "barang");
                break;
            case "manageuserstaff":
                loadAllUserAdminPageData(request);
                request.setAttribute("content", "manageuserstaff");
                break;
            case "managecustomer":
                loadAllUserCustomerPageData(request);
                request.setAttribute("content", "managecustomer");
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
        e.printStackTrace();
        request.setAttribute("error", "Error: " + e.getMessage());
        RequestDispatcher dispatcher = request.getRequestDispatcher("Admin/index.jsp");
        dispatcher.forward(request, response);
    }
}

/**
 * Load barang page data with pagination
 */
private void loadBarangPageData(HttpServletRequest request) {
    try {
        BarangDao barangDao = new BarangDao();
        String searchAction = request.getParameter("action");
        String keyword = request.getParameter("keyword");
        String categoryId = request.getParameter("categoryId");
        String pageStr = request.getParameter("pageNum");
        
        int currentPage = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }
        
        ArrayList<Book> allBooks;
        String selectedCategoryName = "Semua Kategori";
        
        // Handle different actions
        if ("search".equals(searchAction) && !ValidationConf.isEmpty(keyword)) {
            allBooks = barangDao.searchBooks(keyword);
            request.setAttribute("searchKeyword", keyword);
        } else if ("filter".equals(searchAction) && !ValidationConf.isEmpty(categoryId)) {
            allBooks = barangDao.getBooksByCategory(Integer.parseInt(categoryId));
            request.setAttribute("selectedCategory", categoryId);
            
            // Get category name for display
            ArrayList<Category> categories = barangDao.getAllCategories();
            for (Category cat : categories) {
                if (cat.getCategory_id() == Integer.parseInt(categoryId)) {
                    selectedCategoryName = cat.getName();
                    break;
                }
            }
        } else {
            allBooks = barangDao.getAllBooksWithDetails();
        }
        
        // Implement pagination
        int totalItems = allBooks.size();
        int totalPages = (int) Math.ceil((double) totalItems / ITEMS_PER_PAGE);
        int startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
        int endIndex = Math.min(startIndex + ITEMS_PER_PAGE, totalItems);
        
        ArrayList<Book> paginatedBooks = new ArrayList<>();
        if (startIndex < totalItems) {
            for (int i = startIndex; i < endIndex; i++) {
                paginatedBooks.add(allBooks.get(i));
            }
        }
        
        // Load all necessary data for the page
        request.setAttribute("books", paginatedBooks);
        request.setAttribute("authors", barangDao.getAllAuthors());
        request.setAttribute("categories", barangDao.getAllCategories());
        request.setAttribute("publishers", barangDao.getAllPublishers());
        
        // Pagination attributes
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);
        request.setAttribute("itemsPerPage", ITEMS_PER_PAGE);
        
        // Statistics for dashboard
        request.setAttribute("totalBooks", totalItems);
        request.setAttribute("lowStockBooks", getLowStockCount(allBooks));
        request.setAttribute("outOfStockBooks", getOutOfStockCount(allBooks));
        request.setAttribute("selectedCategoryName", selectedCategoryName);
        
    } catch (Exception e) {
        request.setAttribute("error", "Failed to load barang data: " + e.getMessage());
    }
}

/**
 * Load dashboard data for admin home page
 */
private void loadDashboardData(HttpServletRequest request) {
    try {
        UsersDao userDao = new UsersDao();
        BarangDao barangDao = new BarangDao();
        
        // Get user statistics
        request.setAttribute("totalAdmins", userDao.getAllAdmins().size());
        request.setAttribute("totalStaff", userDao.getAllStaff().size());
        request.setAttribute("totalCustomers", userDao.getAllCustomers().size());
        
        // Get book statistics
        ArrayList<Book> allBooks = barangDao.getAllBooksWithDetails();
        request.setAttribute("totalBooks", allBooks.size());
        request.setAttribute("lowStockBooks", getLowStockCount(allBooks));
        request.setAttribute("outOfStockBooks", getOutOfStockCount(allBooks));
        
    } catch (Exception e) {
        request.setAttribute("dashboardError", "Failed to load dashboard data: " + e.getMessage());
    }
}

/**
 * Load all Admin and Staff data for management page with pagination
 */
private void loadAllUserAdminPageData(HttpServletRequest request) {
    try {
        UsersDao userDao = new UsersDao();
        String filter = request.getParameter("filter");
        String pageStr = request.getParameter("pageNum");
        
        int currentPage = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }
        
        ArrayList<Users> allAdmins = new ArrayList<>();
        ArrayList<Users> allStaff = new ArrayList<>();
        
        if ("admin".equals(filter)) {
            allAdmins = userDao.getAllAdmins();
        } else if ("staff".equals(filter)) {
            allStaff = userDao.getAllStaff();
        } else {
            allAdmins = userDao.getAllAdmins();
            allStaff = userDao.getAllStaff();
        }
        
        // Combine all users for pagination
        ArrayList<Users> allUsers = new ArrayList<>();
        allUsers.addAll(allAdmins);
        allUsers.addAll(allStaff);
        
        // Implement pagination
        int totalItems = allUsers.size();
        int totalPages = (int) Math.ceil((double) totalItems / ITEMS_PER_PAGE);
        int startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
        int endIndex = Math.min(startIndex + ITEMS_PER_PAGE, totalItems);
        
        // Separate paginated results back to admin and staff
        ArrayList<Users> paginatedAdmins = new ArrayList<>();
        ArrayList<Users> paginatedStaff = new ArrayList<>();
        
        if (startIndex < totalItems) {
            for (int i = startIndex; i < endIndex; i++) {
                Users user = allUsers.get(i);
                if (user.getRole() == UserRoles.ADMIN) {
                    paginatedAdmins.add(user);
                } else if (user.getRole() == UserRoles.STAFF) {
                    paginatedStaff.add(user);
                }
            }
        }
        
        request.setAttribute("adminList", paginatedAdmins);
        request.setAttribute("staffList", paginatedStaff);
        request.setAttribute("totalAdmins", allAdmins.size());
        request.setAttribute("totalStaff", allStaff.size());
        
        // Pagination attributes
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);
        request.setAttribute("itemsPerPage", ITEMS_PER_PAGE);
        
    } catch (Exception e) {
        request.setAttribute("error", "Failed to load admin/staff data: " + e.getMessage());
    }
}

/**
 * Load all Customer data for management page with pagination - SIMPLIFIED tanpa address
 */
private void loadAllUserCustomerPageData(HttpServletRequest request) {
    try {
        UsersDao userDao = new UsersDao();
        String filter = request.getParameter("filter");
        String pageStr = request.getParameter("pageNum");
        
        int currentPage = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }
        
        ArrayList<Customer> allCustomers;
        
        if ("male".equals(filter)) {
            // Filter by male customers
            ArrayList<Users> maleUsers = userDao.getUsersByGenderAndRole("Male", UserRoles.CUSTOMER);
            allCustomers = new ArrayList<>();
            for (Users user : maleUsers) {
                Customer customer = userDao.getCustomerById(user.getUserId());
                if (customer != null) {
                    allCustomers.add(customer);
                }
            }
        } else if ("female".equals(filter)) {
            // Filter by female customers
            ArrayList<Users> femaleUsers = userDao.getUsersByGenderAndRole("Female", UserRoles.CUSTOMER);
            allCustomers = new ArrayList<>();
            for (Users user : femaleUsers) {
                Customer customer = userDao.getCustomerById(user.getUserId());
                if (customer != null) {
                    allCustomers.add(customer);
                }
            }
        } else {
            // Get all customers with basic details (tanpa address)
            allCustomers = userDao.getAllCustomersBasic();
        }
        
        // Implement pagination
        int totalItems = allCustomers.size();
        int totalPages = (int) Math.ceil((double) totalItems / ITEMS_PER_PAGE);
        int startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
        int endIndex = Math.min(startIndex + ITEMS_PER_PAGE, totalItems);
        
        ArrayList<Customer> paginatedCustomers = new ArrayList<>();
        if (startIndex < totalItems) {
            for (int i = startIndex; i < endIndex; i++) {
                paginatedCustomers.add(allCustomers.get(i));
            }
        }
        
        // Set statistics
        int totalCustomers = userDao.getTotalUsersByRole(UserRoles.CUSTOMER);
        
        request.setAttribute("customerList", paginatedCustomers);
        request.setAttribute("totalCustomers", totalCustomers);
        
        // Pagination attributes
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);
        request.setAttribute("itemsPerPage", ITEMS_PER_PAGE);
        
    } catch (Exception e) {
        request.setAttribute("error", "Failed to load customer data: " + e.getMessage());
    }
}

// ===== HELPER METHODS =====

private int getLowStockCount(ArrayList<Book> books) {
    int count = 0;
    for (Book book : books) {
        if (book.getStock() > 0 && book.getStock() <= 10) {
            count++;
        }
    }
    return count;
}

private int getOutOfStockCount(ArrayList<Book> books) {
    int count = 0;
    for (Book book : books) {
        if (book.getStock() == 0) {
            count++;
        }
    }
    return count;
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
    return "Admin Router Servlet with pagination support";
}
}
