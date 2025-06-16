package Controllers;

import DAO.BarangDao;
import DAO.ReviewDao;
import DAO.UsersDao;
import Models.*;
import Config.ValidationConf;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ContentPageServlet", urlPatterns = {"/Admin"})
public class ContentPageServlet extends HttpServlet {
    
    private static final int ITEMS_PER_PAGE = 10;
    
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
    
    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("user");
        
        // Check if user is logged in and has admin/staff role
        if (currentUser == null || 
            (currentUser.getRole() != UserRoles.ADMIN && currentUser.getRole() != UserRoles.STAFF)) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String page = request.getParameter("page");
        String action = request.getParameter("action");
        
        if (page == null) {
            page = "home";
        }
        
        try {
            switch (page) {
                case "home":
                    loadHomePage(request);
                    request.setAttribute("content", "home");
                    break;
                    
                case "statistik":
                    loadStatistikPage(request);
                    request.setAttribute("content", "statistik");
                    break;
                    
                case "barang":
                    loadBarangPage(request, action);
                    request.setAttribute("content", "barang");
                    break;
                    
                case "manageuserstaff":
                    loadManageUserStaffPage(request);
                    request.setAttribute("content", "manageuserstaff");
                    break;
                    
                case "managecustomer":
                    loadManageCustomerPage(request);
                    request.setAttribute("content", "managecustomer");
                    break;
                    
                case "setting":
                    loadSettingPage(request);
                    request.setAttribute("content", "setting");
                    break;
                    
                default:
                    loadHomePage(request);
                    request.setAttribute("content", "home");
                    break;
            }
            
            // Forward to index.jsp
            request.getRequestDispatcher("Admin/index.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            setNotificationMessage(request, "error", "Terjadi kesalahan sistem: " + e.getMessage());
            request.setAttribute("content", "home");
            request.getRequestDispatcher("Admin/index.jsp").forward(request, response);
        }
    }
    
    /**
     * Load home page data with dashboard statistics
     */
    private void loadHomePage(HttpServletRequest request) {
        try {
            BarangDao barangDao = new BarangDao();
            UsersDao usersDao = new UsersDao();
            ReviewDao reviewDao = new ReviewDao();
            
            // Get statistics
            int totalBooks = getTotalBooks(barangDao);
            int totalUsers = getTotalUsers(usersDao);
            int totalAdmins = usersDao.getTotalUsersByRole(UserRoles.ADMIN);
            int totalStaff = usersDao.getTotalUsersByRole(UserRoles.STAFF);
            int totalCustomers = usersDao.getTotalUsersByRole(UserRoles.CUSTOMER);
            int totalReviews = getTotalReviews(reviewDao);
            
            // Get recent data
            ArrayList<Book> recentBooks = getRecentBooks(barangDao, 5);
            ArrayList<Review> recentReviews = reviewDao.getRecentReviews(5);
            ArrayList<Users> recentUsers = usersDao.getRecentUsersByRole(UserRoles.CUSTOMER, 5);
            ArrayList<Book> topRatedBooks = reviewDao.getTopRatedBooks(5);
            
            // Get books with low stock
            ArrayList<Book> lowStockBooks = getLowStockBooks(barangDao, 10);
            
            // Set attributes for dashboard
            request.setAttribute("totalBooks", totalBooks);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalAdmins", totalAdmins);
            request.setAttribute("totalStaff", totalStaff);
            request.setAttribute("totalCustomers", totalCustomers);
            request.setAttribute("totalReviews", totalReviews);
            
            request.setAttribute("recentBooks", recentBooks);
            request.setAttribute("recentReviews", recentReviews);
            request.setAttribute("recentUsers", recentUsers);
            request.setAttribute("topRatedBooks", topRatedBooks);
            request.setAttribute("lowStockBooks", lowStockBooks);
            
            // Calculate percentages for charts
            double booksPercentage = calculateBooksGrowth(barangDao);
            double usersPercentage = calculateUsersGrowth(usersDao);
            double reviewsPercentage = calculateReviewsGrowth(reviewDao);
            
            request.setAttribute("booksGrowth", booksPercentage);
            request.setAttribute("usersGrowth", usersPercentage);
            request.setAttribute("reviewsGrowth", reviewsPercentage);
            
        } catch (Exception e) {
            setNotificationMessage(request, "error", "Gagal memuat data dashboard: " + e.getMessage());
        }
    }
    
