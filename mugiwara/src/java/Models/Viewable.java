package Models;

/**
 *
 * @author bayus
 */

public interface Viewable {
     /**
     * Menampilkan halaman atau tampilan untuk inventaris buku.
     */
    public void viewBookInventory();

    /**
     * Menampilkan halaman atau tampilan untuk laporan penjualan.
     */
    public void viewSalesReports();

    /**
     * Menampilkan halaman atau tampilan untuk manajemen pengguna.
     */
    public void viewUserManagement();

    /**
     * Menampilkan halaman atau tampilan untuk pengaturan toko.
     */
    public void viewStoreSettings();

    /**
     * Menampilkan halaman atau tampilan untuk dasbor analitik.
     */
    public void viewAnalyticsDashboard();
}
