<div class="offcanvas offcanvas-start w-260" data-bs-scroll="true" tabindex="-1" id="offcanvasPrimaryMenu">
    <div class="offcanvas-header border-bottom h-70 justify-content-between">
        <img src="assets/images/logo1.png" width="160" alt="">
        <a href="javascript:;" class="primaery-menu-close" data-bs-dismiss="offcanvas">
            <i class="material-icons-outlined">close</i>
        </a>
    </div>
    <div class="offcanvas-body">
        <nav class="sidebar-nav">
            <ul class="metismenu" id="sidenav">
                <li class="menu-label">Primary Menu</li>
                
                <!-- Dashboard -->
                <li>
                    <a href="../Admin?page=home">
                        <div class="parent-icon"><i class="material-icons-outlined">home</i></div>
                        <div class="menu-title">Dashboard</div>
                    </a>
                </li>
                
                <!-- Statistik Penjualan -->
                <li>
                    <a href="../Admin?page=statistik">
                        <div class="parent-icon"><i class="material-icons-outlined">poll</i></div>
                        <div class="menu-title">Statistik Penjualan</div>
                    </a>
                </li>
                
                <!-- Manajemen Barang -->
                <li>
                    <a href="javascript:;" class="has-arrow">
                        <div class="parent-icon"><i class="material-icons-outlined">inventory_2</i></div>
                        <div class="menu-title">Manajemen Barang</div>
                    </a>
                    <ul>
                        <li><a href="../Admin?page=barang"><i class="material-icons-outlined">arrow_right</i>Daftar Buku</a></li>
                        <li><a href="../Admin?page=category"><i class="material-icons-outlined">arrow_right</i>Kategori</a></li>
                        <li><a href="../Admin?page=author"><i class="material-icons-outlined">arrow_right</i>Penulis</a></li>
                        <li><a href="../Admin?page=publisher"><i class="material-icons-outlined">arrow_right</i>Penerbit</a></li>
                    </ul>
                </li>
                
                <!-- Manajemen Pengguna -->
                <li>
                    <a href="javascript:;" class="has-arrow">
                        <div class="parent-icon"><i class="material-icons-outlined">admin_panel_settings</i></div>
                        <div class="menu-title">Manajemen Pengguna</div>
                    </a>
                    <ul>
                        <li><a href="../Admin?page=manageuserstaff"><i class="material-icons-outlined">arrow_right</i>Admin & Staff</a></li>
                        <li><a href="../Admin?page=managecustomer"><i class="material-icons-outlined">arrow_right</i>Customer</a></li>
                    </ul>
                </li>
                
                <!-- Manajemen Customer -->
                <li>
                    <a href="../Admin?page=managecustomer">
                        <div class="parent-icon"><i class="material-icons-outlined">manage_accounts</i></div>
                        <div class="menu-title">Manajemen Customer</div>
                    </a>
                </li>
                
                <!-- Pengaturan Payment -->
                <li>
                    <a href="javascript:;" class="has-arrow">
                        <div class="parent-icon"><i class="material-icons-outlined">payment</i></div>
                        <div class="menu-title">Pengaturan Payment</div>
                    </a>
                    <ul>
                        <li><a href="../Admin?page=paymentmethod"><i class="material-icons-outlined">arrow_right</i>Metode Pembayaran</a></li>
                        <li><a href="../Admin?page=paymentconfig"><i class="material-icons-outlined">arrow_right</i>Konfigurasi Tripay</a></li>
                        <li><a href="../Admin?page=paymenthistory"><i class="material-icons-outlined">arrow_right</i>Riwayat Pembayaran</a></li>
                    </ul>
                </li>
                
                <!-- Banner Management -->
                <li>
                    <a href="../Admin?page=banner">
                        <div class="parent-icon"><i class="material-icons-outlined">view_carousel</i></div>
                        <div class="menu-title">Banner</div>
                    </a>
                </li>
                
                <!-- Pengaturan Website -->
                <li>
                    <a href="javascript:;" class="has-arrow">
                        <div class="parent-icon"><i class="material-icons-outlined">settings</i></div>
                        <div class="menu-title">Pengaturan Website</div>
                    </a>
                    <ul>
                        <li><a href="../Admin?page=setting"><i class="material-icons-outlined">arrow_right</i>Pengaturan Umum</a></li>
                        <li><a href="../Admin?page=storesetting"><i class="material-icons-outlined">arrow_right</i>Pengaturan Toko</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
    </div>
    <div class="offcanvas-footer p-3 border-top h-70">
        <div class="form-check form-switch">
            <input class="form-check-input" type="checkbox" role="switch" id="DarkMode">
            <label class="form-check-label" for="DarkMode">Dark Mode</label>
        </div>
    </div>
</div>
