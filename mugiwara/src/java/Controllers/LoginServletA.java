package Controllers;

import DAO.UsersDao;
import Models.Users;
import Models.UserRoles;
import Config.ValidationConf;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginServletA", urlPatterns = {"/Logina"})
public class LoginServletA extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                Integer userId = (Integer) session.getAttribute("user_id");
                if (userId != null) {
                    // Update login status menggunakan UsersDao
                    UsersDao userDao = new UsersDao();
                    userDao.logout(userId);
                }
                session.invalidate();
            }
            
            // Redirect ke halaman login admin dengan pesan logout
            response.sendRedirect("Admin/login.jsp?message=logout_success");
            return;
        }
        
        // Jika sudah login sebagai admin/staff, redirect ke dashboard admin
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("isLoggedIn") != null) {
            Integer roleId = (Integer) session.getAttribute("role_id");
            if (roleId != null && (roleId == 1 || roleId == 2)) { // Admin atau Staff
                response.sendRedirect("Admin/index.jsp");
                return;
            }
        }
        
        request.getRequestDispatcher("Admin/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");
        
        HttpSession session = request.getSession();

        // Validasi input kosong menggunakan ValidationConf
        if (ValidationConf.isEmpty(email) || ValidationConf.isEmpty(password)) {
            setNotificationMessage(request, "warning", "Email dan Password tidak boleh kosong!");
            request.getRequestDispatcher("Admin/login.jsp").forward(request, response);
            return;
        }

        // Validasi format email menggunakan ValidationConf
        if (!ValidationConf.isValidEmail(email)) {
            setNotificationMessage(request, "warning", "Format email tidak valid!");
            request.getRequestDispatcher("Admin/login.jsp").forward(request, response);
            return;
        }

        // Validasi panjang input
        if (!ValidationConf.isValidLength(email, 1, 100)) {
            setNotificationMessage(request, "warning", "Email terlalu panjang!");
            request.getRequestDispatcher("Admin/login.jsp").forward(request, response);
            return;
        }

        if (!ValidationConf.isValidLength(password, 1, 255)) {
            setNotificationMessage(request, "warning", "Password terlalu panjang!");
            request.getRequestDispatcher("Admin/login.jsp").forward(request, response);
            return;
        }

        try {
            UsersDao userDao = new UsersDao();
            Users user = userDao.login(email.trim(), password);

            if (user != null) {
                // Cek apakah user adalah Admin atau Staff
                if (user.getRole() != UserRoles.ADMIN && user.getRole() != UserRoles.STAFF) {
                    setNotificationMessage(request, "error", 
                        "Akses ditolak! Halaman ini khusus untuk Admin dan Staff. Anda login sebagai " + user.getRole().getRoleName());
                    request.getRequestDispatcher("Admin/login.jsp").forward(request, response);
                    return;
                }

                // Set session attributes
                session.setAttribute("user_id", user.getUserId());
                session.setAttribute("username", user.getUsername());
                session.setAttribute("email", user.getEmail());
                session.setAttribute("full_name", user.getFullName());
                session.setAttribute("role_id", user.getRoleId());
                session.setAttribute("role_name", user.getRole().getRoleName());
                session.setAttribute("isLoggedIn", true);
                session.setAttribute("user", user);

                // Set remember me cookie jika dipilih
                if ("on".equals(rememberMe)) {
                    javax.servlet.http.Cookie emailCookie = new javax.servlet.http.Cookie("admin_remembered_email", email);
                    emailCookie.setMaxAge(30 * 24 * 60 * 60); // 30 hari
                    emailCookie.setPath("/");
                    response.addCookie(emailCookie);
                } else {
                    // Remove remember me cookie if unchecked
                    javax.servlet.http.Cookie emailCookie = new javax.servlet.http.Cookie("admin_remembered_email", "");
                    emailCookie.setMaxAge(0);
                    emailCookie.setPath("/");
                    response.addCookie(emailCookie);
                }

                // Redirect ke dashboard admin dengan pesan sukses
                response.sendRedirect("Admin?page=home&message=login_success");
                return;

            } else {
                setNotificationMessage(request, "error", userDao.getMessage());
            }

        } catch (Exception e) {
            e.printStackTrace();
            setNotificationMessage(request, "error", "Terjadi kesalahan sistem. Silakan coba lagi.");
        }

        request.getRequestDispatcher("Admin/login.jsp").forward(request, response);
    }

    // Helper method untuk set notification message (menggunakan format Lobibox)
    private void setNotificationMessage(HttpServletRequest request, String type, String message) {
        request.setAttribute("notificationMsg", message);
        request.setAttribute("notificationType", type);
    }
}