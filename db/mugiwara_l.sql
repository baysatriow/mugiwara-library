-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 17, 2025 at 05:28 AM
-- Server version: 8.0.30
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mugiwara_l`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `address_id` int NOT NULL,
  `user_id` int NOT NULL,
  `province` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `district` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `postal_code` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `full_address` text COLLATE utf8mb4_general_ci,
  `is_default` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`address_id`, `user_id`, `province`, `city`, `district`, `postal_code`, `full_address`, `is_default`) VALUES
(1, 0, 'DKI Jakarta', 'Jakarta Selatan', 'Kebayoran Baru', '12190', 'Jl. Senopati No. 7, Selong, Kebayoran Baru', 1),
(2, 0, 'Jawa Barat', 'Bandung', 'Sukajadi', '40162', 'Jl. Dr. Setiabudi No. 229, Isola, Sukasari', 0),
(3, 0, 'Jawa Timur', 'Surabaya', 'Gubeng', '60281', 'Jl. Kertajaya Indah Timur IX No. 35', 0),
(4, 0, 'Bali', 'Denpasar', 'Denpasar Selatan', '80227', 'Jl. Tukad Badung No. 123, Renon', 0),
(5, 0, 'Banten', 'Tangerang Selatan', 'Serpong', '15310', 'Perumahan Gading Serpong, Jl. Boulevard Gading Serpong, Blok A No. 1', 0),
(6, 0, 'DI Yogyakarta', 'Sleman', 'Depok', '55281', 'Jl. Kaliurang KM 5.5, Caturtunggal, Depok', 0),
(7, 0, 'Jawa Tengah', 'Semarang', 'Banyumanik', '50264', 'Jl. Ngesrep Timur V No. 55, Sumurboto', 0),
(8, 0, 'Sumatera Utara', 'Medan', 'Medan Polonia', '20152', 'Jl. Imam Bonjol No. 17, Suka Damai', 0),
(9, 0, 'Kalimantan Timur', 'Balikpapan', 'Balikpapan Kota', '76111', 'Jl. Jenderal Sudirman No. 45, Klandasan Ulu', 0),
(10, 0, 'Jawa Barat', 'Bekasi', 'Bekasi Selatan', '17148', 'Grand Galaxy City, Jl. Pulo Sirih Utama Blok FE No. 382', 0),
(11, 39, 'aSDASD', 'Bandungs', 'ASDSAD', '42424', 'aasdasdasdasd', 0),
(14, 39, 'Jawa Barat', 'Bandung', 'Bojongsoang', '12345', 'GBA 1 Blok C No 135', 0),
(16, 39, 'Jawa Barat', 'Bandung', 'Bojongsoang', '54321', 'Cherry Field No 13', 0),
(17, 39, 'sumatera utara', 'Tebing Tinggi', 'tebing tinggi', '20674', 'blabla', 1);

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`user_id`) VALUES
(1),
(2),
(27);

-- --------------------------------------------------------

--
-- Table structure for table `author`
--

CREATE TABLE `author` (
  `author_id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `author`
--

INSERT INTO `author` (`author_id`, `name`, `description`) VALUES
(1, 'Andrea Hirata', 'Penulis novel \"Laskar Pelangi\". Kategori: Novel. Penerbit: Gramedia Pustaka Utama'),
(2, 'Dewi Lestari', 'Penulis novel \"Supernova\". Kategori: Novel. Penerbit: GagasMedia'),
(3, 'Ayu Utami', 'Penulis sastra \"Saman\". Kategori: Novel. Penerbit: Kepustakaan Populer Gramedia'),
(4, 'Habiburrahman El Shirazy', 'Penulis novel Islami \"Ayat-Ayat Cinta\". Kategori: Novel. Penerbit: Mizan Pustaka'),
(5, 'Is Yuniarto', 'Komikus Indonesia terkenal dengan seri \"Garudayana\". Kategori: Komik. Penerbit: Elex Media Komputindo'),
(6, 'Sweta Kartika', 'Komikus dan ilustrator \"Grey & Jingga\". Kategori: Komik. Penerbit: Buku Mojok'),
(7, 'Najwa Shihab', 'Jurnalis dan penulis opini di berbagai media. Kategori: Majalah. Penerbit: Republika Penerbit'),
(8, 'Leila S. Chudori', 'Penulis buku \"Laut Bercerita\", dikenal dengan gaya penulisan sastra dan jurnalisme. Kategori: Majalah. Penerbit: Kepustakaan Populer Gramedia.'),
(9, 'Eka Kurniawan', 'Penulis fiksi sastra seperti \"Cantik Itu Luka\" dan \"Seperti Dendam, Rindu Harus Dibayar Tuntas\". Kategori: Novel. Penerbit: Gramedia Pustaka Utama.'),
(10, 'Ratih Kumala', 'Penulis novel \"Gadis Kretek\" yang diadaptasi ke serial Netflix. Kategori: Novel. Penerbit: Gramedia Pustaka Utama.'),
(13, 'Luluk HF', ''),
(14, 'Endo Tatsuya', 'Tatsuya Endo adalah seorang mangaka (komikus) Jepang, terkenal karena karyanya \"Spy x Family\". Ia juga menciptakan serial manga lain seperti \"Tista\" dan \"Blade of the Moon Princess\". \"Spy x Family\" telah menjadi sangat populer dan sukses secara komersial, terjual lebih dari 35 juta kopi hingga Maret 2024.'),
(15, '-', 'Majalah'),
(16, 'Koyoharu Gotouge', 'Koyoharu Gotouge adalah seorang mangaka (komikus) Jepang yang dikenal sebagai penulis seri manga Kimetsu no Yaiba (Demon Slayer). Ia lahir pada tanggal 5 Mei 1989.');

-- --------------------------------------------------------

--
-- Table structure for table `bank_transfer`
--

