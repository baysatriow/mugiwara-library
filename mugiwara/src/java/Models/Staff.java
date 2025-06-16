package Models;

/**
 *
 * @author bayus
 */

public class Staff extends Users implements Viewable{
    private int StaffId;
    private String position;
    
    public Staff() {
        super();
        this.role = UserRoles.STAFF;
    }
    
    public Staff(String username, String email, String password) {
        super(username, email, password);
        this.role = UserRoles.STAFF;
    }

    public Staff(String position, String username, String email, String password, UserRoles role) {
        super(username, email, password, role);
        this.position = position;
    }

    public Staff(String position, String username, String email, String password) {
        super(username, email, password);
        this.position = position;
    }

    public Staff(int StaffId, String position, String username, String email, String password) {
        super(username, email, password);
        this.StaffId = StaffId;
        this.position = position;
    }

    public Staff(int StaffId, String position, String username, String email, String password, UserRoles role) {
        super(username, email, password, role);
        this.StaffId = StaffId;
        this.position = position;
    }

    
    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public int getStaffId() {
        return StaffId;
    }

    public void setStaffId(int StaffId) {
        this.StaffId = StaffId;
    }
    
    
    /**
     * Menampilkan halaman atau tampilan untuk inventaris buku.
     */
    public void viewBookInventory(){
        
    }

    /**
     * Menampilkan halaman atau tampilan untuk laporan penjualan.
     */
    public void viewSalesReports(){
        
    }

    /**
     * Menampilkan halaman atau tampilan untuk manajemen pengguna.
     */
    public void viewUserManagement(){
        
    }

    /**
     * Menampilkan halaman atau tampilan untuk pengaturan toko.
     */
    public void viewStoreSettings(){
        
    }

    /**
     * Menampilkan halaman atau tampilan untuk dasbor analitik.
     */
    public void viewAnalyticsDashboard(){
        
    }

    @Override
    public String toString() {
        return "Staff{" +
                "staffId=" + StaffId +
                ", position='" + position + '\'' +
                ", userId=" + getUserId() +
                ", username='" + getUsername() + '\'' +
                ", email='" + getEmail() + '\'' +
                ", fullName='" + getFullName() + '\'' +
                ", role=" + getRole() +
                '}';
    }
}
