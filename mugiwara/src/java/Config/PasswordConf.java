package Config;

/**
 *
 * @author bayus
 */

import org.mindrot.jbcrypt.BCrypt;
import java.security.SecureRandom;

public class PasswordConf {

    /**
     * Hashes a password using the BCrypt algorithm.
     * @param password The plain-text password to hash.
     * @return A BCrypt-hashed password string.
     */
    public static String hashPassword(String password) {
        // Gensalt's second parameter is the log_rounds, 12 is a good default
        return BCrypt.hashpw(password, BCrypt.gensalt(12));
    }

    /**
     * Verifies a plain-text password against a BCrypt hashed string.
     * @param password The plain-text password to check.
     * @param hashedPassword The hashed password from the database.
     * @return true if the password matches the hash, false otherwise.
     */
    public static boolean verifyPassword(String password, String hashedPassword) {
        // Basic check to ensure the hash is potentially valid before checking
        if (password == null || hashedPassword == null || !hashedPassword.startsWith("$2a$")) {
            return false;
        }
        return BCrypt.checkpw(password, hashedPassword);
    }

    /**
     * Generates a random password of a given length.
     * @param length The desired length of the password.
     * @return The randomly generated password.
     */
    public static String generateRandomPassword(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*";
        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder();

        for (int i = 0; i < length; i++) {
            int index = random.nextInt(chars.length());
            password.append(chars.charAt(index));
        }

        return password.toString();
    }
}
