package DAO;

import Config.PasswordConf;
import Config.ValidationConf;
import Models.Customer;
import Models.UserRoles;
import Models.Users;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UsersDao extends Models<Users> {
    
    public UsersDao() {
        this.table = "users";
        this.primaryKey = "user_id";
    }
    
    @Override
    Users toModel(ResultSet rs) {
        Users user = new Users();
        try {
            user.setUserId(rs.getInt("user_id"));
            user.setUsername(rs.getString("username"));
            user.setEmail(rs.getString("email"));
            user.setPassword(rs.getString("password"));
            user.setFullName(rs.getString("full_name"));
            user.setGender(rs.getString("gender"));
            user.setBirthDate(rs.getDate("birth_date"));
            
            // Convert role_id to UserRoles enum
            int roleId = rs.getInt("role_id");
            user.setRoleById(roleId);
            
            user.setImagePath(rs.getString("image_path"));
            user.setLogin(rs.getBoolean("login"));
        } catch (SQLException e) {
            setMessage("Error mapping ResultSet to Users: " + e.getMessage());
        }
        return user;
    }
    
    // Method khusus untuk mapping Customer dengan phone dan address
    private Customer toCustomerModel(ResultSet rs) {
        Customer customer = new Customer();
        try {
            customer.setUserId(rs.getInt("user_id"));
            customer.setUsername(rs.getString("username"));
            customer.setEmail(rs.getString("email"));
            customer.setPassword(rs.getString("password"));
            customer.setFullName(rs.getString("full_name"));
            customer.setGender(rs.getString("gender"));
            customer.setBirthDate(rs.getDate("birth_date"));
            
            // Convert role_id to UserRoles enum
            int roleId = rs.getInt("role_id");
            customer.setRoleById(roleId);
            
            customer.setImagePath(rs.getString("image_path"));
            customer.setLogin(rs.getBoolean("login"));
            
            // Customer specific fields
            customer.setPhone(rs.getString("phone"));
        } catch (SQLException e) {
            setMessage("Error mapping ResultSet to Customer: " + e.getMessage());
        }
        return customer;
    }

    // Method khusus untuk mapping Customer dengan phone (tanpa address)
    private Customer toCustomerBasicModel(ResultSet rs) {
        Customer customer = new Customer();
        try {
            customer.setUserId(rs.getInt("user_id"));
            customer.setUsername(rs.getString("username"));
            customer.setEmail(rs.getString("email"));
            customer.setPassword(rs.getString("password"));
            customer.setFullName(rs.getString("full_name"));
            customer.setGender(rs.getString("gender"));
            customer.setBirthDate(rs.getDate("birth_date"));

            // Convert role_id to UserRoles enum
            int roleId = rs.getInt("role_id");
            customer.setRoleById(roleId);

            customer.setImagePath(rs.getString("image_path"));
            customer.setLogin(rs.getBoolean("login"));

            // Customer specific fields (hanya phone, tanpa address)
            customer.setPhone(rs.getString("phone"));
            // address tidak diset, dibiarkan null

        } catch (SQLException e) {
            setMessage("Error mapping ResultSet to Customer: " + e.getMessage());
        }
        return customer;
    }
    
    // Method untuk registrasi user baru dengan UserRoles
    public boolean registerUser(String username, String email, String password, String fullName, UserRoles role) {
        return registerUser(username, email, password, fullName, role.getRoleId());
    }
    
    // Method untuk registrasi user baru dengan roleId (overloaded)
    public boolean registerUser(String username, String email, String password, String fullName, int roleId) {
        try {
            // Validasi role ID
            if (!UserRoles.isValidRoleId(roleId)) {
                setMessage("Invalid role ID: " + roleId);
                return false;
            }
            
            // Validasi input menggunakan ValidationConf
            if (ValidationConf.isEmpty(username) || ValidationConf.isEmpty(email) || 
                ValidationConf.isEmpty(password) || ValidationConf.isEmpty(fullName)) {
                setMessage("Semua field harus diisi");
                return false;
            }
            
            if (!ValidationConf.isValidEmail(email)) {
                setMessage("Format email tidak valid");
                return false;
            }
            
            if (!ValidationConf.isValidUsername(username)) {
                setMessage("Username harus 3-20 karakter dan hanya boleh mengandung huruf, angka, dan underscore");
                return false;
            }
            
            if (!ValidationConf.isValidName(fullName)) {
                setMessage("Nama lengkap hanya boleh mengandung huruf dan spasi");
                return false;
            }
            
            if (!ValidationConf.isStrongPassword(password)) {
                setMessage(ValidationConf.getPasswordStrengthMessage(password));
                return false;
            }
            
            connect();
            
            // Check if username or email already exists
            if (isUsernameExists(username)) {
                setMessage("Username sudah digunakan");
                return false;
            }
            
            if (isEmailExists(email)) {
                setMessage("Email sudah terdaftar");
                return false;
            }
            
            // Hash password menggunakan BCrypt
            String hashedPassword = PasswordConf.hashPassword(password);
            
            // Sanitize input untuk SQL
            String sanitizedUsername = ValidationConf.sanitizeForSQL(username);
            String sanitizedEmail = ValidationConf.sanitizeForSQL(email);
            String sanitizedFullName = ValidationConf.sanitizeForSQL(fullName);
            
            // Insert new user
            String query = "INSERT INTO users (username, email, password, full_name, role_id, login) VALUES ('" 
                         + sanitizedUsername + "', '" + sanitizedEmail + "', '" + hashedPassword + "', '" 
                         + sanitizedFullName + "', " + roleId + ", 0)";
            
            int result = stmt.executeUpdate(query);
            
            if (result > 0) {
                // Get the inserted user ID
                ResultSet rs = stmt.executeQuery("SELECT LAST_INSERT_ID() as user_id");
                if (rs.next()) {
                    int userId = rs.getInt("user_id");
                    
                    // Insert into specific role table
                    insertIntoRoleTable(userId, roleId);
                    
                    setMessage("User berhasil didaftarkan");
                    return true;
                }
            }
            
        } catch (SQLException e) {
            setMessage("Registrasi gagal: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }
    
    // Method untuk login dengan BCrypt verification
    public Users login(String username, String password) {
        try {
            // Validasi input
            if (ValidationConf.isEmpty(username) || ValidationConf.isEmpty(password)) {
                setMessage("Username/email dan password tidak boleh kosong");
                return null;
            }
            
            connect();
            
            // Sanitize input
            String sanitizedUsername = ValidationConf.sanitizeForSQL(username);
            
            // Get user data first (without password verification in SQL)
            String query = "SELECT u.*, ur.role_name FROM users u " +
                          "JOIN user_role ur ON u.role_id = ur.role_id " +
                          "WHERE (u.username = '" + sanitizedUsername + "' OR u.email = '" + sanitizedUsername + "')";
            
            ResultSet rs = stmt.executeQuery(query);
            
            if (rs.next()) {
                String storedHashedPassword = rs.getString("password");
                
                // Verify password menggunakan BCrypt
                if (PasswordConf.verifyPassword(password, storedHashedPassword)) {
                    Users user = toModel(rs);
                    
                    // Update login status
                    updateLoginStatus(user.getUserId(), true);
                    user.setLogin(true);
                    
                    setMessage("Login berhasil");
                    return user;
                } else {
                    setMessage("Username/email atau password salah");
                }
            } else {
                setMessage("Username/email tidak ditemukan");
            }
            
        } catch (SQLException e) {
            setMessage("Login gagal: " + e.getMessage());
        } finally {
            disconnect();
        }
        return null;
    }
    
    // Method untuk mendapatkan user berdasarkan role enum
    public ArrayList<Users> getUsersByRole(UserRoles role) {
        return getUsersByRole(role.getRoleId());
    }
    
    // Method untuk mendapatkan user berdasarkan role ID (overloaded)
    public ArrayList<Users> getUsersByRole(int roleId) {
        this.where("role_id = " + roleId);
        return this.get();
    }
    
    // Method untuk mendapatkan semua admin
    public ArrayList<Users> getAllAdmins() {
        return getUsersByRole(UserRoles.ADMIN);
    }
    
    // Method untuk mendapatkan semua staff
    public ArrayList<Users> getAllStaff() {
        return getUsersByRole(UserRoles.STAFF);
    }
    
    // Method untuk mendapatkan semua customer
    public ArrayList<Users> getAllCustomers() {
        return getUsersByRole(UserRoles.CUSTOMER);
    }
    
    // Method untuk update role user
    public boolean updateUserRole(int userId, UserRoles newRole) {
        try {
            connect();
            
            // Get current role
            Users user = find(String.valueOf(userId));
            if (user == null) {
                setMessage("User tidak ditemukan");
                return false;
            }
            
            UserRoles oldRole = user.getRole();
            
            // Update role in users table
            String query = "UPDATE users SET role_id = " + newRole.getRoleId() + 
                          " WHERE user_id = " + userId;
            
            int result = stmt.executeUpdate(query);
            
            if (result > 0) {
                // Remove from old role table
                removeFromRoleTable(userId, oldRole.getRoleId());
                
                // Insert into new role table
                insertIntoRoleTable(userId, newRole.getRoleId());
                
                setMessage("Role user berhasil diupdate");
                return true;
            }
            
        } catch (SQLException e) {
            setMessage("Gagal update role user: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }
    
    // Method untuk logout
    public boolean logout(int userId) {
        return updateLoginStatus(userId, false);
    }
    
    // Method untuk update login status
    private boolean updateLoginStatus(int userId, boolean status) {
        try {
            connect();
            String query = "UPDATE users SET login = " + (status ? 1 : 0) + " WHERE user_id = " + userId;
            int result = stmt.executeUpdate(query);
            return result > 0;
        } catch (SQLException e) {
            setMessage("Gagal update status login: " + e.getMessage());
            return false;
        } finally {
            disconnect();
        }
    }
    
    // Method untuk update profile user
    public boolean updateProfile(int userId, String fullName, String gender, java.util.Date birthDate, String imagePath) {
        try {
            // Validasi input
            if (ValidationConf.isEmpty(fullName)) {
                setMessage("Nama lengkap tidak boleh kosong");
                return false;
            }
            
            if (!ValidationConf.isValidName(fullName)) {
                setMessage("Nama lengkap hanya boleh mengandung huruf dan spasi");
                return false;
            }
            
            connect();
            
            String sanitizedFullName = ValidationConf.sanitizeForSQL(fullName);
            String sanitizedGender = ValidationConf.sanitizeForSQL(gender);
            String sanitizedImagePath = ValidationConf.sanitizeForSQL(imagePath);
            
            String query = "UPDATE users SET full_name = '" + sanitizedFullName + "', " +
                          "gender = '" + sanitizedGender + "', " +
                          "birth_date = '" + new java.sql.Date(birthDate.getTime()) + "', " +
                          "image_path = '" + sanitizedImagePath + "' " +
                          "WHERE user_id = " + userId;
            
            int result = stmt.executeUpdate(query);
            if (result > 0) {
                setMessage("Profil berhasil diupdate");
                return true;
            }
        } catch (SQLException e) {
            setMessage("Gagal update profil: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }
    
    // Method untuk search users
    public ArrayList<Users> searchUsers(String keyword) {
        if (ValidationConf.isEmpty(keyword)) {
            return new ArrayList<>();
        }
        
        String sanitizedKeyword = ValidationConf.sanitizeForSQL(keyword);
        this.where("username LIKE '%" + sanitizedKeyword + "%' OR email LIKE '%" + sanitizedKeyword + 
                  "%' OR full_name LIKE '%" + sanitizedKeyword + "%'");
        return this.get();
    }
    
    // Method untuk mendapatkan user berdasarkan email
    public Users getUserByEmail(String email) {
        try {
            if (!ValidationConf.isValidEmail(email)) {
                setMessage("Format email tidak valid");
                return null;
            }
            
            connect();
            String sanitizedEmail = ValidationConf.sanitizeForSQL(email);
            String query = "SELECT * FROM users WHERE email = '" + sanitizedEmail + "'";
            ResultSet rs = stmt.executeQuery(query);
            
            if (rs.next()) {
                return toModel(rs);
            }
        } catch (SQLException e) {
            setMessage("Error mendapatkan user berdasarkan email: " + e.getMessage());
        } finally {
            disconnect();
        }
        return null;
    }
    
    // ===== TAMBAHAN METHOD UNTUK USER MANAGEMENT =====
    
    // Method untuk mendapatkan user berdasarkan ID
    public Users getUserById(int userId) {
        return find(String.valueOf(userId));
    }
    
    // Method untuk update user tanpa mengubah password (untuk admin panel)
    public boolean updateUser(int userId, String username, String email, String fullName, 
                             String gender, java.util.Date birthDate) {
        try {
            // Validasi input
            if (ValidationConf.isEmpty(username) || ValidationConf.isEmpty(email)) {
                setMessage("Username dan email tidak boleh kosong");
                return false;
            }
            
            if (!ValidationConf.isValidEmail(email)) {
                setMessage("Format email tidak valid");
                return false;
            }
            
            if (!ValidationConf.isValidUsername(username)) {
                setMessage("Username harus 3-20 karakter dan hanya boleh mengandung huruf, angka, dan underscore");
                return false;
            }
            
            if (!ValidationConf.isEmpty(fullName) && !ValidationConf.isValidName(fullName)) {
                setMessage("Nama lengkap hanya boleh mengandung huruf dan spasi");
                return false;
            }
            
            connect();
            
            // Check if username exists for other users
            if (isUsernameExistsForOtherUser(username, userId)) {
                setMessage("Username sudah digunakan oleh user lain");
                return false;
            }
            
            // Check if email exists for other users
            if (isEmailExistsForOtherUser(email, userId)) {
                setMessage("Email sudah digunakan oleh user lain");
                return false;
            }
            
            // Sanitize input
            String sanitizedUsername = ValidationConf.sanitizeForSQL(username);
            String sanitizedEmail = ValidationConf.sanitizeForSQL(email);
            String sanitizedFullName = ValidationConf.sanitizeForSQL(fullName != null ? fullName : "");
            String sanitizedGender = ValidationConf.sanitizeForSQL(gender != null ? gender : "");
            
            String query = "UPDATE users SET username = '" + sanitizedUsername + "', " +
                          "email = '" + sanitizedEmail + "', " +
                          "full_name = '" + sanitizedFullName + "', " +
                          "gender = '" + sanitizedGender + "'";
            
            if (birthDate != null) {
                query += ", birth_date = '" + new java.sql.Date(birthDate.getTime()) + "'";
            }
            
            query += " WHERE user_id = " + userId;
            
            int result = stmt.executeUpdate(query);
            if (result > 0) {
                setMessage("User berhasil diupdate");
                return true;
            } else {
                setMessage("User tidak ditemukan");
            }
            
        } catch (SQLException e) {
            setMessage("Gagal mengupdate user: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }
    
    // Method untuk update user dengan password baru (untuk admin panel)
    public boolean updateUserWithPassword(int userId, String username, String email, String fullName,
                                     String gender, java.util.Date birthDate, String newPassword) {
        try {
            // Validasi input
            if (ValidationConf.isEmpty(username) || ValidationConf.isEmpty(email)) {
                setMessage("Username dan email tidak boleh kosong");
                return false;
            }
            
            if (!ValidationConf.isValidEmail(email)) {
                setMessage("Format email tidak valid");
                return false;
            }
            
            if (!ValidationConf.isValidUsername(username)) {
                setMessage("Username harus 3-20 karakter dan hanya boleh mengandung huruf, angka, dan underscore");
                return false;
            }
            
            if (!ValidationConf.isEmpty(fullName) && !ValidationConf.isValidName(fullName)) {
                setMessage("Nama lengkap hanya boleh mengandung huruf dan spasi");
                return false;
            }
            
            if (!ValidationConf.isStrongPassword(newPassword)) {
                setMessage(ValidationConf.getPasswordStrengthMessage(newPassword));
                return false;
            }
            
            connect();
            
            // Check if username exists for other users
            if (isUsernameExistsForOtherUser(username, userId)) {
                setMessage("Username sudah digunakan oleh user lain");
                return false;
            }
            
            // Check if email exists for other users
            if (isEmailExistsForOtherUser(email, userId)) {
                setMessage("Email sudah digunakan oleh user lain");
                return false;
            }
            
            // Hash new password
            String hashedPassword = PasswordConf.hashPassword(newPassword);
            
            // Sanitize input
            String sanitizedUsername = ValidationConf.sanitizeForSQL(username);
            String sanitizedEmail = ValidationConf.sanitizeForSQL(email);
            String sanitizedFullName = ValidationConf.sanitizeForSQL(fullName != null ? fullName : "");
            String sanitizedGender = ValidationConf.sanitizeForSQL(gender != null ? gender : "");
            
            String query = "UPDATE users SET username = '" + sanitizedUsername + "', " +
                          "email = '" + sanitizedEmail + "', " +
                          "password = '" + hashedPassword + "', " +
                          "full_name = '" + sanitizedFullName + "', " +
                          "gender = '" + sanitizedGender + "'";
            
            if (birthDate != null) {
                query += ", birth_date = '" + new java.sql.Date(birthDate.getTime()) + "'";
            }
            
            query += " WHERE user_id = " + userId;
            
            int result = stmt.executeUpdate(query);
            if (result > 0) {
                setMessage("User berhasil diupdate");
                return true;
            } else {
                setMessage("User tidak ditemukan");
            }
            
        } catch (SQLException e) {
            setMessage("Gagal mengupdate user: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }
    
    // Method untuk delete user (untuk admin panel)
    public boolean deleteUser(int userId) {
        try {
            connect();
            
            // Get user role first untuk remove dari role table
            Users user = find(String.valueOf(userId));
            if (user != null) {
                // Remove from role-specific table first
                removeFromRoleTable(userId, user.getRole().getRoleId());
            }
            
            // Delete from users table
            String query = "DELETE FROM users WHERE user_id = " + userId;
            int result = stmt.executeUpdate(query);
            
            if (result > 0) {
                setMessage("User berhasil dihapus");
                return true;
            } else {
                setMessage("User tidak ditemukan");
            }
            
        } catch (SQLException e) {
            setMessage("Gagal menghapus user: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }
    
    
    // Method untuk filter users berdasarkan gender dan role
    public ArrayList<Users> getUsersByGenderAndRole(String gender, UserRoles role) {
        try {
            connect();
            String sanitizedGender = ValidationConf.sanitizeForSQL(gender);
            String query = "SELECT * FROM users WHERE gender = '" + sanitizedGender + 
                          "' AND role_id = " + role.getRoleId() + " ORDER BY user_id DESC";
            
            ArrayList<Users> users = new ArrayList<>();
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                users.add(toModel(rs));
            }
            
            return users;
            
        } catch (SQLException e) {
            setMessage("Error getting users by gender and role: " + e.getMessage());
            return new ArrayList<>();
        } finally {
            disconnect();
        }
    }
    
    // Method untuk mendapatkan user dengan detail role
    public ArrayList<Users> getAllUsersWithRoleDetails() {
        try {
            connect();
            String query = "SELECT u.*, ur.role_name FROM users u " +
                          "JOIN user_role ur ON u.role_id = ur.role_id " +
                          "ORDER BY u.user_id DESC";
            
            ArrayList<Users> users = new ArrayList<>();
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                users.add(toModel(rs));
            }
            
            return users;
            
        } catch (SQLException e) {
            setMessage("Error getting users with role details: " + e.getMessage());
            return new ArrayList<>();
        } finally {
            disconnect();
        }
    }
    
    // Method untuk cek apakah username sudah ada untuk user lain (untuk edit)
    private boolean isUsernameExistsForOtherUser(String username, int userId) {
        try {
            String sanitizedUsername = ValidationConf.sanitizeForSQL(username);
            String query = "SELECT COUNT(*) as count FROM users WHERE username = '" + sanitizedUsername + 
                          "' AND user_id != " + userId;
            ResultSet rs = stmt.executeQuery(query);
            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
        } catch (SQLException e) {
            setMessage("Error checking username for other user: " + e.getMessage());
        }
        return false;
    }
    
    // Method untuk cek apakah email sudah ada untuk user lain (untuk edit)
    private boolean isEmailExistsForOtherUser(String email, int userId) {
        try {
            String sanitizedEmail = ValidationConf.sanitizeForSQL(email);
            String query = "SELECT COUNT(*) as count FROM users WHERE email = '" + sanitizedEmail + 
                          "' AND user_id != " + userId;
            ResultSet rs = stmt.executeQuery(query);
            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
        } catch (SQLException e) {
            setMessage("Error checking email for other user: " + e.getMessage());
        }
        return false;
    }
    
    // Method untuk mendapatkan total count berdasarkan role
    public int getTotalUsersByRole(UserRoles role) {
        try {
            connect();
            String query = "SELECT COUNT(*) as total FROM users WHERE role_id = " + role.getRoleId();
            ResultSet rs = stmt.executeQuery(query);
            
            if (rs.next()) {
                return rs.getInt("total");
            }
            
        } catch (SQLException e) {
            setMessage("Error getting total users by role: " + e.getMessage());
        } finally {
            disconnect();
        }
        return 0;
    }
    
    // Method untuk mendapatkan recent users berdasarkan role
    public ArrayList<Users> getRecentUsersByRole(UserRoles role, int limit) {
        try {
            connect();
            String query = "SELECT * FROM users WHERE role_id = " + role.getRoleId() + 
                          " ORDER BY user_id DESC LIMIT " + limit;
            
            ArrayList<Users> users = new ArrayList<>();
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                users.add(toModel(rs));
            }
            
            return users;
            
        } catch (SQLException e) {
            setMessage("Error getting recent users by role: " + e.getMessage());
            return new ArrayList<>();
        } finally {
            disconnect();
        }
    }
    
    // Method khusus untuk update Customer dengan phone dan address
    public boolean updateCustomer(int userId, String username, String email, String fullName, 
                                 String gender, java.util.Date birthDate, String phone, String address) {
        try {
            // Validasi input
            if (ValidationConf.isEmpty(username) || ValidationConf.isEmpty(email)) {
                setMessage("Username dan email tidak boleh kosong");
                return false;
            }
            
            if (!ValidationConf.isValidEmail(email)) {
                setMessage("Format email tidak valid");
                return false;
            }
            
            if (!ValidationConf.isValidUsername(username)) {
                setMessage("Username harus 3-20 karakter dan hanya boleh mengandung huruf, angka, dan underscore");
                return false;
            }
            
            if (!ValidationConf.isEmpty(fullName) && !ValidationConf.isValidName(fullName)) {
                setMessage("Nama lengkap hanya boleh mengandung huruf dan spasi");
                return false;
            }
            
            connect();
            
            // Check if username exists for other users
            if (isUsernameExistsForOtherUser(username, userId)) {
                setMessage("Username sudah digunakan oleh user lain");
                return false;
            }
            
            // Check if email exists for other users
            if (isEmailExistsForOtherUser(email, userId)) {
                setMessage("Email sudah digunakan oleh user lain");
                return false;
            }
            
            // Sanitize input
            String sanitizedUsername = ValidationConf.sanitizeForSQL(username);
            String sanitizedEmail = ValidationConf.sanitizeForSQL(email);
            String sanitizedFullName = ValidationConf.sanitizeForSQL(fullName != null ? fullName : "");
            String sanitizedGender = ValidationConf.sanitizeForSQL(gender != null ? gender : "");
            String sanitizedPhone = ValidationConf.sanitizeForSQL(phone != null ? phone : "");
            String sanitizedAddress = ValidationConf.sanitizeForSQL(address != null ? address : "");
            
            String query = "UPDATE users SET username = '" + sanitizedUsername + "', " +
                          "email = '" + sanitizedEmail + "', " +
                          "full_name = '" + sanitizedFullName + "', " +
                          "gender = '" + sanitizedGender + "', " +
                          "phone = '" + sanitizedPhone + "', " +
                          "address = '" + sanitizedAddress + "'";
            
            if (birthDate != null) {
                query += ", birth_date = '" + new java.sql.Date(birthDate.getTime()) + "'";
            }
            
            query += " WHERE user_id = " + userId;
            
            int result = stmt.executeUpdate(query);
            if (result > 0) {
                setMessage("Customer berhasil diupdate");
                return true;
            } else {
                setMessage("Customer tidak ditemukan");
            }
            
        } catch (SQLException e) {
            setMessage("Gagal mengupdate customer: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }

    // Method khusus untuk update Customer dengan password baru
    public boolean updateCustomerWithPassword(int userId, String username, String email, String fullName,
                                             String gender, java.util.Date birthDate, String phone, 
                                             String address, String newPassword) {
        try {
            // Validasi input
            if (ValidationConf.isEmpty(username) || ValidationConf.isEmpty(email)) {
                setMessage("Username dan email tidak boleh kosong");
                return false;
            }
            
            if (!ValidationConf.isValidEmail(email)) {
                setMessage("Format email tidak valid");
                return false;
            }
            
            if (!ValidationConf.isValidUsername(username)) {
                setMessage("Username harus 3-20 karakter dan hanya boleh mengandung huruf, angka, dan underscore");
                return false;
            }
            
            if (!ValidationConf.isEmpty(fullName) && !ValidationConf.isValidName(fullName)) {
                setMessage("Nama lengkap hanya boleh mengandung huruf dan spasi");
                return false;
            }
            
            if (!ValidationConf.isStrongPassword(newPassword)) {
                setMessage(ValidationConf.getPasswordStrengthMessage(newPassword));
                return false;
            }
            
            connect();
            
            // Check if username exists for other users
            if (isUsernameExistsForOtherUser(username, userId)) {
                setMessage("Username sudah digunakan oleh user lain");
                return false;
            }
            
            // Check if email exists for other users
            if (isEmailExistsForOtherUser(email, userId)) {
                setMessage("Email sudah digunakan oleh user lain");
                return false;
            }
            
            // Hash new password
            String hashedPassword = PasswordConf.hashPassword(newPassword);
            
            // Sanitize input
            String sanitizedUsername = ValidationConf.sanitizeForSQL(username);
            String sanitizedEmail = ValidationConf.sanitizeForSQL(email);
            String sanitizedFullName = ValidationConf.sanitizeForSQL(fullName != null ? fullName : "");
            String sanitizedGender = ValidationConf.sanitizeForSQL(gender != null ? gender : "");
            String sanitizedPhone = ValidationConf.sanitizeForSQL(phone != null ? phone : "");
            String sanitizedAddress = ValidationConf.sanitizeForSQL(address != null ? address : "");
            
            String query = "UPDATE users SET username = '" + sanitizedUsername + "', " +
                          "email = '" + sanitizedEmail + "', " +
                          "password = '" + hashedPassword + "', " +
                          "full_name = '" + sanitizedFullName + "', " +
                          "gender = '" + sanitizedGender + "', " +
                          "phone = '" + sanitizedPhone + "', " +
                          "address = '" + sanitizedAddress + "'";
            
            if (birthDate != null) {
                query += ", birth_date = '" + new java.sql.Date(birthDate.getTime()) + "'";
            }
            
            query += " WHERE user_id = " + userId;
            
            int result = stmt.executeUpdate(query);
            if (result > 0) {
                setMessage("Customer berhasil diupdate");
                return true;
            } else {
                setMessage("Customer tidak ditemukan");
            }
            
        } catch (SQLException e) {
            setMessage("Gagal mengupdate customer: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }

    // Method untuk mendapatkan Customer dengan phone dan address
    public ArrayList<Customer> getAllCustomersWithDetails() {
        ArrayList<Customer> customers = new ArrayList<>();
        try {
            connect();
            String query = "SELECT * FROM users WHERE role_id = " + UserRoles.CUSTOMER.getRoleId() + " ORDER BY user_id DESC";
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                customers.add(toCustomerModel(rs));
            }

        } catch (SQLException e) {
            setMessage("Error getting customers with details: " + e.getMessage());
        } finally {
            disconnect();
        }
        return customers;
    }

    // Method untuk mendapatkan Customer berdasarkan ID
    public Customer getCustomerById(int userId) {
        try {
            connect();
            String query = "SELECT * FROM users WHERE user_id = " + userId + " AND role_id = " + UserRoles.CUSTOMER.getRoleId();
            ResultSet rs = stmt.executeQuery(query);

            if (rs.next()) {
                return toCustomerModel(rs);
            }

        } catch (SQLException e) {
            setMessage("Error getting customer by ID: " + e.getMessage());
        } finally {
            disconnect();
        }
        return null;
    }

    // ===== CUSTOMER SPECIFIC METHODS (TANPA ADDRESS) =====

    // Method khusus untuk update Customer dengan phone (tanpa address)
    public boolean updateCustomer(int userId, String username, String email, String fullName,
                                 String gender, java.util.Date birthDate) {
        try {
            // Validasi input
            if (ValidationConf.isEmpty(username) || ValidationConf.isEmpty(email)) {
                setMessage("Username dan email tidak boleh kosong");
                return false;
            }

            if (!ValidationConf.isValidEmail(email)) {
                setMessage("Format email tidak valid");
                return false;
            }

            if (!ValidationConf.isValidUsername(username)) {
                setMessage("Username harus 3-20 karakter dan hanya boleh mengandung huruf, angka, dan underscore");
                return false;
            }

            if (!ValidationConf.isEmpty(fullName) && !ValidationConf.isValidName(fullName)) {
                setMessage("Nama lengkap hanya boleh mengandung huruf dan spasi");
                return false;
            }

            connect();

            // Check if username exists for other users
            if (isUsernameExistsForOtherUser(username, userId)) {
                setMessage("Username sudah digunakan oleh user lain");
                return false;
            }

            // Check if email exists for other users
            if (isEmailExistsForOtherUser(email, userId)) {
                setMessage("Email sudah digunakan oleh user lain");
                return false;
            }

            // Sanitize input
            String sanitizedUsername = ValidationConf.sanitizeForSQL(username);
            String sanitizedEmail = ValidationConf.sanitizeForSQL(email);
            String sanitizedFullName = ValidationConf.sanitizeForSQL(fullName != null ? fullName : "");
            String sanitizedGender = ValidationConf.sanitizeForSQL(gender != null ? gender : "");

            String query = "UPDATE users SET username = '" + sanitizedUsername + "', " +
                             "email = '" + sanitizedEmail + "', " +
                             "full_name = '" + sanitizedFullName + "', " +
                             "gender = '" + sanitizedGender + "'";
            
            if (birthDate != null) {
                query += ", birth_date = '" + new java.sql.Date(birthDate.getTime()) + "'";
            }
            
            query += " WHERE user_id = " + userId;
            
            int result = stmt.executeUpdate(query);
            if (result > 0) {
                setMessage("Customer berhasil diupdate");
                return true;
            } else {
                setMessage("Customer tidak ditemukan");
            }
            
        } catch (SQLException e) {
            setMessage("Gagal mengupdate customer: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }

    // Method khusus untuk update Customer dengan password baru (tanpa address)
    public boolean updateCustomerWithPassword(int userId, String username, String email, String fullName,
                                             String gender, java.util.Date birthDate,
                                             String newPassword) {
        try {
            // Validasi input
            if (ValidationConf.isEmpty(username) || ValidationConf.isEmpty(email)) {
                setMessage("Username dan email tidak boleh kosong");
                return false;
            }
            
            if (!ValidationConf.isValidEmail(email)) {
                setMessage("Format email tidak valid");
                return false;
            }
            
            if (!ValidationConf.isValidUsername(username)) {
                setMessage("Username harus 3-20 karakter dan hanya boleh mengandung huruf, angka, dan underscore");
                return false;
            }
            
            if (!ValidationConf.isEmpty(fullName) && !ValidationConf.isValidName(fullName)) {
                setMessage("Nama lengkap hanya boleh mengandung huruf dan spasi");
                return false;
            }
            
            if (!ValidationConf.isStrongPassword(newPassword)) {
                setMessage(ValidationConf.getPasswordStrengthMessage(newPassword));
                return false;
            }
            
            connect();
            
            // Check if username exists for other users
            if (isUsernameExistsForOtherUser(username, userId)) {
                setMessage("Username sudah digunakan oleh user lain");
                return false;
            }
            
            // Check if email exists for other users
            if (isEmailExistsForOtherUser(email, userId)) {
                setMessage("Email sudah digunakan oleh user lain");
                return false;
            }
            
            // Hash new password
            String hashedPassword = PasswordConf.hashPassword(newPassword);
            
            // Sanitize input
            String sanitizedUsername = ValidationConf.sanitizeForSQL(username);
            String sanitizedEmail = ValidationConf.sanitizeForSQL(email);
            String sanitizedFullName = ValidationConf.sanitizeForSQL(fullName != null ? fullName : "");
            String sanitizedGender = ValidationConf.sanitizeForSQL(gender != null ? gender : "");
            
            String query = "UPDATE users SET username = '" + sanitizedUsername + "', " +
                             "email = '" + sanitizedEmail + "', " +
                             "password = '" + hashedPassword + "', " +
                             "full_name = '" + sanitizedFullName + "', " +
                             "gender = '" + sanitizedGender + "'";
            
            if (birthDate != null) {
                query += ", birth_date = '" + new java.sql.Date(birthDate.getTime()) + "'";
            }
            
            query += " WHERE user_id = " + userId;
            
            int result = stmt.executeUpdate(query);
            if (result > 0) {
                setMessage("Customer berhasil diupdate");
                return true;
            } else {
                setMessage("Customer tidak ditemukan");
            }
            
        } catch (SQLException e) {
            setMessage("Gagal mengupdate customer: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }

    // Method untuk mendapatkan Customer dengan basic details (tanpa address)
    public ArrayList<Customer> getAllCustomersBasic() {
        ArrayList<Customer> customers = new ArrayList<>();
        try {
            connect();
            String query = "SELECT * FROM users WHERE role_id = " + UserRoles.CUSTOMER.getRoleId() + " ORDER BY user_id DESC";
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                customers.add(toCustomerBasicModel(rs));
            }

        } catch (SQLException e) {
            setMessage("Error getting customers basic: " + e.getMessage());
        } finally {
            disconnect();
        }
        return customers;
    }
    
    // ===== EXISTING METHODS =====
    
    // Method untuk cek apakah username sudah ada
    private boolean isUsernameExists(String username) {
        try {
            String sanitizedUsername = ValidationConf.sanitizeForSQL(username);
            String query = "SELECT COUNT(*) as count FROM users WHERE username = '" + sanitizedUsername + "'";
            ResultSet rs = stmt.executeQuery(query);
            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
        } catch (SQLException e) {
            setMessage("Error checking username: " + e.getMessage());
        }
        return false;
    }
    
    // Method untuk cek apakah email sudah ada
    private boolean isEmailExists(String email) {
        try {
            String sanitizedEmail = ValidationConf.sanitizeForSQL(email);
            String query = "SELECT COUNT(*) as count FROM users WHERE email = '" + sanitizedEmail + "'";
            ResultSet rs = stmt.executeQuery(query);
            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
        } catch (SQLException e) {
            setMessage("Error checking email: " + e.getMessage());
        }
        return false;
    }
    
    // Method untuk insert ke tabel role spesifik
    private void insertIntoRoleTable(int userId, int roleId) {
        try {
            String query = "";
            switch (roleId) {
                case 1: // Admin
                    query = "INSERT INTO admin (user_id) VALUES (" + userId + ")";
                    break;
                case 2: // Staff
                    query = "INSERT INTO staff (user_id) VALUES (" + userId + ")";
                    break;
                case 3: // Customer
                    query = "INSERT INTO customer (user_id) VALUES (" + userId + ")";
                    break;
            }
            
            if (!query.isEmpty()) {
                stmt.executeUpdate(query);
            }
        } catch (SQLException e) {
            setMessage("Error inserting into role table: " + e.getMessage());
        }
    }
    
    // Helper method untuk remove dari role table
    private void removeFromRoleTable(int userId, int roleId) {
        try {
            String query = "";
            switch (roleId) {
                case 1: // Admin
                    query = "DELETE FROM admin WHERE user_id = " + userId;
                    break;
                case 2: // Staff
                    query = "DELETE FROM staff WHERE user_id = " + userId;
                    break;
                case 3: // Customer
                    query = "DELETE FROM customer WHERE user_id = " + userId;
                    break;
            }
            
            if (!query.isEmpty()) {
                stmt.executeUpdate(query);
            }
        } catch (SQLException e) {
            setMessage("Error removing from role table: " + e.getMessage());
        }
    }
}
