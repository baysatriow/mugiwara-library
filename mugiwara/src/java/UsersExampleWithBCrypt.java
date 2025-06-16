import DAO.UsersDao;
import Models.Users;
import Models.UserRoles;
import Config.PasswordConf;
import java.util.ArrayList;

public class UsersExampleWithBCrypt {
    
    public static void main(String[] args) {
        UsersDao userDao = new UsersDao();
        
        // Example 1: Register dengan password validation
        boolean registerResult = userDao.registerUserWithValidation(
            "secure_user", 
            "secure@email.com", 
            "SecurePass123!", 
            "Secure User", 
            UserRoles.CUSTOMER
        );
        System.out.println("Register with validation result: " + registerResult);
        System.out.println("Message: " + userDao.getMessage());
        
        // Example 2: Register dengan password lemah (akan gagal)
        boolean weakPasswordResult = userDao.registerUserWithValidation(
            "weak_user", 
            "weak@email.com", 
            "123", 
            "Weak User", 
            UserRoles.CUSTOMER
        );
        System.out.println("Weak password register result: " + weakPasswordResult);
        System.out.println("Message: " + userDao.getMessage());
        
        // Example 3: Login dengan BCrypt verification
        Users loggedInUser = userDao.login("secure_user", "SecurePass123!");
        if (loggedInUser != null) {
            System.out.println("Login successful for: " + loggedInUser.getFullName());
            System.out.println("User ID: " + loggedInUser.getUserId());
            System.out.println("Role: " + loggedInUser.getRole().getRoleName());
        }
        
        // Example 4: Change password
        if (loggedInUser != null) {
            boolean changePasswordResult = userDao.changePassword(
                loggedInUser.getUserId(), 
                "SecurePass123!", 
                "NewSecurePass456!"
            );
            System.out.println("Change password result: " + changePasswordResult);
            System.out.println("Message: " + userDao.getMessage());
        }
        
        // Example 5: Reset password (generate random)
        if (loggedInUser != null) {
            String newRandomPassword = userDao.resetPassword(loggedInUser.getUserId());
            if (newRandomPassword != null) {
                System.out.println("New random password: " + newRandomPassword);
                System.out.println("Message: " + userDao.getMessage());
            }
        }
        
        // Example 6: Reset password by email
        String resetPassword = userDao.resetPasswordByEmail("secure@email.com");
        if (resetPassword != null) {
            System.out.println("Reset password by email: " + resetPassword);
        }
        
        // Example 7: Test password strength validation
        System.out.println("Is 'weak123' strong: " + userDao.isPasswordStrong("weak123"));
        System.out.println("Is 'StrongPass123!' strong: " + userDao.isPasswordStrong("StrongPass123!"));
        
        // Example 8: Update password (admin function)
        if (loggedInUser != null) {
            boolean updateResult = userDao.updatePassword(loggedInUser.getUserId(), "AdminSetPass123!");
            System.out.println("Admin update password result: " + updateResult);
        }
        
        // Example 9: Demonstrasi BCrypt functions langsung
        String plainPassword = "TestPassword123!";
        String hashedPassword = PasswordConf.hashPassword(plainPassword);
        System.out.println("Original password: " + plainPassword);
        System.out.println("Hashed password: " + hashedPassword);
        System.out.println("Password verification: " + PasswordConf.verifyPassword(plainPassword, hashedPassword));
        
        // Example 10: Generate random password
        String randomPassword = PasswordConf.generateRandomPassword(16);
        System.out.println("Generated random password: " + randomPassword);
    }
}