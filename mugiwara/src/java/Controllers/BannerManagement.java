package Controllers;

import Models.BannerSlide;
import DAO.BannerSlideDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

@WebServlet(name = "BannerManagement", urlPatterns = {"/BannerManagement"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class BannerManagement extends HttpServlet {
    
    private BannerSlideDAO bannerDAO;
    private static final String UPLOAD_DIR = "uploads/banners";
    
    @Override
    public void init() throws ServletException {
        bannerDAO = new BannerSlideDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "getBanner":
                getBannerDetails(request, response);
                break;
            case "toggleStatus":
                toggleBannerStatus(request, response);
                break;
            case "delete":
                deleteBanner(request, response);
                break;
            case "debug":
                debugConnection(request, response);
                break;
            default:
                listBanners(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendRedirect("Admin?page=banner");
            return;
        }
        
        switch (action) {
            case "add":
                addBanner(request, response);
                break;
            case "update":
                updateBanner(request, response);
                break;
            case "updateOrder":
                updateBannerOrder(request, response);
                break;
            default:
                response.sendRedirect("Admin?page=banner");
                break;
        }
    }
    
    private void getBannerDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            String bannerIdStr = request.getParameter("bannerId");
            if (bannerIdStr == null || bannerIdStr.trim().isEmpty()) {
                out.print("{\"error\": \"Banner ID is required\"}");
                return;
            }
            
            int bannerId = Integer.parseInt(bannerIdStr);
            BannerSlide banner = bannerDAO.find(String.valueOf(bannerId));
            
            if (banner == null) {
                out.print("{\"error\": \"Banner not found\"}");
                return;
            }
            
            // Create JSON response
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("bannerID", banner.getBannerID());
            jsonResponse.addProperty("title", banner.getTitle());
            jsonResponse.addProperty("description", banner.getDescription());
            jsonResponse.addProperty("imagePath", banner.getImagePath());
            jsonResponse.addProperty("linkUrl", banner.getLinkUrl());
            jsonResponse.addProperty("isActive", banner.isIsActive());
            jsonResponse.addProperty("order", banner.getOrder());
            
            // Format dates
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            if (banner.getStartDate() != null) {
                jsonResponse.addProperty("startDate", banner.getStartDate().format(formatter));
            }
            if (banner.getEndDate() != null) {
                jsonResponse.addProperty("endDate", banner.getEndDate().format(formatter));
            }
            if (banner.getCreateAt() != null) {
                jsonResponse.addProperty("createAt", banner.getCreateAt().toString());
            }
            
            out.print(jsonResponse.toString());
            
        } catch (NumberFormatException e) {
            out.print("{\"error\": \"Invalid banner ID format\"}");
        } catch (Exception e) {
            out.print("{\"error\": \"" + e.getMessage() + "\"}");
            e.printStackTrace();
        }
    }
    
    private void listBanners(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String filter = request.getParameter("filter");
            String pageStr = request.getParameter("pageNum");
            
            int currentPage = 1;
            int itemsPerPage = 10;
            
            if (pageStr != null && !pageStr.trim().isEmpty()) {
                try {
                    currentPage = Integer.parseInt(pageStr);
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }
            
            ArrayList<BannerSlide> banners;
            int totalItems;
            
            // Get banners based on filter
            if ("active".equals(filter)) {
                banners = bannerDAO.getBannersByStatus(true);
                totalItems = bannerDAO.countBannersByStatus(true);
            } else if ("inactive".equals(filter)) {
                banners = bannerDAO.getBannersByStatus(false);
                totalItems = bannerDAO.countBannersByStatus(false);
            } else {
                banners = bannerDAO.getBanners(currentPage, itemsPerPage);
                totalItems = bannerDAO.countBanners();
            }
            
            // Calculate pagination
            int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
            
            // Get statistics
            int totalBanners = bannerDAO.countBanners();
            int totalActiveBanners = bannerDAO.countBannersByStatus(true);
            int totalInactiveBanners = bannerDAO.countBannersByStatus(false);
            ArrayList<BannerSlide> activeBanners = bannerDAO.getActiveBanners();
            
            // Set attributes
            request.setAttribute("banners", banners);
            request.setAttribute("activeBanners", activeBanners);
            request.setAttribute("totalBanners", totalBanners);
            request.setAttribute("totalActiveBanners", totalActiveBanners);
            request.setAttribute("totalInactiveBanners", totalInactiveBanners);
            request.setAttribute("currentFilter", filter != null ? filter : "");
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalItems", totalItems);
            
            // Forward to JSP
            request.getRequestDispatcher("admin/banner.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            setNotification(request, "error", "Terjadi kesalahan saat memuat data banner: " + e.getMessage());
            response.sendRedirect("Admin?page=home");
        }
    }
    
    private void addBanner(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            BannerSlide banner = new BannerSlide();
            
            // Get form data
            banner.setTitle(request.getParameter("title"));
            banner.setDescription(request.getParameter("description"));
            banner.setLinkUrl(request.getParameter("linkUrl"));
            banner.setIsActive(request.getParameter("isActive") != null);
            
            // Handle image upload
            String imagePath = handleImageUpload(request);
            if (imagePath != null) {
                banner.setImagePath(imagePath);
            } else {
                // Use manual path if provided
                String manualPath = request.getParameter("imagePath");
                if (manualPath != null && !manualPath.trim().isEmpty()) {
                    banner.setImagePath(manualPath.trim());
                }
            }
            
            // Handle dates
            handleDates(request, banner);
            
            // Set order (get next available order)
            int nextOrder = bannerDAO.getMaxOrder() + 1;
            banner.setOrder(nextOrder);
            
            // Set created by (you might want to get this from session)
            banner.setCreatedBy(1); // Default user ID
            
            // Save banner
            boolean success = bannerDAO.insertBannerSlide(banner);
            
            if (success) {
                setNotification(request, "success", "Banner berhasil ditambahkan!");
            } else {
                setNotification(request, "error", "Gagal menambahkan banner: " + bannerDAO.getMessage());
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            setNotification(request, "error", "Terjadi kesalahan: " + e.getMessage());
        }
        
        response.sendRedirect("Admin?page=banner");
    }
    
    private void updateBanner(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String bannerIdStr = request.getParameter("bannerId");
            if (bannerIdStr == null || bannerIdStr.trim().isEmpty()) {
                setNotification(request, "error", "Banner ID tidak valid");
                response.sendRedirect("Admin?page=banner");
                return;
            }
            
            int bannerId = Integer.parseInt(bannerIdStr);
            BannerSlide banner = bannerDAO.find(String.valueOf(bannerId));
            
            if (banner == null) {
                setNotification(request, "error", "Banner tidak ditemukan");
                response.sendRedirect("Admin?page=banner");
                return;
            }
            
            // Update banner data
            banner.setTitle(request.getParameter("title"));
            banner.setDescription(request.getParameter("description"));
            banner.setLinkUrl(request.getParameter("linkUrl"));
            banner.setIsActive(request.getParameter("isActive") != null);
            
            // Handle image upload (only if new image is uploaded)
            String newImagePath = handleImageUpload(request);
            if (newImagePath != null) {
                banner.setImagePath(newImagePath);
            } else {
                // Check if manual path is provided
                String manualPath = request.getParameter("imagePath");
                if (manualPath != null && !manualPath.trim().isEmpty()) {
                    banner.setImagePath(manualPath.trim());
                }
            }
            
            // Handle dates
            handleDates(request, banner);
            
            // Set updated by
            banner.setUpdatedBy(1); // Default user ID
            
            // Update banner
            boolean success = bannerDAO.updateBannerSlide(banner);
            
            if (success) {
                setNotification(request, "success", "Banner berhasil diperbarui!");
            } else {
                setNotification(request, "error", "Gagal memperbarui banner: " + bannerDAO.getMessage());
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            setNotification(request, "error", "Terjadi kesalahan: " + e.getMessage());
        }
        
        response.sendRedirect("Admin?page=banner");
    }
    
    private void updateBannerOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String bannerIdStr = request.getParameter("bannerId");
            String newOrderStr = request.getParameter("newOrder");
            
            if (bannerIdStr == null || newOrderStr == null) {
                setNotification(request, "error", "Parameter tidak lengkap");
                response.sendRedirect("Admin?page=banner");
                return;
            }
            
            int bannerId = Integer.parseInt(bannerIdStr);
            int newOrder = Integer.parseInt(newOrderStr);
            
            boolean success = bannerDAO.updateOrder(bannerId, newOrder);
            
            if (success) {
                setNotification(request, "success", "Urutan banner berhasil diperbarui!");
            } else {
                setNotification(request, "error", "Gagal memperbarui urutan banner: " + bannerDAO.getMessage());
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            setNotification(request, "error", "Terjadi kesalahan: " + e.getMessage());
        }
        
        response.sendRedirect("Admin?page=banner");
    }
    
    private void toggleBannerStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String bannerIdStr = request.getParameter("bannerId");
            if (bannerIdStr == null || bannerIdStr.trim().isEmpty()) {
                setNotification(request, "error", "Banner ID tidak valid");
                response.sendRedirect("Admin?page=banner");
                return;
            }
            
            int bannerId = Integer.parseInt(bannerIdStr);
            boolean success = bannerDAO.toggleActiveStatus(bannerId);
            
            if (success) {
                setNotification(request, "success", "Status banner berhasil diubah!");
            } else {
                setNotification(request, "error", "Gagal mengubah status banner: " + bannerDAO.getMessage());
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            setNotification(request, "error", "Terjadi kesalahan: " + e.getMessage());
        }
        
        response.sendRedirect("Admin?page=banner");
    }
    
    private void deleteBanner(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String bannerIdStr = request.getParameter("bannerId");
            if (bannerIdStr == null || bannerIdStr.trim().isEmpty()) {
                setNotification(request, "error", "Banner ID tidak valid");
                response.sendRedirect("Admin?page=banner");
                return;
            }
            
            int bannerId = Integer.parseInt(bannerIdStr);
            
            // Get banner details first to delete image file
            BannerSlide banner = bannerDAO.find(String.valueOf(bannerId));
            
            boolean success = bannerDAO.deleteBanner(bannerId);
            
            if (success) {
                // Delete image file if exists
                if (banner != null && banner.getImagePath() != null) {
                    deleteImageFile(banner.getImagePath());
                }
                setNotification(request, "success", "Banner berhasil dihapus!");
            } else {
                setNotification(request, "error", "Gagal menghapus banner: " + bannerDAO.getMessage());
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            setNotification(request, "error", "Terjadi kesalahan: " + e.getMessage());
        }
        
        response.sendRedirect("Admin?page=banner");
    }
    
    private void debugConnection(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            int bannerCount = bannerDAO.countBanners();
            out.print("{\"bannerCount\": " + bannerCount + ", \"message\": \"" + bannerDAO.getMessage() + "\"}");
        } catch (Exception e) {
            out.print("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }
    
    private String handleImageUpload(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("imageFile");
        
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }
        
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        if (fileName == null || fileName.trim().isEmpty()) {
            return null;
        }
        
        // Generate unique filename
        String fileExtension = "";
        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex > 0) {
            fileExtension = fileName.substring(dotIndex);
        }
        
        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
        
        // Create upload directory if not exists
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        // Save file
        String filePath = uploadPath + File.separator + uniqueFileName;
        filePart.write(filePath);
        
        return UPLOAD_DIR + "/" + uniqueFileName;
    }
    
    private void handleDates(HttpServletRequest request, BannerSlide banner) {
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        
        try {
            if (startDateStr != null && !startDateStr.trim().isEmpty()) {
                banner.setStartDate(LocalDateTime.parse(startDateStr, formatter));
            }
        } catch (DateTimeParseException e) {
            System.err.println("Error parsing start date: " + e.getMessage());
        }
        
        try {
            if (endDateStr != null && !endDateStr.trim().isEmpty()) {
                banner.setEndDate(LocalDateTime.parse(endDateStr, formatter));
            }
        } catch (DateTimeParseException e) {
            System.err.println("Error parsing end date: " + e.getMessage());
        }
    }
    
    private void deleteImageFile(String imagePath) {
        try {
            String fullPath = getServletContext().getRealPath("") + File.separator + imagePath;
            File file = new File(fullPath);
            if (file.exists()) {
                file.delete();
            }
        } catch (Exception e) {
            System.err.println("Error deleting image file: " + e.getMessage());
        }
    }
    
    private void setNotification(HttpServletRequest request, String type, String message) {
        HttpSession session = request.getSession();
        session.setAttribute("notificationType", type);
        session.setAttribute("notificationMsg", message);
    }
}