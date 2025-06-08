package Models;

/**
 *
 * @author bayus
 */

public class UserRoles {
    public static final int ADMIN = 1;
    public static final int STAFF = 2;
    public static final int CUSTOMER = 3;
    
    public static String getRoleName(int roleId) {
        switch (roleId) {
            case ADMIN:
                return "Admin";
            case STAFF:
                return "Staff";
            case CUSTOMER:
                return "Customer";
            default:
                return "Unknown";
        }
    }
}