    /**
     * Load statistik page with detailed analytics
     */
    private void loadStatistikPage(HttpServletRequest request) {
        try {
            BarangDao barangDao = new BarangDao();
            UsersDao usersDao = new UsersDao();
            ReviewDao reviewDao = new ReviewDao();
            
            // Get detailed statistics
            ArrayList<Book> allBooks = barangDao.getAllBooksWithDetails();
            ArrayList<Users> allUsers = usersDao.getAllUsersWithRoleDetails();
            ArrayList<Review> allReviews = reviewDao.getAllReviewsWithDetails();
            
            // Category statistics
            int[] categoryStats = getCategoryStatistics(barangDao);
            
            // Monthly statistics
            int[] monthlyBookStats = getMonthlyBookStatistics(barangDao);
            int[] monthlyUserStats = getMonthlyUserStatistics(usersDao);
            int[] monthlyReviewStats = getMonthlyReviewStatistics(reviewDao);
            
            // Rating distribution
            int[] ratingDistribution = getRatingDistribution(reviewDao);
            
            request.setAttribute("allBooks", allBooks);
            request.setAttribute("allUsers", allUsers);
            request.setAttribute("allReviews", allReviews);
            request.setAttribute("categoryStats", categoryStats);
            request.setAttribute("monthlyBookStats", monthlyBookStats);
            request.setAttribute("monthlyUserStats", monthlyUserStats);
            request.setAttribute("monthlyReviewStats", monthlyReviewStats);
            request.setAttribute("ratingDistribution", ratingDistribution);
            
        } catch (Exception e) {
            setNotificationMessage(request, "error", "Gagal memuat data statistik: " + e.getMessage());
        }
    }
    
    /**
     * Load barang page with books data
     */
    private void loadBarangPage(HttpServletRequest request, String action) {
        try {
            BarangDao barangDao = new BarangDao();
            ReviewDao reviewDao = new ReviewDao();
            
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
            
            ArrayList<Book> books;
            String selectedCategoryName = "Semua Kategori";
            
            // Handle different actions
            if ("search".equals(action) && !ValidationConf.isEmpty(keyword)) {
                books = barangDao.searchBooks(keyword);
                request.setAttribute("searchKeyword", keyword);
            } else if ("filter".equals(action) && !ValidationConf.isEmpty(categoryId)) {
                books = barangDao.getBooksByCategory(Integer.parseInt(categoryId));
                // Get category name
                selectedCategoryName = getCategoryName(barangDao, Integer.parseInt(categoryId));
            } else {
                books = barangDao.getAllBooksWithDetails();
            }
            
            // Add review statistics to books
            for (Book book : books) {
                double avgRating = reviewDao.getAverageRating(book.getBook_id());
                int reviewCount = reviewDao.getReviewCount(book.getBook_id());
                book.setAverageRating(avgRating);
                book.setReviewCount(reviewCount);
            }
            
            // Pagination
            int totalItems = books.size();
            int totalPages = (int) Math.ceil((double) totalItems / ITEMS_PER_PAGE);
            int startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
            int endIndex = Math.min(startIndex + ITEMS_PER_PAGE, totalItems);
            
            ArrayList<Book> paginatedBooks = new ArrayList<>();
            if (startIndex < totalItems) {
                for (int i = startIndex; i < endIndex; i++) {
                    paginatedBooks.add(books.get(i));
                }
            }
            
            // Get additional data for the page
            ArrayList<Author> authors = barangDao.getAllAuthors();
            ArrayList<Category> categories = barangDao.getAllCategories();
            ArrayList<Publisher> publishers = barangDao.getAllPublishers();
            
            // Set attributes
            request.setAttribute("books", paginatedBooks);
            request.setAttribute("authors", authors);
            request.setAttribute("categories", categories);
            request.setAttribute("publishers", publishers);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalItems", totalItems);
            request.setAttribute("selectedCategoryName", selectedCategoryName);
            
            // Stock statistics
            int lowStockBooks = getLowStockCount(barangDao);
            int outOfStockBooks = getOutOfStockCount(barangDao);
            
            request.setAttribute("lowStockBooks", lowStockBooks);
            request.setAttribute("outOfStockBooks", outOfStockBooks);
            
        } catch (Exception e) {
            setNotificationMessage(request, "error", "Gagal memuat data buku: " + e.getMessage());
        }
    }
    
