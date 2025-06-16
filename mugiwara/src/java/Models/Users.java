package Models;

import java.util.Date;

public class Users {
    protected int userId;
    protected String username;
    protected String email;
    protected String password;
    protected String fullName;
    protected String gender;
    protected Date birthDate;
    protected UserRoles role;
    protected String imagePath;
    protected boolean login;
    
    public Users() {}
    
    public Users(String username, String email, String password) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.login = false;
        this.role = UserRoles.CUSTOMER;
    }
    
    public Users(String username, String email, String password, UserRoles role) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.role = role;
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

    public UserRoles getRole() {
        return role;
    }

    public void setRole(UserRoles role) {
        this.role = role;
    }
    
    // Helper method untuk mendapatkan role ID
    public int getRoleId() {
        return role != null ? role.getRoleId() : 0;
    }
    
    // Helper method untuk set role berdasarkan ID
    public void setRoleById(int roleId) {
        this.role = UserRoles.fromRoleId(roleId);
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
    
    // Helper methods untuk cek role
    public boolean isAdmin() {
        return role == UserRoles.ADMIN;
    }
    
    public boolean isStaff() {
        return role == UserRoles.STAFF;
    }
    
    public boolean isCustomer() {
        return role == UserRoles.CUSTOMER;
    }
}