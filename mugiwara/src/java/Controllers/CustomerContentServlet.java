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

@WebServlet(name = "CustomerContentServlet", urlPatterns = {"/CustomerContent", "/"})
public class CustomerContentServlet extends HttpServlet {

    private static final int ITEMS_PER_PAGE = 12;

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
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "home";
        }
        
        try {
            switch (action) {
                case "home":
                    loadHomePage(request);
                    break;
                    
                case "search":
                    loadSearchResults(request);
                    break;
                    
                case "filter":
                    loadFilteredResults(request);
                    break;
                    
                case "latest":
                    loadLatestBooks(request);
                    break;
                    
                case "bestseller":
                    loadBestsellerBooks(request);
                    break;
                    
                default:
                    loadHomePage(request);
                    break;
            }
            
            // Forward to index.jsp
            request.getRequestDispatcher("index.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading page: " + e.getMessage());
        }
    }

    /**
     * Load home page with latest books, bestsellers, and reviews
     */
    private void loadHomePage(HttpServletRequest request) {
        try {
            BarangDao barangDao = new BarangDao();
            ReviewDao reviewDao = new ReviewDao();
            
            // Get latest books (limit 12 for carousel)
            ArrayList<Book> latestBooks = getLatestBooks(barangDao, 12);
            
            // Get bestseller books (books with high ratings/reviews)
            ArrayList<Book> bestsellerBooks = getBestsellerBooks(barangDao, reviewDao, 12);
            
            // Get customer reviews for testimonials
            ArrayList<Review> customerReviews = reviewDao.getRecentReviews(9); // 3 slides x 3 reviews
            
            // Get categories for dropdown
            ArrayList<Category> categories = barangDao.getAllCategories();
            
            // Add review statistics to books
            addReviewStatistics(latestBooks, reviewDao);
            addReviewStatistics(bestsellerBooks, reviewDao);
            
            // Set attributes
            request.setAttribute("latestBooks", latestBooks);
            request.setAttribute("bestsellerBooks", bestsellerBooks);
            request.setAttribute("customerReviews", customerReviews);
            request.setAttribute("categories", categories);
            
            // Get cart count if user is logged in
            HttpSession session = request.getSession();
            Users currentUser = (Users) session.getAttribute("user");
            if (currentUser != null) {
                int cartCount = getCartCount(currentUser.getUserId());
                request.setAttribute("cartCount", cartCount);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Load search results
     */
    private void loadSearchResults(HttpServletRequest request) {
        try {
            BarangDao barangDao = new BarangDao();
            ReviewDao reviewDao = new ReviewDao();
            
            String searchQuery = request.getParameter("search");
            
            if (!ValidationConf.isEmpty(searchQuery)) {
                ArrayList<Book> searchResults = barangDao.searchBooks(searchQuery.trim());
                addReviewStatistics(searchResults, reviewDao);
                
                request.setAttribute("latestBooks", searchResults);
                request.setAttribute("searchQuery", searchQuery);
                request.setAttribute("searchResults", true);
            } else {
                loadHomePage(request);
            }
            
            // Get categories for dropdown
            ArrayList<Category> categories = barangDao.getAllCategories();
            request.setAttribute("categories", categories);
            
        } catch (Exception e) {
            e.printStackTrace();
            loadHomePage(request);
        }
    }

    /**
     * Load filtered results by category
     */
    private void loadFilteredResults(HttpServletRequest request) {
        try {
            BarangDao barangDao = new BarangDao();
            ReviewDao reviewDao = new ReviewDao();
            
            String categoryId = request.getParameter("category");
            
            if (!ValidationConf.isEmpty(categoryId)) {
                ArrayList<Book> filteredBooks = barangDao.getBooksByCategory(Integer.parseInt(categoryId));
                addReviewStatistics(filteredBooks, reviewDao);
                
                request.setAttribute("latestBooks", filteredBooks);
                request.setAttribute("filteredCategory", categoryId);
                request.setAttribute("filterResults", true);
            } else {
                loadHomePage(request);
            }
            
            // Get categories for dropdown
            ArrayList<Category> categories = barangDao.getAllCategories();
            request.setAttribute("categories", categories);
            
        } catch (Exception e) {
            e.printStackTrace();
            loadHomePage(request);
        }
    }

    /**
     * Load all latest books
     */
    private void loadLatestBooks(HttpServletRequest request) {
        try {
            BarangDao barangDao = new BarangDao();
            ReviewDao reviewDao = new ReviewDao();
            
            ArrayList<Book> latestBooks = getLatestBooks(barangDao, 50); // More books for "Lihat Semua"
            addReviewStatistics(latestBooks, reviewDao);
            
            request.setAttribute("latestBooks", latestBooks);
            request.setAttribute("pageTitle", "Buku Terbaru");
            request.setAttribute("showAllLatest", true);
            
            // Get categories for dropdown
            ArrayList<Category> categories = barangDao.getAllCategories();
            request.setAttribute("categories", categories);
            
        } catch (Exception e) {
            e.printStackTrace();
            loadHomePage(request);
        }
    }

    /**
     * Load all bestseller books
     */
    private void loadBestsellerBooks(HttpServletRequest request) {
        try {
            BarangDao barangDao = new BarangDao();
            ReviewDao reviewDao = new ReviewDao();
            
            ArrayList<Book> bestsellerBooks = getBestsellerBooks(barangDao, reviewDao, 50);
            addReviewStatistics(bestsellerBooks, reviewDao);
            
            request.setAttribute("bestsellerBooks", bestsellerBooks);
            request.setAttribute("pageTitle", "Buku Terlaris");
            request.setAttribute("showAllBestseller", true);
            
            // Get categories for dropdown
            ArrayList<Category> categories = barangDao.getAllCategories();
            request.setAttribute("categories", categories);
            
        } catch (Exception e) {
            e.printStackTrace();
            loadHomePage(request);
        }
    }

    // Helper methods
    private ArrayList<Book> getLatestBooks(BarangDao barangDao, int limit) {
        try {
            ArrayList<Book> allBooks = barangDao.getAllBooksWithDetails();
            ArrayList<Book> latestBooks = new ArrayList<>();
            
            // Sort by book_id descending (assuming higher ID = newer)
            allBooks.sort((a, b) -> Integer.compare(b.getBook_id(), a.getBook_id()));
            
            int count = Math.min(limit, allBooks.size());
            for (int i = 0; i < count; i++) {
                latestBooks.add(allBooks.get(i));
            }
            
            return latestBooks;
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }

    private ArrayList<Book> getBestsellerBooks(BarangDao barangDao, ReviewDao reviewDao, int limit) {
        try {
            ArrayList<Book> allBooks = barangDao.getAllBooksWithDetails();
            ArrayList<Book> bestsellerBooks = new ArrayList<>();
            
            // Add review statistics and sort by rating/review count
            for (Book book : allBooks) {
                double avgRating = reviewDao.getAverageRating(book.getBook_id());
                int reviewCount = reviewDao.getReviewCount(book.getBook_id());
                book.setAverageRating(avgRating);
                book.setReviewCount(reviewCount);
                
                // Calculate bestseller score (rating * review count)
                double bestsellerScore = avgRating * reviewCount;
                book.setBestsellerScore(bestsellerScore);
            }
            
            // Sort by bestseller score descending
            allBooks.sort((a, b) -> Double.compare(b.getBestsellerScore(), a.getBestsellerScore()));
            
            int count = Math.min(limit, allBooks.size());
            for (int i = 0; i < count; i++) {
                bestsellerBooks.add(allBooks.get(i));
            }
            
            return bestsellerBooks;
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }

    private void addReviewStatistics(ArrayList<Book> books, ReviewDao reviewDao) {
        try {
            for (Book book : books) {
                double avgRating = reviewDao.getAverageRating(book.getBook_id());
                int reviewCount = reviewDao.getReviewCount(book.getBook_id());
                book.setAverageRating(avgRating);
                book.setReviewCount(reviewCount);
            }
        } catch (Exception e) {
            // Continue without review statistics
        }
    }

    private int getCartCount(int userId) {
        try {
            // This would typically query a cart table
            // For now, return 0 as placeholder
            return 0;
        } catch (Exception e) {
            return 0;
        }
    }

    @Override
    public String getServletInfo() {
        return "Customer Content Servlet for Homepage";
    }
}