    /**
     * Load manage user staff page
     */
    private void loadManageUserStaffPage(HttpServletRequest request) {
        try {
            UsersDao usersDao = new UsersDao();
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
            
            ArrayList<Users> adminList = new ArrayList<>();
            ArrayList<Users> staffList = new ArrayList<>();
            
            if ("admin".equals(filter)) {
                adminList = usersDao.getAllAdmins();
            } else if ("staff".equals(filter)) {
                staffList = usersDao.getAllStaff();
            } else {
                adminList = usersDao.getAllAdmins();
                staffList = usersDao.getAllStaff();
            }
            
            // Combine for pagination
            ArrayList<Users> allUsers = new ArrayList<>();
            allUsers.addAll(adminList);
            allUsers.addAll(staffList);
            
            // Pagination
            int totalItems = allUsers.size();
            int totalPages = (int) Math.ceil((double) totalItems / ITEMS_PER_PAGE);
            
            request.setAttribute("adminList", adminList);
            request.setAttribute("staffList", staffList);
            request.setAttribute("totalAdmins", adminList.size());
            request.setAttribute("totalStaff", staffList.size());
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalItems", totalItems);
            
        } catch (Exception e) {
            setNotificationMessage(request, "error", "Gagal memuat data admin/staff: " + e.getMessage());
        }
    }
    
    /**
     * Load manage customer page
     */
    private void loadManageCustomerPage(HttpServletRequest request) {
        try {
            UsersDao usersDao = new UsersDao();
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
            
            ArrayList<Users> customerList;
            
            if ("male".equals(filter)) {
                customerList = usersDao.getUsersByGenderAndRole("Male", UserRoles.CUSTOMER);
            } else if ("female".equals(filter)) {
                customerList = usersDao.getUsersByGenderAndRole("Female", UserRoles.CUSTOMER);
            } else {
                customerList = usersDao.getAllCustomers();
            }
            
            // Pagination
            int totalItems = customerList.size();
            int totalPages = (int) Math.ceil((double) totalItems / ITEMS_PER_PAGE);
            int startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
            int endIndex = Math.min(startIndex + ITEMS_PER_PAGE, totalItems);
            
            ArrayList<Users> paginatedCustomers = new ArrayList<>();
            if (startIndex < totalItems) {
                for (int i = startIndex; i < endIndex; i++) {
                    paginatedCustomers.add(customerList.get(i));
                }
            }
            
            request.setAttribute("customerList", paginatedCustomers);
            request.setAttribute("totalCustomers", customerList.size());
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalItems", totalItems);
            
        } catch (Exception e) {
            setNotificationMessage(request, "error", "Gagal memuat data customer: " + e.getMessage());
        }
    }
    
    /**
     * Load setting page
     */
    private void loadSettingPage(HttpServletRequest request) {
        // Load system settings
        request.setAttribute("systemName", "Mugiwara Library");
        request.setAttribute("version", "1.0.0");
        request.setAttribute("itemsPerPage", ITEMS_PER_PAGE);
        request.setAttribute("maxFileSize", "10MB");
    }
    
    // Helper methods
    private int getTotalBooks(BarangDao barangDao) {
        try {
            return barangDao.getAllBooksWithDetails().size();
        } catch (Exception e) {
            return 0;
        }
    }
    
    private int getTotalUsers(UsersDao usersDao) {
        try {
            return usersDao.getAllUsersWithRoleDetails().size();
        } catch (Exception e) {
            return 0;
        }
    }
    
