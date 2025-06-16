package Servlet;

import DAO.BookDAO;
import DAO.ReviewDAO;
import Models.Book;
import Models.Review;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ContentHomeServlet", urlPatterns = {"/home", "/index"})
public class ContentHomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        BookDAO bookDAO = new BookDAO();
        ReviewDAO reviewDAO = new ReviewDAO();
        
        try {
            // Get latest books (limit 12 for carousel)
            ArrayList<Book> latestBooks = bookDAO.getLatestBooks(12);
            request.setAttribute("latestBooks", latestBooks);
            
            // Get best selling books (limit 12 for carousel)
            ArrayList<Book> bestSellingBooks = bookDAO.getBestSellingBooks(12);
            request.setAttribute("bestSellingBooks", bestSellingBooks);
            
            // Get customer reviews (limit 6 for testimonials)
            ArrayList<Review> customerReviews = reviewDAO.getReviewsWithDetails();
            if (customerReviews.size() > 6) {
                customerReviews = new ArrayList<>(customerReviews.subList(0, 6));
            }
            request.setAttribute("customerReviews", customerReviews);
            
            // Forward to index.jsp
            request.getRequestDispatcher("index.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("error", "Error loading home page content: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Content Home Servlet for Mugiwara Library";
    }
}
