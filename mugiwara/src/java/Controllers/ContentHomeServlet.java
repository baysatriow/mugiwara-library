package Controllers;

import DAO.BookDAO;
import DAO.ReviewDAO;
import DAO.BannerSlideDAO;
import Models.Book;
import Models.Review;
import Models.BannerSlide;
import Config.ErrorHandler;
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
        
        // Initialize with empty collections as fallback
        ArrayList<Book> latestBooks = new ArrayList<>();
        ArrayList<Book> bestSellingBooks = new ArrayList<>();
        ArrayList<Review> customerReviews = new ArrayList<>();
        ArrayList<BannerSlide> activeBanners = new ArrayList<>();
        
        // Track loading status for debugging
        boolean latestBooksLoaded = false;
        boolean bestSellingBooksLoaded = false;
        boolean reviewsLoaded = false;
        boolean bannersLoaded = false;
        
        try {
            // Load active banners with error handling
            try {
                BannerSlideDAO bannerDAO = new BannerSlideDAO();
                activeBanners = bannerDAO.getActiveBanners();
                
                if (activeBanners != null && !activeBanners.isEmpty()) {
                    bannersLoaded = true;
                    System.out.println("Successfully loaded " + activeBanners.size() + " active banners");
                } else {
                    activeBanners = new ArrayList<>();
                    System.out.println("No active banners found or null result");
                }
            } catch (Exception e) {
                System.err.println("Error loading active banners: " + e.getMessage());
                e.printStackTrace();
                activeBanners = new ArrayList<>();
            }
            
            // Load latest books with error handling
            try {
                BookDAO bookDAO = new BookDAO();
                latestBooks = bookDAO.getLatestBooks(12);
                
                if (latestBooks != null && !latestBooks.isEmpty()) {
                    latestBooksLoaded = true;
                    System.out.println("Successfully loaded " + latestBooks.size() + " latest books");
                } else {
                    latestBooks = new ArrayList<>();
                    System.out.println("No latest books found or null result");
                }
            } catch (Exception e) {
                System.err.println("Error loading latest books: " + e.getMessage());
                e.printStackTrace();
                latestBooks = new ArrayList<>();
            }
            
            // Load best selling books with error handling
            try {
                BookDAO bookDAO = new BookDAO();
                bestSellingBooks = bookDAO.getBestSellingBooks(12);
                
                if (bestSellingBooks != null && !bestSellingBooks.isEmpty()) {
                    bestSellingBooksLoaded = true;
                    System.out.println("Successfully loaded " + bestSellingBooks.size() + " best selling books");
                } else {
                    bestSellingBooks = new ArrayList<>();
                    System.out.println("No best selling books found or null result");
                }
            } catch (Exception e) {
                System.err.println("Error loading best selling books: " + e.getMessage());
                e.printStackTrace();
                bestSellingBooks = new ArrayList<>();
            }
            
            // Load customer reviews with error handling
            try {
                ReviewDAO reviewDAO = new ReviewDAO();
                ArrayList<Review> allReviews = reviewDAO.getReviewsWithDetails();
                
                if (allReviews != null && !allReviews.isEmpty()) {
                    // Limit to 6 reviews for testimonials
                    customerReviews = new ArrayList<>();
                    int maxReviews = Math.min(6, allReviews.size());
                    for (int i = 0; i < maxReviews; i++) {
                        Review review = allReviews.get(i);
                        if (review != null) {
                            customerReviews.add(review);
                        }
                    }
                    reviewsLoaded = true;
                    System.out.println("Successfully loaded " + customerReviews.size() + " customer reviews");
                } else {
                    customerReviews = new ArrayList<>();
                    System.out.println("No customer reviews found or null result");
                }
            } catch (Exception e) {
                System.err.println("Error loading customer reviews: " + e.getMessage());
                e.printStackTrace();
                customerReviews = new ArrayList<>();
            }
            
            // Set attributes with guaranteed non-null values
            request.setAttribute("latestBooks", latestBooks);
            request.setAttribute("bestSellingBooks", bestSellingBooks);
            request.setAttribute("customerReviews", customerReviews);
            request.setAttribute("activeBanners", activeBanners);
            
            // Set loading status for debugging
            request.setAttribute("latestBooksLoaded", latestBooksLoaded);
            request.setAttribute("bestSellingBooksLoaded", bestSellingBooksLoaded);
            request.setAttribute("reviewsLoaded", reviewsLoaded);
            request.setAttribute("bannersLoaded", bannersLoaded);
            
            // Set page metadata
            request.setAttribute("pageTitle", "Mugiwara Library - Toko Buku Online Terpercaya");
            request.setAttribute("pageDescription", "Temukan koleksi buku terlengkap dengan harga terbaik di Mugiwara Library");
            
            System.out.println("Home page data loaded successfully - Latest: " + latestBooks.size() + 
                             ", Bestsellers: " + bestSellingBooks.size() + 
                             ", Reviews: " + customerReviews.size() +
                             ", Banners: " + activeBanners.size());
            
            // Forward to index.jsp
            request.getRequestDispatcher("index.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Critical error in ContentHomeServlet: " + e.getMessage());
            e.printStackTrace();
            
            // Even on critical error, try to show the page with empty data
            request.setAttribute("latestBooks", latestBooks);
            request.setAttribute("bestSellingBooks", bestSellingBooks);
            request.setAttribute("customerReviews", customerReviews);
            request.setAttribute("activeBanners", activeBanners);
            request.setAttribute("criticalError", true);
            request.setAttribute("errorMessage", "Terjadi kesalahan saat memuat data. Beberapa konten mungkin tidak tersedia.");
            
            try {
                request.getRequestDispatcher("index.jsp").forward(request, response);
            } catch (Exception forwardError) {
                // Last resort - redirect to error page
                ErrorHandler.handleDatabaseError(request, response, 
                    "Critical error loading home page: " + e.getMessage(), e);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Content Home Servlet for Mugiwara Library - Handles home page data loading including banners";
    }
}