    private int getTotalReviews(ReviewDao reviewDao) {
        try {
            return reviewDao.getAllReviewsWithDetails().size();
        } catch (Exception e) {
            return 0;
        }
    }
    
    private ArrayList<Book> getRecentBooks(BarangDao barangDao, int limit) {
        try {
            ArrayList<Book> allBooks = barangDao.getAllBooksWithDetails();
            ArrayList<Book> recentBooks = new ArrayList<>();
            
            int count = Math.min(limit, allBooks.size());
            for (int i = 0; i < count; i++) {
                recentBooks.add(allBooks.get(i));
            }
            
            return recentBooks;
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }
    
    private ArrayList<Book> getLowStockBooks(BarangDao barangDao, int threshold) {
        try {
            ArrayList<Book> allBooks = barangDao.getAllBooksWithDetails();
            ArrayList<Book> lowStockBooks = new ArrayList<>();
            
            for (Book book : allBooks) {
                if (book.getStock() <= threshold && book.getStock() > 0) {
                    lowStockBooks.add(book);
                }
            }
            
            return lowStockBooks;
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }
    
    private int getLowStockCount(BarangDao barangDao) {
        return getLowStockBooks(barangDao, 10).size();
    }
    
    private int getOutOfStockCount(BarangDao barangDao) {
        try {
            ArrayList<Book> allBooks = barangDao.getAllBooksWithDetails();
            int count = 0;
            
            for (Book book : allBooks) {
                if (book.getStock() == 0) {
                    count++;
                }
            }
            
            return count;
        } catch (Exception e) {
            return 0;
        }
    }
    
    private String getCategoryName(BarangDao barangDao, int categoryId) {
        try {
            ArrayList<Category> categories = barangDao.getAllCategories();
            for (Category category : categories) {
                if (category.getCategory_id() == categoryId) {
                    return category.getName();
                }
            }
        } catch (Exception e) {
            // Return default
        }
        return "Kategori";
    }
    
    private double calculateBooksGrowth(BarangDao barangDao) {
        // Simplified calculation - in real implementation, compare with previous period
        return 12.5; // Example percentage
    }
    
    private double calculateUsersGrowth(UsersDao usersDao) {
        // Simplified calculation - in real implementation, compare with previous period
        return 8.3; // Example percentage
    }
    
    private double calculateReviewsGrowth(ReviewDao reviewDao) {
        // Simplified calculation - in real implementation, compare with previous period
        return 15.7; // Example percentage
    }
    
    private int[] getCategoryStatistics(BarangDao barangDao) {
        // Return array of book counts per category
        // In real implementation, query database for actual statistics
        return new int[]{25, 18, 32, 15, 22}; // Example data
    }
    
    private int[] getMonthlyBookStatistics(BarangDao barangDao) {
        // Return array of monthly book additions
        return new int[]{5, 8, 12, 7, 15, 10, 18, 22, 16, 9, 13, 20}; // Example data
    }
    
    private int[] getMonthlyUserStatistics(UsersDao usersDao) {
        // Return array of monthly user registrations
        return new int[]{12, 18, 25, 15, 30, 22, 35, 28, 20, 16, 24, 32}; // Example data
    }
    
    private int[] getMonthlyReviewStatistics(ReviewDao reviewDao) {
        // Return array of monthly reviews
        return new int[]{8, 15, 22, 18, 25, 20, 30, 35, 28, 22, 26, 40}; // Example data
    }
    
    private int[] getRatingDistribution(ReviewDao reviewDao) {
        // Return array of rating counts [1-star, 2-star, 3-star, 4-star, 5-star]
        return new int[]{5, 8, 25, 45, 67}; // Example data
    }
    
    private void setNotificationMessage(HttpServletRequest request, String type, String message) {
        HttpSession session = request.getSession();
        session.setAttribute("notificationMsg", message);
        session.setAttribute("notificationType", type);
    }
    
    @Override
    public String getServletInfo() {
        return "Content Page Servlet for Admin Dashboard";
    }
}
