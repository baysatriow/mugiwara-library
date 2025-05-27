package Models;

/**
 *
 * @author bayus
 */

public class UserRole {
    private int roleId;
    private String roleName;
    private boolean isDefault;
    
    public UserRole() {
    }
    
    public UserRole(int roleId, String roleName, boolean isDefault) {
        this.roleId = roleId;
        this.roleName = roleName;
        this.isDefault = isDefault;
    }
    
    // Getters and Setters
    public int getRoleId() {
        return roleId;
    }
    
    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }
    
    public String getRoleName() {
        return roleName;
    }
    
    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
    
    public boolean isDefault() {
        return isDefault;
    }
    
    public void setDefault(boolean isDefault) {
        this.isDefault = isDefault;
    }
}