CREATE TABLE `bank_transfer` (
  `payment_id` int NOT NULL,
  `bank_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `account_number` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `acc_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `banner_slide`
--

CREATE TABLE `banner_slide` (
  `banner_id` int NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `image_path` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `link_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `order` int NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `banner_slide`
--

INSERT INTO `banner_slide` (`banner_id`, `title`, `description`, `image_path`, `link_url`, `is_active`, `order`, `start_date`, `end_date`, `created_at`, `updated_at`, `created_by`, `updated_by`) VALUES
(1, 'Welcome Banners', '-', 'uploads/banners/dd2ebc6e-dcf1-4f05-995b-efe4a8e91e6c.png', '', 1, 1, '2025-06-17 00:00:00', '2026-01-17 23:59:00', '2025-06-16 23:39:21', '2025-06-17 00:53:58', 1, 1),
(3, 'Banner Qris', '', 'uploads/banners/492530da-6e31-49f1-b5d2-d4c85d5ca51b.png', NULL, 1, 2, '2025-06-17 00:00:00', '2026-01-17 23:59:59', '2025-06-16 23:51:28', '2025-06-16 23:51:28', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `book_id` int NOT NULL,
  `isbn` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `author_id` int DEFAULT NULL,
  `price` double NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `publisher_id` int DEFAULT NULL,
  `publication_date` date DEFAULT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `width` double DEFAULT NULL,
  `length` double DEFAULT NULL,
  `weight` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`book_id`, `isbn`, `title`, `author_id`, `price`, `description`, `publisher_id`, `publication_date`, `stock`, `width`, `length`, `weight`, `category_id`, `image_path`) VALUES
(1, '9789793062792', 'Laskar Pelangi', 1, 89000, 'Laskar Pelangi merupakan novel yang terinspirasi dari kisah nyata kehidupan Andrea Hirata selaku penulis yang mana saat itu dirinya bertempat tinggal di Desa Gantung, Kabupaten Gantung, Belitung Timur. Berkenaan dengan hal tersebut, mudah bagi si penulis merepresentasikan berbagai unsur sosial dan budaya masyarakat Belitung ke dalam bentuk cerita di novel Laskar Pelangi ini secara apik.', 4, '2011-05-11', 50, 13, 0, 0, 1, 'uploads/books/1750018158570_LASKAR_PELANGI.png'),
(2, '9786022915249', 'Orang-Orang Biasa', 1, 89000, 'Kali ini, karyanya mengisahkan sebuah rencana perampokan yang dilakukan oleh 10 orang yang berada dalam satu persahabatan di Kota Belantik, yaitu Salud, Junilah, Nihe, Dinah, Handai, Sobri, Honorun, Rusip, Tohirin, dan Debut. Awalnya, Kota Belantik disebut kota naif karena masyarakatnya yang terkenal ramah dan sopan walaupun tidak banyak yang mengenyam pendidikan tinggi, namun sebutan naif tersebut hilang sejak terjadinya kasus perampokan terjadi ketika pawai kemerdekaan yang dilakukan oleh sekelompok perampok.', 4, '2019-03-01', 30, 20.5, 13, 0, 1, 'uploads/books/1750018139340_ORANG_ORANG_BIASA.png'),
(3, '9786022916864', 'Guru Aini', 1, 98100, 'Ini persamaan hidupku sekarang, Bu, âDesi menyodorkan buku catatan ke tengah meja. Bu Amanah, yang juga guru matematika, tersenyum getir melihat persamaan garis lurus dengan variabel-variabel yang didefinisikan sendiri oleh Desi, x1: pendidikan, x2: kecerdasan. Yang menarik perhatiannya adalah konstanta a: pengorbanan. âPendidikan memerlukan pengorbanan, Bu. Pengorbanan itu nilai tetap, konstan, tak boleh berubahâ Konon, berdasarkan penelitian antah berantah, umumnya idealisme anak muda yang baru tamat dari perguruan tinggi bertahan paling lama 4 bulan. Setelah itu mereka akan menjadi pengeluh, penggerutu, dan penyalah seperti banyak orang lainnya, lalu secara menyedihkan terseret arus deras sungai besar rutinitas dan basa-basi birokrasi lalu tunduk patuh pada sistem yang buruk. Dalam kenyataan hidup seperti itu, seberapa jauh Desi berani mempertahankan idealismenya menjadi guru matematika di sekolah pelosok?', 4, '2020-02-01', 40, 13, 20.5, 0, 1, 'uploads/books/1750018116876_GURU_AINI.png'),
(4, '9786022911319', 'Supernova: Inteligensi Embun Pagi', 2, 106200, 'Setelah mendapat petunjuk dari upacara Ayahuasca di Lembah Suci Urubamba, Gio berangkat ke Indonesia. Di Jakarta, dia menemui Dimas dan Reuben. Bersama, mereka berusaha menelusuri identitas orang di balik Supernova. Di Bandung, pertemuan Bodhi dan Elektra mulai memicu ingatan mereka berdua tentang tempat bernama Asko. Sedangkan Zarah, yang pulang ke desa Batu Luhur setelah sekian lama melanglangbuana, kembali berhadapan dengan misteri hilangnya Firas, ayahnya. Sementara itu, dalam perjalanan pesawat dari New York menuju Jakarta, teman seperjalanan Alfa yang bernama Kell mengungkapkan sesuatu yang tidak terduga. Dari berbagai lokasi yang berbeda, keterhubungan antara mereka perlahan terkuak. Identitas dan misi mereka akhirnya semakin jelas. Hidup mereka takkan pernah sama lagi.', 2, '2016-02-10', 50, 14, 20, 1, 1, 'uploads/books/1750018089026_INTELEGENSI_EMBUN_PAGI.png'),
(5, '9786024811242', 'Anatomi Rasa', 3, 49700, 'Anatomi Rasa ini adalah salah satu buku dalam seri Spiritualisme Kritis, tetapi masih berhubungan dengan seri Bilangan Fu yang ditulis Ayu Utami bertahun lalu. Buku ini adalah sekumpulan tulisan surat Parang Jati untuk perempuan yang dicintainya, Marja, tentang pemikirannya mengenai âRasaâ yang didasarkan pada khazanah spiritual Jawa (dalam kaitannya dengan ajaran Hindu, Buddha, dan Islam).', 7, '2019-03-18', 30, 20, 13.5, 0, 1, 'uploads/books/1750018067096_ANATOMI_RASA.png'),
(7, '9786024818722', 'Laut Bercerita', 8, 134900, 'Buku Laut Bercerita menceritakan terkait perilaku kekejaman dan kebengisan yang dirasakan oleh kelompok aktivis mahasiswa di masa Orde Baru. Tidak hanya itu, novel ini pun merenungkan kembali akan hilangnya tiga belas aktivis, bahkan sampai saat ini belum juga ada yang mendapatkan petunjuknya. Buku ini juga bertutur tentang kisah keluarga yang kehilangan, sekumpulan sahabat yang merasakan kekosongan di dada, sekelompok orang yang gemar menyiksa dan lancar berkhianat, dan sejumlah keluarga yang mencari kejelasan makam anaknya.', 7, '2022-08-03', 20, 13.5, 20, 0, 1, 'uploads/books/1750017976603_LAUT_BERCERITA.png'),
(8, '9786024242756', 'Pulang', 8, 85200, 'Paris, Mei 1968. Ketika gerakan mahasiswa berkecamuk di Paris, Dimas Suryo, seorang eksil politik Indonesia, bertemu Vivienne Deveraux, mahasiswa yang ikut demonstrasi melawan pemerintahan Prancis. Pada saat yang sama, Dimas menerima kabar dari Jakarta; Hananto Prawiro, sahabatnya, ditangkap tentara dan dinyatakan tewas. Di tengah kesibukan mengelola Restoran Tanah Air di Paris, Dimas bersama tiga kawannya-Nugroho, Tjai, dan Risjafâterus-menerus dikejar rasa bersalah karena kawan-kawannya di Indonesia dikejar, ditembak, atau menghilang begitu saja dalam perburuan peristiwa 30 September. Apalagi dia tak bisa melupakan Surti Anandariâisteri Hanantoâyang bersama ketiga anaknya berbulan-bulan diinterogasi tentara.', 7, '2017-02-20', 40, 13.5, 20, 0, 1, 'uploads/books/1750017959537_PULANG.png'),
(9, '592302176', 'Namaku Alam', 8, 85200, 'Inilah yang kubayangkan detik-detik terakhir Bapak: 18 Mei 1970. Hari gelap. Langit berwarna hitam dengan garis ungu. Bulan bersembunyi di balik ranting pohon randu. Sekumpulan burung nasar bertengger di pagar kawat. Mereka mencium aroma manusia yang nyaris jadi mayat bercampur bau mesiu. Terdengar lolongan anjing berkepanjangan. Empat orang berbaris rapi, masing-masing berdiri dengan senapan yang diarahkan kepada Bapak. Hanya satu senapan berisi peluru mematikan. Selebihnya, peluru karet. Tak satu pun di antara keempat lelaki itu tahu siapa yang kelak menghentikan hidup Bapak. Pada usianya yang ke-33 tahun, Segara Alam menjenguk kembali masa kecilnya hingga dewasa. Semua peristiwa tertanam dengan kuat. Karena memiliki photographic memory, Alam ingat pertama kali dia ditodong senapan oleh seorang lelaki dewasa ketika masih berusia tiga tahun; pertama kali sepupunya mencercanya sebagai anak âpengkhianat negaraâ; pertama kali Alam berkelahi dengan seorang anak pengusaha besar yang menguasai sekolah; dan pertama kali dia jatuh cinta. Profil Penulis: LEILA S. CHUDORI adalah purnakarya jurnalis Tempo dan penulis Indonesia yang menghasilkan berbagai karya cerita pendek, novel, dan skenario drama televisi. Buku Bukunya yang telah diterbitkan oleh Kepustakaan Populer Gramedia adalah Malam Terakhir, Pulang, Nadira, Laut Bercerita dalam versi softcover dan hardcover, serta yang akan terbit Namaku Alam. Novel berjudul Pulang menceritakan empat wartawan Indonesia yang tak bisa kembali ke tanah air setelah peristiwa tragedi 1965. Ini merupakan seri pertama dari semestanya yang kemudian dilanjutkan dengan Namaku Alam yang terbit tahun ini. Pulang memenangkan Khatulistiwa Award untuk Prosa Terbaik 2013 dan sudah diterjemahkan ke dalam bahasa Inggris menjadi âHomeâ (terjemahan John H.McGlynn, diterbitkan oleh Yayasan Lontar dan oleh Deep Vellum, AS). Tahun 2015 World Literature memasukkan âHomeâ sebagai satu dari 75 Novel Terjemahan yang Diperhatikan (75 Notable Translations of 2015). Novel ini sudah diterjemahkan ke dalam bahasa Inggris, Prancis, Belanda, Jerman dan Italia. Lima tahun kemudian, Leila meluncurkan novel berjudul Laut Bercerita yang berkisah tentang para aktivis yang diculik tahun 1998 dan belum kembali hingga kini. Peluncuran novel ini disertai penayangan film pendek âLaut Berceritaâ yang disutradarai Pritagita Arianegara, produksi Yayasan Dian Sastrowardoyo dan Cineria Films. Pada 2020, Laut Bercerita diterjemahkan ke dalam bahasa Inggris oleh John H.McGlynn menjadi âThe Sea Speaks His Nameâ dan diterbitkan oleh Penguin Random House South-east Asian (S.E.A). Novel Laut Bercerita memperoleh Penghargaaan S.E.A. Writers Award 2020 dan IKAPI Award sebagai Book of the Year tahun 2022.', 7, '2023-09-03', 20, 13.5, 20, 0, 1, 'uploads/books/1750017940318_NAMAKU_ALAM.png'),
(10, '9786020312583', 'Novel Cantik Itu Luka', 9, 106250, 'Hidup di era kolonialisme bagi para wanita dianggap sudah setara seperti hidup di neraka. Terutama bagi para wanita berparas cantik yang menjadi incaran tentara penjajah untuk melampiaskan hasrat mereka. Itu lah takdir miris yang dilalui Dewi Ayu, demi menyelamatkan hidupnya sendiri Dewi harus menerima paksaan menjadi pelacur bagi tentara Belanda dan Jepang selama masa kedudukan mereka di Indonesia. Kecantikan Dewi tidak hanya terkenal dikalangan para penjajah saja, seluruh desa pun mengakui pesona parasnya itu. Namun bagi Dewi, kecantikannya ini seperti kutukan, kutukan yang membuat hidupnya sengsara, dan kutukan yang mengancam takdir keempat anak perempuannya yang ikut mewarisi genetik cantiknya. Tapi tidak dengan satu anak terakhir Dewi, si Cantik, yang lahir dengan kondisi buruk rupa. Tak lama setelah mendatangkan Cantik ke dunia, Dewi harus berpulang. Tapi di satu sore, dua puluh satu tahun kemudian, Dewi kembali, bangkit dari kuburannya. Kebangkitannya menguak kutukan dan tragedi keluarga. Bagaimana takdir yang akan menghampiri si Cantik? Apa yang membuat Dewi harus kembali ke dunia bak neraka ini? Ungkap rahasia dibalik misteri kisah masa kolonial dalam novel Cantik Itu Luka karya Eka Kurniawan.', 1, '2018-05-07', 20, 14, 21, 1, 1, 'uploads/books/1750017911180_CANTIK_ITU_LUKA.png'),
(11, '9786020328935', 'Novel Coratcoret di Toilet', 5, 33750, 'Buku ini adalah kumpulan dari cerita pendek. Di dalamnya berisikan kisah-kisah yang mengandung semacam jejak sejarah, namun dapat dibalut humor dengan baik, sehingga para pembaca awam sekalipun dapat menikmati isi ceritanya. Dengan tidak mengurangi tajamnya kritik yang disampaikan, menunjukan situasi kemanusiaan yang buruk, dan simpati pada orang-orang yang tertindas. Judul-judul cerpen yang dimasukan dalam buku ini adalah Peter Pan, Dongen Sebelum Bercinta, Corat-Coret di Toilet, Teman Kencan, Rayuan Dusta untuk Marietje, Hikayat si Orang Gila dan lainnya. Aku tak percaya bapak-bapak anggota dewan, aku lebih percaya kepada dinding toilet. Merupakan kisah tentang berbagai macam reaksi mahasiswa terhadap situasi pemerintahan yang terekam di toilet, mengingat kebebasan berpendapat menjadi sangat mahal di tengah gemuruh politik yang sedang terjadi pada saat itu, sehingga dinding toilet pun dijadikan media menyalurkan aspirasi yang tertahan. Tulisan yang dirangkum dalam kumpulan cerpen bergaya sarkas, dan satir sosial dilahirkan dari kumpulan cerita yang disajikan apik oleh Eka Kurniawan yang juga telah menulis ÃÂÃÂÃÂÃÂ¢ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂCantik itu LukaÃÂÃÂÃÂÃÂ¢ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ.', 3, '2016-05-09', 40, 14, 21, 0, 2, 'uploads/books/1750017870915_CORAT_CORET_DITOILET.png'),
(20, '9786238952007', ' Mariposa Masa Seandainya', 13, 89100, 'Acha tak bisa berkata apa pun ketika mendengar pengakuan mengejutkan dari seseorang yang pernah menolaknya dengan kejam enam tahun lalu itu. Ia tak pernah menyangka hal seperti ini akan terjadi di hidupnya. Tubuh Acha membeku sangat lama, berusaha mencerna dengan baik kalimat tersebut. Acha harus bagaimana? Balasan apa yang harus ia berikan? Sungguh, Acha tidak tahu harus berbuat apa saat ini. Sementara laki-laki di hadapannya masih menatapnya dengan lekat dan penuh kesungguhan. âGue akan kejar lo seperti yang lo lakukan enam tahun lalu, dan gue akan berusaha buat lo suka lagi sama gue.', 13, '2025-01-21', 10, 14, 21, 300, 1, 'uploads/books/1750063971493_aa4iy_a08n.jpg'),
(21, '9786022916611', 'Ayah dan Sirkus Pohon', 1, 71100, 'Ayah dan Sirkus Pohon adalah novel dengan tema pendidikan yang masih tetap menjadi isu hangat di Indonesia. Dikemas dengan kisah antara ayah dan anak, mengkritisi kondisi sosial masyarakat Indonesia dengan gaya yang kocak dan memikat.', 4, '2020-02-02', 15, 13, 20, 169, 1, 'uploads/books/1750064755322_AyahDanSirkusPohon.jpg'),
(22, '9786024242855', 'Maya', 3, 84150, 'Setelah dua tahun Saman dinyatakan hilang, kini Yasmin menerima tiga pucuk surat dari kekasih gelapnya itu. Bersama suratnya, aktivis hak asasi manusia itu juga mengirimkan sebutir batu akik. Untuk menjawab peristiwa misterius itu Yasmin yang sesungguhnya sangat rasional terpaksa pergi ke seorang guru kebatinan, Suhubudi, ayah dari Parang Jati. Di Padepokan Suhubudi Yasmin justru terlibat dalam suatu kejadian lain yang baginya merupakan perjalanan batin untuk memahami diri sendiri, cintanya, dan negerinyaâsementara Parang Jati menjawab teka-teki tentang keberadaan Saman. Cerita ini berlatar peristiwa Reformasi 1998. Novel ini menghubungkan Seri Bilangan Fu dan dwilogi Saman-Larung.', 7, '2023-07-17', 50, 13.5, 20, 200, 1, 'uploads/books/1750064606447_maya.png'),
(23, '9786024242831', 'Lalita', 3, 84150, 'Lalita menerima sejilid kertas tua berisi bagan-bagan mandala, dan sejak itu setiap hari pengetahuannya tentang sang kakek bertambah. Setiap kali pengetahuan itu bertambah banyak, setiap kali pula sang kakek bertambah muda dalam penglihatannya. Pada suatu titik ia bisa sepenuhnya melihat seorang remaja berumur tiga belas tahun, yang berdiri lurus kaku dan kepala sedikit miring seolah melihat sesuatu yang tidak dilihat orang lain. Apa hubungan semua itu dengan Candi Borobudur? Itu akan menjadi petualangan Yuda, Marja, dan Parang Jati.', 7, '2023-07-26', 50, 13, 20, 500, 1, 'uploads/books/1750064778948_lalita.png'),
(24, '9786024812263', 'Manjali', 3, 84150, 'Marja Manjali adalah gadis kota yang ringan hati dan tak tahu banyak tentang sejarah kuno. Di tengah liburan mereka, kekasihnya tiba-tiba punya urusan mendadak dan harus pergi. Sang pacar menitipkan Marja pada Parang Jati, sahabat mereka. Parang Jati pun mengajak Marja Manjali menelusuri candi dan tempat-tempat di pedalaman Jawa Timur yang menyimpan rahasia. Cinta di antara mereka tampaknya tak terelakan. Tapi, Sandi Yuda, sang pacar, muncul lagi. Pemuda itu tak hanya membuat hati Marja Manjali terbelah; ia juga membawa masalah. Jika kebetulan terjadi terlalu banyak, seorang beriman akan mencari rencana ilahi, seorang ilmuwan akan mencari pola-pola.', 7, '2023-07-17', 40, 13.5, 20, 200, 1, 'uploads/books/1750064942845_manjali.png'),
(25, '9786022916659', 'Mozaik-Mozaik Terindah', 1, 53100, 'Mozaik-Mozaik Terindah merupakan kumpulan bab-bab pilihan editor yang diambil dari buku-buku Andrea Hirata. Di dalamnya kita akan menemukan semangat, perjuangan, cinta, harapan, dan tak kalah pentingnya adalah makna sahabat. Andrea Hirata adalah pemenang pertama penghargaan sastra New York Book Festival 2013 untuk The Rainbow Troops, Laskar Pelangi edisi Amerika, penerbit Farrar, Straus & Giroux, New York, kategori general fiction, dan pemenang pertama Buchawards 2013, Jerman, untuk Die Regenbogen Truppe, Laskar Pelangi edisi Jerman, penerbit Hanser Berlin. Dia juga pemenang seleksi short story majalah sastra terkemuka di Amerika, Washington Square Review, New York University, edisi winter/spring 2011 untuk short story pertamanya Dry Season.', 4, '2020-02-02', 10, 13, 20, 138, 1, 'uploads/books/1750065103113_MozaikMozaikTerindah.jpg'),
(26, '9786024242862', 'Larung', 3, 84150, 'Setelah sukses dengan Saman-nya, Ayu Utami kemudian memunculkan kelanjutan kisah empat sahabat perempuan dalam novel Larung. Tidak kalah bagus dari novel Saman, novel Larung ini seakan mengajak pembacanya untuk merefleksi moral dan keadilan hukum yang dimiliki oleh seluruh elemen masyarakat Indonesia, baik rakyat maupun penguasanya. Dikisahkan, Larung ini adalah karakter baru yang akan membantu Saman, mereka berdua kemudian berusaha untuk menyelamatkan tiga aktivis yang dikejar-kejar karena peristiwa 27 Juli 1996. Novel Larung ini didominasi oleh pergolakan politik dan kekuasaan rezim militer yang berusaha merepresentasikan kekuasaan orde baru.', 7, '2023-02-28', 40, 13.5, 20, 200, 1, 'uploads/books/1750065168417_larung.png'),
(27, '9786024243999', 'Saman', 3, 75650, 'Empat perempuan bersahabat sejak kecil. Shakuntala si pemberontak. Cok si binal. Yasmin yang selalu ingin ideal. Dan Laila, si lugu yang sedang bimbang untuk menyerahkan keperawanannya pada lelaki beristri. Tapi diam-diam dua di antara sahabat itu menyimpan rasa kagum pada seorang pemuda dari masa silam: Saman, seorang aktivis yang menjadi buron dalam masa rezim militer Orde Baru. Kepada Yasmin, atau Lailakah, Saman akhirnya jatuh cinta.', 7, '2023-02-28', 50, 13.5, 20, 180, 1, 'uploads/books/1750065306806_saman.png'),
(28, '9786230021312', 'Spy x Family 1', 14, 38250, 'Spy X Family mengisahkan tentang seorang mata-mata yang demi melancarkan misi perdamaian harus membangun sebuah keluarga palsu. Master mata-mata Twilight tidak tertandingi dalam hal menyamar dalam misi berbahaya demi kemajuan dunia. Agen dengan sebutan nama âTwilightâ atau âSenjaâ, yang merupakan mata-mata utama di Westalia Intelligence Servicesâ Eastern (W.I.S.E), hidup dengan kerap kali berganti-ganti identitas. Tugasnya itulah yang membuatnya harus melakukan berbagai kehidupan yang berbeda lewat berbagai penyamaran. Walaupun begitu, ia mendedikasikan hidupnya demi kedamaian dunia.', 3, '2020-10-14', 100, 12, 18, 150, 2, 'uploads/books/1750065529131_spy_x_family_1.png'),
(29, '9786020324708', 'Seperti Dendam, Rindu Harus Dibayar Tuntas', 9, 63750, 'Seperti Dendam, Rindu Harus Dibayar Tuntas karya Eka Kurniawan bercerita tentang seorang anak muda bernama Ayo Kawir mengintip sebuah tragedi pemerkosaan yang dilakukan oleh dua orang posisi terhadap seorang perempuan sakit jiwa ', 1, '2021-12-03', 20, 14, 21, 350, 1, 'uploads/books/1750065549945_GPU_SDRHD2019MTH03SDRHD9.jpg'),
(30, '9786230022272', 'Spy x Family 2', 14, 38250, 'Twilight harus menyusup ke Akademi Eden yang bergengsi untuk mendekati targetnya Donovan Desmond, tetapi apakah dia menghancurkan peluang putrinya Anya dengan ledakannya selama wawancara penerimaan? Mungkin misi yang benar-benar pasti kali ini adalah memastikan Anya berdua menjadi siswa teladan dan berteman dengan putra Donovan yang sombong, Damian.', 3, '2021-01-06', 100, 12, 18, 212, 2, 'uploads/books/1750065698362_spy_x_family_2.png'),
(31, '9786230025334', 'Spy X Family 3', 14, 38250, 'Untuk menjaga perdamaian antara negara-negara saingan Westalis dan Ostania, agen Westalis dengan nama sandi \"Twilight\" ditugaskan untuk memata-matai Donovan Desmond, pemimpin partai politik ekstremis di Ostania. Namun, karena Desmond terkenal tertutup, satu-satunya cara Twilight bisa dekat dengannya adalah dengan mendaftarkan seorang anak di sekolah swasta yang sama dengan putra Desmond dan menyamar sebagai ayah mereka. Untuk mencapai ini, ia menciptakan alias Loid Forger, mengadopsi seorang gadis yatim piatu bernama Anya, dan menikahi seorang wanita bernama Yor Briar, untuk menciptakan citra keluarga yang bahagia. Namun, Yor sebenarnya adalah seorang pembunuh bayaran profesional, baik dia maupun Loid mereka berdua tidak menyadari identitas sebenarnya masing-masing. Keduanya juga tidak menyadari bahwa Anya bisa membaca pikiran, dan mengetahui profesi mereka yang sebenarnya. Terlepas dari faktor-faktor yang tidak diketahui ini, Loid harus belajar memainkan peran ayah dan suami yang sempurna untuk menjalankan misinya.', 3, '2021-04-14', 100, 12, 18, 120, 2, 'uploads/books/1750065946901_spy_x_family_3.png'),
(32, '9786230027246', 'Spy X Family 4', 14, 38250, 'The Forgers ingin menambahkan seekor anjing ke dalam keluarga mereka, tetapi ini bukanlah tugas yang mudahâterutama ketika Twilight harus secara bersamaan menggagalkan rencana pembunuhan terhadap seorang menteri luar negeri! Para pelaku berencana untuk menggunakan anjing yang terlatih khusus untuk serangan itu, tetapi Twilight mendapat bantuan tak terduga untuk menghentikan para teroris ini.', 3, '2021-07-21', 100, 12, 18, 150, 2, 'uploads/books/1750066103565_spy_x_family_4.png'),
(33, '9786230952586', 'Hi Awan', 13, 89100, 'Dua mata indah itu terus menatapi satu sosok yang sedang tertawa di meja ujung kafe. Paras yang tampan, senyum melengkung manis, dan sikap yang ramah. Semuanya terlihat sangat menenangkan.', 13, '2023-09-30', 20, 14, 20.5, 230, 1, 'uploads/books/1750066171116_cpgcc2bidmejrupekfknkm.jpg'),
(34, '9786230029400', 'Spy x Family 5', 14, 38250, 'Anya Forger telah mencoba yang terbaik untuk berteman dengan Damian Desmond, putra pemimpin politik kuat Ostania, Donovan Desmond. Namun usahanya terus menerus ditolak. Meskipun mengalami kemunduran, Anya bertekad untuk mendapatkan akses ke lingkaran dalam Desmonds dan menyusun rencana baruâmencapai ujian tengah semesternya! Bisakah Anya yang tertantang secara akademis melakukan hal ini demi perdamaian dunia?', 3, '2021-12-08', 100, 12, 18, 150, 2, 'uploads/books/1750066247314_spy_x_family_5.png'),
(35, '9786236456118', 'Mariposa 2 Part 2', 13, 89100, 'Mariposa adalah sebuah novel fiksi romance. Dalam bahasa Spanyol, Mariposa dapat diartikan sebagai kupu kupu, dan kupu kupu sendiri memiliki filosofi. semakin dikejar, akan semakin menjauh, tapi jika dibiarkan, maka akan semakin mendekat. filosofi itulah yang kemudian menjadi ide cerita novel Mariposa ini.', 13, '2022-02-05', 20, 14.5, 21, 3350, 1, 'uploads/books/1750066389623_img20220205_15340302.avif'),
(36, '0000000000', 'Watches Indonesia Edisi 27 - 2025', 15, 100000, 'Watches Indonesia adalah majalah khusus yang membahas dunia jam tangan, mulai dari model terbaru, tren, hingga sejarah dan kolektor. Apa yang mungkin Anda temukan di dalamnya? Ulasan Jam Tangan Terbaru, Tren Terbaru di Dunia Jam Tangan, Tips dan Trik Merawat Jam Tangan, Sejarah dan Perkembangan Jam Tangan, Foto-foto Berkualitas Tinggi.', 14, '2025-06-16', 20, 24, 30, 50, 3, 'uploads/books/1750066396879_WhatsApp_Image_2025_06_16_at_16.25.46_b9c717ac.jpg'),
(37, '9786230017193', 'Demon Slayer: Kimetsu No Yaiba 01', 16, 34000, 'Hidup Tanjiro tiba-tiba hancur saat ia pulang ke rumah dan melihat rumahnya berlumuran darah, seluruh keluarganya dibantai iblis dan hanya tersisa Nezuko, adik perempuannya yang masih hidup namun Nezuko sudah berubah menjadi iblis. Ia berusaha keras agar Nezuko kembali saat nyawanya hampir terancam. Giyu, salah satu pembasmi iblis muncul saat itu dan membuat Tanjiro berusaha menghindar dari serangan Giyu yang ingin membunuh Nezuko. Akhirnya Giyu memutuskan untuk tidak membunuh Nezuko dan mengutus Tanjiro pergi menemui seseorang. Tanjiro pun mengikuti perintah Giyu dan bertekad untuk membalas dendam keluarganya serta menjadikan Nezuko kembali menjadi manusia.', 3, '2020-05-18', 100, 12, 18, 130, 2, 'uploads/books/1750066679723_demon_slayer_1.png'),
(38, '9786236456101', 'Mariposa 2 Part 1', 13, 89100, 'Mariposa adalah sebuah novel fiksi romance. Dalam bahasa Spanyol, Mariposa dapat diartikan sebagai kupu kupu, dan kupu kupu sendiri memiliki filosofi semakin dikejar, akan semakin menjauh, tapi jika dibiarkan, maka akan semakin mendekat. filosofi itulah yang kemudian menjadi ide cerita novel Mariposa ini.', 13, '2022-02-05', 20, 14.5, 21, 330, 1, 'uploads/books/1750066686396_img20220205_15065175.avif'),
(39, '0000000001', 'Fortune Indonesia (Edisi Mei 2025)', 15, 100000, 'Edisi Mei 2025 dari majalah Fortune Indonesia hadir dengan beberapa sorotan utama. Di dalamnya, Anda akan menemukan analisis mendalam mengenai tantangan yang dihadapi industri asuransi di Indonesia, mulai dari pelemahan daya beli masyarakat, inflasi biaya kesehatan yang tinggi, hingga ketatnya persaingan antar perusahaan. Alexander Grenz dari Allianz Life Indonesia berbagi strategi perusahaan dalam menghadapi dinamika pasar ini. Secara keseluruhan, Fortune Indonesia edisi Mei 2025 menyajikan perpaduan antara analisis strategis sektor keuangan dan bahasan mendalam mengenai industri pendukung yang esensial bagi perekonomian Indonesia.', 14, '2025-05-01', 20, 20, 28, 40, 3, 'uploads/books/1750066710183_Fortune_Indonesia__Edisi_Mei_2025_.jpg'),
(40, '9786230018220', 'Demon Slayer: Kimetsu No Yaiba 02', 16, 34000, 'Setelah berhasil melewati seleksi akhir ujian untuk menjadi anggota Kisatsutai,Tanjiro ditemani Nezuko yang telah sadarkan diri, pergi ke suatu kota di mana para gadis muda dikabarkan menghilang secara misterius. Apakah ini juga ulah iblis?', 3, '2020-12-09', 100, 12, 18, 150, 2, 'uploads/books/1750066819201_demon_slayer_2.png'),
(41, '9786025508615', 'Mariposa', 13, 89100, 'Buku yang dikarang oleh penulis bernama Luluk HF dan memiliki judul Mariposa ini adalah buku yang menceritakan mengenai Natasha Kay Loovi atau yang biasa dikenal dengan sapaan Acha. Acha merupakan gadis ajaib yang memiliki paras cantik layaknya seorang bidadari. Selain itu, Mariposa ini juga merupakan buku yang menceritakan mengenai Iqbal. ', 13, '2020-03-20', 20, 14.5, 21, 480, 1, 'uploads/books/1750066876065_mariposa_cover_film.avif'),
(42, '0000000002', 'National Geographic Indonesia Mei 2025', 15, 70000, 'Dalam edisi spesial ini, National Geographic Indonesia menyoroti berbagai topik termasuk eksplorasi alam, pelestarian budaya, dan perkembangan ilmu pengetahuan di Indonesia. Meskipun detail spesifik mengenai isi edisi Mei 2025 belum tersedia, edisi-edisi sebelumnya sering kali menampilkan artikel tentang ekosistem Indonesia, tradisi suku-suku asli, dan penemuan ilmiah terbaru.', 14, '2025-05-01', 30, 21, 28, 350, 3, 'uploads/books/1750066908018_NationalGeographicIndonesiaMei2025.jpg'),
(43, '9786230018961', 'Demon Slayer: Kimetsu No Yaiba 03', 16, 34000, 'Kediaman Tamayo diserang oleh dua iblis yang mengendalikan bola dan panah. Kedua iblis itu merupakan bawahan Kibutsuji yang ingin membunuh Tanjiro dan Nezuko. Tanjiro dan Nezuko bekerja sama untuk membunuh kedua iblis yang sudah menghancurkan kediaman Tamayo. Tanjiro mendapatkan bantuan Yushiro untuk melihat arah bola dari iblis tersebut. Sementara Tanjiro melawan iblis bola, Nezuko pun melawan iblis panah itu. Apakah Tanjiro dan Nezuko berhasil memenangkan pertarungan melawan dua iblis suruhan Kibutsuji?', 3, '2020-11-04', 100, 12, 19, 120, 2, 'uploads/books/1750066963355_demon_slayer_3.png'),
(44, '0000000003', 'Bobo 06 (Edisi 15 Mei 2025)', 15, 17000, 'Membaca majalah memberikan banyak manfaat, salah satunya adalah sebagai sumber informasi terkini. Majalah sering kali menyajikan berita dan tren terbaru di berbagai bidang seperti teknologi, fashion, kesehatan, dan ekonomi. Selain itu, majalah juga memperluas wawasan pembaca dengan topik yang bervariasi, memberikan pengetahuan spesifik yang lebih mendalam, serta wawancara eksklusif yang sulit ditemukan di media lain. Hal ini membantu pembaca memahami isu-isu atau tren yang sedang berkembang dalam waktu yang lebih singkat dibandingkan buku.', 14, '2025-05-01', 30, 21, 29, 670, 3, 'uploads/books/1750067452301_Bobo06_Edisi15Mei2025_.jpg'),
(45, '9786023768073', 'Hukum Agraria & Tata Ruang', 2, 58500, 'hukum Agraria adalah Keseluruhan kaidah-kaidah hukum baik yang tertulis maupun yang tidak tertulis yang mengatur agraria. Bachsan Mustofa menjabarkan kaidah hukum yang tertulis adalah Hukum Agraria dalam bentuk hukum undang-undang dan peraturan-peraturan tertulis lainnya yang dibuat negara, sedangkan kaidah hukum yang tidak tertulis adalah Hukum Agraria dalam bentuk hukum Adat Agraria yang dibuat oleh masyarakat adat setempat dan yang pertumbuhan,', 16, '2022-07-20', 40, 15, 23, 3550, 1, 'uploads/books/1750068107052_img20220720_13453314.avif'),
(46, '0000000004', 'Peluang Maret 2025', 15, 55000, 'Majalah Peluang No.180 edisi Maret 2025 kembali hadir dengan sejumlah ulasan ekonomi menarik. Khususnya dalam melihat prospek ekonomi era Presiden Prabowo Subianto. Di 100 hari pertama kepemimpinannya, kami menyoroti alasan mengapa \'Indonesia Gelap\' atas beban dengan segepok ambisi, lewat kampanye bersama wakilnya, berupa katrol tax ratio jadi 23% yang pada 2022 baru 10,41% dari PDB; buka 19 juta lapangan kerja; pertumbuhan ekonomi 6%-7%; tekan kemiskinan di bawah 5% dari saat ini 9,36%; makan bergizi gratis untuk 70,5 juta pelajar dan balita yang anggarannya Rp471 triliun=14,16% dari belanja negara.', 14, '2025-06-16', 30, 21, 28, 200, 3, 'uploads/books/1750068327689_PeluangMaret2025.jpg'),
(47, '9786022910572', 'Spernova: Gelombang ', 2, 139000, 'Sebuah upacara gondang mengubah segalanya bagi Alfa. Makhluk misterius yang disebut Si Jaga Portibi tiba tiba muncul menghantuinya. Orang orang sakti berebut menginginkan Alfa menjadi murid mereka. Dan, yang paling mengerikan dari itu semua adalah setiap tidurnya menjadi pertaruhan nyawa. Sesuatu menunggu Alfa di alam mimpi.', 4, '2014-10-06', 25, 13.5, 20, 400, 1, 'uploads/books/1750068608937_9786022910572_supernova_gelombang__5.avif'),
(48, '9786028811712', 'Novel Akar: Supernova', 2, 89000, 'Kesejatian hidup ada pada batu kerikil yang tertendang ketika kau melangkah menyusuri jalan. Kesejatian hidup ada pada selembar daun kering yang gugur tertiup angin. Kesejatian hidup ada air susu ibu yang yang merelakan puting payudaranya dihisap oleh bayi manapun. ', 4, '2012-03-04', 25, 14.5, 20, 350, 1, 'uploads/books/1750068872946_AKAR_SUPERNOVA_edit.avif'),
(49, '9786230019685', 'Demon Slayer: Kimetsu No Yaiba 04', 16, 34000, 'Begitu Tanjiro keluar usai mengalahkan iblis pengguna tsuzumi, dia melihat Zenitsu Agatsuma tengah dipukuli secara sepihak oleh seorang pemuda bertopeng babi hutan. Tanjiro berusaha menghentikan pemuda itu, tapi setelahnya dia yang jadi incaran! Usai beristirahat, Tanjiro dan kawan-kawan mendapat perintah darurat dari Kisatsutai dan menuju suatu gunung yang menyeramkan!! Rahasia apa yang tersembunyi di gunung itu?', 3, '2021-01-27', 100, 12, 18, 130, 2, 'uploads/books/1750068943623_demon_slayer_4.png'),
(50, '9786028811729', 'Kesatria. Putri & Bintang Jatuh: Supernova', 2, 89000, 'Reuben dan Dimas, pasangan gay yang sama-sama berprofesi akademisi, berikrar untuk membuat karya bersama pada hari jadi mereka ke 10. Reuben, yang terobsesi menghubungkan sains dan spiritualitas dan menyebut dirinya Psikolog Kuantum. ', 4, '2012-03-04', 25, 14.5, 20, 400, 1, 'uploads/books/1750069137017_Kesatria._Putri__Bintang_Jatuh_Supernova.avif'),
(51, '9786230024382', 'Demon Slayer: Kimetsu No Yaiba 05', 16, 34000, 'Tanjiro dan kawan-kawan akhirnya beranjak menuju Gunung Natagumo dan bertarung begitu alot melawan keluarga iblis laba-laba penghuni gunung tersebut! Zenitsu terkena racun yang akan mengubahnya menjadi laba-laba, Inosuke dan Tanjiro menjadi bulan-bulanan iblis raksasa yang berperan sebagai ayah. Ujung pertarungan mereka belum tampak. Di tengah keputusasaan itu, adakah yang bergerak menyusul mereka di belakang?', 3, '2021-03-02', 100, 12, 18, 150, 2, 'uploads/books/1750069262658_demon_slayer_5.png');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int NOT NULL,
  `customer_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cart_id`, `customer_id`) VALUES
(1, 39);

-- --------------------------------------------------------

--
-- Table structure for table `cart_item`
--

CREATE TABLE `cart_item` (
  `cart_id` int NOT NULL,
  `book_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `name`) VALUES
(1, 'novel'),
(2, 'komik'),
(3, 'majalah');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `user_id` int NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`user_id`, `phone`, `address_id`) VALUES
(4, '08XXXXX', 2),
(24, NULL, NULL),
(25, NULL, NULL),
(26, NULL, NULL),
(29, NULL, NULL),
(30, NULL, NULL),
(31, NULL, NULL),
(32, NULL, NULL),
(33, NULL, NULL),
(34, NULL, NULL),
(35, NULL, NULL),
(36, NULL, NULL),
(37, NULL, NULL),
(38, NULL, NULL),
(39, '081238483920', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `total` double NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `payment_id` int DEFAULT NULL,
  `shipment_id` int DEFAULT NULL,
  `processed_by` int DEFAULT NULL,
  `tracking_number` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_item`
--

CREATE TABLE `order_item` (
  `order_id` int NOT NULL,
  `book_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int NOT NULL,
  `order_id` int NOT NULL,
  `amount` double NOT NULL,
  `date_time` datetime NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `payment_method_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_method`
--

CREATE TABLE `payment_method` (
  `payment_id` int NOT NULL,
  `payment_code` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `payment_status` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `date_time` datetime NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `publisher`
--

CREATE TABLE `publisher` (
  `publisher_id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `publisher`
--

INSERT INTO `publisher` (`publisher_id`, `name`, `description`) VALUES
(1, 'Gramedia Pustaka Utama', 'Salah satu penerbit terbesar di Indonesia, bagian dari Kompas Gramedia.'),
(2, 'Mizan Pustaka', 'Penerbit independen terkenal dengan buku-buku Islam dan fiksi populer.'),
(3, 'Elex Media Komputindo', 'Penerbit komik, teknologi, dan novel terjemahan, anak perusahaan Gramedia.'),
(4, 'Bentang Pustaka', 'Fokus pada sastra, biografi, dan novel terjemahan.'),
(5, 'Republika Penerbit', 'Penerbit buku Islam dan budaya populer.'),
(6, 'Penerbit Erlangga', 'Fokus pada buku pelajaran dan pendidikan formal.'),
(7, 'Kepustakaan Populer Gramedia', 'Dikenal dengan karya-karya sastra, sejarah, dan sosial.'),
(8, 'Noura Publishing', 'Penerbit buku religi dan fiksi populer.'),
(9, 'Buku Mojok', 'Penerbit independen dengan tema-tema kritis dan progresif.'),
(10, 'GagasMedia', 'Terkenal dengan novel-novel pop dan fiksi remaja Indonesia.'),
(13, 'Coconut Books', ''),
(14, 'Majalah Gramedia', 'Menerbitkan majalah-majalah'),
(16, 'Pustaka Baru Press', '');

-- --------------------------------------------------------

--
-- Table structure for table `qris_payment`
--

CREATE TABLE `qris_payment` (
  `payment_id` int NOT NULL,
  `qris_code` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `report_id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `generated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `type_id` int DEFAULT NULL,
  `report_data` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `report_type`
--

CREATE TABLE `report_type` (
  `type_id` int NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `periodicity` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `review_id` int NOT NULL,
  `book_id` int NOT NULL,
  `reviewer_id` int NOT NULL,
  `rating` int NOT NULL,
  `comment` text COLLATE utf8mb4_general_ci,
  `review_date` datetime DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`review_id`, `book_id`, `reviewer_id`, `rating`, `comment`, `review_date`) VALUES
(1, 1, 3, 5, 'Buku yang sangat bagus! Sangat membantu dalam memahami konsep programming.', '2024-01-15 10:30:00'),
(2, 1, 4, 4, 'Penjelasan cukup jelas, tapi ada beberapa bagian yang bisa diperbaiki.', '2024-01-16 14:20:00'),
(3, 2, 3, 5, 'Buku wajib untuk data scientist! Sangat komprehensif.', '2024-01-17 09:15:00'),
(5, 3, 4, 3, 'Buku standar untuk web development, tidak ada yang istimewa.', '2024-01-19 11:30:00'),
(7, 4, 3, 5, 'Excellent book for mobile development!', '2024-01-21 08:40:00'),
(8, 5, 4, 4, 'Good introduction to machine learning concepts.', '2024-01-22 15:10:00');

-- --------------------------------------------------------

--
-- Table structure for table `shipment`
--

CREATE TABLE `shipment` (
  `shipment_id` int NOT NULL,
  `shipping_method_id` int NOT NULL,
  `estimated_date` date DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `cost` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shipment`
--

INSERT INTO `shipment` (`shipment_id`, `shipping_method_id`, `estimated_date`, `address`, `cost`) VALUES
(1, 1, '2025-06-15', 'Jl. Merdeka No. 10, Bandung, Jawa Barat 40111', 5),
(2, 2, '2025-06-12', 'Jl. Jenderal Sudirman Kav. 52-53, Jakarta Selatan, DKI Jakarta 12190', 15),
(3, 3, '2025-06-10', 'Jl. Dago Asri I No. 24, Coblong, Bandung, Jawa Barat 40135', 25),
(4, 1, '2025-06-16', 'Jl. Pahlawan No. 88, Surabaya, Jawa Timur 60174', 5),
(5, 2, '2025-06-13', 'Jl. Gajah Mada No. 1, Semarang, Jawa Tengah 50134', 15);

-- --------------------------------------------------------

--
-- Table structure for table `shipping_method`
--

CREATE TABLE `shipping_method` (
  `shipping_method_id` int NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `cost` double NOT NULL,
  `estimated_days` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shipping_method`
--

INSERT INTO `shipping_method` (`shipping_method_id`, `name`, `description`, `cost`, `estimated_days`) VALUES
(1, 'Standard Shipping', 'Regular shipping service, 3-5 business days', 5, 5),
(2, 'Express Shipping', 'Fast shipping service, 1-2 business days', 15, 2),
(3, 'Same Day Delivery', 'Delivery on the same day for local orders', 25, 0);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `user_id` int NOT NULL,
  `position` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`user_id`, `position`) VALUES
(3, 'Head Manager');

-- --------------------------------------------------------

--
-- Table structure for table `store_setting`
--

CREATE TABLE `store_setting` (
  `store_id` int NOT NULL,
  `store_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `logo_path` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_general_ci,
  `phone` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `social_media` text COLLATE utf8mb4_general_ci,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_setting`
--

INSERT INTO `store_setting` (`store_id`, `store_name`, `logo_path`, `address`, `phone`, `email`, `description`, `social_media`, `updated_at`) VALUES
(1, 'BookStore', NULL, '123 Main Street, City, Country', '+1234567890', 'contact@bookstore.com', 'Your one-stop shop for all kinds of books', NULL, '2025-05-25 01:34:12');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `gender` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `login` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `full_name`, `gender`, `birth_date`, `role_id`, `image_path`, `login`) VALUES
(1, 'baysatriow', 'bayusatriowid@gmail.com', '$2a$12$fiZ9Sw.RJ7YhnuGqeBlGUOTSy6NxNhiJsntCZRd9Z0qXy91LFTteC', 'Bayu Satrio Wibowo', 'Male', '2005-03-12', 1, '-', 1),
(2, 'admins', 'admin@gmail.com', '$2y$10$dDBJGmckjngsL99qsVLfw.83/Q/dmAAXn3.hsQ5zPcj5jiX0YjpZG', 'Administrator', 'Female', '2000-01-01', 1, '-', 0),
(3, 'staff', 'staff@gmail.com', '$2y$10$6zE1HOnjljX9WMnFDiRLmeFSdSPPOdFTRFb6NwgKWda5ValWUNcdm', 'Staff', 'Male', '2025-05-01', 2, '-', 0),
(4, 'lamberry', 'Lamberi@gmail.com', '$2y$10$IopTSaPNILEGSbk1xOOMS.yC2sGBFpsFOoK4UcHNX2fD61aKHD046', 'Lamberry Roy', 'Male', '1994-02-11', 3, '-', 0),
(6, 'siti_sulistiani', 'siti.sulistiani1992@yahoo.com', '$2a$12$6bnCahWn9IqFF7M9mn9Gx0gQ9io2lv5ksqAZoAOIscJti7rL6zGbS', 'Siti Sulistiani', 'Female', '1992-07-05', 3, '-', 0),
(7, 'agung_wahyudi', 'agung.wahyudi1991@gmail.com', '$2a$12$OYzYO.Whxh1qzvZux0zPtKLMOR61X9FPQNkFzx3EIRlqHaZIn5C8O', 'Agung Wahyudi', 'Male', '1991-10-09', 3, '-', 0),
(8, 'lina_purnama', 'lina.purnama1993@hotmail.com', '$2a$12$0mBjsvw9zJG0FkjynjOjt6wGSmq0eBPo81vufL2Vhp8w.BJ7pwcx2', 'Lina Purnama', 'Female', '1993-04-18', 3, '-', 0),
(9, 'rio_hidayat', 'rio.hidayat1994@outlook.com', '$2a$12$9pkHbB6gBfnmlHzIcZelFzHp5RMMl8htyQyDmmhD8vKlLKmTeQ27s', 'Rio Hidayat', 'Male', '1994-12-02', 3, '-', 0),
(10, 'indra_pratama', 'indra.pratama1992@gmail.com', '$2a$12$1UqDbykFlG3CpKB5.PV58bSeUmG7uUGWRpZSz2H1cPWLz5ZKHntjK', 'Indra Pratama', 'Male', '1992-09-14', 3, '-', 0),
(11, 'nina_sari', 'nina.sari1995@yahoo.com', '$2a$12$ZQqj8u2AqMoxlQ32LfZ5KK9ykffYyyFwGT0.C.Et7if5BaNRpfZ8G', 'Nina Sari', 'Female', '1995-08-21', 3, '-', 0),
(12, 'arief_febrianto', 'arief.febrianto1990@gmail.com', '$2a$12$QDozF7mHhgZ1zdt7CKZXKOzVZ6A4I0nMz3fpPSmLlDdR9n8efUOxO', 'Arief Febrianto', 'Male', '1990-06-27', 3, '-', 0),
(13, 'fitri_rahmawati', 'fitri.rahmawati1991@hotmail.com', '$2a$12$rgZ2xshKMOum9gIKHwrf1aOZ7Mie9d8yEbZb6.Iw.Tpe7Xx3CGbRS', 'Fitri Rahmawati', 'Female', '1991-11-17', 3, '-', 0),
(14, 'joko_prabowo', 'joko.prabowo1989@yahoo.com', '$2a$12$zkd6C3xyW1GmmCSh1V8yGlE2u7eh6DB6gFJl1/ZoTbcpgmrGGHv4m', 'Joko Prabowo', 'Male', '1989-05-01', 3, '-', 0),
(15, 'yuliana_setyawati', 'yuliana.setyawati1994@gmail.com', '$2a$12$MIHRkD2yOpVW3SHmBR2twOaO6xLl9T95n9NzWmiHtD0FOE1hfHqGy', 'Yuliana Setyawati', 'Female', '1994-03-22', 3, '-', 0),
(16, 'agus_wirawan', 'agus.wirawan1993@hotmail.com', '$2a$12$kkUlB5gtzqMiF6f8mi9R9PAxhxaBXXyZYzT1Lo2J5ln9Pa0sh82wK', 'Agus Wirawan', 'Male', '1993-06-08', 3, '-', 0),
(17, 'tina_yuliana', 'tina.yuliana1991@gmail.com', '$2a$12$u0lAK2RZ2YckZc39a4cIYJH2qu3OBxu7wJygky4hbYOeicCMqffvA', 'Tina Yuliana', 'Female', '1991-12-15', 3, '-', 0),
(18, 'litazaa', 'elytazaa@yahoo.com', '$2a$12$yZpppGoF7OnoOciBa7UtOiDa2wyT7BQtOWXq8D3tVR1zKmwp5MZXK', 'Zanetra Elyta', 'Female', '2005-02-28', 3, '-', 0),
(19, 'maria_anggiani', 'maria.anggiani1994@outlook.com', '$2a$12$gMn80KkCeP7IKy7NbpDXwHZKl0WePAVKwwJlKVmNw.r7TVYFng0km', 'Maria Anggiani', 'Female', '1994-01-30', 3, '-', 0),
(21, 'hanna_susanti', 'hanna.susanti1993@hotmail.com', '$2a$12$NLPV5wWc78MBElOyfFlNql14wBmqQmQu46v9vYqF37M9UUIc4Gjje', 'Hanna Susanti', 'Female', '1993-09-07', 3, '-', 0),
(22, 'heru_adi', 'heru.adi1991@gmail.com', '$2a$12$LGR2YkM0MP3IuYd6mrzQnDbjw1tR3tYvlZZKzm6Onv.6QFx2EFKY6', 'Heru Adi', 'Male', '1991-10-02', 3, '-', 0),
(24, 'halomohan', 'mohanagz@gmail.com', '$2a$12$6ewtwnKe/bN1yy9ftlsxvuhG0yryO/dAMUvzP8DBYtLZEYKo8Lv/q', 'Gilbert Halomoan', 'Male', '2005-07-06', 3, NULL, 1),
(25, 'saHdanee', 'sahdanaja@gmail.com', '$2a$12$COpKUaFiU0FkPQw.XtxcKei01.66sXYkAiQooIgHQtS3WxqA7l7ua', 'Syahdan  Rizki', 'Male', '2005-01-01', 3, NULL, 1),
(26, 'bayus', 'bayus@gmail.com', '$2a$12$LQsOrWw484LxaZBMsRPti.FK.DssgJk70hm8Bv28DUnMEu3/G356.', 'Bayu', 'Male', '2025-06-16', 3, NULL, 1),
(27, 'omnifyzid', 'director@salmanitb.com', '$2a$12$dFhNNNUzyN0zCIiDkoPTJO695dArGQ1CdLShdTC9E7/QMTWaM3SzG', 'Bayu', 'Male', '2025-06-16', 1, 'null', 0),
(29, 'bayu99', 'bayu99@gmail.com', '$2a$12$Ygsz7bP1ZXqI3pq2nuJ.MOKTzcxf60vHC3.7IAUnTaeZ.yk3hnIBy', 'Wibowo Yuba', 'Male', '2005-02-22', 3, NULL, 1),
(30, 'fadhillahahsan08', 'fadhillahahsan08@gmail.com', '$2a$12$MM3rmu3Lg5EtWPiPQ9ILPuxqDrTtcQBnSyamf3bFdy/Ag3Jeh1Vla', 'Sitti Fadhillah Nur Ahsan', 'Female', '2005-09-08', 3, NULL, 1),
(31, 'a12isazahra', 'a12isazahra@gmail.com', '$2a$12$3t2Ov4U6./2vYWKAMAR2w.zQq0QTstoB.V/GDAwBjoNmUjuoBxmZC', 'Aisya Zahra', 'Female', '2004-03-01', 3, NULL, 1),
(32, 'imbron', 'imbron@gmail.com', '$2a$12$sFHgH8m/6d3bV4KQW81Ite3mB7/CYLzgffbKwYT6z2RCpOiKXn7Xa', 'Muhammad Imbron Yadie', 'Male', '1988-11-02', 3, NULL, 0),
(33, 'aranita', 'aranita@yahoo.com', '$2a$12$TQ2rO28lFYyQwUVuoyOC0uXGAnaoCMA0Sk4c0wKakQuGQSNlUo0Ci', 'Nadia Aranita', 'Female', '1998-01-01', 3, NULL, 0),
(34, 'Jenniekim', 'jenniekim@yahoo.com', '$2a$12$wxBsc2LQAiRZgy/y5ifOvO9IU7SEkZHhuA2Zr83k0hvSLLUGA7ecq', 'Jennie Kimberly', 'Female', '1996-01-16', 3, NULL, 0),
(35, 'warungindomie', 'warungindomie@yahoo.com', '$2a$12$FbKSYbyRSTToptXOZFSaeOehgU7AVdX29bWdUSZMKC8Pszoc.EDxy', 'Warmindo', 'Male', '1960-08-08', 3, NULL, 0),
(36, 'madeline', 'madeline@student.telkomuniversity.ac.id', '$2a$12$FkyvNqgH.LJFmaMTxpc1Uu4LDVUBj7ou7lr/qQA31cikHY2ROzBi2', 'Madeline', 'Female', '2001-06-17', 3, NULL, 0),
(37, 'renie45', 'renie45@gmail.com', '$2a$12$dJDm.JTOwESVSd1g9HbfyuPf8G5TAstfMLC8sB8ySz..3Hjn/XL7q', 'Julieta Anggraeni', 'Female', '1984-11-14', 3, NULL, 0),
(38, 'rumlah', 'rumlah@gmail.com', '$2a$12$PLL3K3nchd7oFyatwGM4u.LuhUKNE1.jU8L.rATW4he7FXfDSTOvm', 'Dahyat Amrullah', 'Male', '1998-06-10', 3, NULL, 0),
(39, 'customer', 'customer@gmail.com', '$2a$12$/4c822u5tl8NR.VhP5uEhexatgt9IcJzJWnpE1cgPD5bMEjnAfYKq', 'gilbert', 'Laki-laki', '2004-12-09', 3, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE `user_role` (
  `role_id` int NOT NULL,
  `role_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `is_default` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_role`
--

INSERT INTO `user_role` (`role_id`, `role_name`, `is_default`) VALUES
(1, 'ADMIN', 0),
(2, 'STAFF', 0),
(3, 'CUSTOMER', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`address_id`);

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `author`
--
ALTER TABLE `author`
  ADD PRIMARY KEY (`author_id`);

--
-- Indexes for table `bank_transfer`
--
ALTER TABLE `bank_transfer`
  ADD PRIMARY KEY (`payment_id`);

--
-- Indexes for table `banner_slide`
--
ALTER TABLE `banner_slide`
  ADD PRIMARY KEY (`banner_id`);

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`book_id`),
  ADD UNIQUE KEY `isbn` (`isbn`),
  ADD KEY `author_id` (`author_id`),
  ADD KEY `publisher_id` (`publisher_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `cart_item`
--
ALTER TABLE `cart_item`
  ADD PRIMARY KEY (`cart_id`,`book_id`),
  ADD KEY `book_id` (`book_id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `address_id` (`address_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `payment_id` (`payment_id`),
  ADD KEY `shipment_id` (`shipment_id`),
  ADD KEY `processed_by` (`processed_by`);

--
-- Indexes for table `order_item`
--
ALTER TABLE `order_item`
  ADD PRIMARY KEY (`order_id`,`book_id`),
  ADD KEY `book_id` (`book_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `payment_method_id` (`payment_method_id`);

--
-- Indexes for table `payment_method`
--
ALTER TABLE `payment_method`
  ADD PRIMARY KEY (`payment_id`),
  ADD UNIQUE KEY `payment_code` (`payment_code`);

--
-- Indexes for table `publisher`
--
ALTER TABLE `publisher`
  ADD PRIMARY KEY (`publisher_id`);

--
-- Indexes for table `qris_payment`
--
ALTER TABLE `qris_payment`
  ADD PRIMARY KEY (`payment_id`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `type_id` (`type_id`);

--
-- Indexes for table `report_type`
--
ALTER TABLE `report_type`
  ADD PRIMARY KEY (`type_id`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`review_id`),
  ADD UNIQUE KEY `unique_user_book_review` (`reviewer_id`,`book_id`),
  ADD KEY `book_id` (`book_id`);

--
-- Indexes for table `shipment`
--
ALTER TABLE `shipment`
  ADD PRIMARY KEY (`shipment_id`),
  ADD KEY `shipping_method_id` (`shipping_method_id`);

--
-- Indexes for table `shipping_method`
--
ALTER TABLE `shipping_method`
  ADD PRIMARY KEY (`shipping_method_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `store_setting`
--
ALTER TABLE `store_setting`
  ADD PRIMARY KEY (`store_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `address_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `author`
--
ALTER TABLE `author`
  MODIFY `author_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `banner_slide`
--
ALTER TABLE `banner_slide`
  MODIFY `banner_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `book`
--
ALTER TABLE `book`
  MODIFY `book_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_method`
--
ALTER TABLE `payment_method`
  MODIFY `payment_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `publisher`
--
ALTER TABLE `publisher`
  MODIFY `publisher_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `report`
--
ALTER TABLE `report`
  MODIFY `report_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `report_type`
--
ALTER TABLE `report_type`
  MODIFY `type_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `review_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shipment`
--
ALTER TABLE `shipment`
  MODIFY `shipment_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `shipping_method`
--
ALTER TABLE `shipping_method`
  MODIFY `shipping_method_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `store_setting`
--
ALTER TABLE `store_setting`
  MODIFY `store_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `user_role`
--
ALTER TABLE `user_role`
  MODIFY `role_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `bank_transfer`
--
ALTER TABLE `bank_transfer`
  ADD CONSTRAINT `bank_transfer_ibfk_1` FOREIGN KEY (`payment_id`) REFERENCES `payment_method` (`payment_id`);

--
-- Constraints for table `book`
--
ALTER TABLE `book`
  ADD CONSTRAINT `book_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`author_id`),
  ADD CONSTRAINT `book_ibfk_2` FOREIGN KEY (`publisher_id`) REFERENCES `publisher` (`publisher_id`),
  ADD CONSTRAINT `book_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`);

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`user_id`);

--
-- Constraints for table `cart_item`
--
ALTER TABLE `cart_item`
  ADD CONSTRAINT `cart_item_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`),
  ADD CONSTRAINT `cart_item_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`);

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `customer_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`user_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`payment_id`) REFERENCES `payment_method` (`payment_id`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`shipment_id`),
  ADD CONSTRAINT `orders_ibfk_4` FOREIGN KEY (`processed_by`) REFERENCES `staff` (`user_id`);

--
-- Constraints for table `order_item`
--
ALTER TABLE `order_item`
  ADD CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_item_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`payment_id`);

--
-- Constraints for table `qris_payment`
--
ALTER TABLE `qris_payment`
  ADD CONSTRAINT `qris_payment_ibfk_1` FOREIGN KEY (`payment_id`) REFERENCES `payment_method` (`payment_id`);

--
-- Constraints for table `report`
--
ALTER TABLE `report`
  ADD CONSTRAINT `report_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `report_type` (`type_id`);

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`reviewer_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `shipment`
--
ALTER TABLE `shipment`
  ADD CONSTRAINT `shipment_ibfk_1` FOREIGN KEY (`shipping_method_id`) REFERENCES `shipping_method` (`shipping_method_id`);

--
-- Constraints for table `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `user_role` (`role_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
