package Models;

import java.util.Date;

public class Users {
    private int userId;
    private String username;
    private String email;
    private String password;
    private String fullName;
    private String gender;
    private Date birthDate;
    private UserRole role;
    private String imagePath;
    private boolean login;
    
    public Users() {
    }
    
    public Users(String username, String email, String password, String fullName, 
                String gender, Date birthDate, UserRole role, String imagePath) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.gender = gender;
        this.birthDate = birthDate;
        this.role = role;
        this.imagePath = imagePath;
        this.login = false;
    }
    
    // Getters and Setters
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    public String getGender() {
        return gender;
    }
    
    public void setGender(String gender) {
        this.gender = gender;
    }
    
    public Date getBirthDate() {
        return birthDate;
    }
    
    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }
    
    public UserRole getRole() {
        return role;
    }
    
    public void setRole(UserRole role) {
        this.role = role;
    }
    
    public String getImagePath() {
        return imagePath;
    }
    
    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
    
    public boolean isLogin() {
        return login;
    }
    
    public void setLogin(boolean login) {
        this.login = login;
    }
    
    // Methods
    public boolean login() {
        // Implementation for login
        this.login = true;
        return true;
    }
    
    public void logout() {
        // Implementation for logout
        this.login = false;
    }
    
    public void updateProfile() {
        // Implementation for updating profile
    }
    
    public void getResetPassword() {
        // Implementation for resetting password
    }
}
