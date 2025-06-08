package DAO;

import Config.DBConnection;
import Models.Users;

import Models.Users;
import Models.UserRole;
import java.util.List;

public interface UserDAO extends BaseDAO<Users, Integer> {
    
    /**
     * Find a user by username
     * @param username The username to search for
     * @return The user if found, null otherwise
     */
    Users findByUsername(String username);
    
    /**
     * Find a user by email
     * @param email The email to search for
     * @return The user if found, null otherwise
     */
    Users findByEmail(String email);
    
    /**
     * Find users by role
     * @param role The role to search for
     * @return A list of users with the given role
     */
    List<Users> findByRole(UserRole role);
    
    /**
     * Authenticate a user
     * @param username The username
     * @param password The password
     * @return The authenticated user if successful, null otherwise
     */
    Users authenticate(String username, String password);
    
    /**
     * Update user password
     * @param userId The user ID
     * @param newPassword The new password
     * @return true if successful, false otherwise
     */
    boolean updatePassword(int userId, String newPassword);
    
    /**
     * Check if username exists
     * @param username The username to check
     * @return true if exists, false otherwise
     */
    boolean usernameExists(String username);
    
    /**
     * Check if email exists
     * @param email The email to check
     * @return true if exists, false otherwise
     */
    boolean emailExists(String email);
}
