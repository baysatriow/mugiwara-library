package Controllers;

import DAO.BarangDao;
import Models.*;
import Config.ValidationConf;
import java.io.IOException;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

// Excel export imports
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import java.io.ByteArrayOutputStream;

@WebServlet(name = "BarangServlet", urlPatterns = {"/BarangServlet"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class BarangServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads/books";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        BarangDao barangDao = new BarangDao();
        
        if ("getBook".equals(action)) {
            // Handle AJAX request for getting book data
            handleGetBookAjax(request, response, barangDao);
            return;
        } else if ("export".equals(action)) {
            // Handle Excel export
            handleExportExcel(request, response, barangDao);
            return;
        }
        
        // For other GET requests, redirect to Admin router
        response.sendRedirect("Admin?page=barang");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        BarangDao barangDao = new BarangDao();
        
        try {
            switch (action) {
                case "add":
                    handleAddBook(request, barangDao);
                    break;
                case "update":
                    handleUpdateBook(request, barangDao);
                    break;
                case "delete":
                    handleDeleteBook(request, barangDao);
                    break;
                case "addAuthor":
                    handleAddAuthor(request, barangDao);
                    break;
                case "addCategory":
                    handleAddCategory(request, barangDao);
                    break;
                case "addPublisher":
                    handleAddPublisher(request, barangDao);
                    break;
                default:
                    setNotificationMessage(request, "warning", "Aksi tidak dikenali");
                    break;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            setNotificationMessage(request, "error", "Terjadi kesalahan sistem: " + e.getMessage());
        }
        
        // Redirect back to Admin router barang page
        response.sendRedirect("Admin?page=barang");
    }
    
    /**
     * Handle file upload for book image
     */
    private String handleFileUpload(HttpServletRequest request, String fieldName) throws IOException, ServletException {
        Part filePart = request.getPart(fieldName);
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }
        
        String fileName = getFileName(filePart);
        if (fileName == null || fileName.isEmpty()) {
            return null;
        }
        
        // Create upload directory if it doesn't exist
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        // Generate unique filename
        String fileExtension = fileName.substring(fileName.lastIndexOf("."));
        String uniqueFileName = System.currentTimeMillis() + "_" + fileName.replaceAll("[^a-zA-Z0-9.]", "_");
        
        // Save file
        String filePath = uploadPath + File.separator + uniqueFileName;
        filePart.write(filePath);
        
        // Return relative path for database storage
        return UPLOAD_DIR + "/" + uniqueFileName;
    }
    
    /**
     * Extract filename from Part header
     */
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
    
    /**
     * Handle AJAX request to get book data for editing
     */
    private void handleGetBookAjax(HttpServletRequest request, HttpServletResponse response, BarangDao barangDao) 
            throws ServletException, IOException {
        
        String bookId = request.getParameter("bookId");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        if (!ValidationConf.isEmpty(bookId)) {
            Book book = barangDao.getBookById(Integer.parseInt(bookId));
            
            if (book != null) {
                String json = bookToJson(book);
                response.getWriter().write(json);
            } else {
                response.getWriter().write("{\"error\":\"Book not found\"}");
            }
        } else {
            response.getWriter().write("{\"error\":\"Invalid book ID\"}");
        }
    }
    
    /**
     * Handle Excel export
     */
    private void handleExportExcel(HttpServletRequest request, HttpServletResponse response, BarangDao barangDao) 
            throws ServletException, IOException {
        
        try {
            ArrayList<Book> books = barangDao.getAllBooksWithDetails();
            
            // Create workbook and sheet
            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("Data Buku");
            
            // Create header row
            Row headerRow = sheet.createRow(0);
            String[] headers = {"No", "ISBN", "Judul", "Penulis", "Penerbit", "Kategori", "Harga", "Stok", "Tanggal Terbit"};
            
            CellStyle headerStyle = workbook.createCellStyle();
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerStyle.setFont(headerFont);
            
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
            }
            
            // Fill data rows
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            for (int i = 0; i < books.size(); i++) {
                Row row = sheet.createRow(i + 1);
                Book book = books.get(i);
                
                row.createCell(0).setCellValue(i + 1);
                row.createCell(1).setCellValue(book.getISBN() != null ? book.getISBN() : "");
                row.createCell(2).setCellValue(book.getTitle() != null ? book.getTitle() : "");
                row.createCell(3).setCellValue(book.getAuthor() != null ? book.getAuthor().getName() : "");
                row.createCell(4).setCellValue(book.getPublisher() != null ? book.getPublisher().getName() : "");
                row.createCell(5).setCellValue(book.getCategory() != null ? book.getCategory().getName() : "");
                row.createCell(6).setCellValue(book.getPrice());
                row.createCell(7).setCellValue(book.getStock());
                row.createCell(8).setCellValue(book.getPublicationDate() != null ? sdf.format(book.getPublicationDate()) : "");
            }
            
            // Auto-size columns
            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }
            
            // Set response headers
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment; filename=data_buku_" + System.currentTimeMillis() + ".xlsx");
            
            // Write to response
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            workbook.write(outputStream);
            response.getOutputStream().write(outputStream.toByteArray());
            workbook.close();
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating Excel file");
        }
    }
    
    // ===== BOOK CRUD HANDLERS =====
    
    private void handleAddBook(HttpServletRequest request, BarangDao barangDao) throws Exception {
        String isbn = request.getParameter("isbn");
        String title = request.getParameter("title");
        String authorId = request.getParameter("authorId");
        String publisherId = request.getParameter("publisherId");
        String categoryId = request.getParameter("categoryId");
        String price = request.getParameter("price");
        String description = request.getParameter("description");
        String publicationDate = request.getParameter("publicationDate");
        String width = request.getParameter("width");
        String length = request.getParameter("length");
        String weight = request.getParameter("weight");
        String stock = request.getParameter("stock");
        
        // Handle file upload
        String imagePath = handleFileUpload(request, "bookImage");
        
        // Validasi input
        if (ValidationConf.isEmpty(isbn) || ValidationConf.isEmpty(title) || 
            ValidationConf.isEmpty(authorId) || ValidationConf.isEmpty(publisherId) ||
            ValidationConf.isEmpty(categoryId) || ValidationConf.isEmpty(price) ||
            ValidationConf.isEmpty(stock)) {
            setNotificationMessage(request, "warning", "Semua field wajib harus diisi!");
            return;
        }
        
        if (!ValidationConf.isValidPrice(price)) {
            setNotificationMessage(request, "warning", "Format harga tidak valid!");
            return;
        }
        
        if (!ValidationConf.isValidQuantity(stock)) {
            setNotificationMessage(request, "warning", "Format stok tidak valid!");
            return;
        }
        
        // Parse date
        Date pubDate = new Date();
        if (!ValidationConf.isEmpty(publicationDate)) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            pubDate = sdf.parse(publicationDate);
        }
        
        boolean result = barangDao.addBook(
            isbn, title, Integer.parseInt(authorId), Integer.parseInt(publisherId),
            Integer.parseInt(categoryId), Integer.parseInt(price), description, pubDate,
            Double.parseDouble(width.isEmpty() ? "0" : width),
            Double.parseDouble(length.isEmpty() ? "0" : length),
            Integer.parseInt(weight.isEmpty() ? "0" : weight),
            Integer.parseInt(stock), imagePath
        );
        
        if (result) {
            setNotificationMessage(request, "success", barangDao.getMessage());
        } else {
            setNotificationMessage(request, "error", barangDao.getMessage());
        }
    }
    
    private void handleUpdateBook(HttpServletRequest request, BarangDao barangDao) throws Exception {
        String bookId = request.getParameter("bookId");
        String isbn = request.getParameter("isbn");
        String title = request.getParameter("title");
        String authorId = request.getParameter("authorId");
        String publisherId = request.getParameter("publisherId");
        String categoryId = request.getParameter("categoryId");
        String price = request.getParameter("price");
        String description = request.getParameter("description");
        String publicationDate = request.getParameter("publicationDate");
        String width = request.getParameter("width");
        String length = request.getParameter("length");
        String weight = request.getParameter("weight");
        String stock = request.getParameter("stock");
        
        // Handle file upload (optional for update)
        String imagePath = handleFileUpload(request, "bookImage");
        if (imagePath == null) {
            imagePath = request.getParameter("currentImagePath");
        }
        
        // Validasi input
        if (ValidationConf.isEmpty(bookId) || ValidationConf.isEmpty(isbn) || 
            ValidationConf.isEmpty(title) || ValidationConf.isEmpty(authorId) ||
            ValidationConf.isEmpty(publisherId) || ValidationConf.isEmpty(categoryId) ||
            ValidationConf.isEmpty(price) || ValidationConf.isEmpty(stock)) {
            setNotificationMessage(request, "warning", "Semua field wajib harus diisi!");
            return;
        }
        
        // Parse date
        Date pubDate = new Date();
        if (!ValidationConf.isEmpty(publicationDate)) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            pubDate = sdf.parse(publicationDate);
        }
        
        boolean result = barangDao.updateBook(
            Integer.parseInt(bookId), isbn, title, Integer.parseInt(authorId),
            Integer.parseInt(publisherId), Integer.parseInt(categoryId),
            Integer.parseInt(price), description, pubDate,
            Double.parseDouble(width.isEmpty() ? "0" : width),
            Double.parseDouble(length.isEmpty() ? "0" : length),
            Integer.parseInt(weight.isEmpty() ? "0" : weight),
            Integer.parseInt(stock), imagePath
        );
        
        if (result) {
            setNotificationMessage(request, "success", barangDao.getMessage());
        } else {
            setNotificationMessage(request, "error", barangDao.getMessage());
        }
    }
    
    private void handleDeleteBook(HttpServletRequest request, BarangDao barangDao) {
        String bookId = request.getParameter("bookId");
        
        if (ValidationConf.isEmpty(bookId)) {
            setNotificationMessage(request, "warning", "ID buku tidak valid!");
            return;
        }
        
        boolean result = barangDao.deleteBook(Integer.parseInt(bookId));
        
        if (result) {
            setNotificationMessage(request, "success", barangDao.getMessage());
        } else {
            setNotificationMessage(request, "error", barangDao.getMessage());
        }
    }
    
    private void handleAddAuthor(HttpServletRequest request, BarangDao barangDao) {
        String name = request.getParameter("authorName");
        String description = request.getParameter("authorDescription");
        
        boolean result = barangDao.addAuthor(name, description);
        
        if (result) {
            setNotificationMessage(request, "success", barangDao.getMessage());
        } else {
            setNotificationMessage(request, "error", barangDao.getMessage());
        }
    }
    
    private void handleAddCategory(HttpServletRequest request, BarangDao barangDao) {
        String name = request.getParameter("categoryName");
        
        boolean result = barangDao.addCategory(name);
        
        if (result) {
            setNotificationMessage(request, "success", barangDao.getMessage());
        } else {
            setNotificationMessage(request, "error", barangDao.getMessage());
        }
    }
    
    private void handleAddPublisher(HttpServletRequest request, BarangDao barangDao) {
        String name = request.getParameter("publisherName");
        String description = request.getParameter("publisherDescription");
        
        boolean result = barangDao.addPublisher(name, description);
        
        if (result) {
            setNotificationMessage(request, "success", barangDao.getMessage());
        } else {
            setNotificationMessage(request, "error", barangDao.getMessage());
        }
    }
    
    // ===== HELPER METHODS =====
    
    private void setNotificationMessage(HttpServletRequest request, String type, String message) {
        request.getSession().setAttribute("notificationMsg", message);
        request.getSession().setAttribute("notificationType", type);
    }
    
    private String bookToJson(Book book) {
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"bookId\":").append(book.getBook_id()).append(",");
        json.append("\"isbn\":").append(book.getISBN() != null ? "\"" + book.getISBN() + "\"" : "null").append(",");
        json.append("\"title\":").append(book.getTitle() != null ? "\"" + book.getTitle().replace("\"", "\\\"") + "\"" : "null").append(",");
        json.append("\"authorId\":").append(book.getAuthor() != null ? book.getAuthor().getAuthor_id() : "null").append(",");
        json.append("\"publisherId\":").append(book.getPublisher() != null ? "\"" + book.getPublisher().getName() + "\"" : "null").append(",");
        json.append("\"categoryId\":").append(book.getCategory() != null ? book.getCategory().getCategory_id() : "null").append(",");
        json.append("\"price\":").append(book.getPrice()).append(",");
        json.append("\"description\":").append(book.getDescription() != null ? "\"" + book.getDescription().replace("\"", "\\\"") + "\"" : "null").append(",");
        json.append("\"stock\":").append(book.getStock()).append(",");
        json.append("\"width\":").append(book.getWidth()).append(",");
        json.append("\"length\":").append(book.getLength()).append(",");
        json.append("\"weight\":").append(book.getWeight()).append(",");
        json.append("\"publicationDate\":").append(book.getPublicationDate() != null ? "\"" + new SimpleDateFormat("yyyy-MM-dd").format(book.getPublicationDate()) + "\"" : "null").append(",");
        json.append("\"imagePath\":").append(book.getImagePath() != null ? "\"" + book.getImagePath() + "\"" : "null");
        json.append("}");
        return json.toString();
    }
}
