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

@WebServlet(name = "LoginServlet", urlPatterns = {"/Login"})
public class LoginServlet extends HttpServlet {

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
            
            // Redirect ke halaman login dengan pesan logout
            response.sendRedirect("login.jsp?message=logout_success");
            return;
        }
        
        // Jika sudah login, redirect ke dashboard
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("isLoggedIn") != null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        request.getRequestDispatcher("login.jsp").forward(request, response);
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
            setToastMessage(request, "warning", "Peringatan", "Email dan Password tidak boleh kosong!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Validasi format email menggunakan ValidationConf
        if (!ValidationConf.isValidEmail(email)) {
            setToastMessage(request, "warning", "Peringatan", "Format email tidak valid!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Validasi panjang input
        if (!ValidationConf.isValidLength(email, 1, 100)) {
            setToastMessage(request, "warning", "Peringatan", "Email terlalu panjang!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (!ValidationConf.isValidLength(password, 1, 255)) {
            setToastMessage(request, "warning", "Peringatan", "Password terlalu panjang!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {
            UsersDao userDao = new UsersDao();
            Users user = userDao.login(email.trim(), password);

            if (user != null) {
                // Cek apakah user adalah customer
                if (user.getRole() != UserRoles.CUSTOMER) {
                    setToastMessage(request, "error", "Akses Ditolak", 
                        "Halaman ini khusus untuk customer. Silakan gunakan halaman admin untuk login sebagai " + user.getRole().getRoleName());
                    request.getRequestDispatcher("login.jsp").forward(request, response);
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
                    javax.servlet.http.Cookie emailCookie = new javax.servlet.http.Cookie("remembered_email", email);
                    emailCookie.setMaxAge(30 * 24 * 60 * 60); // 30 hari
                    emailCookie.setPath("/");
                    response.addCookie(emailCookie);
                } else {
                    // Remove remember me cookie if unchecked
                    javax.servlet.http.Cookie emailCookie = new javax.servlet.http.Cookie("remembered_email", "");
                    emailCookie.setMaxAge(0);
                    emailCookie.setPath("/");
                    response.addCookie(emailCookie);
                }

                // Redirect ke dashboard dengan pesan sukses
                response.sendRedirect("home");
                return;

            } else {
                setToastMessage(request, "error", "Login Gagal", userDao.getMessage());
            }

        } catch (Exception e) {
            e.printStackTrace();
            setToastMessage(request, "error", "Error Sistem", "Terjadi kesalahan sistem. Silakan coba lagi.");
        }

        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    // Helper method untuk set toast message
    private void setToastMessage(HttpServletRequest request, String type, String title, String message) {
        request.setAttribute("toastType", type);
        request.setAttribute("toastTitle", title);
        request.setAttribute("toastMessage", message);
    }
}