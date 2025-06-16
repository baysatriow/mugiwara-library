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

@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Jika sudah login, redirect ke dashboard
        if (request.getSession(false) != null && 
            request.getSession(false).getAttribute("isLoggedIn") != null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validasi input kosong menggunakan ValidationConf
        if (ValidationConf.isEmpty(fullName) || ValidationConf.isEmpty(email) || 
            ValidationConf.isEmpty(password) || ValidationConf.isEmpty(confirmPassword)) {
            
            setToastMessage(request, "warning", "Peringatan", "Semua field harus diisi!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Validasi panjang input
        if (!ValidationConf.isValidLength(fullName, 2, 100)) {
            setToastMessage(request, "warning", "Peringatan", "Nama lengkap harus antara 2-100 karakter!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!ValidationConf.isValidLength(email, 5, 100)) {
            setToastMessage(request, "warning", "Peringatan", "Email harus antara 5-100 karakter!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Validasi format nama menggunakan ValidationConf
        if (!ValidationConf.isValidName(fullName)) {
            setToastMessage(request, "warning", "Peringatan", "Nama lengkap hanya boleh mengandung huruf dan spasi!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Validasi format email menggunakan ValidationConf
        if (!ValidationConf.isValidEmail(email)) {
            setToastMessage(request, "warning", "Peringatan", "Format email tidak valid!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Validasi konfirmasi password
        if (!password.equals(confirmPassword)) {
            setToastMessage(request, "warning", "Peringatan", "Password dan konfirmasi password tidak sama!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Validasi kekuatan password menggunakan ValidationConf
        if (!ValidationConf.isStrongPassword(password)) {
            String strengthMessage = ValidationConf.getPasswordStrengthMessage(password);
            setToastMessage(request, "warning", "Password Lemah", strengthMessage);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        try {
            UsersDao userDao = new UsersDao();

            // Generate username dari email (bagian sebelum @)
            String baseUsername = email.substring(0, email.indexOf("@"));
            
            // Pastikan username valid, jika tidak buat yang valid
            if (!ValidationConf.isValidUsername(baseUsername)) {
                baseUsername = "user" + System.currentTimeMillis();
            }
            
            String username = baseUsername;
            
            // Jika username sudah ada, tambahkan angka random
            int counter = 1;
            while (isUsernameExists(username)) {
                username = baseUsername + counter;
                counter++;
                
                // Prevent infinite loop
                if (counter > 1000) {
                    username = "user" + System.currentTimeMillis();
                    break;
                }
            }

            // Registrasi user sebagai customer
            boolean registerResult = userDao.registerUser(
                username, 
                email.trim(), 
                password, 
                fullName.trim(), 
                UserRoles.CUSTOMER
            );

            if (registerResult) {
                setToastMessage(request, "success", "Registrasi Berhasil", 
                    "Akun berhasil dibuat! Silakan login dengan akun Anda.");
                request.setAttribute("registrationSuccess", true);
                request.setAttribute("registeredEmail", email);
                request.setAttribute("generatedUsername", username);
            } else {
                setToastMessage(request, "error", "Registrasi Gagal", userDao.getMessage());
            }

        } catch (Exception e) {
            e.printStackTrace();
            setToastMessage(request, "error", "Error Sistem", "Terjadi kesalahan sistem. Silakan coba lagi.");
        }

        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    // Helper method untuk set toast message
    private void setToastMessage(HttpServletRequest request, String type, String title, String message) {
        request.setAttribute("toastType", type);
        request.setAttribute("toastTitle", title);
        request.setAttribute("toastMessage", message);
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
}