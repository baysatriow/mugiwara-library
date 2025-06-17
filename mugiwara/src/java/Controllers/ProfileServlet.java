package Controllers;

import DAO.ProfileDAO;
import DAO.AddressDAO;
import Models.Customer;
import Models.Address;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

@WebServlet("/profile")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // 5MB max file size
public class ProfileServlet extends HttpServlet {
    
    private ProfileDAO profileDAO;
    private AddressDAO addressDAO;
    private Gson gson;
    
    @Override
    public void init() throws ServletException {
        profileDAO = new ProfileDAO();
        addressDAO = new AddressDAO();
        gson = new Gson();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        // Jika tidak ada action parameter, tampilkan halaman profil
        if (action == null) {
            // Cek session login
            if (!isUserLoggedIn(request)) {
                response.sendRedirect("login.jsp");
                return;
            }
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }
        
        // Cek session dan ambil user ID
        Integer userId = getUserIdFromSession(request);
        if (userId == null) {
            sendJsonResponse(response, false, "User not logged in", null);
            return;
        }
        
        switch (action) {
            case "getProfile":
                getProfile(request, response, userId);
                break;
            case "getAddresses":
                getAddresses(request, response, userId);
                break;
            default:
                sendJsonResponse(response, false, "Invalid action", null);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        // Cek session dan ambil user ID
        Integer userId = getUserIdFromSession(request);
        if (userId == null) {
            sendJsonResponse(response, false, "User not logged in", null);
            return;
        }
        
        switch (action != null ? action : "") {
            case "updateProfile":
                updateProfile(request, response, userId);
                break;
            case "changePassword":
                changePassword(request, response, userId);
                break;
            case "addAddress":
                addAddress(request, response, userId);
                break;
            case "updateAddress":
                updateAddress(request, response, userId);
                break;
            case "deleteAddress":
                deleteAddress(request, response, userId);
                break;
            case "setDefaultAddress":
                setDefaultAddress(request, response, userId);
                break;
            default:
                sendJsonResponse(response, false, "Invalid action", null);
        }
    }
    
    // Helper method untuk cek login status dari session
    private boolean isUserLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }
        
        Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
        Integer userId = (Integer) session.getAttribute("user_id");
        
