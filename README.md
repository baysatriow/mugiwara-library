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
    - [Teknologi Alternatif (Untuk Pengembangan Masa Depan)](#teknologi-alternatif-untuk-pengembangan-masa-depan)
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
  - [**JSTL**](https://docs.oracle.com/javaee/5/tutorial/doc/bnakc.html) — Library tag standar JSP
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
  - [**Maven**](https://maven.apache.org/)
  - [**JUnit**](https://junit.org/)

- **Deployment:**
  - Belum Inisiasi

### Teknologi Alternatif (Untuk Pengembangan Masa Depan)

- [**Spring MVC**](https://spring.io/guides/gs/serving-web-content/) — Framework Java untuk web
- [**Hibernate ORM**](https://hibernate.org/) — Framework untuk ORM
- [**RESTful API**](https://restfulapi.net/) — Untuk integrasi dengan aplikasi frontend modern
- [**Thymeleaf**](https://www.thymeleaf.org/) — Template engine alternatif untuk JSP

## 📋 Fitur Utama

Mugiwara Library menyediakan fitur-fitur berikut:

- **Sistem Pengguna:**
  - Registrasi dan login pengguna
  - Profil pengguna dan manajemen akun
  - Role-based access control (Admin, Staf, Pelanggan)

- **Katalog Buku:**
  - Tampilan katalog lengkap
  - Pencarian dan filter berdasarkan kategori, penulis, penerbit
  - Detail buku lengkap (sinopsis, penulis, rating, harga)
  - Ulasan dan rating dari pengguna

- **Pembelian Buku:**
  - Keranjang belanja
  - Proses checkout dan pembayaran
  - Riwayat pembelian
  - Wishlist buku

- **Admin Panel:**
  - Manajemen inventori buku
  - Laporan penjualan
  - Manajemen pengguna
  - Dashboard analitik

- **Fitur Tambahan:**
  - Sistem rekomendasi buku
  - Notifikasi ketersediaan buku
  - Newsletter
  - Promo dan diskon

## 🏛️ Struktur Aplikasi (Bayangan)

```
mugiwara-library/
├── .gitignore                   # Konfigurasi file yang diabaikan Git
├── pom.xml                      # Konfigurasi Maven
├── LICENSE                      # Lisensi proyek
├── README.md                    # Dokumentasi utama
├── docs/                        # Dokumentasi tambahan
├── src/
│   ├── main/
│   │   ├── java/com/isekaibyte/mugiwara/
│   │   │   ├── controller/      # Servlet untuk menangani request
│   │   │   ├── model/           # Model data (POJO)
│   │   │   ├── dao/             # Data Access Objects
│   │   │   ├── service/         # Business Proses
│   │   │   └── util/            # Utility classes
│   │   ├── resources/
│   │   │   ├── database.properties  # Konfigurasi database
│   │   │   └── log4j.properties     # Konfigurasi logging
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   ├── web.xml          # Konfigurasi aplikasi web
│   │       │   └── lib/             # Library eksternal
│   │       ├── META-INF/            # Metadata aplikasi
│   │       ├── assets/              # Aset statis (CSS, JS, gambar)
│   │       │   ├── css/             # Stylesheet
│   │       │   ├── js/              # JavaScript files
│   │       │   └── images/          # Gambar
│   │       ├── common/              # Komponen JSP yang digunakan kembali
│   │       │   ├── header.jsp       # Header halaman
│   │       │   ├── footer.jsp       # Footer halaman
│   │       │   └── navbar.jsp       # Navigasi
│   │       └── views/               # Halaman JSP
│   │           ├── index.jsp        # Halaman utama
│   │           ├── login.jsp        # Halaman login
│   │           ├── register.jsp     # Halaman registrasi
│   │           ├── catalog/         # Halaman katalog buku
│   │           ├── book/            # Halaman detail buku
│   │           ├── cart/            # Halaman keranjang belanja
│   │           ├── checkout/        # Halaman checkout
│   │           ├── profile/         # Halaman profil pengguna
│   │           └── admin/           # Halaman admin
│   └── test/                    # Unit dan integration tests
│       └── java/com/isekaibyte/mugiwara/
├── database/
│   ├── schema.sql               # Struktur database
│   └── sample-data.sql          # Data contoh
└── docker/                      # Konfigurasi Docker (opsional)
    ├── Dockerfile
    └── docker-compose.yml
```

## 🏁 Memulai Proyek

### Instalasi

1. **Prasyarat:**
   - JDK 11 atau lebih baru
   - Apache Tomcat 9.x
   - MySQL 8.x
   - Maven 3.6+

2. **Clone Repository:**
   ```bash
   git clone https://github.com/baysatriow/mugiwara-library.git
   cd mugiwara-library
   ```

3. **Build Project:**
   ```bash
   mvn clean package
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
   Edit file `src/main/resources/database.properties`:
   ```properties
   jdbc.driver=com.mysql.cj.jdbc.Driver
   jdbc.url=jdbc:mysql://localhost:3306/mugiwara_library
   jdbc.username=mugiwara
   jdbc.password=password
   ```

### Menjalankan Aplikasi

1. **Deploy ke Tomcat:**
   ```bash
   mvn tomcat7:run
   ```
   atau salin file WAR ke direktori `webapps` Tomcat.

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
   mvn test
   ```

## 👥 Tim Pengembang

**Tim Isekai Byte:**

[Logo Isekai Byte](https://github.com/baysatriow/mugiwara-library/blob/main/logo.png)

| Nama Anggota | Username GitHub | Peran | Kontribusi |
|--------------|-----------------|-------|------------|
| Bayu Satrio Wibowo | [@baysatriow](https://github.com/baysatriow) | FullStack Developer | - |
| Syahdan Rizqi Ruhendy | [@rubiliku](https://github.com/rubiliku) | Frontend Developer | - |
| Aisya Zahra | [@isaffectionate](https://github.com/isaffectionate) | Frontend Developer | - |
| Sitti Fadhillah Nur Ahsan | [@dicodella](https://github.com/dicodella) | Frontend Developer | - |
| Gilbert Halomoan Lumbantoruan | [@-](-) | Frontend Developer | Backend Developer |
| Elita Zanetra Alhamrasari | [@-](-) | Frontend Developer | - |

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