package Models;

/**
 * Enum untuk role pengguna dalam sistem
 * @author bayus
 */

public enum UserRoles {
    ADMIN(1, "Admin"),
    STAFF(2, "Staff"),
    CUSTOMER(3, "Customer");

    private final int roleId;
    private final String roleName;

    UserRoles(int roleId, String roleName) {
        this.roleId = roleId;
        this.roleName = roleName;
    }

    public int getRoleId() {
        return roleId;
    }

    public String getRoleName() {
        return roleName;
    }
    
    // Method untuk mendapatkan UserRoles berdasarkan roleId
    public static UserRoles fromRoleId(int roleId) {
        for (UserRoles role : UserRoles.values()) {
            if (role.getRoleId() == roleId) {
                return role;
            }
        }
        throw new IllegalArgumentException("Invalid role ID: " + roleId);
    }
    
    // Method untuk mendapatkan UserRoles berdasarkan roleName
    public static UserRoles fromRoleName(String roleName) {
        for (UserRoles role : UserRoles.values()) {
            if (role.getRoleName().equalsIgnoreCase(roleName)) {
                return role;
            }
        }
        throw new IllegalArgumentException("Invalid role name: " + roleName);
    }
    
    // Method untuk validasi apakah roleId valid
    public static boolean isValidRoleId(int roleId) {
        try {
            fromRoleId(roleId);
            return true;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }
    
    // Method untuk mendapatkan semua role IDs
    public static int[] getAllRoleIds() {
        UserRoles[] roles = UserRoles.values();
        int[] roleIds = new int[roles.length];
        for (int i = 0; i < roles.length; i++) {
            roleIds[i] = roles[i].getRoleId();
        }
        return roleIds;
    }
    
    // Method untuk mendapatkan semua role names
    public static String[] getAllRoleNames() {
        UserRoles[] roles = UserRoles.values();
        String[] roleNames = new String[roles.length];
        for (int i = 0; i < roles.length; i++) {
            roleNames[i] = roles[i].getRoleName();
        }
        return roleNames;
    }
    
    @Override
    public String toString() {
        return roleName;
    }
}