package Models;

/**
 *
 * @author bayus
 */

public class Admin extends Users implements Viewable{
    private int AdminId;
    
    public Admin() {
        super();
        this.role = UserRoles.ADMIN;
    }
    
    public Admin(String username, String email, String password) {
        super(username, email, password);
        this.role = UserRoles.ADMIN;
    }

    public Admin(int AdminId, String username, String email, String password) {
        super(username, email, password);
        this.AdminId = AdminId;
    }

    public Admin(int AdminId, String username, String email, String password, UserRoles role) {
        super(username, email, password, role);
        this.AdminId = AdminId;
    }
    
    
    public int getAdminId() {
        return AdminId;
    }

    public void setAdminId(int AdminId) {
        this.AdminId = AdminId;
    }
    
    
    @Override
    public void viewBookInventory() {
        System.out.println("Navigasi ke halaman inventaris buku...");
    }

    @Override
    public void viewSalesReports() {
        System.out.println("Navigasi ke halaman laporan penjualan...");
    }

    @Override
    public void viewUserManagement() {
        System.out.println("Navigasi ke halaman manajemen pengguna...");
    }

    @Override
    public void viewStoreSettings() {
        System.out.println("Navigasi ke halaman pengaturan toko...");
    }

    @Override
    public void viewAnalyticsDashboard() {
        System.out.println("Navigasi ke halaman dasbor analitik...");
    }

    @Override
    public String toString() {
        return "Admin{" +
                "adminId=" + AdminId +
                ", userId=" + getUserId() +
                ", username='" + getUsername() + '\'' +
                ", email='" + getEmail() + '\'' +
                ", fullName='" + getFullName() + '\'' +
                ", role=" + getRole() +
                '}';
    }
}
