package Config;

/**
 *
 * @author bayus
 */

import java.util.regex.Pattern;

public class ValidationConf {
    
    private static final Pattern EMAIL_PATTERN = 
        Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    
    private static final Pattern PHONE_PATTERN = 
        Pattern.compile("^\\+?[0-9]{10,15}$");
    
    private static final Pattern USERNAME_PATTERN = 
        Pattern.compile("^[a-zA-Z0-9_]{3,20}$");
    
    private static final Pattern NAME_PATTERN = 
        Pattern.compile("^[a-zA-Z\\s]{2,50}$");
    
    /**
     * Validate email format
     * @param email The email to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email).matches();
    }
    
    /**
     * Validate phone number format
     * @param phone The phone number to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidPhone(String phone) {
        return phone != null && PHONE_PATTERN.matcher(phone).matches();
    }
    
    /**
     * Validate username format
     * @param username The username to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidUsername(String username) {
        return username != null && USERNAME_PATTERN.matcher(username).matches();
    }
    
    /**
     * Validate name format (only letters and spaces)
     * @param name The name to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidName(String name) {
        return name != null && NAME_PATTERN.matcher(name.trim()).matches();
    }
    
    /**
     * Validate password strength
     * @param password The password to validate
     * @return true if strong enough, false otherwise
     */
    public static boolean isStrongPassword(String password) {
        if (password == null || password.length() < 8) {
            return false;
        }
        
        boolean hasUpper = false;
        boolean hasLower = false;
        boolean hasDigit = false;
        boolean hasSpecial = false;
        
        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) hasUpper = true;
            else if (Character.isLowerCase(c)) hasLower = true;
            else if (Character.isDigit(c)) hasDigit = true;
            else if (!Character.isLetterOrDigit(c)) hasSpecial = true;
        }
        
        return hasUpper && hasLower && hasDigit && hasSpecial;
    }
    
    /**
     * Get password strength message
     * @param password The password to check
     * @return String message describing what's missing
     */
    public static String getPasswordStrengthMessage(String password) {
        if (password == null || password.isEmpty()) {
            return "Password tidak boleh kosong";
        }
        
        if (password.length() < 8) {
            return "Password harus minimal 8 karakter";
        }
        
        boolean hasUpper = false;
        boolean hasLower = false;
        boolean hasDigit = false;
        boolean hasSpecial = false;
        
        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) hasUpper = true;
            else if (Character.isLowerCase(c)) hasLower = true;
            else if (Character.isDigit(c)) hasDigit = true;
            else if (!Character.isLetterOrDigit(c)) hasSpecial = true;
        }
        
        StringBuilder missing = new StringBuilder("Password harus mengandung: ");
        boolean needComma = false;
        
        if (!hasUpper) {
            missing.append("huruf besar");
            needComma = true;
        }
        if (!hasLower) {
            if (needComma) missing.append(", ");
            missing.append("huruf kecil");
            needComma = true;
        }
        if (!hasDigit) {
            if (needComma) missing.append(", ");
            missing.append("angka");
            needComma = true;
        }
        if (!hasSpecial) {
            if (needComma) missing.append(", ");
            missing.append("karakter khusus");
        }
        
        return hasUpper && hasLower && hasDigit && hasSpecial ? "Password kuat" : missing.toString();
    }
    
    /**
     * Validate ISBN format
     * @param isbn The ISBN to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidISBN(String isbn) {
        if (isbn == null) return false;
        
        // Remove hyphens and spaces
        isbn = isbn.replaceAll("[\\s-]", "");
        
        // Check if it's ISBN-10 or ISBN-13
        return isbn.length() == 10 || isbn.length() == 13;
    }
    
    /**
     * Check if string is null or empty
     * @param str The string to check
     * @return true if null or empty, false otherwise
     */
    public static boolean isEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }
    
    /**
     * Check if string length is within range
     * @param str The string to check
     * @param min Minimum length
     * @param max Maximum length
     * @return true if within range, false otherwise
     */
    public static boolean isValidLength(String str, int min, int max) {
        if (str == null) return false;
        int length = str.trim().length();
        return length >= min && length <= max;
    }
    
    /**
     * Sanitize string for SQL (basic protection)
     * @param input The input string
     * @return Sanitized string
     */
    public static String sanitizeForSQL(String input) {
        if (input == null) return null;
        return input.replace("'", "''").replace("\"", "\\\"");
    }
    
    /**
     * Validate price format
     * @param price The price to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidPrice(String price) {
        if (price == null || price.trim().isEmpty()) return false;
        try {
            double priceValue = Double.parseDouble(price);
            return priceValue >= 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }
    
    /**
     * Validate quantity format
     * @param quantity The quantity to validate
     * @return true if valid, false otherwise
     */
    public static boolean isValidQuantity(String quantity) {
        if (quantity == null || quantity.trim().isEmpty()) return false;
        try {
            int quantityValue = Integer.parseInt(quantity);
            return quantityValue > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}