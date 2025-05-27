package Controllers;

import Config.DBConnection; // Menggunakan DBConnection Anda
import Config.PasswordConf;
import Config.ValidationConf;

import java.io.IOException;
import java.sql.ResultSet; // Hanya perlu ResultSet
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author bayus
 */

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
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
                    DBConnection dbLogout = new DBConnection();
                    // runQuery akan menangani koneksi dan diskoneksi sendiri
                    // PERHATIAN: userId adalah integer, jadi aman dari SQL injection di sini.
                    dbLogout.runQuery("UPDATE users SET login = 0 WHERE user_id = " + userId);
                    if (!dbLogout.isConnected() && !dbLogout.getMessage().contains("berhasil")) { // Cek apakah query gagal
                        System.err.println("Error updating login status on logout: " + dbLogout.getMessage());
                    }
                }
                session.invalidate();
            }
            response.sendRedirect("Admin/login.jsp?logoutSuccess=true");
            return;
        }
        request.getRequestDispatcher("Admin/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();

        if (email == null || email.trim().isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("notificationMsg", "Email dan Password tidak boleh kosong!");
            request.setAttribute("notificationType", "warning");
            request.setAttribute("loginErrorMsg", "Email dan password tidak boleh kosong.");
            request.getRequestDispatcher("Admin/login.jsp").forward(request, response);
            return;
        }

        if (!ValidationConf.isValidEmail(email)) {
            request.setAttribute("loginErrorMsg", "Format email tidak valid.");
            request.getRequestDispatcher("Admin/login.jsp").forward(request, response);
            return;
        }

        DBConnection db = new DBConnection();
        ResultSet rsUser = null;

        try {
            db.connect();
            if (!db.isConnected()) {
                request.setAttribute("loginErrorMsg", "Tidak dapat terhubung ke database: " + db.getMessage());
                request.getRequestDispatcher("Admin/login.jsp").forward(request, response);
                return;
            }

            String sanitizedEmail = email.replace("'", "''");

            String sqlUser = "SELECT u.user_id, u.username, u.email, u.password AS hashed_password, u.full_name, u.role_id, ur.role_name " +
                             "FROM users u " +
                             "LEFT JOIN user_role ur ON u.role_id = ur.role_id " +
                             "WHERE u.email = '" + sanitizedEmail + "'";

            rsUser = db.getData(sqlUser);

            if (rsUser != null && rsUser.next()) {
                String storedHashedPassword = rsUser.getString("hashed_password");

                if (PasswordConf.verifyPassword(password, storedHashedPassword)) {
                    int userId = rsUser.getInt("user_id");
                    String username = rsUser.getString("username");
                    String fullName = rsUser.getString("full_name");
                    int roleId = rsUser.getInt("role_id");
                    String roleName = rsUser.getString("role_name");

                    session.setAttribute("user_id", userId);
                    session.setAttribute("username", username);
                    session.setAttribute("email", email);
                    session.setAttribute("full_name", fullName);
                    session.setAttribute("role_id", roleId);
                    session.setAttribute("role_name", roleName != null ? roleName : "N/A");
                    session.setAttribute("isLoggedIn", true);

                    db.runQuery("UPDATE users SET login = 1 WHERE user_id = " + userId);
                    if (!db.isConnected() && !db.getMessage().contains("berhasil")) {
                         System.err.println("Warning: Gagal mengupdate status login menjadi 1: " + db.getMessage());
                    }
                    
                    response.sendRedirect("/Admin");
                    return;

                } else {
                    request.setAttribute("notificationMsg", "GAGAL LOGIN" + storedHashedPassword + password);
                    request.setAttribute("notificationType", "warning");
                    request.setAttribute("loginErrorMsg", "Email atau password salah.");
                }
            } else {

                if (rsUser == null && db.getMessage().contains("Gagal mengambil data")) {
                     request.setAttribute("loginErrorMsg", "Gagal mengambil data pengguna: " + db.getMessage());
                } else {
                    request.setAttribute("loginErrorMsg", "Email atau password salah.");
                    request.setAttribute("notificationMsg", "Email atau Password Salah");
                    request.setAttribute("notificationType", "error");
                }
            }
            request.getRequestDispatcher("Admin/login.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("loginErrorMsg", "Terjadi kesalahan SQL: " + e.getMessage());
            request.getRequestDispatcher("Admin/login.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("loginErrorMsg", "Terjadi kesalahan sistem: " + e.getMessage());
            request.getRequestDispatcher("Admin/login.jsp").forward(request, response);
        }
        finally {
            try {
                if (rsUser != null) rsUser.close();
            } catch (SQLException ex) {
                System.err.println("Error closing ResultSet: " + ex.getMessage());
            }

            if (db != null && db.isConnected()) {
                db.disconnect();
            }
        }
    }
}