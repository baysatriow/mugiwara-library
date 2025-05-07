# 📚 Mugiwara Library

> [Mugiwara Library](https://github.com/baysatriow/mugiwara-library) adalah website toko buku online yang dibangun dengan JSP dan MySQL untuk memudahkan pengguna dalam mencari dan membeli buku secara daring.

[![GitHub license](https://img.shields.io/github/license/baysatriow/mugiwara-library)](https://github.com/baysatriow/mugiwara-library/blob/main/LICENSE)
[![Website](-)](-)

| Mugiwara Library |
| ---------------- |
| [-] |
| [-](-) |

## 📑 Daftar Isi

- [📚 Mugiwara Library](#-mugiwara-library)
  - [📑 Daftar Isi](#-daftar-isi)
  - [📦 Repositories](#-repositories)
  - [🧱 Tech Stack](#-tech-stack)
    - [Teknologi Utama](#teknologi-utama)
  - [📋 Fitur Utama](#-fitur-utama)
  - [🏛️ Struktur Aplikasi (Bayangan)](#️-struktur-aplikasi-bayangan)
  - [🏁 Memulai Proyek](#-memulai-proyek)
    - [Instalasi](#instalasi)
    - [Konfigurasi Database](#konfigurasi-database)
    - [Menjalankan Aplikasi](#menjalankan-aplikasi)
    - [Deployment](#deployment)
  - [🧪 Panduan Pengujian](#-panduan-pengujian)
  - [👥 Tim Pengembang](#-tim-pengembang)
  - [🤝 Kontribusi](#-kontribusi)
  - [📝 Lisensi](#-lisensi)

## 📦 Repositories

Repository yang dibutuhkan untuk proyek ini:

- [`mugiwara-library`](https://github.com/isekaibyte/mugiwara-library): Aplikasi utama (JSP)

## 🧱 Tech Stack

### Teknologi Utama

- **Server Side:**
  - [**Java**](https://www.java.com/) — Main Language Program
  - [**JSP (JavaServer Pages)**](https://www.oracle.com/java/technologies/jspt.html) — Page Dinamis Java
  - [**Servlet**](https://javaee.github.io/servlet-spec/) — API Request
  - [**Apache Tomcat**](http://tomcat.apache.org/) — Web server dan servlet container

- **Database:**
  - [**MySQL**](https://www.mysql.com/) — DBMS
  - [**JDBC**](https://docs.oracle.com/javase/8/docs/technotes/guides/jdbc/) — API untuk koneksi database

- **Frontend:**
  - [**HTML5**](https://html.spec.whatwg.org/)
  - [**CSS3**](https://www.w3.org/Style/CSS/)
  - [**JavaScript**](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
  - [**Bootstrap 5**](https://getbootstrap.com/)
  - [**jQuery**](https://jquery.com/)

- **Alat Pengembangan:**
  - [**Git**](https://git-scm.com/)
  - [**Apache Ant**](https://ant.apache.org/) — Build Tool

- **Deployment:**
  - Belum Inisiasi

## 📋 Fitur Utama

Mugiwara Library Store menyediakan fitur-fitur berikut:

- **Sistem Pengguna:**
  - Fitur Registrasi dan Login 
  - Fitur Profil Pengguna dan Manajemen Akun 
  - Fitur Role-based access control (Admin, Staf, Pelanggan)

- **Katalog Buku:**
  - Tampilan katalog lengkap secara menyeluruh 
  - Pencarian dan filter berdasarkan kategori
  - Detail buku lengkap (sinopsis, penulis, harga, identitas buku)
  - Ulasan dan rating dari pengguna

- **Pembelian Buku:**
  - Keranjang belanja
  - Proses checkout dan pembayaran
  - Riwayat pembelian
  - Tracing Pengiriman

- **Admin Panel:**
  - Manajemen inventori buku
  - Laporan penjualan
  - Manajemen pengguna
  - Pengaturan Toko
  - Dashboard analitik

## 🏛️ Struktur Aplikasi (Bayangan)

```
MUGIWARA-LIBRARY/
├── mugiwara/
│   ├── src/
│   │   ├── Controllers/     # Servlet untuk menangani request (Controller)
│   │   ├── Models/          # Kelas untuk data dan logika bisnis (Model)
│   │   ├── Dao/             # Data Access Object untuk operasi database
│   │   └── Config/          # Kelas utilitas (koneksi DB, validasi, dll)
│   │
│   ├── web/                # Direktori konten web (View)
│   │   ├── WEB-INF/
│   │   │   ├── web.xml     # Konfigurasi aplikasi web
│   │   │   ├── classes/    # Kelas terkompilasi (diisi saat build)
│   │   │   ├── lib/        # Library JAR
│   │   │   └── tags/       # Custom tag files (.tag)
│   │   │
│   │   ├── META-INF/
│   │   │   └── context.xml # Konfigurasi konteks Tomcat
│   │   │
│   │   ├── assets/         # Aset statis
│   │   │   ├── css/        # Stylesheet
│   │   │   ├── js/         # JavaScript
│   │   │   └── images/     # Gambar
│   │   │
│   │   ├── component/         # Komponen JSP yang digunakan kembali
│   │   │   ├── header.jsp
│   │   │   ├── footer.jsp
│   │   │   └── navbar.jsp
│   │   │
│   │   ├── admin/          # Halaman khusus admin (terpisah)
│   │   │   ├── index.jsp             # Dashboard admin
│   │   │   ├── books/                # Manajemen buku
│   │   │   │   ├── list.jsp
│   │   │   │   ├── add.jsp
│   │   │   │   └── edit.jsp
│   │   │   ├── users/                # Manajemen pengguna
│   │   │   │   ├── list.jsp
│   │   │   │   ├── add.jsp
│   │   │   │   └── edit.jsp
│   │   │   ├── orders/               # Manajemen pesanan
│   │   │   │   ├── list.jsp
│   │   │   │   └── detail.jsp
│   │   │   ├── reports/              # Laporan
│   │   │   │   ├── sales.jsp
│   │   │   │   └── inventory.jsp
│   │   │   ├── common/               # Komponen admin
│   │   │   │   ├── header.jsp
│   │   │   │   ├── footer.jsp
│   │   │   │   └── sidebar.jsp
│   │   │   └── assets/               # Aset khusus admin
│   │   │       ├── css/
│   │   │       └── js/
│   │   │
│   │   ├── views/          # Halaman utama website
│   │   │   ├── home.jsp             # Halaman beranda
│   │   │   ├── catalog.jsp          # Katalog buku
│   │   │   ├── book-detail.jsp      # Detail buku
│   │   │   ├── cart.jsp             # Keranjang belanja
│   │   │   ├── checkout.jsp         # Halaman checkout
│   │   │   ├── login.jsp            # Halaman login
│   │   │   ├── register.jsp         # Halaman pendaftaran
│   │   │   ├── user/                # Area member/pengguna
│   │   │   │   ├── profile.jsp
│   │   │   │   ├── orders.jsp
│   │   │   │   └── settings.jsp
│   │   │   └── error/                # Halaman error
│   │   │       ├── 404.jsp
│   │   │       └── 500.jsp
│   │   │
│   │   ├── index.jsp      # Halaman utama (redirect ke /views/home.jsp)
│   │   └── favicon.ico    # Favicon
│   │
│   ├── build.xml          # Konfigurasi build Ant
│   └── nbproject/         # Metadata proyek NetBeans
│
└── database/              # Skrip database
    ├── schema.sql         # Definisi tabel
    └── sample-data.sql    # Data contoh awal
```

## 🏁 Memulai Proyek

### Instalasi

1. **Prasyarat:**
   - JDK 11 atau lebih baru
   - Apache Tomcat 9.x
   - MySQL 8.x
   - Apache Ant 1.10+

2. **Clone Repository:**
   ```bash
   git clone https://github.com/baysatriow/mugiwara-library.git
   cd mugiwara-library
   ```

3. **Build Project:**
   ```bash
   ant build
   ```

### Konfigurasi Database

1. **Buat Database:**
   ```sql
   CREATE DATABASE mugiwara_library;
   CREATE USER 'mugiwara'@'localhost' IDENTIFIED BY 'password';
   GRANT ALL PRIVILEGES ON mugiwara_library.* TO 'mugiwara'@'localhost';
   FLUSH PRIVILEGES;
   ```

2. **Import Schema:**
   ```bash
   mysql -u mugiwara -p mugiwara_library < database/schema.sql
   mysql -u mugiwara -p mugiwara_library < database/sample-data.sql
   ```

3. **Konfigurasi Koneksi:**
   Edit file `src/resources/database.properties`:
   ```properties
   jdbc.driver=com.mysql.cj.jdbc.Driver
   jdbc.url=jdbc:mysql://localhost:3306/mugiwara_library
   jdbc.username=mugiwara
   jdbc.password=password
   ```

### Menjalankan Aplikasi

1. **Deploy ke Tomcat:**
   ```bash
   ant deploy
   ```
   atau salin file WAR dari direktori `build` ke direktori `webapps` Tomcat.

2. **Akses Aplikasi:**
   Buka browser dan kunjungi `http://localhost:8080/mugiwara-library`

### Deployment

1. **-:**
   ```-
   ```


## 🧪 Panduan Pengujian

1. **Akun Demo:**
   - **Admin:**
     - Username: admin
     - Password: admin123
   - **Pelanggan:**
     - Username: user
     - Password: user123

2. **Menjalankan Test:**
   ```bash
   ant test
   ```

## 👥 Tim Pengembang

**Tim Isekai Byte:**

<p align="center">
  <img src="https://github.com/baysatriow/mugiwara-library/blob/main/logo.png" alt="Logo Isekai Byte" width="500" />
</p>

| Nama Anggota | Username GitHub | Peran | Kontribusi |
|--------------|-----------------|-------|------------|
| Bayu Satrio Wibowo | [@baysatriow](https://github.com/baysatriow) | FullStack Developer | - |
| Syahdan Rizqi Ruhendy | [@rubiliku](https://github.com/rubiliku) | Frontend Developer | - |
| Aisya Zahra | [@isaffectionate](https://github.com/isaffectionate) | Frontend Developer | - |
| Sitti Fadhillah Nur Ahsan | [@dicodella](https://github.com/dicodella) | Frontend Developer | - |
| Gilbert Halomoan Lumbantoruan | [@-](-) | Backend Developer | - |
| Elita Zanetra Alhamrasari | [@elytazaaa](https://github.com/dicodella) | Frontend Developer | - |

## 🤝 Kontribusi

Kami sangat menghargai kontribusi dari komunitas! Jika Anda ingin berkontribusi:

1. Fork repository ini
2. Buat branch fitur baru (`git checkout -b feature/AmazingFeature`)
3. Commit perubahan Anda (`git commit -m 'Add some AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buka Pull Request

## 📝 Lisensi

Proyek ini dilisensikan di bawah [MIT License](./LICENSE).

---

&copy; 2025 Isekai Byte. All Rights Reserved.