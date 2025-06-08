package Models;

import java.util.Date;
public class Users {
    protected String userId;
    protected String username;
    protected String email;
    protected String password;
    protected String fullName;
    protected String gender;
    protected Date birthDate;
    protected int roleId;
    protected String imagePath;
    protected int login;
    
    public Users() {}
    
    public Users(String username, String email, String password) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.roleId = UserRoles.CUSTOMER; // default role
    }
    
    // Business methods
    public boolean login() {
        // Login logic implementation
        return true;
    }
    
    public void logout() {
        // Logout logic implementation
    }
    
    public void updateProfile() {
        // Update profile logic
    }
    
    public void generalReport() {
        // Generate general report
    }
    
    // Getters and Setters
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    
    public Date getBirthDate() { return birthDate; }
    public void setBirthDate(Date birthDate) { this.birthDate = birthDate; }
    
    public int getRoleId() { return roleId; }
    public void setRoleId(int roleId) { this.roleId = roleId; }
    
    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }
    
    public int getLogin() { return login; }
    public void setLogin(int login) { this.login = login; }
    
    public String getRoleName() {
        return UserRoles.getRoleName(roleId);
    }
}
