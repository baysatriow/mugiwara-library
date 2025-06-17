package Controllers;

import DAO.ReviewDAO;
import DAO.BookDAO;
import Models.Review;
import Models.Book;
import Config.ErrorHandler;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ReviewServlet", urlPatterns = {"/reviews", "/ratings"})
public class ReviewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        ReviewDAO reviewDAO = new ReviewDAO();
        String action = request.getParameter("action");
        
        try {
            if ("book".equals(action)) {
                handleBookReviews(request, response, reviewDAO);
                return;
            } else if ("latest".equals(action)) {
                handleLatestReviews(request, response, reviewDAO);
                return;
            }
            
            // Default: Get all reviews for main review page
            ArrayList<Review> allReviews = reviewDAO.getReviewsWithDetails();
            
            // Calculate some statistics
            int totalReviews = allReviews.size();
            double averageRating = calculateOverallAverageRating(allReviews);
            
            // Set attributes
            request.setAttribute("allReviews", allReviews);
            request.setAttribute("totalReviews", totalReviews);
            request.setAttribute("averageRating", averageRating);
            request.setAttribute("pageTitle", "Apa Kata Customer");
            request.setAttribute("pageDescription", "Lihat review dan rating dari customer kami");
            
            // Forward to review.jsp
            request.getRequestDispatcher("review.jsp").forward(request, response);
            
        } catch (Exception e) {
            ErrorHandler.handleDatabaseError(request, response, 
                "Error loading reviews: " + e.getMessage(), e);
        }
    }

    private void handleBookReviews(HttpServletRequest request, HttpServletResponse response, ReviewDAO reviewDAO)
            throws ServletException, IOException {
        
        String bookIdStr = request.getParameter("bookId");
        if (bookIdStr != null) {
            try {
                int bookId = Integer.parseInt(bookIdStr);
                
                // Get book details
                BookDAO bookDAO = new BookDAO();
                Book book = bookDAO.find(String.valueOf(bookId));
                
                if (book != null) {
                    // Get reviews for this book
                    ArrayList<Review> bookReviews = reviewDAO.getReviewsByBook(bookId);
                    double averageRating = reviewDAO.getAverageRating(bookId);
                    int totalReviews = reviewDAO.getTotalReviews(bookId);
                    
                    request.setAttribute("book", book);
                    request.setAttribute("bookReviews", bookReviews);
                    request.setAttribute("averageRating", averageRating);
                    request.setAttribute("totalReviews", totalReviews);
                    request.setAttribute("bookId", bookId);
                    
                    request.getRequestDispatcher("book_reviews.jsp").forward(request, response);
                } else {
                    ErrorHandler.handleNotFoundError(request, response, 
                        "Buku dengan ID " + bookId + " tidak ditemukan");
                }
            } catch (NumberFormatException e) {
                ErrorHandler.handleValidationError(request, response, 
                    "ID buku tidak valid: " + bookIdStr);
            }
        } else {
            ErrorHandler.handleValidationError(request, response, 
                "ID buku tidak boleh kosong");
        }
    }

    private void handleLatestReviews(HttpServletRequest request, HttpServletResponse response, ReviewDAO reviewDAO)
            throws ServletException, IOException {
        
        ArrayList<Review> latestReviews = reviewDAO.getLatestReviews(20);
        
        request.setAttribute("allReviews", latestReviews);
        request.setAttribute("totalReviews", latestReviews.size());
        request.setAttribute("pageTitle", "Review Terbaru");
        request.setAttribute("pageDescription", "Review terbaru dari customer kami");
        
        request.getRequestDispatcher("review.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            ErrorHandler.handleAuthenticationError(request, response, 
                "Anda harus login untuk memberikan review");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("submit".equals(action)) {
            handleSubmitReview(request, response, userId);
        } else {
            doGet(request, response);
        }
    }

    private void handleSubmitReview(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");
            
            // Validate input
            if (rating < 1 || rating > 5) {
                request.setAttribute("error", "Rating harus antara 1-5 bintang");
                doGet(request, response);
                return;
            }
            
            if (comment == null || comment.trim().isEmpty()) {
                comment = "Review tanpa komentar";
            }
            
            // Insert review using correct parameter names
            ReviewDAO reviewDAO = new ReviewDAO();
            boolean success = reviewDAO.insertReview(bookId, userId, rating, comment.trim());
            
            if (success) {
                // Redirect to book detail page with success message
                response.sendRedirect("books?action=detail&id=" + bookId + "&reviewSuccess=true");
            } else {
                request.setAttribute("error", "Gagal menyimpan review. Silakan coba lagi.");
                doGet(request, response);
            }
            
        } catch (NumberFormatException e) {
            ErrorHandler.handleValidationError(request, response, 
                "Data review tidak valid");
        } catch (Exception e) {
            ErrorHandler.handleDatabaseError(request, response, 
                "Error submitting review: " + e.getMessage(), e);
        }
    }

    private double calculateOverallAverageRating(ArrayList<Review> reviews) {
        if (reviews.isEmpty()) {
            return 0.0;
        }
        
        double totalRating = 0.0;
        for (Review review : reviews) {
            totalRating += review.getRating();
        }
        
        return totalRating / reviews.size();
    }

    @Override
    public String getServletInfo() {
        return "Review Servlet for Mugiwara Library";
    }
}
