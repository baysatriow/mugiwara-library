package Servlet;

import DAO.ReviewDAO;
import Models.Review;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ReviewServlet", urlPatterns = {"/reviews", "/ratings"})
public class ReviewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        ReviewDAO reviewDAO = new ReviewDAO();
        String action = request.getParameter("action");
        
        try {
            if ("book".equals(action)) {
                // Get reviews for specific book
                String bookIdStr = request.getParameter("bookId");
                if (bookIdStr != null) {
                    int bookId = Integer.parseInt(bookIdStr);
                    ArrayList<Review> bookReviews = reviewDAO.getReviewsByBook(bookId);
                    double averageRating = reviewDAO.getAverageRating(bookId);
                    int totalReviews = reviewDAO.getTotalReviews(bookId);
                    
                    request.setAttribute("bookReviews", bookReviews);
                    request.setAttribute("averageRating", averageRating);
                    request.setAttribute("totalReviews", totalReviews);
                    request.setAttribute("bookId", bookId);
                    
                    request.getRequestDispatcher("book_reviews.jsp").forward(request, response);
                    return;
                }
            }
            
            // Default: Get all reviews for main review page
            ArrayList<Review> allReviews = reviewDAO.getReviewsWithDetails();
            request.setAttribute("allReviews", allReviews);
            
            // Forward to review.jsp
            request.getRequestDispatcher("review.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("error", "Error loading reviews: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Handle review submission
        String action = request.getParameter("action");
        
        if ("submit".equals(action)) {
            try {
                int bookId = Integer.parseInt(request.getParameter("bookId"));
                int userId = Integer.parseInt(request.getParameter("userId"));
                int rating = Integer.parseInt(request.getParameter("rating"));
                String comment = request.getParameter("comment");
                
                Review review = new Review(bookId, userId, rating, comment);
                ReviewDAO reviewDAO = new ReviewDAO();
                
                // Insert review (you'll need to implement insert method in ReviewDAO)
                // For now, we'll redirect back to reviews
                
                response.sendRedirect("reviews");
                
            } catch (Exception e) {
                request.setAttribute("error", "Error submitting review: " + e.getMessage());
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } else {
            doGet(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Review Servlet for Mugiwara Library";
    }
}
