package Controllers;

/**
 *
 * @author bayus
 */

import Config.DBConnection_BCKP;
import Config.PasswordConf;
import Config.ValidationConf;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
                    DBConnection_BCKP dbLogout = new DBConnection_BCKP();
                    dbLogout.runQuery("UPDATE users SET login = 0 WHERE user_id = " + userId);
                }
                session.invalidate();
            }
            response.sendRedirect("Admin/login.jsp");
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
            request.getRequestDispatcher("Admin/login.jsp").forward(request, response);
            return;
        }

        if (!ValidationConf.isValidEmail(email)) {
            request.setAttribute("notificationMsg", "Format email tidak valid.");
            request.setAttribute("notificationType", "warning");
            request.getRequestDispatcher("Admin/login.jsp").forward(request, response);
            return;
        }

        DBConnection_BCKP db = new DBConnection_BCKP();
        ResultSet rsUser = null;

        try {
            String sanitizedEmail = email.replace("'", "''");

            String sqlUser = "SELECT u.user_id, u.username, u.email, u.password AS hashed_password, u.full_name, u.role_id, ur.role_name " +
                             "FROM users u " +
                             "LEFT JOIN user_role ur ON u.role_id = ur.role_id " +
                             "WHERE u.email = '" + sanitizedEmail + "'";

            rsUser = db.getData(sqlUser);

            if (!db.isConnected()) {
                 request.setAttribute("notificationMsg", "Tidak dapat terhubung ke database: " + db.getMessage());
                 request.setAttribute("notificationType", "error");
                 request.getRequestDispatcher("Admin/login.jsp").forward(request, response);
                 return;
            }

            if (rsUser != null && rsUser.next()) {
                String storedHashedPassword = rsUser.getString("hashed_password");
                
                if (PasswordConf.verifyPassword(password, storedHashedPassword)) {
                    int userId = rsUser.getInt("user_id");
                    
                    session.setAttribute("user_id", userId);
                    session.setAttribute("username", rsUser.getString("username"));
                    session.setAttribute("email", email);
                    session.setAttribute("full_name", rsUser.getString("full_name"));
                    session.setAttribute("role_id", rsUser.getInt("role_id"));
                    session.setAttribute("role_name", rsUser.getString("role_name"));
                    session.setAttribute("isLoggedIn", true);

                    DBConnection_BCKP dbUpdate = new DBConnection_BCKP();
                    dbUpdate.runQuery("UPDATE users SET login = 1 WHERE user_id = " + userId);
                    
                    response.sendRedirect("Admin/index.jsp");
                    return;

                } else {
                    request.setAttribute("notificationMsg", "Email atau Password Salah.");
                    request.setAttribute("notificationType", "error");
                }
            } else {
                request.setAttribute("notificationMsg", "Email atau Password Salah.");
                request.setAttribute("notificationType", "error");
            }

            request.getRequestDispatcher("Admin/login.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("notificationMsg", "Terjadi kesalahan SQL: " + e.getMessage());
            request.setAttribute("notificationType", "error");
            request.getRequestDispatcher("Admin/login.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("notificationMsg", "Terjadi kesalahan sistem: " + e.getMessage());
            request.setAttribute("notificationType", "error");
            request.getRequestDispatcher("Admin/login.jsp").forward(request, response);
        } finally {
            try {
                if (rsUser != null) rsUser.close();
            } catch (SQLException ex) {
                System.err.println("Error closing ResultSet: " + ex.getMessage());
            }

            // Penting untuk memanggil disconnect() setelah selesai menggunakan koneksi dari getData()
            if (db != null && db.isConnected()) {
                db.disconnect();
            }
        }
    }
}
