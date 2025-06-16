package Controllers;

import DAO.UsersDao;
import Models.UserRoles;
import Config.ValidationConf;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "RegisterServletA", urlPatterns = {"/RegisterServletA"})
public class RegisterServletA extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Redirect ke admin panel jika akses langsung
        response.sendRedirect("Admin?page=manageuserstaff");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Ambil parameter dari form
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("fullName");
        String gender = request.getParameter("gender");
        String birthDate = request.getParameter("birthDate");
        String phone = request.getParameter("phone");
        
        // Parameter khusus admin
        String source = request.getParameter("source");
        String roleIdParam = request.getParameter("roleId");

        // Validasi parameter admin
        if (!"admin".equals(source) || ValidationConf.isEmpty(roleIdParam)) {
            setNotificationMessage(request, "error", "Akses tidak valid!");
            response.sendRedirect("Admin?page=manageuserstaff");
            return;
        }

        // Parse role ID
        int roleId;
        try {
            roleId = Integer.parseInt(roleIdParam);
        } catch (NumberFormatException e) {
            setNotificationMessage(request, "error", "Role ID tidak valid!");
            response.sendRedirect("Admin?page=manageuserstaff");
            return;
        }

        // Validasi role ID
        if (!UserRoles.isValidRoleId(roleId)) {
            setNotificationMessage(request, "error", "Role tidak valid!");
            response.sendRedirect("Admin?page=manageuserstaff");
            return;
        }

        // Konversi ke UserRoles enum
        UserRoles role = UserRoles.fromRoleId(roleId);

        // Validasi input wajib
        if (ValidationConf.isEmpty(username) || ValidationConf.isEmpty(email) || 
            ValidationConf.isEmpty(password) || ValidationConf.isEmpty(confirmPassword)) {
            
            setNotificationMessage(request, "warning", "Username, email, password, dan konfirmasi password harus diisi!");
            redirectBasedOnRole(response, role);
            return;
        }

        // Validasi panjang input
        if (!ValidationConf.isValidLength(username, 3, 50)) {
            setNotificationMessage(request, "warning", "Username harus antara 3-50 karakter!");
            redirectBasedOnRole(response, role);
            return;
        }

        if (!ValidationConf.isValidLength(email, 5, 100)) {
            setNotificationMessage(request, "warning", "Email harus antara 5-100 karakter!");
            redirectBasedOnRole(response, role);
            return;
        }

        if (!ValidationConf.isEmpty(fullName) && !ValidationConf.isValidLength(fullName, 2, 100)) {
            setNotificationMessage(request, "warning", "Nama lengkap harus antara 2-100 karakter!");
            redirectBasedOnRole(response, role);
            return;
        }

        // Validasi format username
        if (!ValidationConf.isValidUsername(username)) {
            setNotificationMessage(request, "warning", "Username hanya boleh mengandung huruf, angka, dan underscore!");
            redirectBasedOnRole(response, role);
            return;
        }

        // Validasi format nama jika diisi
        if (!ValidationConf.isEmpty(fullName) && !ValidationConf.isValidName(fullName)) {
            setNotificationMessage(request, "warning", "Nama lengkap hanya boleh mengandung huruf dan spasi!");
            redirectBasedOnRole(response, role);
            return;
        }

        // Validasi format email
        if (!ValidationConf.isValidEmail(email)) {
            setNotificationMessage(request, "warning", "Format email tidak valid!");
            redirectBasedOnRole(response, role);
            return;
        }

        // Validasi konfirmasi password
        if (!password.equals(confirmPassword)) {
            setNotificationMessage(request, "warning", "Password dan konfirmasi password tidak sama!");
            redirectBasedOnRole(response, role);
            return;
        }

        // Validasi kekuatan password
        if (!ValidationConf.isStrongPassword(password)) {
            String strengthMessage = ValidationConf.getPasswordStrengthMessage(password);
            setNotificationMessage(request, "warning", "Password lemah: " + strengthMessage);
            redirectBasedOnRole(response, role);
            return;
        }

        // Validasi gender jika diisi
        if (!ValidationConf.isEmpty(gender) && !isValidGender(gender)) {
            setNotificationMessage(request, "warning", "Gender tidak valid!");
            redirectBasedOnRole(response, role);
            return;
        }

        try {
            UsersDao userDao = new UsersDao();

            // Cek apakah username sudah ada
            if (isUsernameExists(username)) {
                setNotificationMessage(request, "warning", "Username '" + username + "' sudah digunakan!");
                redirectBasedOnRole(response, role);
                return;
            }

            // Cek apakah email sudah ada
            if (isEmailExists(email)) {
                setNotificationMessage(request, "warning", "Email '" + email + "' sudah terdaftar!");
                redirectBasedOnRole(response, role);
                return;
            }

            // Parse birth date jika diisi
            java.util.Date birthDateParsed = null;
            if (!ValidationConf.isEmpty(birthDate)) {
                try {
                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                    birthDateParsed = sdf.parse(birthDate);
                } catch (Exception e) {
                    setNotificationMessage(request, "warning", "Format tanggal lahir tidak valid!");
                    redirectBasedOnRole(response, role);
                    return;
                }
            }

            // Registrasi user dengan role yang ditentukan
            boolean registerResult = userDao.registerUser(
                username.trim(), 
                email.trim(), 
                password, 
                fullName != null ? fullName.trim() : "", 
                role
            );

            if (registerResult) {
                // Update profile jika ada data tambahan
                if (!ValidationConf.isEmpty(gender) || birthDateParsed != null) {
                    // Get user ID yang baru dibuat
                    int newUserId = getLastInsertedUserId(userDao, username);
                    if (newUserId > 0) {
                        userDao.updateProfile(newUserId, 
                            fullName != null ? fullName.trim() : "", 
                            gender, 
                            birthDateParsed, 
                            null);
                    }
                }

                String roleDisplayName = getRoleDisplayName(role);
                setNotificationMessage(request, "success", 
                    roleDisplayName + " '" + username + "' berhasil didaftarkan!");
                
            } else {
                setNotificationMessage(request, "error", 
                    "Gagal mendaftarkan user: " + userDao.getMessage());
            }

        } catch (Exception e) {
            e.printStackTrace();
            setNotificationMessage(request, "error", 
                "Terjadi kesalahan sistem: " + e.getMessage());
        }

        // Redirect berdasarkan role
        redirectBasedOnRole(response, role);
    }

    // Helper method untuk set notification message yang sinkron dengan admin panel
    private void setNotificationMessage(HttpServletRequest request, String type, String message) {
        HttpSession session = request.getSession();
        session.setAttribute("notificationMsg", message);
        session.setAttribute("notificationType", type);
    }

    // Helper method untuk redirect berdasarkan role
    private void redirectBasedOnRole(HttpServletResponse response, UserRoles role) throws IOException {
        if (role == UserRoles.CUSTOMER) {
            response.sendRedirect("Admin?page=managecustomer");
        } else {
            response.sendRedirect("Admin?page=manageuserstaff");
        }
    }

    // Helper method untuk get role display name
    private String getRoleDisplayName(UserRoles role) {
        switch (role) {
            case ADMIN:
                return "Admin";
            case STAFF:
                return "Staff";
            case CUSTOMER:
                return "Customer";
            default:
                return "User";
        }
    }

    // Helper method untuk cek username exists
    private boolean isUsernameExists(String username) {
        try {
            UsersDao userDao = new UsersDao();
            return userDao.searchUsers(username).stream()
                    .anyMatch(user -> user.getUsername().equals(username));
        } catch (Exception e) {
            return false;
        }
    }

    // Helper method untuk cek email exists
    private boolean isEmailExists(String email) {
        try {
            UsersDao userDao = new UsersDao();
            return userDao.getUserByEmail(email) != null;
        } catch (Exception e) {
            return false;
        }
    }

    // Helper method untuk validasi gender
    private boolean isValidGender(String gender) {
        return "Male".equals(gender) || "Female".equals(gender);
    }

    // Helper method untuk get last inserted user ID
    private int getLastInsertedUserId(UsersDao userDao, String username) {
        try {
            return userDao.searchUsers(username).stream()
                    .filter(user -> user.getUsername().equals(username))
                    .findFirst()
                    .map(user -> user.getUserId())
                    .orElse(0);
        } catch (Exception e) {
            return 0;
        }
    }

    @Override
    public String getServletInfo() {
        return "RegisterServletA - Admin Registration Management Servlet";
    }
}