        return isLoggedIn != null && isLoggedIn && userId != null;
    }
    
    // Helper method untuk ambil user ID dari session
    private Integer getUserIdFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return null;
        }
        
        Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
        if (isLoggedIn == null || !isLoggedIn) {
            return null;
        }
        
        return (Integer) session.getAttribute("user_id");
    }
    
    // Helper method untuk ambil informasi user dari session
    private JsonObject getUserInfoFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return null;
        }
        
        JsonObject userInfo = new JsonObject();
        userInfo.addProperty("userId", (Integer) session.getAttribute("user_id"));
        userInfo.addProperty("username", (String) session.getAttribute("username"));
        userInfo.addProperty("email", (String) session.getAttribute("email"));
        userInfo.addProperty("fullName", (String) session.getAttribute("full_name"));
        userInfo.addProperty("roleId", (Integer) session.getAttribute("role_id"));
        userInfo.addProperty("roleName", (String) session.getAttribute("role_name"));
        
        return userInfo;
    }
    
    private void getProfile(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws IOException {
        Customer customer = profileDAO.getCustomerProfile(userId);
        
        if (customer != null) {
            JsonObject profileData = new JsonObject();
            profileData.addProperty("userId", customer.getUserId());
            profileData.addProperty("username", customer.getUsername());
            profileData.addProperty("email", customer.getEmail());
            profileData.addProperty("fullName", customer.getFullName());
            profileData.addProperty("gender", customer.getGender());
            profileData.addProperty("birthDate", customer.getBirthDate() != null ? 
                                   customer.getBirthDate().toString() : "");
            profileData.addProperty("phone", customer.getPhone());
            profileData.addProperty("imagePath", customer.getImagePath());
            
            sendJsonResponse(response, true, "Profile retrieved successfully", profileData);
        } else {
            // Jika data customer tidak ditemukan di database, ambil dari session
            JsonObject sessionUserInfo = getUserInfoFromSession(request);
            if (sessionUserInfo != null) {
                JsonObject profileData = new JsonObject();
                profileData.addProperty("userId", sessionUserInfo.get("userId").getAsInt());
                profileData.addProperty("username", sessionUserInfo.get("username").getAsString());
                profileData.addProperty("email", sessionUserInfo.get("email").getAsString());
                profileData.addProperty("fullName", sessionUserInfo.get("fullName").getAsString());
                profileData.addProperty("gender", "");
                profileData.addProperty("birthDate", "");
                profileData.addProperty("phone", "");
                profileData.addProperty("imagePath", "");
                
                sendJsonResponse(response, true, "Profile retrieved from session", profileData);
            } else {
                sendJsonResponse(response, false, "Profile not found", null);
            }
        }
    }
    
    private void updateProfile(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws IOException {
        try {
            String fullName = request.getParameter("fullName");
            String gender = request.getParameter("gender");
            String birthDateStr = request.getParameter("birthDate");
            String phone = request.getParameter("phone");
            
            // Validasi input
            if (fullName == null || fullName.trim().isEmpty()) {
                sendJsonResponse(response, false, "Full name is required", null);
                return;
            }
            
            if (phone == null || phone.trim().isEmpty()) {
                sendJsonResponse(response, false, "Phone number is required", null);
                return;
            }
            
            // Parse birth date
            Date birthDate = null;
            if (birthDateStr != null && !birthDateStr.trim().isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    java.util.Date parsedDate = sdf.parse(birthDateStr);
                    birthDate = new Date(parsedDate.getTime());
                } catch (ParseException e) {
                    sendJsonResponse(response, false, "Invalid birth date format", null);
                    return;
                }
            }
            
            boolean success = profileDAO.updateProfile(userId, fullName.trim(), gender, birthDate, phone.trim());
            
            if (success) {
                // Update session data
                HttpSession session = request.getSession();
                session.setAttribute("full_name", fullName.trim());
                
                sendJsonResponse(response, true, "Profile updated successfully", null);
            } else {
                sendJsonResponse(response, false, "Failed to update profile: " + profileDAO.getMessage(), null);
            }
            
        } catch (Exception e) {
            sendJsonResponse(response, false, "Error updating profile: " + e.getMessage(), null);
        }
    }
    
    private void changePassword(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws IOException {
        try {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            
            // Validasi input
            if (currentPassword == null || currentPassword.trim().isEmpty()) {
                sendJsonResponse(response, false, "Current password is required", null);
                return;
            }
            
            if (newPassword == null || newPassword.trim().isEmpty()) {
                sendJsonResponse(response, false, "New password is required", null);
                return;
            }
            
            if (!newPassword.equals(confirmPassword)) {
                sendJsonResponse(response, false, "New password and confirmation do not match", null);
                return;
            }
            
            if (!profileDAO.isValidPassword(newPassword)) {
                sendJsonResponse(response, false, "Password must be at least 6 characters and contain both letters and numbers", null);
                return;
            }
            
            boolean success = profileDAO.changePassword(userId, currentPassword, newPassword);
            
            if (success) {
                sendJsonResponse(response, true, "Password changed successfully", null);
            } else {
                sendJsonResponse(response, false, profileDAO.getMessage(), null);
            }
            
        } catch (Exception e) {
            sendJsonResponse(response, false, "Error changing password: " + e.getMessage(), null);
        }
    }
    
    private void getAddresses(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws IOException {
        ArrayList<Address> addresses = addressDAO.getAddressesByUserId(userId);
        sendJsonResponse(response, true, "Addresses retrieved successfully", addresses);
    }
    
    private void addAddress(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws IOException {
        try {
            String province = request.getParameter("province");
            String city = request.getParameter("city");
            String district = request.getParameter("district");
            String postalCode = request.getParameter("postalCode");
            String fullAddress = request.getParameter("fullAddress");
            boolean isDefault = Boolean.parseBoolean(request.getParameter("isDefault"));
            
            // Validasi input
            if (fullAddress == null || fullAddress.trim().isEmpty()) {
                sendJsonResponse(response, false, "Full address is required", null);
                return;
            }
            
            // Jika ini adalah alamat pertama, set sebagai default
            if (addressDAO.getAddressCount(userId) == 0) {
                isDefault = true;
            }
            
            Address address = new Address();
            address.setProvince(province != null ? province.trim() : "");
            address.setCity(city != null ? city.trim() : "");
            address.setDistrict(district != null ? district.trim() : "");
            address.setPostalCode(postalCode != null ? postalCode.trim() : "");
            address.setFullAddress(fullAddress.trim());
            address.setIsDefault(isDefault);
            
            boolean success = addressDAO.addAddress(userId, address);
            
            if (success) {
                sendJsonResponse(response, true, "Address added successfully", null);
            } else {
                sendJsonResponse(response, false, "Failed to add address: " + addressDAO.getMessage(), null);
            }
            
        } catch (Exception e) {
            sendJsonResponse(response, false, "Error adding address: " + e.getMessage(), null);
        }
    }
    
    private void updateAddress(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws IOException {
        try {
            int addressId = Integer.parseInt(request.getParameter("addressId"));
            String province = request.getParameter("province");
            String city = request.getParameter("city");
            String district = request.getParameter("district");
            String postalCode = request.getParameter("postalCode");
            String fullAddress = request.getParameter("fullAddress");
            boolean isDefault = Boolean.parseBoolean(request.getParameter("isDefault"));
            
            // Validasi input
            if (fullAddress == null || fullAddress.trim().isEmpty()) {
                sendJsonResponse(response, false, "Full address is required", null);
                return;
            }
            
            Address address = new Address();
            address.setProvince(province != null ? province.trim() : "");
            address.setCity(city != null ? city.trim() : "");
            address.setDistrict(district != null ? district.trim() : "");
            address.setPostalCode(postalCode != null ? postalCode.trim() : "");
            address.setFullAddress(fullAddress.trim());
            address.setIsDefault(isDefault);
            
            boolean success = addressDAO.updateAddress(addressId, userId, address);
            
            if (success) {
                sendJsonResponse(response, true, "Address updated successfully", null);
            } else {
                sendJsonResponse(response, false, "Failed to update address: " + addressDAO.getMessage(), null);
            }
            
        } catch (NumberFormatException e) {
            sendJsonResponse(response, false, "Invalid address ID", null);
        } catch (Exception e) {
            sendJsonResponse(response, false, "Error updating address: " + e.getMessage(), null);
        }
    }
    
    private void deleteAddress(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws IOException {
        try {
            int addressId = Integer.parseInt(request.getParameter("addressId"));
            
            boolean success = addressDAO.deleteAddress(addressId, userId);
            
            if (success) {
                sendJsonResponse(response, true, "Address deleted successfully", null);
            } else {
                sendJsonResponse(response, false, "Failed to delete address. Cannot delete default address.", null);
            }
            
        } catch (NumberFormatException e) {
            sendJsonResponse(response, false, "Invalid address ID", null);
        } catch (Exception e) {
            sendJsonResponse(response, false, "Error deleting address: " + e.getMessage(), null);
        }
    }
    
    private void setDefaultAddress(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws IOException {
        try {
            int addressId = Integer.parseInt(request.getParameter("addressId"));
            
            boolean success = addressDAO.updateDefaultAddress(userId, addressId);
            
            if (success) {
                sendJsonResponse(response, true, "Default address updated successfully", null);
            } else {
                sendJsonResponse(response, false, "Failed to update default address", null);
            }
            
        } catch (NumberFormatException e) {
            sendJsonResponse(response, false, "Invalid address ID", null);
        } catch (Exception e) {
            sendJsonResponse(response, false, "Error updating default address: " + e.getMessage(), null);
        }
    }
    
    private void sendJsonResponse(HttpServletResponse response, boolean success, String message, Object data) 
            throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("success", success);
        jsonResponse.addProperty("message", message);
        
        if (data != null) {
            jsonResponse.add("data", gson.toJsonTree(data));
        }
        
        PrintWriter out = response.getWriter();
        out.print(gson.toJson(jsonResponse));
        out.flush();
    }
}