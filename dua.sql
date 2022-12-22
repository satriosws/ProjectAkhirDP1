-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Waktu pembuatan: 12 Des 2022 pada 09.32
-- Versi server: 10.4.24-MariaDB
-- Versi PHP: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dua`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `dummy` ()   BEGIN

    DECLARE i,n INT;
    DECLARE jalur_id INT;
    DECLARE no_pendaftar varchar(20);
    DECLARE nama varchar(100);
    DECLARE nisn varchar(15);
    DECLARE nik varchar(20);
    DECLARE tempat_lahir varchar(60);
    DECLARE tanggal_lahir date;
    DECLARE jenis_kelamin varchar(30);
    DECLARE no_hp varchar(20);
    DECLARE alamat text;
    DECLARE agama varchar(25);
    DECLARE idp1 int(11);
    DECLARE idp2 int(11);
    DECLARE nominal_bayar varchar(15);
    DECLARE bank_id int(11);
    DECLARE isb varchar(10);
    
    DECLARE pendaftar_id INT;
    DECLARE tingkat_prestasi VARCHAR(30);
    DECLARE nama_prestasi VARCHAR(255);
    DECLARE tahun int;
    DECLARE url_dokumen VARCHAR(100);

SET i = 0;
SET n = 1000;
while i < n DO

    SET jalur_id = (SELECT id_jalur FROM jalur_masuk ORDER BY RAND() LIMIT 1);
    SET no_pendaftar = (SELECT CONCAT('P',YEAR(CURRENT_DATE()),jalur_id , (i+1)));
    SET nama = (SELECT CONCAT('AprilYandi Dwi W ', (i+1)));
    SET nisn = (SELECT CONCAT('56419974', (i+1)));
    SET nik = (SELECT CONCAT('3276022304010010', (i+1)));
    SET tempat_lahir = 'Jakarta';
    SET tanggal_lahir = (SELECT '2001-12-31'- INTERVAL FLOOR(RAND() * 30) DAY);
    SET jenis_kelamin = 'Laki-Laki';
    SET no_hp = (SELECT CONCAT('08810243', (i+1)));
    SET alamat = (SELECT CONCAT('Kp.Babakan No. ', (i+1)));
    SET agama = 'Islam';
    SET idp1 = (SELECT id_prodi FROM prodi ORDER BY RAND() LIMIT 1);
    SET idp2 = (SELECT id_prodi FROM prodi ORDER BY RAND() LIMIT 1);
    SET nominal_bayar = 150000;
    SET bank_id = (SELECT id_bank FROM bank ORDER BY RAND() LIMIT 1);
    SET isb = 'Sudah';
    
    
    IF jalur_id = 3 THEN
        SET nominal_bayar = null;
        SET bank_id = null;
        SET isb = 'Gratis';
        END IF;

     IF(i+1) % 7 = 0 THEN
    	SET isb = 'Belum';
    END IF;

    IF (i+1) % 5 = 0 THEN
        SET jenis_kelamin = 'Perempuan';
        SET tempat_lahir = 'Depok';
        END IF;

    INSERT INTO pendaftar (id_jalur, no_pendaftar, nama, nisn, nik, tempat_lahir, tanggal_lahir, jenis_kelamin, no_hp, alamat, agama, id_prodi1, id_prodi2, nominal_bayar, id_bank, status_bayar)
    VALUES (jalur_id, no_pendaftar, nama, nisn, nik, tempat_lahir, tanggal_lahir, jenis_kelamin, no_hp, alamat, agama, idp1, idp2, nominal_bayar, bank_id, isb);

        SET pendaftar_id = (SELECT LAST_INSERT_ID());

        if jalur_id = 3 THEN
        SET tingkat_prestasi = 'NASIONAL';
        SET tahun = (SELECT YEAR(CURRENT_DATE()));

        if (1+i) % 6 = 0 THEN
        	SET tingkat_prestasi = 'INTERNASIONAL';
        	SET tahun = (SELECT YEAR(CURRENT_DATE()));
        END if;
        SET nama_prestasi = (SELECT CONCAT('Prestasi ', tingkat_prestasi,' ', nama));
        SET url_dokumen = (SELECT CONCAT('public/uploads/prestasi/', pendaftar_id)); 
        
        INSERT INTO pendaftar_prestasi (id_pendaftar, tingkat_prestasi, nama_prestasi, tahun, url_dokumen)
        VALUES(pendaftar_id, tingkat_prestasi, nama_prestasi, tahun, url_dokumen);
        
        END IF;
        SET i = i + 1;
END WHILE;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `bank`
--

CREATE TABLE `bank` (
  `id_bank` int(11) NOT NULL,
  `nama_bank` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `bank`
--

INSERT INTO `bank` (`id_bank`, `nama_bank`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 'BCA', '2022-12-07 04:46:34', NULL, NULL, NULL),
(2, 'MANDIRI', '2022-12-07 04:47:11', NULL, NULL, NULL),
(3, 'BNI', '2022-12-07 04:47:31', NULL, NULL, NULL),
(4, 'BRI', '2022-12-07 04:47:44', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `fakultas`
--

CREATE TABLE `fakultas` (
  `id_fakultas` int(11) NOT NULL,
  `id_perguruan_tinggi` int(11) NOT NULL DEFAULT 0,
  `nama_fakultas` varchar(255) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `fakultas`
--

INSERT INTO `fakultas` (`id_fakultas`, `id_perguruan_tinggi`, `nama_fakultas`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 1, 'Teknologi Industri', '2022-12-07 05:04:36', NULL, NULL, NULL),
(2, 1, 'Fakultas Sastra', '2022-12-07 05:06:18', NULL, NULL, NULL),
(3, 1, 'Fakultas Ilmu Komunikasi Dan Teknlogi Informasi', '2022-12-07 05:07:39', NULL, NULL, NULL),
(4, 1, 'Fakultas Ekonomi', '2022-12-07 05:08:25', NULL, NULL, NULL),
(5, 1, 'Fakultas Psikologi', '2022-12-07 05:21:02', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `jalur_masuk`
--

CREATE TABLE `jalur_masuk` (
  `id_jalur` int(11) NOT NULL,
  `nama_jalur` varchar(255) NOT NULL,
  `is_tes` int(11) NOT NULL,
  `is_mandiri` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `jalur_masuk`
--

INSERT INTO `jalur_masuk` (`id_jalur`, `nama_jalur`, `is_tes`, `is_mandiri`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 'Mandiri Tes', 1, 0, '2022-12-07 11:40:52', NULL, NULL, NULL),
(2, 'Mandiri Prestasi', 0, 1, '2022-12-07 11:40:52', NULL, NULL, NULL),
(3, 'SNMPTN', 0, 0, '2022-12-07 11:40:52', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pendaftar`
--

CREATE TABLE `pendaftar` (
  `id_pendaftar` int(11) NOT NULL,
  `id_jalur` int(11) NOT NULL,
  `no_pendaftar` varchar(20) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `nisn` varchar(15) DEFAULT NULL,
  `nik` varchar(20) DEFAULT NULL,
  `tempat_lahir` varchar(60) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `jenis_kelamin` enum('Laki-Laki','Perempuan') DEFAULT NULL,
  `no_hp` varchar(15) DEFAULT NULL,
  `alamat` text NOT NULL,
  `agama` varchar(25) NOT NULL,
  `id_prodi1` int(11) NOT NULL,
  `id_prodi2` int(11) DEFAULT NULL,
  `nominal_bayar` decimal(12,2) DEFAULT NULL,
  `id_bank` int(11) DEFAULT NULL,
  `status_bayar` enum('Sudah','Belum','Gratis') NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pendaftar`
--

INSERT INTO `pendaftar` (`id_pendaftar`, `id_jalur`, `no_pendaftar`, `nama`, `nisn`, `nik`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `no_hp`, `alamat`, `agama`, `id_prodi1`, `id_prodi2`, `nominal_bayar`, `id_bank`, `status_bayar`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 2, 'P202221', 'AprilYandi Dwi W 1', '564199741', '32760223040100101', 'Jakarta', '2001-12-04', 'Laki-Laki', '088102431', 'Kp.Babakan No. 1', 'Islam', 7, 6, '150000.00', 2, 'Sudah', '2022-12-12 03:39:27', NULL, NULL, NULL),
(2, 3, 'P202232', 'AprilYandi Dwi W 2', '564199742', '32760223040100102', 'Jakarta', '2001-12-09', 'Laki-Laki', '088102432', 'Kp.Babakan No. 2', 'Islam', 13, 9, NULL, NULL, 'Gratis', '2022-12-12 03:39:27', NULL, NULL, NULL),
(3, 3, 'P202233', 'AprilYandi Dwi W 3', '564199743', '32760223040100103', 'Jakarta', '2001-12-03', 'Laki-Laki', '088102433', 'Kp.Babakan No. 3', 'Islam', 12, 12, NULL, NULL, 'Gratis', '2022-12-12 03:39:27', NULL, NULL, NULL),
(4, 3, 'P202234', 'AprilYandi Dwi W 4', '564199744', '32760223040100104', 'Jakarta', '2001-12-04', 'Laki-Laki', '088102434', 'Kp.Babakan No. 4', 'Islam', 10, 4, NULL, NULL, 'Gratis', '2022-12-12 03:39:27', NULL, NULL, NULL),
(5, 2, 'P202225', 'AprilYandi Dwi W 5', '564199745', '32760223040100105', 'Depok', '2001-12-02', 'Perempuan', '088102435', 'Kp.Babakan No. 5', 'Islam', 9, 9, '150000.00', 3, 'Sudah', '2022-12-12 03:39:27', NULL, NULL, NULL),
(6, 3, 'P202236', 'AprilYandi Dwi W 6', '564199746', '32760223040100106', 'Jakarta', '2001-12-02', 'Laki-Laki', '088102436', 'Kp.Babakan No. 6', 'Islam', 9, 2, NULL, NULL, 'Gratis', '2022-12-12 03:39:28', NULL, NULL, NULL),
(7, 3, 'P202237', 'AprilYandi Dwi W 7', '564199747', '32760223040100107', 'Jakarta', '2001-12-22', 'Laki-Laki', '088102437', 'Kp.Babakan No. 7', 'Islam', 5, 13, NULL, NULL, 'Belum', '2022-12-12 03:39:28', NULL, NULL, NULL),
(8, 1, 'P202218', 'AprilYandi Dwi W 8', '564199748', '32760223040100108', 'Jakarta', '2001-12-19', 'Laki-Laki', '088102438', 'Kp.Babakan No. 8', 'Islam', 10, 8, '150000.00', 2, 'Sudah', '2022-12-12 03:39:28', NULL, NULL, NULL),
(9, 2, 'P202229', 'AprilYandi Dwi W 9', '564199749', '32760223040100109', 'Jakarta', '2001-12-05', 'Laki-Laki', '088102439', 'Kp.Babakan No. 9', 'Islam', 9, 7, '150000.00', 1, 'Sudah', '2022-12-12 03:39:28', NULL, NULL, NULL),
(10, 3, 'P2022310', 'AprilYandi Dwi W 10', '5641997410', '327602230401001010', 'Depok', '2001-12-23', 'Perempuan', '0881024310', 'Kp.Babakan No. 10', 'Islam', 2, 11, NULL, NULL, 'Gratis', '2022-12-12 03:39:28', NULL, NULL, NULL),
(11, 3, 'P2022311', 'AprilYandi Dwi W 11', '5641997411', '327602230401001011', 'Jakarta', '2001-12-28', 'Laki-Laki', '0881024311', 'Kp.Babakan No. 11', 'Islam', 7, 1, NULL, NULL, 'Gratis', '2022-12-12 03:39:29', NULL, NULL, NULL),
(12, 2, 'P2022212', 'AprilYandi Dwi W 12', '5641997412', '327602230401001012', 'Jakarta', '2001-12-04', 'Laki-Laki', '0881024312', 'Kp.Babakan No. 12', 'Islam', 13, 9, '150000.00', 1, 'Sudah', '2022-12-12 03:39:29', NULL, NULL, NULL),
(13, 1, 'P2022113', 'AprilYandi Dwi W 13', '5641997413', '327602230401001013', 'Jakarta', '2001-12-17', 'Laki-Laki', '0881024313', 'Kp.Babakan No. 13', 'Islam', 6, 11, '150000.00', 4, 'Sudah', '2022-12-12 03:39:29', NULL, NULL, NULL),
(14, 2, 'P2022214', 'AprilYandi Dwi W 14', '5641997414', '327602230401001014', 'Jakarta', '2001-12-28', 'Laki-Laki', '0881024314', 'Kp.Babakan No. 14', 'Islam', 6, 1, '150000.00', 3, 'Belum', '2022-12-12 03:39:29', NULL, NULL, NULL),
(15, 1, 'P2022115', 'AprilYandi Dwi W 15', '5641997415', '327602230401001015', 'Depok', '2001-12-11', 'Perempuan', '0881024315', 'Kp.Babakan No. 15', 'Islam', 6, 12, '150000.00', 4, 'Sudah', '2022-12-12 03:39:29', NULL, NULL, NULL),
(16, 3, 'P2022316', 'AprilYandi Dwi W 16', '5641997416', '327602230401001016', 'Jakarta', '2001-12-03', 'Laki-Laki', '0881024316', 'Kp.Babakan No. 16', 'Islam', 6, 6, NULL, NULL, 'Gratis', '2022-12-12 03:39:30', NULL, NULL, NULL),
(17, 2, 'P2022217', 'AprilYandi Dwi W 17', '5641997417', '327602230401001017', 'Jakarta', '2001-12-24', 'Laki-Laki', '0881024317', 'Kp.Babakan No. 17', 'Islam', 11, 13, '150000.00', 4, 'Sudah', '2022-12-12 03:39:30', NULL, NULL, NULL),
(18, 2, 'P2022218', 'AprilYandi Dwi W 18', '5641997418', '327602230401001018', 'Jakarta', '2001-12-13', 'Laki-Laki', '0881024318', 'Kp.Babakan No. 18', 'Islam', 9, 3, '150000.00', 3, 'Sudah', '2022-12-12 03:39:30', NULL, NULL, NULL),
(19, 1, 'P2022119', 'AprilYandi Dwi W 19', '5641997419', '327602230401001019', 'Jakarta', '2001-12-30', 'Laki-Laki', '0881024319', 'Kp.Babakan No. 19', 'Islam', 12, 10, '150000.00', 4, 'Sudah', '2022-12-12 03:39:30', NULL, NULL, NULL),
(20, 3, 'P2022320', 'AprilYandi Dwi W 20', '5641997420', '327602230401001020', 'Depok', '2001-12-14', 'Perempuan', '0881024320', 'Kp.Babakan No. 20', 'Islam', 2, 10, NULL, NULL, 'Gratis', '2022-12-12 03:39:30', NULL, NULL, NULL),
(21, 3, 'P2022321', 'AprilYandi Dwi W 21', '5641997421', '327602230401001021', 'Jakarta', '2001-12-20', 'Laki-Laki', '0881024321', 'Kp.Babakan No. 21', 'Islam', 11, 9, NULL, NULL, 'Belum', '2022-12-12 03:39:30', NULL, NULL, NULL),
(22, 1, 'P2022122', 'AprilYandi Dwi W 22', '5641997422', '327602230401001022', 'Jakarta', '2001-12-24', 'Laki-Laki', '0881024322', 'Kp.Babakan No. 22', 'Islam', 1, 5, '150000.00', 1, 'Sudah', '2022-12-12 03:39:31', NULL, NULL, NULL),
(23, 3, 'P2022323', 'AprilYandi Dwi W 23', '5641997423', '327602230401001023', 'Jakarta', '2001-12-04', 'Laki-Laki', '0881024323', 'Kp.Babakan No. 23', 'Islam', 7, 2, NULL, NULL, 'Gratis', '2022-12-12 03:39:31', NULL, NULL, NULL),
(24, 3, 'P2022324', 'AprilYandi Dwi W 24', '5641997424', '327602230401001024', 'Jakarta', '2001-12-05', 'Laki-Laki', '0881024324', 'Kp.Babakan No. 24', 'Islam', 1, 7, NULL, NULL, 'Gratis', '2022-12-12 03:39:31', NULL, NULL, NULL),
(25, 1, 'P2022125', 'AprilYandi Dwi W 25', '5641997425', '327602230401001025', 'Depok', '2001-12-27', 'Perempuan', '0881024325', 'Kp.Babakan No. 25', 'Islam', 9, 4, '150000.00', 1, 'Sudah', '2022-12-12 03:39:31', NULL, NULL, NULL),
(26, 2, 'P2022226', 'AprilYandi Dwi W 26', '5641997426', '327602230401001026', 'Jakarta', '2001-12-25', 'Laki-Laki', '0881024326', 'Kp.Babakan No. 26', 'Islam', 7, 8, '150000.00', 2, 'Sudah', '2022-12-12 03:39:31', NULL, NULL, NULL),
(27, 2, 'P2022227', 'AprilYandi Dwi W 27', '5641997427', '327602230401001027', 'Jakarta', '2001-12-09', 'Laki-Laki', '0881024327', 'Kp.Babakan No. 27', 'Islam', 13, 3, '150000.00', 1, 'Sudah', '2022-12-12 03:39:32', NULL, NULL, NULL),
(28, 3, 'P2022328', 'AprilYandi Dwi W 28', '5641997428', '327602230401001028', 'Jakarta', '2001-12-24', 'Laki-Laki', '0881024328', 'Kp.Babakan No. 28', 'Islam', 8, 7, NULL, NULL, 'Belum', '2022-12-12 03:39:32', NULL, NULL, NULL),
(29, 3, 'P2022329', 'AprilYandi Dwi W 29', '5641997429', '327602230401001029', 'Jakarta', '2001-12-04', 'Laki-Laki', '0881024329', 'Kp.Babakan No. 29', 'Islam', 9, 10, NULL, NULL, 'Gratis', '2022-12-12 03:39:32', NULL, NULL, NULL),
(30, 2, 'P2022230', 'AprilYandi Dwi W 30', '5641997430', '327602230401001030', 'Depok', '2001-12-30', 'Perempuan', '0881024330', 'Kp.Babakan No. 30', 'Islam', 5, 10, '150000.00', 2, 'Sudah', '2022-12-12 03:39:32', NULL, NULL, NULL),
(31, 1, 'P2022131', 'AprilYandi Dwi W 31', '5641997431', '327602230401001031', 'Jakarta', '2001-12-24', 'Laki-Laki', '0881024331', 'Kp.Babakan No. 31', 'Islam', 4, 13, '150000.00', 2, 'Sudah', '2022-12-12 03:39:32', NULL, NULL, NULL),
(32, 3, 'P2022332', 'AprilYandi Dwi W 32', '5641997432', '327602230401001032', 'Jakarta', '2001-12-19', 'Laki-Laki', '0881024332', 'Kp.Babakan No. 32', 'Islam', 5, 8, NULL, NULL, 'Gratis', '2022-12-12 03:39:32', NULL, NULL, NULL),
(33, 2, 'P2022233', 'AprilYandi Dwi W 33', '5641997433', '327602230401001033', 'Jakarta', '2001-12-29', 'Laki-Laki', '0881024333', 'Kp.Babakan No. 33', 'Islam', 1, 10, '150000.00', 3, 'Sudah', '2022-12-12 03:39:32', NULL, NULL, NULL),
(34, 2, 'P2022234', 'AprilYandi Dwi W 34', '5641997434', '327602230401001034', 'Jakarta', '2001-12-24', 'Laki-Laki', '0881024334', 'Kp.Babakan No. 34', 'Islam', 9, 11, '150000.00', 1, 'Sudah', '2022-12-12 03:39:33', NULL, NULL, NULL),
(35, 3, 'P2022335', 'AprilYandi Dwi W 35', '5641997435', '327602230401001035', 'Depok', '2001-12-02', 'Perempuan', '0881024335', 'Kp.Babakan No. 35', 'Islam', 6, 13, NULL, NULL, 'Belum', '2022-12-12 03:39:33', NULL, NULL, NULL),
(36, 3, 'P2022336', 'AprilYandi Dwi W 36', '5641997436', '327602230401001036', 'Jakarta', '2001-12-24', 'Laki-Laki', '0881024336', 'Kp.Babakan No. 36', 'Islam', 8, 7, NULL, NULL, 'Gratis', '2022-12-12 03:39:33', NULL, NULL, NULL),
(37, 3, 'P2022337', 'AprilYandi Dwi W 37', '5641997437', '327602230401001037', 'Jakarta', '2001-12-31', 'Laki-Laki', '0881024337', 'Kp.Babakan No. 37', 'Islam', 1, 6, NULL, NULL, 'Gratis', '2022-12-12 03:39:33', NULL, NULL, NULL),
(38, 1, 'P2022138', 'AprilYandi Dwi W 38', '5641997438', '327602230401001038', 'Jakarta', '2001-12-26', 'Laki-Laki', '0881024338', 'Kp.Babakan No. 38', 'Islam', 1, 6, '150000.00', 1, 'Sudah', '2022-12-12 03:39:33', NULL, NULL, NULL),
(39, 1, 'P2022139', 'AprilYandi Dwi W 39', '5641997439', '327602230401001039', 'Jakarta', '2001-12-17', 'Laki-Laki', '0881024339', 'Kp.Babakan No. 39', 'Islam', 9, 11, '150000.00', 4, 'Sudah', '2022-12-12 03:39:33', NULL, NULL, NULL),
(40, 2, 'P2022240', 'AprilYandi Dwi W 40', '5641997440', '327602230401001040', 'Depok', '2001-12-02', 'Perempuan', '0881024340', 'Kp.Babakan No. 40', 'Islam', 12, 3, '150000.00', 2, 'Sudah', '2022-12-12 03:39:33', NULL, NULL, NULL),
(41, 1, 'P2022141', 'AprilYandi Dwi W 41', '5641997441', '327602230401001041', 'Jakarta', '2001-12-05', 'Laki-Laki', '0881024341', 'Kp.Babakan No. 41', 'Islam', 6, 2, '150000.00', 3, 'Sudah', '2022-12-12 03:39:34', NULL, NULL, NULL),
(42, 3, 'P2022342', 'AprilYandi Dwi W 42', '5641997442', '327602230401001042', 'Jakarta', '2001-12-16', 'Laki-Laki', '0881024342', 'Kp.Babakan No. 42', 'Islam', 2, 9, NULL, NULL, 'Belum', '2022-12-12 03:39:34', NULL, NULL, NULL),
(43, 1, 'P2022143', 'AprilYandi Dwi W 43', '5641997443', '327602230401001043', 'Jakarta', '2001-12-15', 'Laki-Laki', '0881024343', 'Kp.Babakan No. 43', 'Islam', 8, 5, '150000.00', 1, 'Sudah', '2022-12-12 03:39:34', NULL, NULL, NULL),
(44, 3, 'P2022344', 'AprilYandi Dwi W 44', '5641997444', '327602230401001044', 'Jakarta', '2001-12-10', 'Laki-Laki', '0881024344', 'Kp.Babakan No. 44', 'Islam', 1, 1, NULL, NULL, 'Gratis', '2022-12-12 03:39:34', NULL, NULL, NULL),
(45, 3, 'P2022345', 'AprilYandi Dwi W 45', '5641997445', '327602230401001045', 'Depok', '2001-12-14', 'Perempuan', '0881024345', 'Kp.Babakan No. 45', 'Islam', 12, 4, NULL, NULL, 'Gratis', '2022-12-12 03:39:34', NULL, NULL, NULL),
(46, 1, 'P2022146', 'AprilYandi Dwi W 46', '5641997446', '327602230401001046', 'Jakarta', '2001-12-20', 'Laki-Laki', '0881024346', 'Kp.Babakan No. 46', 'Islam', 13, 3, '150000.00', 4, 'Sudah', '2022-12-12 03:39:35', NULL, NULL, NULL),
(47, 3, 'P2022347', 'AprilYandi Dwi W 47', '5641997447', '327602230401001047', 'Jakarta', '2001-12-06', 'Laki-Laki', '0881024347', 'Kp.Babakan No. 47', 'Islam', 8, 11, NULL, NULL, 'Gratis', '2022-12-12 03:39:35', NULL, NULL, NULL),
(48, 1, 'P2022148', 'AprilYandi Dwi W 48', '5641997448', '327602230401001048', 'Jakarta', '2001-12-09', 'Laki-Laki', '0881024348', 'Kp.Babakan No. 48', 'Islam', 8, 5, '150000.00', 2, 'Sudah', '2022-12-12 03:39:35', NULL, NULL, NULL),
(49, 3, 'P2022349', 'AprilYandi Dwi W 49', '5641997449', '327602230401001049', 'Jakarta', '2001-12-12', 'Laki-Laki', '0881024349', 'Kp.Babakan No. 49', 'Islam', 5, 12, NULL, NULL, 'Belum', '2022-12-12 03:39:35', NULL, NULL, NULL),
(50, 3, 'P2022350', 'AprilYandi Dwi W 50', '5641997450', '327602230401001050', 'Depok', '2001-12-24', 'Perempuan', '0881024350', 'Kp.Babakan No. 50', 'Islam', 2, 6, NULL, NULL, 'Gratis', '2022-12-12 03:39:35', NULL, NULL, NULL),
(51, 3, 'P2022351', 'AprilYandi Dwi W 51', '5641997451', '327602230401001051', 'Jakarta', '2001-12-05', 'Laki-Laki', '0881024351', 'Kp.Babakan No. 51', 'Islam', 3, 3, NULL, NULL, 'Gratis', '2022-12-12 03:39:35', NULL, NULL, NULL),
(52, 3, 'P2022352', 'AprilYandi Dwi W 52', '5641997452', '327602230401001052', 'Jakarta', '2001-12-25', 'Laki-Laki', '0881024352', 'Kp.Babakan No. 52', 'Islam', 3, 12, NULL, NULL, 'Gratis', '2022-12-12 03:39:35', NULL, NULL, NULL),
(53, 1, 'P2022153', 'AprilYandi Dwi W 53', '5641997453', '327602230401001053', 'Jakarta', '2001-12-26', 'Laki-Laki', '0881024353', 'Kp.Babakan No. 53', 'Islam', 13, 12, '150000.00', 2, 'Sudah', '2022-12-12 03:39:35', NULL, NULL, NULL),
(54, 2, 'P2022254', 'AprilYandi Dwi W 54', '5641997454', '327602230401001054', 'Jakarta', '2001-12-09', 'Laki-Laki', '0881024354', 'Kp.Babakan No. 54', 'Islam', 4, 3, '150000.00', 2, 'Sudah', '2022-12-12 03:39:35', NULL, NULL, NULL),
(55, 3, 'P2022355', 'AprilYandi Dwi W 55', '5641997455', '327602230401001055', 'Depok', '2001-12-25', 'Perempuan', '0881024355', 'Kp.Babakan No. 55', 'Islam', 4, 13, NULL, NULL, 'Gratis', '2022-12-12 03:39:35', NULL, NULL, NULL),
(56, 3, 'P2022356', 'AprilYandi Dwi W 56', '5641997456', '327602230401001056', 'Jakarta', '2001-12-16', 'Laki-Laki', '0881024356', 'Kp.Babakan No. 56', 'Islam', 5, 1, NULL, NULL, 'Belum', '2022-12-12 03:39:36', NULL, NULL, NULL),
(57, 2, 'P2022257', 'AprilYandi Dwi W 57', '5641997457', '327602230401001057', 'Jakarta', '2001-12-04', 'Laki-Laki', '0881024357', 'Kp.Babakan No. 57', 'Islam', 2, 1, '150000.00', 3, 'Sudah', '2022-12-12 03:39:36', NULL, NULL, NULL),
(58, 2, 'P2022258', 'AprilYandi Dwi W 58', '5641997458', '327602230401001058', 'Jakarta', '2001-12-12', 'Laki-Laki', '0881024358', 'Kp.Babakan No. 58', 'Islam', 9, 7, '150000.00', 3, 'Sudah', '2022-12-12 03:39:36', NULL, NULL, NULL),
(59, 1, 'P2022159', 'AprilYandi Dwi W 59', '5641997459', '327602230401001059', 'Jakarta', '2001-12-21', 'Laki-Laki', '0881024359', 'Kp.Babakan No. 59', 'Islam', 3, 9, '150000.00', 1, 'Sudah', '2022-12-12 03:39:36', NULL, NULL, NULL),
(60, 3, 'P2022360', 'AprilYandi Dwi W 60', '5641997460', '327602230401001060', 'Depok', '2001-12-13', 'Perempuan', '0881024360', 'Kp.Babakan No. 60', 'Islam', 9, 12, NULL, NULL, 'Gratis', '2022-12-12 03:39:36', NULL, NULL, NULL),
(61, 3, 'P2022361', 'AprilYandi Dwi W 61', '5641997461', '327602230401001061', 'Jakarta', '2001-12-04', 'Laki-Laki', '0881024361', 'Kp.Babakan No. 61', 'Islam', 9, 10, NULL, NULL, 'Gratis', '2022-12-12 03:39:36', NULL, NULL, NULL),
(62, 1, 'P2022162', 'AprilYandi Dwi W 62', '5641997462', '327602230401001062', 'Jakarta', '2001-12-20', 'Laki-Laki', '0881024362', 'Kp.Babakan No. 62', 'Islam', 2, 8, '150000.00', 4, 'Sudah', '2022-12-12 03:39:36', NULL, NULL, NULL),
(63, 1, 'P2022163', 'AprilYandi Dwi W 63', '5641997463', '327602230401001063', 'Jakarta', '2001-12-21', 'Laki-Laki', '0881024363', 'Kp.Babakan No. 63', 'Islam', 9, 12, '150000.00', 3, 'Belum', '2022-12-12 03:39:36', NULL, NULL, NULL),
(64, 1, 'P2022164', 'AprilYandi Dwi W 64', '5641997464', '327602230401001064', 'Jakarta', '2001-12-02', 'Laki-Laki', '0881024364', 'Kp.Babakan No. 64', 'Islam', 7, 7, '150000.00', 2, 'Sudah', '2022-12-12 03:39:36', NULL, NULL, NULL),
(65, 2, 'P2022265', 'AprilYandi Dwi W 65', '5641997465', '327602230401001065', 'Depok', '2001-12-06', 'Perempuan', '0881024365', 'Kp.Babakan No. 65', 'Islam', 10, 11, '150000.00', 3, 'Sudah', '2022-12-12 03:39:36', NULL, NULL, NULL),
(66, 2, 'P2022266', 'AprilYandi Dwi W 66', '5641997466', '327602230401001066', 'Jakarta', '2001-12-18', 'Laki-Laki', '0881024366', 'Kp.Babakan No. 66', 'Islam', 8, 9, '150000.00', 1, 'Sudah', '2022-12-12 03:39:36', NULL, NULL, NULL),
(67, 2, 'P2022267', 'AprilYandi Dwi W 67', '5641997467', '327602230401001067', 'Jakarta', '2001-12-27', 'Laki-Laki', '0881024367', 'Kp.Babakan No. 67', 'Islam', 12, 12, '150000.00', 4, 'Sudah', '2022-12-12 03:39:36', NULL, NULL, NULL),
(68, 3, 'P2022368', 'AprilYandi Dwi W 68', '5641997468', '327602230401001068', 'Jakarta', '2001-12-30', 'Laki-Laki', '0881024368', 'Kp.Babakan No. 68', 'Islam', 12, 11, NULL, NULL, 'Gratis', '2022-12-12 03:39:37', NULL, NULL, NULL),
(69, 3, 'P2022369', 'AprilYandi Dwi W 69', '5641997469', '327602230401001069', 'Jakarta', '2001-12-28', 'Laki-Laki', '0881024369', 'Kp.Babakan No. 69', 'Islam', 9, 9, NULL, NULL, 'Gratis', '2022-12-12 03:39:37', NULL, NULL, NULL),
(70, 1, 'P2022170', 'AprilYandi Dwi W 70', '5641997470', '327602230401001070', 'Depok', '2001-12-29', 'Perempuan', '0881024370', 'Kp.Babakan No. 70', 'Islam', 7, 7, '150000.00', 4, 'Belum', '2022-12-12 03:39:37', NULL, NULL, NULL),
(71, 1, 'P2022171', 'AprilYandi Dwi W 71', '5641997471', '327602230401001071', 'Jakarta', '2001-12-12', 'Laki-Laki', '0881024371', 'Kp.Babakan No. 71', 'Islam', 3, 13, '150000.00', 2, 'Sudah', '2022-12-12 03:39:37', NULL, NULL, NULL),
(72, 1, 'P2022172', 'AprilYandi Dwi W 72', '5641997472', '327602230401001072', 'Jakarta', '2001-12-18', 'Laki-Laki', '0881024372', 'Kp.Babakan No. 72', 'Islam', 3, 11, '150000.00', 2, 'Sudah', '2022-12-12 03:39:37', NULL, NULL, NULL),
(73, 3, 'P2022373', 'AprilYandi Dwi W 73', '5641997473', '327602230401001073', 'Jakarta', '2001-12-12', 'Laki-Laki', '0881024373', 'Kp.Babakan No. 73', 'Islam', 12, 3, NULL, NULL, 'Gratis', '2022-12-12 03:39:37', NULL, NULL, NULL),
(74, 2, 'P2022274', 'AprilYandi Dwi W 74', '5641997474', '327602230401001074', 'Jakarta', '2001-12-31', 'Laki-Laki', '0881024374', 'Kp.Babakan No. 74', 'Islam', 3, 10, '150000.00', 2, 'Sudah', '2022-12-12 03:39:37', NULL, NULL, NULL),
(75, 3, 'P2022375', 'AprilYandi Dwi W 75', '5641997475', '327602230401001075', 'Depok', '2001-12-16', 'Perempuan', '0881024375', 'Kp.Babakan No. 75', 'Islam', 1, 10, NULL, NULL, 'Gratis', '2022-12-12 03:39:37', NULL, NULL, NULL),
(76, 2, 'P2022276', 'AprilYandi Dwi W 76', '5641997476', '327602230401001076', 'Jakarta', '2001-12-30', 'Laki-Laki', '0881024376', 'Kp.Babakan No. 76', 'Islam', 7, 2, '150000.00', 3, 'Sudah', '2022-12-12 03:39:38', NULL, NULL, NULL),
(77, 1, 'P2022177', 'AprilYandi Dwi W 77', '5641997477', '327602230401001077', 'Jakarta', '2001-12-10', 'Laki-Laki', '0881024377', 'Kp.Babakan No. 77', 'Islam', 4, 3, '150000.00', 1, 'Belum', '2022-12-12 03:39:38', NULL, NULL, NULL),
(78, 1, 'P2022178', 'AprilYandi Dwi W 78', '5641997478', '327602230401001078', 'Jakarta', '2001-12-28', 'Laki-Laki', '0881024378', 'Kp.Babakan No. 78', 'Islam', 12, 10, '150000.00', 2, 'Sudah', '2022-12-12 03:39:38', NULL, NULL, NULL),
(79, 1, 'P2022179', 'AprilYandi Dwi W 79', '5641997479', '327602230401001079', 'Jakarta', '2001-12-12', 'Laki-Laki', '0881024379', 'Kp.Babakan No. 79', 'Islam', 3, 3, '150000.00', 4, 'Sudah', '2022-12-12 03:39:38', NULL, NULL, NULL),
(80, 1, 'P2022180', 'AprilYandi Dwi W 80', '5641997480', '327602230401001080', 'Depok', '2001-12-23', 'Perempuan', '0881024380', 'Kp.Babakan No. 80', 'Islam', 8, 10, '150000.00', 4, 'Sudah', '2022-12-12 03:39:38', NULL, NULL, NULL),
(81, 1, 'P2022181', 'AprilYandi Dwi W 81', '5641997481', '327602230401001081', 'Jakarta', '2001-12-02', 'Laki-Laki', '0881024381', 'Kp.Babakan No. 81', 'Islam', 4, 5, '150000.00', 1, 'Sudah', '2022-12-12 03:39:38', NULL, NULL, NULL),
(82, 3, 'P2022382', 'AprilYandi Dwi W 82', '5641997482', '327602230401001082', 'Jakarta', '2001-12-27', 'Laki-Laki', '0881024382', 'Kp.Babakan No. 82', 'Islam', 3, 1, NULL, NULL, 'Gratis', '2022-12-12 03:39:39', NULL, NULL, NULL),
(83, 2, 'P2022283', 'AprilYandi Dwi W 83', '5641997483', '327602230401001083', 'Jakarta', '2001-12-16', 'Laki-Laki', '0881024383', 'Kp.Babakan No. 83', 'Islam', 2, 6, '150000.00', 4, 'Sudah', '2022-12-12 03:39:39', NULL, NULL, NULL),
(84, 1, 'P2022184', 'AprilYandi Dwi W 84', '5641997484', '327602230401001084', 'Jakarta', '2001-12-11', 'Laki-Laki', '0881024384', 'Kp.Babakan No. 84', 'Islam', 6, 11, '150000.00', 4, 'Belum', '2022-12-12 03:39:39', NULL, NULL, NULL),
(85, 2, 'P2022285', 'AprilYandi Dwi W 85', '5641997485', '327602230401001085', 'Depok', '2001-12-04', 'Perempuan', '0881024385', 'Kp.Babakan No. 85', 'Islam', 7, 4, '150000.00', 4, 'Sudah', '2022-12-12 03:39:39', NULL, NULL, NULL),
(86, 1, 'P2022186', 'AprilYandi Dwi W 86', '5641997486', '327602230401001086', 'Jakarta', '2001-12-05', 'Laki-Laki', '0881024386', 'Kp.Babakan No. 86', 'Islam', 6, 5, '150000.00', 1, 'Sudah', '2022-12-12 03:39:39', NULL, NULL, NULL),
(87, 2, 'P2022287', 'AprilYandi Dwi W 87', '5641997487', '327602230401001087', 'Jakarta', '2001-12-22', 'Laki-Laki', '0881024387', 'Kp.Babakan No. 87', 'Islam', 3, 12, '150000.00', 3, 'Sudah', '2022-12-12 03:39:39', NULL, NULL, NULL),
(88, 3, 'P2022388', 'AprilYandi Dwi W 88', '5641997488', '327602230401001088', 'Jakarta', '2001-12-30', 'Laki-Laki', '0881024388', 'Kp.Babakan No. 88', 'Islam', 10, 11, NULL, NULL, 'Gratis', '2022-12-12 03:39:39', NULL, NULL, NULL),
(89, 3, 'P2022389', 'AprilYandi Dwi W 89', '5641997489', '327602230401001089', 'Jakarta', '2001-12-25', 'Laki-Laki', '0881024389', 'Kp.Babakan No. 89', 'Islam', 12, 4, NULL, NULL, 'Gratis', '2022-12-12 03:39:39', NULL, NULL, NULL),
(90, 3, 'P2022390', 'AprilYandi Dwi W 90', '5641997490', '327602230401001090', 'Depok', '2001-12-08', 'Perempuan', '0881024390', 'Kp.Babakan No. 90', 'Islam', 5, 11, NULL, NULL, 'Gratis', '2022-12-12 03:39:39', NULL, NULL, NULL),
(91, 1, 'P2022191', 'AprilYandi Dwi W 91', '5641997491', '327602230401001091', 'Jakarta', '2001-12-29', 'Laki-Laki', '0881024391', 'Kp.Babakan No. 91', 'Islam', 5, 10, '150000.00', 3, 'Belum', '2022-12-12 03:39:39', NULL, NULL, NULL),
(92, 2, 'P2022292', 'AprilYandi Dwi W 92', '5641997492', '327602230401001092', 'Jakarta', '2001-12-10', 'Laki-Laki', '0881024392', 'Kp.Babakan No. 92', 'Islam', 11, 6, '150000.00', 4, 'Sudah', '2022-12-12 03:39:39', NULL, NULL, NULL),
(93, 2, 'P2022293', 'AprilYandi Dwi W 93', '5641997493', '327602230401001093', 'Jakarta', '2001-12-17', 'Laki-Laki', '0881024393', 'Kp.Babakan No. 93', 'Islam', 10, 1, '150000.00', 1, 'Sudah', '2022-12-12 03:39:40', NULL, NULL, NULL),
(94, 1, 'P2022194', 'AprilYandi Dwi W 94', '5641997494', '327602230401001094', 'Jakarta', '2001-12-28', 'Laki-Laki', '0881024394', 'Kp.Babakan No. 94', 'Islam', 3, 2, '150000.00', 2, 'Sudah', '2022-12-12 03:39:40', NULL, NULL, NULL),
(95, 3, 'P2022395', 'AprilYandi Dwi W 95', '5641997495', '327602230401001095', 'Depok', '2001-12-24', 'Perempuan', '0881024395', 'Kp.Babakan No. 95', 'Islam', 8, 5, NULL, NULL, 'Gratis', '2022-12-12 03:39:41', NULL, NULL, NULL),
(96, 2, 'P2022296', 'AprilYandi Dwi W 96', '5641997496', '327602230401001096', 'Jakarta', '2001-12-09', 'Laki-Laki', '0881024396', 'Kp.Babakan No. 96', 'Islam', 13, 13, '150000.00', 4, 'Sudah', '2022-12-12 03:39:41', NULL, NULL, NULL),
(97, 2, 'P2022297', 'AprilYandi Dwi W 97', '5641997497', '327602230401001097', 'Jakarta', '2001-12-07', 'Laki-Laki', '0881024397', 'Kp.Babakan No. 97', 'Islam', 11, 9, '150000.00', 1, 'Sudah', '2022-12-12 03:39:41', NULL, NULL, NULL),
(98, 2, 'P2022298', 'AprilYandi Dwi W 98', '5641997498', '327602230401001098', 'Jakarta', '2001-12-25', 'Laki-Laki', '0881024398', 'Kp.Babakan No. 98', 'Islam', 13, 3, '150000.00', 3, 'Belum', '2022-12-12 03:39:41', NULL, NULL, NULL),
(99, 1, 'P2022199', 'AprilYandi Dwi W 99', '5641997499', '327602230401001099', 'Jakarta', '2001-12-28', 'Laki-Laki', '0881024399', 'Kp.Babakan No. 99', 'Islam', 13, 11, '150000.00', 4, 'Sudah', '2022-12-12 03:39:42', NULL, NULL, NULL),
(100, 2, 'P20222100', 'AprilYandi Dwi W 100', '56419974100', '3276022304010010100', 'Depok', '2001-12-07', 'Perempuan', '08810243100', 'Kp.Babakan No. 100', 'Islam', 7, 8, '150000.00', 2, 'Sudah', '2022-12-12 03:39:42', NULL, NULL, NULL),
(101, 3, 'P20223101', 'AprilYandi Dwi W 101', '56419974101', '3276022304010010101', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243101', 'Kp.Babakan No. 101', 'Islam', 5, 4, NULL, NULL, 'Gratis', '2022-12-12 03:39:42', NULL, NULL, NULL),
(102, 3, 'P20223102', 'AprilYandi Dwi W 102', '56419974102', '3276022304010010102', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243102', 'Kp.Babakan No. 102', 'Islam', 3, 8, NULL, NULL, 'Gratis', '2022-12-12 03:39:42', NULL, NULL, NULL),
(103, 2, 'P20222103', 'AprilYandi Dwi W 103', '56419974103', '3276022304010010103', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243103', 'Kp.Babakan No. 103', 'Islam', 10, 10, '150000.00', 4, 'Sudah', '2022-12-12 03:39:43', NULL, NULL, NULL),
(104, 1, 'P20221104', 'AprilYandi Dwi W 104', '56419974104', '3276022304010010104', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243104', 'Kp.Babakan No. 104', 'Islam', 9, 6, '150000.00', 3, 'Sudah', '2022-12-12 03:39:43', NULL, NULL, NULL),
(105, 3, 'P20223105', 'AprilYandi Dwi W 105', '56419974105', '3276022304010010105', 'Depok', '2001-12-08', 'Perempuan', '08810243105', 'Kp.Babakan No. 105', 'Islam', 13, 11, NULL, NULL, 'Belum', '2022-12-12 03:39:43', NULL, NULL, NULL),
(106, 2, 'P20222106', 'AprilYandi Dwi W 106', '56419974106', '3276022304010010106', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243106', 'Kp.Babakan No. 106', 'Islam', 5, 5, '150000.00', 2, 'Sudah', '2022-12-12 03:39:43', NULL, NULL, NULL),
(107, 2, 'P20222107', 'AprilYandi Dwi W 107', '56419974107', '3276022304010010107', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243107', 'Kp.Babakan No. 107', 'Islam', 13, 12, '150000.00', 3, 'Sudah', '2022-12-12 03:39:44', NULL, NULL, NULL),
(108, 2, 'P20222108', 'AprilYandi Dwi W 108', '56419974108', '3276022304010010108', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243108', 'Kp.Babakan No. 108', 'Islam', 10, 9, '150000.00', 3, 'Sudah', '2022-12-12 03:39:44', NULL, NULL, NULL),
(109, 3, 'P20223109', 'AprilYandi Dwi W 109', '56419974109', '3276022304010010109', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243109', 'Kp.Babakan No. 109', 'Islam', 6, 4, NULL, NULL, 'Gratis', '2022-12-12 03:39:44', NULL, NULL, NULL),
(110, 3, 'P20223110', 'AprilYandi Dwi W 110', '56419974110', '3276022304010010110', 'Depok', '2001-12-19', 'Perempuan', '08810243110', 'Kp.Babakan No. 110', 'Islam', 8, 11, NULL, NULL, 'Gratis', '2022-12-12 03:39:44', NULL, NULL, NULL),
(111, 3, 'P20223111', 'AprilYandi Dwi W 111', '56419974111', '3276022304010010111', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243111', 'Kp.Babakan No. 111', 'Islam', 1, 1, NULL, NULL, 'Gratis', '2022-12-12 03:39:45', NULL, NULL, NULL),
(112, 1, 'P20221112', 'AprilYandi Dwi W 112', '56419974112', '3276022304010010112', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243112', 'Kp.Babakan No. 112', 'Islam', 4, 7, '150000.00', 2, 'Belum', '2022-12-12 03:39:45', NULL, NULL, NULL),
(113, 3, 'P20223113', 'AprilYandi Dwi W 113', '56419974113', '3276022304010010113', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243113', 'Kp.Babakan No. 113', 'Islam', 2, 7, NULL, NULL, 'Gratis', '2022-12-12 03:39:45', NULL, NULL, NULL),
(114, 2, 'P20222114', 'AprilYandi Dwi W 114', '56419974114', '3276022304010010114', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243114', 'Kp.Babakan No. 114', 'Islam', 12, 3, '150000.00', 1, 'Sudah', '2022-12-12 03:39:45', NULL, NULL, NULL),
(115, 2, 'P20222115', 'AprilYandi Dwi W 115', '56419974115', '3276022304010010115', 'Depok', '2001-12-20', 'Perempuan', '08810243115', 'Kp.Babakan No. 115', 'Islam', 9, 8, '150000.00', 4, 'Sudah', '2022-12-12 03:39:46', NULL, NULL, NULL),
(116, 1, 'P20221116', 'AprilYandi Dwi W 116', '56419974116', '3276022304010010116', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243116', 'Kp.Babakan No. 116', 'Islam', 6, 2, '150000.00', 4, 'Sudah', '2022-12-12 03:39:46', NULL, NULL, NULL),
(117, 3, 'P20223117', 'AprilYandi Dwi W 117', '56419974117', '3276022304010010117', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243117', 'Kp.Babakan No. 117', 'Islam', 8, 6, NULL, NULL, 'Gratis', '2022-12-12 03:39:46', NULL, NULL, NULL),
(118, 2, 'P20222118', 'AprilYandi Dwi W 118', '56419974118', '3276022304010010118', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243118', 'Kp.Babakan No. 118', 'Islam', 5, 4, '150000.00', 1, 'Sudah', '2022-12-12 03:39:46', NULL, NULL, NULL),
(119, 1, 'P20221119', 'AprilYandi Dwi W 119', '56419974119', '3276022304010010119', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243119', 'Kp.Babakan No. 119', 'Islam', 7, 7, '150000.00', 3, 'Belum', '2022-12-12 03:39:46', NULL, NULL, NULL),
(120, 1, 'P20221120', 'AprilYandi Dwi W 120', '56419974120', '3276022304010010120', 'Depok', '2001-12-23', 'Perempuan', '08810243120', 'Kp.Babakan No. 120', 'Islam', 5, 13, '150000.00', 1, 'Sudah', '2022-12-12 03:39:47', NULL, NULL, NULL),
(121, 3, 'P20223121', 'AprilYandi Dwi W 121', '56419974121', '3276022304010010121', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243121', 'Kp.Babakan No. 121', 'Islam', 8, 10, NULL, NULL, 'Gratis', '2022-12-12 03:39:47', NULL, NULL, NULL),
(122, 2, 'P20222122', 'AprilYandi Dwi W 122', '56419974122', '3276022304010010122', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243122', 'Kp.Babakan No. 122', 'Islam', 11, 7, '150000.00', 3, 'Sudah', '2022-12-12 03:39:47', NULL, NULL, NULL),
(123, 2, 'P20222123', 'AprilYandi Dwi W 123', '56419974123', '3276022304010010123', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243123', 'Kp.Babakan No. 123', 'Islam', 12, 8, '150000.00', 2, 'Sudah', '2022-12-12 03:39:47', NULL, NULL, NULL),
(124, 1, 'P20221124', 'AprilYandi Dwi W 124', '56419974124', '3276022304010010124', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243124', 'Kp.Babakan No. 124', 'Islam', 12, 12, '150000.00', 3, 'Sudah', '2022-12-12 03:39:47', NULL, NULL, NULL),
(125, 1, 'P20221125', 'AprilYandi Dwi W 125', '56419974125', '3276022304010010125', 'Depok', '2001-12-16', 'Perempuan', '08810243125', 'Kp.Babakan No. 125', 'Islam', 7, 7, '150000.00', 2, 'Sudah', '2022-12-12 03:39:47', NULL, NULL, NULL),
(126, 3, 'P20223126', 'AprilYandi Dwi W 126', '56419974126', '3276022304010010126', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243126', 'Kp.Babakan No. 126', 'Islam', 12, 11, NULL, NULL, 'Belum', '2022-12-12 03:39:47', NULL, NULL, NULL),
(127, 2, 'P20222127', 'AprilYandi Dwi W 127', '56419974127', '3276022304010010127', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243127', 'Kp.Babakan No. 127', 'Islam', 9, 11, '150000.00', 1, 'Sudah', '2022-12-12 03:39:48', NULL, NULL, NULL),
(128, 1, 'P20221128', 'AprilYandi Dwi W 128', '56419974128', '3276022304010010128', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243128', 'Kp.Babakan No. 128', 'Islam', 3, 13, '150000.00', 2, 'Sudah', '2022-12-12 03:39:48', NULL, NULL, NULL),
(129, 2, 'P20222129', 'AprilYandi Dwi W 129', '56419974129', '3276022304010010129', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243129', 'Kp.Babakan No. 129', 'Islam', 1, 11, '150000.00', 2, 'Sudah', '2022-12-12 03:39:49', NULL, NULL, NULL),
(130, 2, 'P20222130', 'AprilYandi Dwi W 130', '56419974130', '3276022304010010130', 'Depok', '2001-12-11', 'Perempuan', '08810243130', 'Kp.Babakan No. 130', 'Islam', 12, 8, '150000.00', 3, 'Sudah', '2022-12-12 03:39:49', NULL, NULL, NULL),
(131, 2, 'P20222131', 'AprilYandi Dwi W 131', '56419974131', '3276022304010010131', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243131', 'Kp.Babakan No. 131', 'Islam', 5, 9, '150000.00', 3, 'Sudah', '2022-12-12 03:39:49', NULL, NULL, NULL),
(132, 3, 'P20223132', 'AprilYandi Dwi W 132', '56419974132', '3276022304010010132', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243132', 'Kp.Babakan No. 132', 'Islam', 7, 4, NULL, NULL, 'Gratis', '2022-12-12 03:39:49', NULL, NULL, NULL),
(133, 1, 'P20221133', 'AprilYandi Dwi W 133', '56419974133', '3276022304010010133', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243133', 'Kp.Babakan No. 133', 'Islam', 11, 8, '150000.00', 2, 'Belum', '2022-12-12 03:39:49', NULL, NULL, NULL),
(134, 1, 'P20221134', 'AprilYandi Dwi W 134', '56419974134', '3276022304010010134', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243134', 'Kp.Babakan No. 134', 'Islam', 12, 4, '150000.00', 3, 'Sudah', '2022-12-12 03:39:50', NULL, NULL, NULL),
(135, 2, 'P20222135', 'AprilYandi Dwi W 135', '56419974135', '3276022304010010135', 'Depok', '2001-12-28', 'Perempuan', '08810243135', 'Kp.Babakan No. 135', 'Islam', 13, 7, '150000.00', 2, 'Sudah', '2022-12-12 03:39:50', NULL, NULL, NULL),
(136, 1, 'P20221136', 'AprilYandi Dwi W 136', '56419974136', '3276022304010010136', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243136', 'Kp.Babakan No. 136', 'Islam', 10, 7, '150000.00', 2, 'Sudah', '2022-12-12 03:39:50', NULL, NULL, NULL),
(137, 1, 'P20221137', 'AprilYandi Dwi W 137', '56419974137', '3276022304010010137', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243137', 'Kp.Babakan No. 137', 'Islam', 2, 11, '150000.00', 2, 'Sudah', '2022-12-12 03:39:50', NULL, NULL, NULL),
(138, 1, 'P20221138', 'AprilYandi Dwi W 138', '56419974138', '3276022304010010138', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243138', 'Kp.Babakan No. 138', 'Islam', 5, 13, '150000.00', 3, 'Sudah', '2022-12-12 03:39:50', NULL, NULL, NULL),
(139, 3, 'P20223139', 'AprilYandi Dwi W 139', '56419974139', '3276022304010010139', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243139', 'Kp.Babakan No. 139', 'Islam', 8, 4, NULL, NULL, 'Gratis', '2022-12-12 03:39:50', NULL, NULL, NULL),
(140, 1, 'P20221140', 'AprilYandi Dwi W 140', '56419974140', '3276022304010010140', 'Depok', '2001-12-18', 'Perempuan', '08810243140', 'Kp.Babakan No. 140', 'Islam', 2, 11, '150000.00', 2, 'Belum', '2022-12-12 03:39:50', NULL, NULL, NULL),
(141, 2, 'P20222141', 'AprilYandi Dwi W 141', '56419974141', '3276022304010010141', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243141', 'Kp.Babakan No. 141', 'Islam', 9, 8, '150000.00', 3, 'Sudah', '2022-12-12 03:39:50', NULL, NULL, NULL),
(142, 3, 'P20223142', 'AprilYandi Dwi W 142', '56419974142', '3276022304010010142', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243142', 'Kp.Babakan No. 142', 'Islam', 3, 11, NULL, NULL, 'Gratis', '2022-12-12 03:39:50', NULL, NULL, NULL),
(143, 1, 'P20221143', 'AprilYandi Dwi W 143', '56419974143', '3276022304010010143', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243143', 'Kp.Babakan No. 143', 'Islam', 13, 10, '150000.00', 1, 'Sudah', '2022-12-12 03:39:51', NULL, NULL, NULL),
(144, 3, 'P20223144', 'AprilYandi Dwi W 144', '56419974144', '3276022304010010144', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243144', 'Kp.Babakan No. 144', 'Islam', 1, 5, NULL, NULL, 'Gratis', '2022-12-12 03:39:51', NULL, NULL, NULL),
(145, 3, 'P20223145', 'AprilYandi Dwi W 145', '56419974145', '3276022304010010145', 'Depok', '2001-12-13', 'Perempuan', '08810243145', 'Kp.Babakan No. 145', 'Islam', 2, 11, NULL, NULL, 'Gratis', '2022-12-12 03:39:51', NULL, NULL, NULL),
(146, 2, 'P20222146', 'AprilYandi Dwi W 146', '56419974146', '3276022304010010146', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243146', 'Kp.Babakan No. 146', 'Islam', 7, 11, '150000.00', 1, 'Sudah', '2022-12-12 03:39:51', NULL, NULL, NULL),
(147, 3, 'P20223147', 'AprilYandi Dwi W 147', '56419974147', '3276022304010010147', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243147', 'Kp.Babakan No. 147', 'Islam', 10, 12, NULL, NULL, 'Belum', '2022-12-12 03:39:51', NULL, NULL, NULL),
(148, 1, 'P20221148', 'AprilYandi Dwi W 148', '56419974148', '3276022304010010148', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243148', 'Kp.Babakan No. 148', 'Islam', 7, 9, '150000.00', 3, 'Sudah', '2022-12-12 03:39:51', NULL, NULL, NULL),
(149, 3, 'P20223149', 'AprilYandi Dwi W 149', '56419974149', '3276022304010010149', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243149', 'Kp.Babakan No. 149', 'Islam', 3, 12, NULL, NULL, 'Gratis', '2022-12-12 03:39:51', NULL, NULL, NULL),
(150, 3, 'P20223150', 'AprilYandi Dwi W 150', '56419974150', '3276022304010010150', 'Depok', '2001-12-18', 'Perempuan', '08810243150', 'Kp.Babakan No. 150', 'Islam', 11, 12, NULL, NULL, 'Gratis', '2022-12-12 03:39:51', NULL, NULL, NULL),
(151, 3, 'P20223151', 'AprilYandi Dwi W 151', '56419974151', '3276022304010010151', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243151', 'Kp.Babakan No. 151', 'Islam', 3, 11, NULL, NULL, 'Gratis', '2022-12-12 03:39:51', NULL, NULL, NULL),
(152, 2, 'P20222152', 'AprilYandi Dwi W 152', '56419974152', '3276022304010010152', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243152', 'Kp.Babakan No. 152', 'Islam', 8, 8, '150000.00', 1, 'Sudah', '2022-12-12 03:39:51', NULL, NULL, NULL),
(153, 1, 'P20221153', 'AprilYandi Dwi W 153', '56419974153', '3276022304010010153', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243153', 'Kp.Babakan No. 153', 'Islam', 4, 11, '150000.00', 3, 'Sudah', '2022-12-12 03:39:52', NULL, NULL, NULL),
(154, 2, 'P20222154', 'AprilYandi Dwi W 154', '56419974154', '3276022304010010154', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243154', 'Kp.Babakan No. 154', 'Islam', 7, 10, '150000.00', 4, 'Belum', '2022-12-12 03:39:52', NULL, NULL, NULL),
(155, 2, 'P20222155', 'AprilYandi Dwi W 155', '56419974155', '3276022304010010155', 'Depok', '2001-12-11', 'Perempuan', '08810243155', 'Kp.Babakan No. 155', 'Islam', 7, 8, '150000.00', 4, 'Sudah', '2022-12-12 03:39:52', NULL, NULL, NULL),
(156, 1, 'P20221156', 'AprilYandi Dwi W 156', '56419974156', '3276022304010010156', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243156', 'Kp.Babakan No. 156', 'Islam', 9, 12, '150000.00', 3, 'Sudah', '2022-12-12 03:39:52', NULL, NULL, NULL),
(157, 1, 'P20221157', 'AprilYandi Dwi W 157', '56419974157', '3276022304010010157', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243157', 'Kp.Babakan No. 157', 'Islam', 11, 2, '150000.00', 4, 'Sudah', '2022-12-12 03:39:52', NULL, NULL, NULL),
(158, 3, 'P20223158', 'AprilYandi Dwi W 158', '56419974158', '3276022304010010158', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243158', 'Kp.Babakan No. 158', 'Islam', 13, 8, NULL, NULL, 'Gratis', '2022-12-12 03:39:52', NULL, NULL, NULL),
(159, 2, 'P20222159', 'AprilYandi Dwi W 159', '56419974159', '3276022304010010159', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243159', 'Kp.Babakan No. 159', 'Islam', 13, 7, '150000.00', 3, 'Sudah', '2022-12-12 03:39:52', NULL, NULL, NULL),
(160, 1, 'P20221160', 'AprilYandi Dwi W 160', '56419974160', '3276022304010010160', 'Depok', '2001-12-29', 'Perempuan', '08810243160', 'Kp.Babakan No. 160', 'Islam', 5, 7, '150000.00', 1, 'Sudah', '2022-12-12 03:39:52', NULL, NULL, NULL),
(161, 2, 'P20222161', 'AprilYandi Dwi W 161', '56419974161', '3276022304010010161', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243161', 'Kp.Babakan No. 161', 'Islam', 11, 1, '150000.00', 4, 'Belum', '2022-12-12 03:39:52', NULL, NULL, NULL),
(162, 1, 'P20221162', 'AprilYandi Dwi W 162', '56419974162', '3276022304010010162', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243162', 'Kp.Babakan No. 162', 'Islam', 5, 3, '150000.00', 4, 'Sudah', '2022-12-12 03:39:52', NULL, NULL, NULL),
(163, 1, 'P20221163', 'AprilYandi Dwi W 163', '56419974163', '3276022304010010163', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243163', 'Kp.Babakan No. 163', 'Islam', 5, 2, '150000.00', 1, 'Sudah', '2022-12-12 03:39:52', NULL, NULL, NULL),
(164, 2, 'P20222164', 'AprilYandi Dwi W 164', '56419974164', '3276022304010010164', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243164', 'Kp.Babakan No. 164', 'Islam', 4, 13, '150000.00', 2, 'Sudah', '2022-12-12 03:39:52', NULL, NULL, NULL),
(165, 1, 'P20221165', 'AprilYandi Dwi W 165', '56419974165', '3276022304010010165', 'Depok', '2001-12-22', 'Perempuan', '08810243165', 'Kp.Babakan No. 165', 'Islam', 9, 5, '150000.00', 2, 'Sudah', '2022-12-12 03:39:52', NULL, NULL, NULL),
(166, 2, 'P20222166', 'AprilYandi Dwi W 166', '56419974166', '3276022304010010166', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243166', 'Kp.Babakan No. 166', 'Islam', 3, 5, '150000.00', 4, 'Sudah', '2022-12-12 03:39:53', NULL, NULL, NULL),
(167, 3, 'P20223167', 'AprilYandi Dwi W 167', '56419974167', '3276022304010010167', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243167', 'Kp.Babakan No. 167', 'Islam', 9, 10, NULL, NULL, 'Gratis', '2022-12-12 03:39:53', NULL, NULL, NULL),
(168, 3, 'P20223168', 'AprilYandi Dwi W 168', '56419974168', '3276022304010010168', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243168', 'Kp.Babakan No. 168', 'Islam', 10, 10, NULL, NULL, 'Belum', '2022-12-12 03:39:53', NULL, NULL, NULL),
(169, 1, 'P20221169', 'AprilYandi Dwi W 169', '56419974169', '3276022304010010169', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243169', 'Kp.Babakan No. 169', 'Islam', 4, 5, '150000.00', 2, 'Sudah', '2022-12-12 03:39:53', NULL, NULL, NULL),
(170, 1, 'P20221170', 'AprilYandi Dwi W 170', '56419974170', '3276022304010010170', 'Depok', '2001-12-28', 'Perempuan', '08810243170', 'Kp.Babakan No. 170', 'Islam', 12, 6, '150000.00', 4, 'Sudah', '2022-12-12 03:39:53', NULL, NULL, NULL),
(171, 3, 'P20223171', 'AprilYandi Dwi W 171', '56419974171', '3276022304010010171', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243171', 'Kp.Babakan No. 171', 'Islam', 11, 11, NULL, NULL, 'Gratis', '2022-12-12 03:39:53', NULL, NULL, NULL),
(172, 3, 'P20223172', 'AprilYandi Dwi W 172', '56419974172', '3276022304010010172', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243172', 'Kp.Babakan No. 172', 'Islam', 2, 3, NULL, NULL, 'Gratis', '2022-12-12 03:39:53', NULL, NULL, NULL),
(173, 1, 'P20221173', 'AprilYandi Dwi W 173', '56419974173', '3276022304010010173', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243173', 'Kp.Babakan No. 173', 'Islam', 2, 5, '150000.00', 2, 'Sudah', '2022-12-12 03:39:53', NULL, NULL, NULL),
(174, 3, 'P20223174', 'AprilYandi Dwi W 174', '56419974174', '3276022304010010174', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243174', 'Kp.Babakan No. 174', 'Islam', 10, 9, NULL, NULL, 'Gratis', '2022-12-12 03:39:53', NULL, NULL, NULL),
(175, 2, 'P20222175', 'AprilYandi Dwi W 175', '56419974175', '3276022304010010175', 'Depok', '2001-12-13', 'Perempuan', '08810243175', 'Kp.Babakan No. 175', 'Islam', 2, 9, '150000.00', 1, 'Belum', '2022-12-12 03:39:53', NULL, NULL, NULL),
(176, 3, 'P20223176', 'AprilYandi Dwi W 176', '56419974176', '3276022304010010176', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243176', 'Kp.Babakan No. 176', 'Islam', 4, 12, NULL, NULL, 'Gratis', '2022-12-12 03:39:54', NULL, NULL, NULL),
(177, 2, 'P20222177', 'AprilYandi Dwi W 177', '56419974177', '3276022304010010177', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243177', 'Kp.Babakan No. 177', 'Islam', 6, 6, '150000.00', 3, 'Sudah', '2022-12-12 03:39:59', NULL, NULL, NULL),
(178, 2, 'P20222178', 'AprilYandi Dwi W 178', '56419974178', '3276022304010010178', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243178', 'Kp.Babakan No. 178', 'Islam', 1, 4, '150000.00', 1, 'Sudah', '2022-12-12 03:39:59', NULL, NULL, NULL),
(179, 3, 'P20223179', 'AprilYandi Dwi W 179', '56419974179', '3276022304010010179', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243179', 'Kp.Babakan No. 179', 'Islam', 9, 8, NULL, NULL, 'Gratis', '2022-12-12 03:39:59', NULL, NULL, NULL),
(180, 2, 'P20222180', 'AprilYandi Dwi W 180', '56419974180', '3276022304010010180', 'Depok', '2001-12-28', 'Perempuan', '08810243180', 'Kp.Babakan No. 180', 'Islam', 3, 9, '150000.00', 1, 'Sudah', '2022-12-12 03:39:59', NULL, NULL, NULL),
(181, 3, 'P20223181', 'AprilYandi Dwi W 181', '56419974181', '3276022304010010181', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243181', 'Kp.Babakan No. 181', 'Islam', 2, 10, NULL, NULL, 'Gratis', '2022-12-12 03:40:00', NULL, NULL, NULL),
(182, 1, 'P20221182', 'AprilYandi Dwi W 182', '56419974182', '3276022304010010182', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243182', 'Kp.Babakan No. 182', 'Islam', 4, 9, '150000.00', 2, 'Belum', '2022-12-12 03:40:00', NULL, NULL, NULL),
(183, 1, 'P20221183', 'AprilYandi Dwi W 183', '56419974183', '3276022304010010183', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243183', 'Kp.Babakan No. 183', 'Islam', 10, 10, '150000.00', 3, 'Sudah', '2022-12-12 03:40:00', NULL, NULL, NULL),
(184, 2, 'P20222184', 'AprilYandi Dwi W 184', '56419974184', '3276022304010010184', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243184', 'Kp.Babakan No. 184', 'Islam', 11, 12, '150000.00', 1, 'Sudah', '2022-12-12 03:40:00', NULL, NULL, NULL),
(185, 1, 'P20221185', 'AprilYandi Dwi W 185', '56419974185', '3276022304010010185', 'Depok', '2001-12-21', 'Perempuan', '08810243185', 'Kp.Babakan No. 185', 'Islam', 12, 8, '150000.00', 4, 'Sudah', '2022-12-12 03:40:00', NULL, NULL, NULL),
(186, 3, 'P20223186', 'AprilYandi Dwi W 186', '56419974186', '3276022304010010186', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243186', 'Kp.Babakan No. 186', 'Islam', 6, 2, NULL, NULL, 'Gratis', '2022-12-12 03:40:00', NULL, NULL, NULL),
(187, 2, 'P20222187', 'AprilYandi Dwi W 187', '56419974187', '3276022304010010187', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243187', 'Kp.Babakan No. 187', 'Islam', 8, 2, '150000.00', 2, 'Sudah', '2022-12-12 03:40:00', NULL, NULL, NULL),
(188, 2, 'P20222188', 'AprilYandi Dwi W 188', '56419974188', '3276022304010010188', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243188', 'Kp.Babakan No. 188', 'Islam', 9, 10, '150000.00', 4, 'Sudah', '2022-12-12 03:40:00', NULL, NULL, NULL),
(189, 2, 'P20222189', 'AprilYandi Dwi W 189', '56419974189', '3276022304010010189', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243189', 'Kp.Babakan No. 189', 'Islam', 6, 1, '150000.00', 4, 'Belum', '2022-12-12 03:40:00', NULL, NULL, NULL),
(190, 3, 'P20223190', 'AprilYandi Dwi W 190', '56419974190', '3276022304010010190', 'Depok', '2001-12-28', 'Perempuan', '08810243190', 'Kp.Babakan No. 190', 'Islam', 11, 11, NULL, NULL, 'Gratis', '2022-12-12 03:40:00', NULL, NULL, NULL),
(191, 1, 'P20221191', 'AprilYandi Dwi W 191', '56419974191', '3276022304010010191', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243191', 'Kp.Babakan No. 191', 'Islam', 9, 8, '150000.00', 2, 'Sudah', '2022-12-12 03:40:01', NULL, NULL, NULL),
(192, 1, 'P20221192', 'AprilYandi Dwi W 192', '56419974192', '3276022304010010192', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243192', 'Kp.Babakan No. 192', 'Islam', 3, 7, '150000.00', 4, 'Sudah', '2022-12-12 03:40:01', NULL, NULL, NULL),
(193, 3, 'P20223193', 'AprilYandi Dwi W 193', '56419974193', '3276022304010010193', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243193', 'Kp.Babakan No. 193', 'Islam', 10, 9, NULL, NULL, 'Gratis', '2022-12-12 03:40:01', NULL, NULL, NULL),
(194, 3, 'P20223194', 'AprilYandi Dwi W 194', '56419974194', '3276022304010010194', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243194', 'Kp.Babakan No. 194', 'Islam', 4, 2, NULL, NULL, 'Gratis', '2022-12-12 03:40:01', NULL, NULL, NULL),
(195, 3, 'P20223195', 'AprilYandi Dwi W 195', '56419974195', '3276022304010010195', 'Depok', '2001-12-21', 'Perempuan', '08810243195', 'Kp.Babakan No. 195', 'Islam', 6, 8, NULL, NULL, 'Gratis', '2022-12-12 03:40:01', NULL, NULL, NULL),
(196, 1, 'P20221196', 'AprilYandi Dwi W 196', '56419974196', '3276022304010010196', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243196', 'Kp.Babakan No. 196', 'Islam', 10, 13, '150000.00', 3, 'Belum', '2022-12-12 03:40:01', NULL, NULL, NULL),
(197, 3, 'P20223197', 'AprilYandi Dwi W 197', '56419974197', '3276022304010010197', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243197', 'Kp.Babakan No. 197', 'Islam', 10, 9, NULL, NULL, 'Gratis', '2022-12-12 03:40:01', NULL, NULL, NULL),
(198, 3, 'P20223198', 'AprilYandi Dwi W 198', '56419974198', '3276022304010010198', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243198', 'Kp.Babakan No. 198', 'Islam', 6, 8, NULL, NULL, 'Gratis', '2022-12-12 03:40:01', NULL, NULL, NULL),
(199, 2, 'P20222199', 'AprilYandi Dwi W 199', '56419974199', '3276022304010010199', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243199', 'Kp.Babakan No. 199', 'Islam', 11, 1, '150000.00', 4, 'Sudah', '2022-12-12 03:40:01', NULL, NULL, NULL),
(200, 2, 'P20222200', 'AprilYandi Dwi W 200', '56419974200', '3276022304010010200', 'Depok', '2001-12-06', 'Perempuan', '08810243200', 'Kp.Babakan No. 200', 'Islam', 11, 3, '150000.00', 1, 'Sudah', '2022-12-12 03:40:02', NULL, NULL, NULL),
(201, 1, 'P20221201', 'AprilYandi Dwi W 201', '56419974201', '3276022304010010201', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243201', 'Kp.Babakan No. 201', 'Islam', 10, 7, '150000.00', 2, 'Sudah', '2022-12-12 03:40:02', NULL, NULL, NULL),
(202, 1, 'P20221202', 'AprilYandi Dwi W 202', '56419974202', '3276022304010010202', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243202', 'Kp.Babakan No. 202', 'Islam', 2, 13, '150000.00', 2, 'Sudah', '2022-12-12 03:40:02', NULL, NULL, NULL),
(203, 3, 'P20223203', 'AprilYandi Dwi W 203', '56419974203', '3276022304010010203', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243203', 'Kp.Babakan No. 203', 'Islam', 5, 12, NULL, NULL, 'Belum', '2022-12-12 03:40:02', NULL, NULL, NULL),
(204, 1, 'P20221204', 'AprilYandi Dwi W 204', '56419974204', '3276022304010010204', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243204', 'Kp.Babakan No. 204', 'Islam', 7, 11, '150000.00', 4, 'Sudah', '2022-12-12 03:40:02', NULL, NULL, NULL),
(205, 3, 'P20223205', 'AprilYandi Dwi W 205', '56419974205', '3276022304010010205', 'Depok', '2001-12-13', 'Perempuan', '08810243205', 'Kp.Babakan No. 205', 'Islam', 12, 7, NULL, NULL, 'Gratis', '2022-12-12 03:40:02', NULL, NULL, NULL),
(206, 3, 'P20223206', 'AprilYandi Dwi W 206', '56419974206', '3276022304010010206', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243206', 'Kp.Babakan No. 206', 'Islam', 1, 11, NULL, NULL, 'Gratis', '2022-12-12 03:40:02', NULL, NULL, NULL),
(207, 1, 'P20221207', 'AprilYandi Dwi W 207', '56419974207', '3276022304010010207', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243207', 'Kp.Babakan No. 207', 'Islam', 11, 10, '150000.00', 3, 'Sudah', '2022-12-12 03:40:02', NULL, NULL, NULL),
(208, 1, 'P20221208', 'AprilYandi Dwi W 208', '56419974208', '3276022304010010208', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243208', 'Kp.Babakan No. 208', 'Islam', 3, 9, '150000.00', 1, 'Sudah', '2022-12-12 03:40:02', NULL, NULL, NULL),
(209, 3, 'P20223209', 'AprilYandi Dwi W 209', '56419974209', '3276022304010010209', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243209', 'Kp.Babakan No. 209', 'Islam', 6, 12, NULL, NULL, 'Gratis', '2022-12-12 03:40:02', NULL, NULL, NULL),
(210, 3, 'P20223210', 'AprilYandi Dwi W 210', '56419974210', '3276022304010010210', 'Depok', '2001-12-06', 'Perempuan', '08810243210', 'Kp.Babakan No. 210', 'Islam', 3, 7, NULL, NULL, 'Belum', '2022-12-12 03:40:02', NULL, NULL, NULL),
(211, 1, 'P20221211', 'AprilYandi Dwi W 211', '56419974211', '3276022304010010211', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243211', 'Kp.Babakan No. 211', 'Islam', 8, 4, '150000.00', 4, 'Sudah', '2022-12-12 03:40:02', NULL, NULL, NULL);
INSERT INTO `pendaftar` (`id_pendaftar`, `id_jalur`, `no_pendaftar`, `nama`, `nisn`, `nik`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `no_hp`, `alamat`, `agama`, `id_prodi1`, `id_prodi2`, `nominal_bayar`, `id_bank`, `status_bayar`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(212, 1, 'P20221212', 'AprilYandi Dwi W 212', '56419974212', '3276022304010010212', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243212', 'Kp.Babakan No. 212', 'Islam', 4, 7, '150000.00', 2, 'Sudah', '2022-12-12 03:40:03', NULL, NULL, NULL),
(213, 2, 'P20222213', 'AprilYandi Dwi W 213', '56419974213', '3276022304010010213', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243213', 'Kp.Babakan No. 213', 'Islam', 8, 4, '150000.00', 1, 'Sudah', '2022-12-12 03:40:03', NULL, NULL, NULL),
(214, 3, 'P20223214', 'AprilYandi Dwi W 214', '56419974214', '3276022304010010214', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243214', 'Kp.Babakan No. 214', 'Islam', 9, 5, NULL, NULL, 'Gratis', '2022-12-12 03:40:03', NULL, NULL, NULL),
(215, 1, 'P20221215', 'AprilYandi Dwi W 215', '56419974215', '3276022304010010215', 'Depok', '2001-12-13', 'Perempuan', '08810243215', 'Kp.Babakan No. 215', 'Islam', 8, 4, '150000.00', 1, 'Sudah', '2022-12-12 03:40:03', NULL, NULL, NULL),
(216, 3, 'P20223216', 'AprilYandi Dwi W 216', '56419974216', '3276022304010010216', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243216', 'Kp.Babakan No. 216', 'Islam', 12, 4, NULL, NULL, 'Gratis', '2022-12-12 03:40:03', NULL, NULL, NULL),
(217, 3, 'P20223217', 'AprilYandi Dwi W 217', '56419974217', '3276022304010010217', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243217', 'Kp.Babakan No. 217', 'Islam', 11, 2, NULL, NULL, 'Belum', '2022-12-12 03:40:03', NULL, NULL, NULL),
(218, 1, 'P20221218', 'AprilYandi Dwi W 218', '56419974218', '3276022304010010218', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243218', 'Kp.Babakan No. 218', 'Islam', 4, 8, '150000.00', 3, 'Sudah', '2022-12-12 03:40:03', NULL, NULL, NULL),
(219, 3, 'P20223219', 'AprilYandi Dwi W 219', '56419974219', '3276022304010010219', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243219', 'Kp.Babakan No. 219', 'Islam', 7, 1, NULL, NULL, 'Gratis', '2022-12-12 03:40:03', NULL, NULL, NULL),
(220, 2, 'P20222220', 'AprilYandi Dwi W 220', '56419974220', '3276022304010010220', 'Depok', '2001-12-09', 'Perempuan', '08810243220', 'Kp.Babakan No. 220', 'Islam', 3, 12, '150000.00', 1, 'Sudah', '2022-12-12 03:40:03', NULL, NULL, NULL),
(221, 3, 'P20223221', 'AprilYandi Dwi W 221', '56419974221', '3276022304010010221', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243221', 'Kp.Babakan No. 221', 'Islam', 8, 8, NULL, NULL, 'Gratis', '2022-12-12 03:40:04', NULL, NULL, NULL),
(222, 1, 'P20221222', 'AprilYandi Dwi W 222', '56419974222', '3276022304010010222', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243222', 'Kp.Babakan No. 222', 'Islam', 6, 6, '150000.00', 4, 'Sudah', '2022-12-12 03:40:04', NULL, NULL, NULL),
(223, 2, 'P20222223', 'AprilYandi Dwi W 223', '56419974223', '3276022304010010223', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243223', 'Kp.Babakan No. 223', 'Islam', 2, 13, '150000.00', 3, 'Sudah', '2022-12-12 03:40:04', NULL, NULL, NULL),
(224, 3, 'P20223224', 'AprilYandi Dwi W 224', '56419974224', '3276022304010010224', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243224', 'Kp.Babakan No. 224', 'Islam', 11, 13, NULL, NULL, 'Belum', '2022-12-12 03:40:04', NULL, NULL, NULL),
(225, 3, 'P20223225', 'AprilYandi Dwi W 225', '56419974225', '3276022304010010225', 'Depok', '2001-12-18', 'Perempuan', '08810243225', 'Kp.Babakan No. 225', 'Islam', 1, 13, NULL, NULL, 'Gratis', '2022-12-12 03:40:04', NULL, NULL, NULL),
(226, 1, 'P20221226', 'AprilYandi Dwi W 226', '56419974226', '3276022304010010226', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243226', 'Kp.Babakan No. 226', 'Islam', 7, 10, '150000.00', 2, 'Sudah', '2022-12-12 03:40:04', NULL, NULL, NULL),
(227, 2, 'P20222227', 'AprilYandi Dwi W 227', '56419974227', '3276022304010010227', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243227', 'Kp.Babakan No. 227', 'Islam', 11, 3, '150000.00', 1, 'Sudah', '2022-12-12 03:40:04', NULL, NULL, NULL),
(228, 1, 'P20221228', 'AprilYandi Dwi W 228', '56419974228', '3276022304010010228', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243228', 'Kp.Babakan No. 228', 'Islam', 4, 7, '150000.00', 1, 'Sudah', '2022-12-12 03:40:04', NULL, NULL, NULL),
(229, 2, 'P20222229', 'AprilYandi Dwi W 229', '56419974229', '3276022304010010229', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243229', 'Kp.Babakan No. 229', 'Islam', 5, 1, '150000.00', 1, 'Sudah', '2022-12-12 03:40:04', NULL, NULL, NULL),
(230, 1, 'P20221230', 'AprilYandi Dwi W 230', '56419974230', '3276022304010010230', 'Depok', '2001-12-26', 'Perempuan', '08810243230', 'Kp.Babakan No. 230', 'Islam', 1, 2, '150000.00', 2, 'Sudah', '2022-12-12 03:40:04', NULL, NULL, NULL),
(231, 2, 'P20222231', 'AprilYandi Dwi W 231', '56419974231', '3276022304010010231', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243231', 'Kp.Babakan No. 231', 'Islam', 4, 12, '150000.00', 4, 'Belum', '2022-12-12 03:40:04', NULL, NULL, NULL),
(232, 2, 'P20222232', 'AprilYandi Dwi W 232', '56419974232', '3276022304010010232', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243232', 'Kp.Babakan No. 232', 'Islam', 6, 9, '150000.00', 4, 'Sudah', '2022-12-12 03:40:05', NULL, NULL, NULL),
(233, 2, 'P20222233', 'AprilYandi Dwi W 233', '56419974233', '3276022304010010233', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243233', 'Kp.Babakan No. 233', 'Islam', 5, 13, '150000.00', 1, 'Sudah', '2022-12-12 03:40:05', NULL, NULL, NULL),
(234, 1, 'P20221234', 'AprilYandi Dwi W 234', '56419974234', '3276022304010010234', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243234', 'Kp.Babakan No. 234', 'Islam', 1, 2, '150000.00', 4, 'Sudah', '2022-12-12 03:40:05', NULL, NULL, NULL),
(235, 1, 'P20221235', 'AprilYandi Dwi W 235', '56419974235', '3276022304010010235', 'Depok', '2001-12-12', 'Perempuan', '08810243235', 'Kp.Babakan No. 235', 'Islam', 5, 2, '150000.00', 2, 'Sudah', '2022-12-12 03:40:05', NULL, NULL, NULL),
(236, 3, 'P20223236', 'AprilYandi Dwi W 236', '56419974236', '3276022304010010236', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243236', 'Kp.Babakan No. 236', 'Islam', 1, 10, NULL, NULL, 'Gratis', '2022-12-12 03:40:05', NULL, NULL, NULL),
(237, 2, 'P20222237', 'AprilYandi Dwi W 237', '56419974237', '3276022304010010237', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243237', 'Kp.Babakan No. 237', 'Islam', 7, 7, '150000.00', 1, 'Sudah', '2022-12-12 03:40:05', NULL, NULL, NULL),
(238, 1, 'P20221238', 'AprilYandi Dwi W 238', '56419974238', '3276022304010010238', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243238', 'Kp.Babakan No. 238', 'Islam', 13, 9, '150000.00', 2, 'Belum', '2022-12-12 03:40:05', NULL, NULL, NULL),
(239, 2, 'P20222239', 'AprilYandi Dwi W 239', '56419974239', '3276022304010010239', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243239', 'Kp.Babakan No. 239', 'Islam', 13, 13, '150000.00', 1, 'Sudah', '2022-12-12 03:40:05', NULL, NULL, NULL),
(240, 1, 'P20221240', 'AprilYandi Dwi W 240', '56419974240', '3276022304010010240', 'Depok', '2001-12-19', 'Perempuan', '08810243240', 'Kp.Babakan No. 240', 'Islam', 6, 12, '150000.00', 1, 'Sudah', '2022-12-12 03:40:05', NULL, NULL, NULL),
(241, 1, 'P20221241', 'AprilYandi Dwi W 241', '56419974241', '3276022304010010241', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243241', 'Kp.Babakan No. 241', 'Islam', 7, 2, '150000.00', 3, 'Sudah', '2022-12-12 03:40:06', NULL, NULL, NULL),
(242, 1, 'P20221242', 'AprilYandi Dwi W 242', '56419974242', '3276022304010010242', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243242', 'Kp.Babakan No. 242', 'Islam', 6, 1, '150000.00', 2, 'Sudah', '2022-12-12 03:40:06', NULL, NULL, NULL),
(243, 3, 'P20223243', 'AprilYandi Dwi W 243', '56419974243', '3276022304010010243', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243243', 'Kp.Babakan No. 243', 'Islam', 10, 4, NULL, NULL, 'Gratis', '2022-12-12 03:40:06', NULL, NULL, NULL),
(244, 3, 'P20223244', 'AprilYandi Dwi W 244', '56419974244', '3276022304010010244', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243244', 'Kp.Babakan No. 244', 'Islam', 7, 6, NULL, NULL, 'Gratis', '2022-12-12 03:40:06', NULL, NULL, NULL),
(245, 1, 'P20221245', 'AprilYandi Dwi W 245', '56419974245', '3276022304010010245', 'Depok', '2001-12-09', 'Perempuan', '08810243245', 'Kp.Babakan No. 245', 'Islam', 7, 7, '150000.00', 2, 'Belum', '2022-12-12 03:40:07', NULL, NULL, NULL),
(246, 2, 'P20222246', 'AprilYandi Dwi W 246', '56419974246', '3276022304010010246', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243246', 'Kp.Babakan No. 246', 'Islam', 13, 3, '150000.00', 2, 'Sudah', '2022-12-12 03:40:07', NULL, NULL, NULL),
(247, 2, 'P20222247', 'AprilYandi Dwi W 247', '56419974247', '3276022304010010247', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243247', 'Kp.Babakan No. 247', 'Islam', 5, 2, '150000.00', 4, 'Sudah', '2022-12-12 03:40:07', NULL, NULL, NULL),
(248, 1, 'P20221248', 'AprilYandi Dwi W 248', '56419974248', '3276022304010010248', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243248', 'Kp.Babakan No. 248', 'Islam', 10, 12, '150000.00', 1, 'Sudah', '2022-12-12 03:40:07', NULL, NULL, NULL),
(249, 3, 'P20223249', 'AprilYandi Dwi W 249', '56419974249', '3276022304010010249', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243249', 'Kp.Babakan No. 249', 'Islam', 8, 7, NULL, NULL, 'Gratis', '2022-12-12 03:40:07', NULL, NULL, NULL),
(250, 3, 'P20223250', 'AprilYandi Dwi W 250', '56419974250', '3276022304010010250', 'Depok', '2001-12-04', 'Perempuan', '08810243250', 'Kp.Babakan No. 250', 'Islam', 9, 10, NULL, NULL, 'Gratis', '2022-12-12 03:40:07', NULL, NULL, NULL),
(251, 3, 'P20223251', 'AprilYandi Dwi W 251', '56419974251', '3276022304010010251', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243251', 'Kp.Babakan No. 251', 'Islam', 13, 6, NULL, NULL, 'Gratis', '2022-12-12 03:40:07', NULL, NULL, NULL),
(252, 2, 'P20222252', 'AprilYandi Dwi W 252', '56419974252', '3276022304010010252', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243252', 'Kp.Babakan No. 252', 'Islam', 8, 10, '150000.00', 2, 'Belum', '2022-12-12 03:40:07', NULL, NULL, NULL),
(253, 3, 'P20223253', 'AprilYandi Dwi W 253', '56419974253', '3276022304010010253', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243253', 'Kp.Babakan No. 253', 'Islam', 9, 10, NULL, NULL, 'Gratis', '2022-12-12 03:40:07', NULL, NULL, NULL),
(254, 3, 'P20223254', 'AprilYandi Dwi W 254', '56419974254', '3276022304010010254', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243254', 'Kp.Babakan No. 254', 'Islam', 7, 9, NULL, NULL, 'Gratis', '2022-12-12 03:40:07', NULL, NULL, NULL),
(255, 1, 'P20221255', 'AprilYandi Dwi W 255', '56419974255', '3276022304010010255', 'Depok', '2001-12-13', 'Perempuan', '08810243255', 'Kp.Babakan No. 255', 'Islam', 13, 8, '150000.00', 4, 'Sudah', '2022-12-12 03:40:08', NULL, NULL, NULL),
(256, 2, 'P20222256', 'AprilYandi Dwi W 256', '56419974256', '3276022304010010256', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243256', 'Kp.Babakan No. 256', 'Islam', 9, 11, '150000.00', 4, 'Sudah', '2022-12-12 03:40:08', NULL, NULL, NULL),
(257, 3, 'P20223257', 'AprilYandi Dwi W 257', '56419974257', '3276022304010010257', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243257', 'Kp.Babakan No. 257', 'Islam', 2, 5, NULL, NULL, 'Gratis', '2022-12-12 03:40:08', NULL, NULL, NULL),
(258, 3, 'P20223258', 'AprilYandi Dwi W 258', '56419974258', '3276022304010010258', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243258', 'Kp.Babakan No. 258', 'Islam', 13, 1, NULL, NULL, 'Gratis', '2022-12-12 03:40:08', NULL, NULL, NULL),
(259, 2, 'P20222259', 'AprilYandi Dwi W 259', '56419974259', '3276022304010010259', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243259', 'Kp.Babakan No. 259', 'Islam', 2, 11, '150000.00', 2, 'Belum', '2022-12-12 03:40:08', NULL, NULL, NULL),
(260, 1, 'P20221260', 'AprilYandi Dwi W 260', '56419974260', '3276022304010010260', 'Depok', '2001-12-21', 'Perempuan', '08810243260', 'Kp.Babakan No. 260', 'Islam', 3, 4, '150000.00', 4, 'Sudah', '2022-12-12 03:40:08', NULL, NULL, NULL),
(261, 2, 'P20222261', 'AprilYandi Dwi W 261', '56419974261', '3276022304010010261', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243261', 'Kp.Babakan No. 261', 'Islam', 9, 12, '150000.00', 3, 'Sudah', '2022-12-12 03:40:08', NULL, NULL, NULL),
(262, 2, 'P20222262', 'AprilYandi Dwi W 262', '56419974262', '3276022304010010262', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243262', 'Kp.Babakan No. 262', 'Islam', 7, 13, '150000.00', 3, 'Sudah', '2022-12-12 03:40:09', NULL, NULL, NULL),
(263, 2, 'P20222263', 'AprilYandi Dwi W 263', '56419974263', '3276022304010010263', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243263', 'Kp.Babakan No. 263', 'Islam', 1, 9, '150000.00', 2, 'Sudah', '2022-12-12 03:40:09', NULL, NULL, NULL),
(264, 1, 'P20221264', 'AprilYandi Dwi W 264', '56419974264', '3276022304010010264', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243264', 'Kp.Babakan No. 264', 'Islam', 4, 11, '150000.00', 1, 'Sudah', '2022-12-12 03:40:09', NULL, NULL, NULL),
(265, 3, 'P20223265', 'AprilYandi Dwi W 265', '56419974265', '3276022304010010265', 'Depok', '2001-12-03', 'Perempuan', '08810243265', 'Kp.Babakan No. 265', 'Islam', 13, 1, NULL, NULL, 'Gratis', '2022-12-12 03:40:09', NULL, NULL, NULL),
(266, 2, 'P20222266', 'AprilYandi Dwi W 266', '56419974266', '3276022304010010266', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243266', 'Kp.Babakan No. 266', 'Islam', 2, 8, '150000.00', 2, 'Belum', '2022-12-12 03:40:09', NULL, NULL, NULL),
(267, 2, 'P20222267', 'AprilYandi Dwi W 267', '56419974267', '3276022304010010267', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243267', 'Kp.Babakan No. 267', 'Islam', 7, 6, '150000.00', 4, 'Sudah', '2022-12-12 03:40:10', NULL, NULL, NULL),
(268, 1, 'P20221268', 'AprilYandi Dwi W 268', '56419974268', '3276022304010010268', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243268', 'Kp.Babakan No. 268', 'Islam', 10, 7, '150000.00', 3, 'Sudah', '2022-12-12 03:40:10', NULL, NULL, NULL),
(269, 3, 'P20223269', 'AprilYandi Dwi W 269', '56419974269', '3276022304010010269', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243269', 'Kp.Babakan No. 269', 'Islam', 10, 1, NULL, NULL, 'Gratis', '2022-12-12 03:40:10', NULL, NULL, NULL),
(270, 3, 'P20223270', 'AprilYandi Dwi W 270', '56419974270', '3276022304010010270', 'Depok', '2001-12-07', 'Perempuan', '08810243270', 'Kp.Babakan No. 270', 'Islam', 2, 2, NULL, NULL, 'Gratis', '2022-12-12 03:40:11', NULL, NULL, NULL),
(271, 1, 'P20221271', 'AprilYandi Dwi W 271', '56419974271', '3276022304010010271', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243271', 'Kp.Babakan No. 271', 'Islam', 3, 8, '150000.00', 4, 'Sudah', '2022-12-12 03:40:11', NULL, NULL, NULL),
(272, 1, 'P20221272', 'AprilYandi Dwi W 272', '56419974272', '3276022304010010272', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243272', 'Kp.Babakan No. 272', 'Islam', 11, 11, '150000.00', 4, 'Sudah', '2022-12-12 03:40:11', NULL, NULL, NULL),
(273, 3, 'P20223273', 'AprilYandi Dwi W 273', '56419974273', '3276022304010010273', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243273', 'Kp.Babakan No. 273', 'Islam', 5, 2, NULL, NULL, 'Belum', '2022-12-12 03:40:11', NULL, NULL, NULL),
(274, 1, 'P20221274', 'AprilYandi Dwi W 274', '56419974274', '3276022304010010274', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243274', 'Kp.Babakan No. 274', 'Islam', 3, 7, '150000.00', 3, 'Sudah', '2022-12-12 03:40:12', NULL, NULL, NULL),
(275, 2, 'P20222275', 'AprilYandi Dwi W 275', '56419974275', '3276022304010010275', 'Depok', '2001-12-05', 'Perempuan', '08810243275', 'Kp.Babakan No. 275', 'Islam', 10, 3, '150000.00', 2, 'Sudah', '2022-12-12 03:40:13', NULL, NULL, NULL),
(276, 1, 'P20221276', 'AprilYandi Dwi W 276', '56419974276', '3276022304010010276', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243276', 'Kp.Babakan No. 276', 'Islam', 5, 13, '150000.00', 2, 'Sudah', '2022-12-12 03:40:13', NULL, NULL, NULL),
(277, 1, 'P20221277', 'AprilYandi Dwi W 277', '56419974277', '3276022304010010277', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243277', 'Kp.Babakan No. 277', 'Islam', 5, 2, '150000.00', 2, 'Sudah', '2022-12-12 03:40:14', NULL, NULL, NULL),
(278, 2, 'P20222278', 'AprilYandi Dwi W 278', '56419974278', '3276022304010010278', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243278', 'Kp.Babakan No. 278', 'Islam', 4, 7, '150000.00', 1, 'Sudah', '2022-12-12 03:40:14', NULL, NULL, NULL),
(279, 1, 'P20221279', 'AprilYandi Dwi W 279', '56419974279', '3276022304010010279', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243279', 'Kp.Babakan No. 279', 'Islam', 2, 10, '150000.00', 2, 'Sudah', '2022-12-12 03:40:14', NULL, NULL, NULL),
(280, 2, 'P20222280', 'AprilYandi Dwi W 280', '56419974280', '3276022304010010280', 'Depok', '2001-12-15', 'Perempuan', '08810243280', 'Kp.Babakan No. 280', 'Islam', 7, 9, '150000.00', 3, 'Belum', '2022-12-12 03:40:15', NULL, NULL, NULL),
(281, 3, 'P20223281', 'AprilYandi Dwi W 281', '56419974281', '3276022304010010281', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243281', 'Kp.Babakan No. 281', 'Islam', 11, 12, NULL, NULL, 'Gratis', '2022-12-12 03:40:15', NULL, NULL, NULL),
(282, 2, 'P20222282', 'AprilYandi Dwi W 282', '56419974282', '3276022304010010282', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243282', 'Kp.Babakan No. 282', 'Islam', 1, 7, '150000.00', 2, 'Sudah', '2022-12-12 03:40:15', NULL, NULL, NULL),
(283, 1, 'P20221283', 'AprilYandi Dwi W 283', '56419974283', '3276022304010010283', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243283', 'Kp.Babakan No. 283', 'Islam', 5, 4, '150000.00', 4, 'Sudah', '2022-12-12 03:40:15', NULL, NULL, NULL),
(284, 3, 'P20223284', 'AprilYandi Dwi W 284', '56419974284', '3276022304010010284', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243284', 'Kp.Babakan No. 284', 'Islam', 1, 7, NULL, NULL, 'Gratis', '2022-12-12 03:40:15', NULL, NULL, NULL),
(285, 2, 'P20222285', 'AprilYandi Dwi W 285', '56419974285', '3276022304010010285', 'Depok', '2001-12-28', 'Perempuan', '08810243285', 'Kp.Babakan No. 285', 'Islam', 7, 9, '150000.00', 1, 'Sudah', '2022-12-12 03:40:15', NULL, NULL, NULL),
(286, 1, 'P20221286', 'AprilYandi Dwi W 286', '56419974286', '3276022304010010286', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243286', 'Kp.Babakan No. 286', 'Islam', 10, 5, '150000.00', 4, 'Sudah', '2022-12-12 03:40:15', NULL, NULL, NULL),
(287, 2, 'P20222287', 'AprilYandi Dwi W 287', '56419974287', '3276022304010010287', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243287', 'Kp.Babakan No. 287', 'Islam', 12, 12, '150000.00', 2, 'Belum', '2022-12-12 03:40:15', NULL, NULL, NULL),
(288, 3, 'P20223288', 'AprilYandi Dwi W 288', '56419974288', '3276022304010010288', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243288', 'Kp.Babakan No. 288', 'Islam', 7, 10, NULL, NULL, 'Gratis', '2022-12-12 03:40:15', NULL, NULL, NULL),
(289, 2, 'P20222289', 'AprilYandi Dwi W 289', '56419974289', '3276022304010010289', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243289', 'Kp.Babakan No. 289', 'Islam', 13, 13, '150000.00', 1, 'Sudah', '2022-12-12 03:40:16', NULL, NULL, NULL),
(290, 2, 'P20222290', 'AprilYandi Dwi W 290', '56419974290', '3276022304010010290', 'Depok', '2001-12-08', 'Perempuan', '08810243290', 'Kp.Babakan No. 290', 'Islam', 5, 6, '150000.00', 1, 'Sudah', '2022-12-12 03:40:16', NULL, NULL, NULL),
(291, 2, 'P20222291', 'AprilYandi Dwi W 291', '56419974291', '3276022304010010291', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243291', 'Kp.Babakan No. 291', 'Islam', 9, 9, '150000.00', 1, 'Sudah', '2022-12-12 03:40:16', NULL, NULL, NULL),
(292, 2, 'P20222292', 'AprilYandi Dwi W 292', '56419974292', '3276022304010010292', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243292', 'Kp.Babakan No. 292', 'Islam', 7, 12, '150000.00', 1, 'Sudah', '2022-12-12 03:40:16', NULL, NULL, NULL),
(293, 2, 'P20222293', 'AprilYandi Dwi W 293', '56419974293', '3276022304010010293', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243293', 'Kp.Babakan No. 293', 'Islam', 6, 5, '150000.00', 1, 'Sudah', '2022-12-12 03:40:16', NULL, NULL, NULL),
(294, 2, 'P20222294', 'AprilYandi Dwi W 294', '56419974294', '3276022304010010294', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243294', 'Kp.Babakan No. 294', 'Islam', 8, 7, '150000.00', 1, 'Belum', '2022-12-12 03:40:16', NULL, NULL, NULL),
(295, 3, 'P20223295', 'AprilYandi Dwi W 295', '56419974295', '3276022304010010295', 'Depok', '2001-12-14', 'Perempuan', '08810243295', 'Kp.Babakan No. 295', 'Islam', 13, 2, NULL, NULL, 'Gratis', '2022-12-12 03:40:17', NULL, NULL, NULL),
(296, 3, 'P20223296', 'AprilYandi Dwi W 296', '56419974296', '3276022304010010296', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243296', 'Kp.Babakan No. 296', 'Islam', 9, 13, NULL, NULL, 'Gratis', '2022-12-12 03:40:19', NULL, NULL, NULL),
(297, 1, 'P20221297', 'AprilYandi Dwi W 297', '56419974297', '3276022304010010297', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243297', 'Kp.Babakan No. 297', 'Islam', 3, 7, '150000.00', 2, 'Sudah', '2022-12-12 03:40:19', NULL, NULL, NULL),
(298, 2, 'P20222298', 'AprilYandi Dwi W 298', '56419974298', '3276022304010010298', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243298', 'Kp.Babakan No. 298', 'Islam', 11, 5, '150000.00', 4, 'Sudah', '2022-12-12 03:40:20', NULL, NULL, NULL),
(299, 1, 'P20221299', 'AprilYandi Dwi W 299', '56419974299', '3276022304010010299', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243299', 'Kp.Babakan No. 299', 'Islam', 6, 11, '150000.00', 2, 'Sudah', '2022-12-12 03:40:20', NULL, NULL, NULL),
(300, 1, 'P20221300', 'AprilYandi Dwi W 300', '56419974300', '3276022304010010300', 'Depok', '2001-12-11', 'Perempuan', '08810243300', 'Kp.Babakan No. 300', 'Islam', 3, 1, '150000.00', 4, 'Sudah', '2022-12-12 03:40:21', NULL, NULL, NULL),
(301, 2, 'P20222301', 'AprilYandi Dwi W 301', '56419974301', '3276022304010010301', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243301', 'Kp.Babakan No. 301', 'Islam', 13, 7, '150000.00', 1, 'Belum', '2022-12-12 03:40:21', NULL, NULL, NULL),
(302, 3, 'P20223302', 'AprilYandi Dwi W 302', '56419974302', '3276022304010010302', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243302', 'Kp.Babakan No. 302', 'Islam', 4, 13, NULL, NULL, 'Gratis', '2022-12-12 03:40:21', NULL, NULL, NULL),
(303, 1, 'P20221303', 'AprilYandi Dwi W 303', '56419974303', '3276022304010010303', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243303', 'Kp.Babakan No. 303', 'Islam', 13, 7, '150000.00', 1, 'Sudah', '2022-12-12 03:40:22', NULL, NULL, NULL),
(304, 2, 'P20222304', 'AprilYandi Dwi W 304', '56419974304', '3276022304010010304', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243304', 'Kp.Babakan No. 304', 'Islam', 5, 3, '150000.00', 3, 'Sudah', '2022-12-12 03:40:22', NULL, NULL, NULL),
(305, 3, 'P20223305', 'AprilYandi Dwi W 305', '56419974305', '3276022304010010305', 'Depok', '2001-12-08', 'Perempuan', '08810243305', 'Kp.Babakan No. 305', 'Islam', 2, 2, NULL, NULL, 'Gratis', '2022-12-12 03:40:22', NULL, NULL, NULL),
(306, 2, 'P20222306', 'AprilYandi Dwi W 306', '56419974306', '3276022304010010306', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243306', 'Kp.Babakan No. 306', 'Islam', 13, 12, '150000.00', 3, 'Sudah', '2022-12-12 03:40:23', NULL, NULL, NULL),
(307, 1, 'P20221307', 'AprilYandi Dwi W 307', '56419974307', '3276022304010010307', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243307', 'Kp.Babakan No. 307', 'Islam', 13, 10, '150000.00', 3, 'Sudah', '2022-12-12 03:40:23', NULL, NULL, NULL),
(308, 2, 'P20222308', 'AprilYandi Dwi W 308', '56419974308', '3276022304010010308', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243308', 'Kp.Babakan No. 308', 'Islam', 3, 5, '150000.00', 3, 'Belum', '2022-12-12 03:40:23', NULL, NULL, NULL),
(309, 1, 'P20221309', 'AprilYandi Dwi W 309', '56419974309', '3276022304010010309', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243309', 'Kp.Babakan No. 309', 'Islam', 10, 4, '150000.00', 1, 'Sudah', '2022-12-12 03:40:24', NULL, NULL, NULL),
(310, 3, 'P20223310', 'AprilYandi Dwi W 310', '56419974310', '3276022304010010310', 'Depok', '2001-12-16', 'Perempuan', '08810243310', 'Kp.Babakan No. 310', 'Islam', 5, 8, NULL, NULL, 'Gratis', '2022-12-12 03:40:24', NULL, NULL, NULL),
(311, 3, 'P20223311', 'AprilYandi Dwi W 311', '56419974311', '3276022304010010311', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243311', 'Kp.Babakan No. 311', 'Islam', 12, 4, NULL, NULL, 'Gratis', '2022-12-12 03:40:24', NULL, NULL, NULL),
(312, 2, 'P20222312', 'AprilYandi Dwi W 312', '56419974312', '3276022304010010312', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243312', 'Kp.Babakan No. 312', 'Islam', 8, 8, '150000.00', 1, 'Sudah', '2022-12-12 03:40:25', NULL, NULL, NULL),
(313, 2, 'P20222313', 'AprilYandi Dwi W 313', '56419974313', '3276022304010010313', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243313', 'Kp.Babakan No. 313', 'Islam', 6, 12, '150000.00', 2, 'Sudah', '2022-12-12 03:40:25', NULL, NULL, NULL),
(314, 3, 'P20223314', 'AprilYandi Dwi W 314', '56419974314', '3276022304010010314', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243314', 'Kp.Babakan No. 314', 'Islam', 12, 12, NULL, NULL, 'Gratis', '2022-12-12 03:40:26', NULL, NULL, NULL),
(315, 3, 'P20223315', 'AprilYandi Dwi W 315', '56419974315', '3276022304010010315', 'Depok', '2001-12-13', 'Perempuan', '08810243315', 'Kp.Babakan No. 315', 'Islam', 6, 9, NULL, NULL, 'Belum', '2022-12-12 03:40:26', NULL, NULL, NULL),
(316, 2, 'P20222316', 'AprilYandi Dwi W 316', '56419974316', '3276022304010010316', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243316', 'Kp.Babakan No. 316', 'Islam', 8, 9, '150000.00', 4, 'Sudah', '2022-12-12 03:40:26', NULL, NULL, NULL),
(317, 3, 'P20223317', 'AprilYandi Dwi W 317', '56419974317', '3276022304010010317', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243317', 'Kp.Babakan No. 317', 'Islam', 13, 8, NULL, NULL, 'Gratis', '2022-12-12 03:40:27', NULL, NULL, NULL),
(318, 3, 'P20223318', 'AprilYandi Dwi W 318', '56419974318', '3276022304010010318', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243318', 'Kp.Babakan No. 318', 'Islam', 6, 12, NULL, NULL, 'Gratis', '2022-12-12 03:40:27', NULL, NULL, NULL),
(319, 3, 'P20223319', 'AprilYandi Dwi W 319', '56419974319', '3276022304010010319', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243319', 'Kp.Babakan No. 319', 'Islam', 9, 12, NULL, NULL, 'Gratis', '2022-12-12 03:40:28', NULL, NULL, NULL),
(320, 2, 'P20222320', 'AprilYandi Dwi W 320', '56419974320', '3276022304010010320', 'Depok', '2001-12-09', 'Perempuan', '08810243320', 'Kp.Babakan No. 320', 'Islam', 11, 10, '150000.00', 3, 'Sudah', '2022-12-12 03:40:28', NULL, NULL, NULL),
(321, 3, 'P20223321', 'AprilYandi Dwi W 321', '56419974321', '3276022304010010321', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243321', 'Kp.Babakan No. 321', 'Islam', 4, 6, NULL, NULL, 'Gratis', '2022-12-12 03:40:29', NULL, NULL, NULL),
(322, 2, 'P20222322', 'AprilYandi Dwi W 322', '56419974322', '3276022304010010322', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243322', 'Kp.Babakan No. 322', 'Islam', 13, 10, '150000.00', 4, 'Belum', '2022-12-12 03:40:29', NULL, NULL, NULL),
(323, 2, 'P20222323', 'AprilYandi Dwi W 323', '56419974323', '3276022304010010323', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243323', 'Kp.Babakan No. 323', 'Islam', 5, 10, '150000.00', 4, 'Sudah', '2022-12-12 03:40:29', NULL, NULL, NULL),
(324, 1, 'P20221324', 'AprilYandi Dwi W 324', '56419974324', '3276022304010010324', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243324', 'Kp.Babakan No. 324', 'Islam', 9, 6, '150000.00', 4, 'Sudah', '2022-12-12 03:40:30', NULL, NULL, NULL),
(325, 1, 'P20221325', 'AprilYandi Dwi W 325', '56419974325', '3276022304010010325', 'Depok', '2001-12-30', 'Perempuan', '08810243325', 'Kp.Babakan No. 325', 'Islam', 6, 4, '150000.00', 1, 'Sudah', '2022-12-12 03:40:30', NULL, NULL, NULL),
(326, 1, 'P20221326', 'AprilYandi Dwi W 326', '56419974326', '3276022304010010326', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243326', 'Kp.Babakan No. 326', 'Islam', 10, 3, '150000.00', 1, 'Sudah', '2022-12-12 03:40:30', NULL, NULL, NULL),
(327, 2, 'P20222327', 'AprilYandi Dwi W 327', '56419974327', '3276022304010010327', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243327', 'Kp.Babakan No. 327', 'Islam', 8, 6, '150000.00', 4, 'Sudah', '2022-12-12 03:40:30', NULL, NULL, NULL),
(328, 1, 'P20221328', 'AprilYandi Dwi W 328', '56419974328', '3276022304010010328', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243328', 'Kp.Babakan No. 328', 'Islam', 6, 3, '150000.00', 3, 'Sudah', '2022-12-12 03:40:30', NULL, NULL, NULL),
(329, 1, 'P20221329', 'AprilYandi Dwi W 329', '56419974329', '3276022304010010329', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243329', 'Kp.Babakan No. 329', 'Islam', 4, 7, '150000.00', 3, 'Belum', '2022-12-12 03:40:31', NULL, NULL, NULL),
(330, 3, 'P20223330', 'AprilYandi Dwi W 330', '56419974330', '3276022304010010330', 'Depok', '2001-12-13', 'Perempuan', '08810243330', 'Kp.Babakan No. 330', 'Islam', 9, 4, NULL, NULL, 'Gratis', '2022-12-12 03:40:31', NULL, NULL, NULL),
(331, 3, 'P20223331', 'AprilYandi Dwi W 331', '56419974331', '3276022304010010331', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243331', 'Kp.Babakan No. 331', 'Islam', 5, 9, NULL, NULL, 'Gratis', '2022-12-12 03:40:31', NULL, NULL, NULL),
(332, 1, 'P20221332', 'AprilYandi Dwi W 332', '56419974332', '3276022304010010332', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243332', 'Kp.Babakan No. 332', 'Islam', 2, 13, '150000.00', 3, 'Sudah', '2022-12-12 03:40:32', NULL, NULL, NULL),
(333, 3, 'P20223333', 'AprilYandi Dwi W 333', '56419974333', '3276022304010010333', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243333', 'Kp.Babakan No. 333', 'Islam', 9, 5, NULL, NULL, 'Gratis', '2022-12-12 03:40:32', NULL, NULL, NULL),
(334, 1, 'P20221334', 'AprilYandi Dwi W 334', '56419974334', '3276022304010010334', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243334', 'Kp.Babakan No. 334', 'Islam', 7, 4, '150000.00', 2, 'Sudah', '2022-12-12 03:40:32', NULL, NULL, NULL),
(335, 3, 'P20223335', 'AprilYandi Dwi W 335', '56419974335', '3276022304010010335', 'Depok', '2001-12-07', 'Perempuan', '08810243335', 'Kp.Babakan No. 335', 'Islam', 3, 12, NULL, NULL, 'Gratis', '2022-12-12 03:40:32', NULL, NULL, NULL),
(336, 2, 'P20222336', 'AprilYandi Dwi W 336', '56419974336', '3276022304010010336', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243336', 'Kp.Babakan No. 336', 'Islam', 12, 8, '150000.00', 2, 'Belum', '2022-12-12 03:40:33', NULL, NULL, NULL),
(337, 2, 'P20222337', 'AprilYandi Dwi W 337', '56419974337', '3276022304010010337', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243337', 'Kp.Babakan No. 337', 'Islam', 9, 6, '150000.00', 2, 'Sudah', '2022-12-12 03:40:33', NULL, NULL, NULL),
(338, 3, 'P20223338', 'AprilYandi Dwi W 338', '56419974338', '3276022304010010338', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243338', 'Kp.Babakan No. 338', 'Islam', 7, 3, NULL, NULL, 'Gratis', '2022-12-12 03:40:34', NULL, NULL, NULL),
(339, 1, 'P20221339', 'AprilYandi Dwi W 339', '56419974339', '3276022304010010339', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243339', 'Kp.Babakan No. 339', 'Islam', 3, 10, '150000.00', 1, 'Sudah', '2022-12-12 03:40:35', NULL, NULL, NULL),
(340, 2, 'P20222340', 'AprilYandi Dwi W 340', '56419974340', '3276022304010010340', 'Depok', '2001-12-20', 'Perempuan', '08810243340', 'Kp.Babakan No. 340', 'Islam', 1, 7, '150000.00', 2, 'Sudah', '2022-12-12 03:40:35', NULL, NULL, NULL),
(341, 3, 'P20223341', 'AprilYandi Dwi W 341', '56419974341', '3276022304010010341', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243341', 'Kp.Babakan No. 341', 'Islam', 3, 10, NULL, NULL, 'Gratis', '2022-12-12 03:40:35', NULL, NULL, NULL),
(342, 3, 'P20223342', 'AprilYandi Dwi W 342', '56419974342', '3276022304010010342', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243342', 'Kp.Babakan No. 342', 'Islam', 1, 9, NULL, NULL, 'Gratis', '2022-12-12 03:40:36', NULL, NULL, NULL),
(343, 1, 'P20221343', 'AprilYandi Dwi W 343', '56419974343', '3276022304010010343', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243343', 'Kp.Babakan No. 343', 'Islam', 10, 10, '150000.00', 4, 'Belum', '2022-12-12 03:40:36', NULL, NULL, NULL),
(344, 3, 'P20223344', 'AprilYandi Dwi W 344', '56419974344', '3276022304010010344', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243344', 'Kp.Babakan No. 344', 'Islam', 1, 10, NULL, NULL, 'Gratis', '2022-12-12 03:40:37', NULL, NULL, NULL),
(345, 3, 'P20223345', 'AprilYandi Dwi W 345', '56419974345', '3276022304010010345', 'Depok', '2001-12-28', 'Perempuan', '08810243345', 'Kp.Babakan No. 345', 'Islam', 7, 9, NULL, NULL, 'Gratis', '2022-12-12 03:40:37', NULL, NULL, NULL),
(346, 1, 'P20221346', 'AprilYandi Dwi W 346', '56419974346', '3276022304010010346', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243346', 'Kp.Babakan No. 346', 'Islam', 4, 3, '150000.00', 4, 'Sudah', '2022-12-12 03:40:37', NULL, NULL, NULL),
(347, 2, 'P20222347', 'AprilYandi Dwi W 347', '56419974347', '3276022304010010347', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243347', 'Kp.Babakan No. 347', 'Islam', 2, 6, '150000.00', 2, 'Sudah', '2022-12-12 03:40:37', NULL, NULL, NULL),
(348, 2, 'P20222348', 'AprilYandi Dwi W 348', '56419974348', '3276022304010010348', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243348', 'Kp.Babakan No. 348', 'Islam', 11, 6, '150000.00', 2, 'Sudah', '2022-12-12 03:40:37', NULL, NULL, NULL),
(349, 2, 'P20222349', 'AprilYandi Dwi W 349', '56419974349', '3276022304010010349', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243349', 'Kp.Babakan No. 349', 'Islam', 10, 11, '150000.00', 3, 'Sudah', '2022-12-12 03:40:38', NULL, NULL, NULL),
(350, 3, 'P20223350', 'AprilYandi Dwi W 350', '56419974350', '3276022304010010350', 'Depok', '2001-12-07', 'Perempuan', '08810243350', 'Kp.Babakan No. 350', 'Islam', 6, 13, NULL, NULL, 'Belum', '2022-12-12 03:40:38', NULL, NULL, NULL),
(351, 2, 'P20222351', 'AprilYandi Dwi W 351', '56419974351', '3276022304010010351', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243351', 'Kp.Babakan No. 351', 'Islam', 12, 10, '150000.00', 4, 'Sudah', '2022-12-12 03:40:38', NULL, NULL, NULL),
(352, 3, 'P20223352', 'AprilYandi Dwi W 352', '56419974352', '3276022304010010352', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243352', 'Kp.Babakan No. 352', 'Islam', 9, 12, NULL, NULL, 'Gratis', '2022-12-12 03:40:38', NULL, NULL, NULL),
(353, 3, 'P20223353', 'AprilYandi Dwi W 353', '56419974353', '3276022304010010353', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243353', 'Kp.Babakan No. 353', 'Islam', 2, 8, NULL, NULL, 'Gratis', '2022-12-12 03:40:39', NULL, NULL, NULL),
(354, 1, 'P20221354', 'AprilYandi Dwi W 354', '56419974354', '3276022304010010354', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243354', 'Kp.Babakan No. 354', 'Islam', 6, 10, '150000.00', 4, 'Sudah', '2022-12-12 03:40:39', NULL, NULL, NULL),
(355, 3, 'P20223355', 'AprilYandi Dwi W 355', '56419974355', '3276022304010010355', 'Depok', '2001-12-26', 'Perempuan', '08810243355', 'Kp.Babakan No. 355', 'Islam', 4, 1, NULL, NULL, 'Gratis', '2022-12-12 03:40:40', NULL, NULL, NULL),
(356, 3, 'P20223356', 'AprilYandi Dwi W 356', '56419974356', '3276022304010010356', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243356', 'Kp.Babakan No. 356', 'Islam', 12, 3, NULL, NULL, 'Gratis', '2022-12-12 03:40:40', NULL, NULL, NULL),
(357, 3, 'P20223357', 'AprilYandi Dwi W 357', '56419974357', '3276022304010010357', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243357', 'Kp.Babakan No. 357', 'Islam', 11, 2, NULL, NULL, 'Belum', '2022-12-12 03:40:40', NULL, NULL, NULL),
(358, 2, 'P20222358', 'AprilYandi Dwi W 358', '56419974358', '3276022304010010358', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243358', 'Kp.Babakan No. 358', 'Islam', 11, 10, '150000.00', 2, 'Sudah', '2022-12-12 03:40:40', NULL, NULL, NULL),
(359, 3, 'P20223359', 'AprilYandi Dwi W 359', '56419974359', '3276022304010010359', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243359', 'Kp.Babakan No. 359', 'Islam', 9, 9, NULL, NULL, 'Gratis', '2022-12-12 03:40:41', NULL, NULL, NULL),
(360, 3, 'P20223360', 'AprilYandi Dwi W 360', '56419974360', '3276022304010010360', 'Depok', '2001-12-25', 'Perempuan', '08810243360', 'Kp.Babakan No. 360', 'Islam', 2, 4, NULL, NULL, 'Gratis', '2022-12-12 03:40:41', NULL, NULL, NULL),
(361, 1, 'P20221361', 'AprilYandi Dwi W 361', '56419974361', '3276022304010010361', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243361', 'Kp.Babakan No. 361', 'Islam', 5, 3, '150000.00', 1, 'Sudah', '2022-12-12 03:40:41', NULL, NULL, NULL),
(362, 1, 'P20221362', 'AprilYandi Dwi W 362', '56419974362', '3276022304010010362', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243362', 'Kp.Babakan No. 362', 'Islam', 3, 4, '150000.00', 3, 'Sudah', '2022-12-12 03:40:41', NULL, NULL, NULL),
(363, 3, 'P20223363', 'AprilYandi Dwi W 363', '56419974363', '3276022304010010363', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243363', 'Kp.Babakan No. 363', 'Islam', 10, 4, NULL, NULL, 'Gratis', '2022-12-12 03:40:41', NULL, NULL, NULL),
(364, 2, 'P20222364', 'AprilYandi Dwi W 364', '56419974364', '3276022304010010364', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243364', 'Kp.Babakan No. 364', 'Islam', 2, 8, '150000.00', 4, 'Belum', '2022-12-12 03:40:42', NULL, NULL, NULL),
(365, 1, 'P20221365', 'AprilYandi Dwi W 365', '56419974365', '3276022304010010365', 'Depok', '2001-12-22', 'Perempuan', '08810243365', 'Kp.Babakan No. 365', 'Islam', 6, 12, '150000.00', 2, 'Sudah', '2022-12-12 03:40:42', NULL, NULL, NULL),
(366, 2, 'P20222366', 'AprilYandi Dwi W 366', '56419974366', '3276022304010010366', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243366', 'Kp.Babakan No. 366', 'Islam', 13, 11, '150000.00', 1, 'Sudah', '2022-12-12 03:40:42', NULL, NULL, NULL),
(367, 2, 'P20222367', 'AprilYandi Dwi W 367', '56419974367', '3276022304010010367', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243367', 'Kp.Babakan No. 367', 'Islam', 8, 6, '150000.00', 1, 'Sudah', '2022-12-12 03:40:42', NULL, NULL, NULL),
(368, 1, 'P20221368', 'AprilYandi Dwi W 368', '56419974368', '3276022304010010368', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243368', 'Kp.Babakan No. 368', 'Islam', 10, 12, '150000.00', 3, 'Sudah', '2022-12-12 03:40:43', NULL, NULL, NULL),
(369, 3, 'P20223369', 'AprilYandi Dwi W 369', '56419974369', '3276022304010010369', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243369', 'Kp.Babakan No. 369', 'Islam', 8, 2, NULL, NULL, 'Gratis', '2022-12-12 03:40:43', NULL, NULL, NULL),
(370, 3, 'P20223370', 'AprilYandi Dwi W 370', '56419974370', '3276022304010010370', 'Depok', '2001-12-06', 'Perempuan', '08810243370', 'Kp.Babakan No. 370', 'Islam', 11, 10, NULL, NULL, 'Gratis', '2022-12-12 03:40:43', NULL, NULL, NULL),
(371, 2, 'P20222371', 'AprilYandi Dwi W 371', '56419974371', '3276022304010010371', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243371', 'Kp.Babakan No. 371', 'Islam', 9, 9, '150000.00', 2, 'Belum', '2022-12-12 03:40:44', NULL, NULL, NULL),
(372, 3, 'P20223372', 'AprilYandi Dwi W 372', '56419974372', '3276022304010010372', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243372', 'Kp.Babakan No. 372', 'Islam', 9, 3, NULL, NULL, 'Gratis', '2022-12-12 03:40:44', NULL, NULL, NULL),
(373, 1, 'P20221373', 'AprilYandi Dwi W 373', '56419974373', '3276022304010010373', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243373', 'Kp.Babakan No. 373', 'Islam', 7, 7, '150000.00', 3, 'Sudah', '2022-12-12 03:40:44', NULL, NULL, NULL),
(374, 3, 'P20223374', 'AprilYandi Dwi W 374', '56419974374', '3276022304010010374', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243374', 'Kp.Babakan No. 374', 'Islam', 5, 5, NULL, NULL, 'Gratis', '2022-12-12 03:40:44', NULL, NULL, NULL),
(375, 2, 'P20222375', 'AprilYandi Dwi W 375', '56419974375', '3276022304010010375', 'Depok', '2001-12-22', 'Perempuan', '08810243375', 'Kp.Babakan No. 375', 'Islam', 5, 12, '150000.00', 2, 'Sudah', '2022-12-12 03:40:45', NULL, NULL, NULL),
(376, 3, 'P20223376', 'AprilYandi Dwi W 376', '56419974376', '3276022304010010376', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243376', 'Kp.Babakan No. 376', 'Islam', 1, 11, NULL, NULL, 'Gratis', '2022-12-12 03:40:45', NULL, NULL, NULL),
(377, 2, 'P20222377', 'AprilYandi Dwi W 377', '56419974377', '3276022304010010377', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243377', 'Kp.Babakan No. 377', 'Islam', 10, 3, '150000.00', 1, 'Sudah', '2022-12-12 03:40:45', NULL, NULL, NULL),
(378, 3, 'P20223378', 'AprilYandi Dwi W 378', '56419974378', '3276022304010010378', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243378', 'Kp.Babakan No. 378', 'Islam', 12, 8, NULL, NULL, 'Belum', '2022-12-12 03:40:45', NULL, NULL, NULL),
(379, 2, 'P20222379', 'AprilYandi Dwi W 379', '56419974379', '3276022304010010379', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243379', 'Kp.Babakan No. 379', 'Islam', 7, 1, '150000.00', 1, 'Sudah', '2022-12-12 03:40:45', NULL, NULL, NULL),
(380, 3, 'P20223380', 'AprilYandi Dwi W 380', '56419974380', '3276022304010010380', 'Depok', '2001-12-10', 'Perempuan', '08810243380', 'Kp.Babakan No. 380', 'Islam', 7, 4, NULL, NULL, 'Gratis', '2022-12-12 03:40:45', NULL, NULL, NULL),
(381, 3, 'P20223381', 'AprilYandi Dwi W 381', '56419974381', '3276022304010010381', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243381', 'Kp.Babakan No. 381', 'Islam', 12, 11, NULL, NULL, 'Gratis', '2022-12-12 03:40:46', NULL, NULL, NULL),
(382, 3, 'P20223382', 'AprilYandi Dwi W 382', '56419974382', '3276022304010010382', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243382', 'Kp.Babakan No. 382', 'Islam', 11, 3, NULL, NULL, 'Gratis', '2022-12-12 03:40:46', NULL, NULL, NULL),
(383, 1, 'P20221383', 'AprilYandi Dwi W 383', '56419974383', '3276022304010010383', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243383', 'Kp.Babakan No. 383', 'Islam', 13, 7, '150000.00', 3, 'Sudah', '2022-12-12 03:40:46', NULL, NULL, NULL),
(384, 3, 'P20223384', 'AprilYandi Dwi W 384', '56419974384', '3276022304010010384', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243384', 'Kp.Babakan No. 384', 'Islam', 4, 3, NULL, NULL, 'Gratis', '2022-12-12 03:40:46', NULL, NULL, NULL),
(385, 1, 'P20221385', 'AprilYandi Dwi W 385', '56419974385', '3276022304010010385', 'Depok', '2001-12-09', 'Perempuan', '08810243385', 'Kp.Babakan No. 385', 'Islam', 5, 9, '150000.00', 4, 'Belum', '2022-12-12 03:40:46', NULL, NULL, NULL),
(386, 1, 'P20221386', 'AprilYandi Dwi W 386', '56419974386', '3276022304010010386', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243386', 'Kp.Babakan No. 386', 'Islam', 12, 8, '150000.00', 3, 'Sudah', '2022-12-12 03:40:46', NULL, NULL, NULL),
(387, 2, 'P20222387', 'AprilYandi Dwi W 387', '56419974387', '3276022304010010387', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243387', 'Kp.Babakan No. 387', 'Islam', 5, 7, '150000.00', 3, 'Sudah', '2022-12-12 03:40:46', NULL, NULL, NULL),
(388, 1, 'P20221388', 'AprilYandi Dwi W 388', '56419974388', '3276022304010010388', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243388', 'Kp.Babakan No. 388', 'Islam', 3, 12, '150000.00', 2, 'Sudah', '2022-12-12 03:40:46', NULL, NULL, NULL),
(389, 1, 'P20221389', 'AprilYandi Dwi W 389', '56419974389', '3276022304010010389', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243389', 'Kp.Babakan No. 389', 'Islam', 13, 7, '150000.00', 3, 'Sudah', '2022-12-12 03:40:46', NULL, NULL, NULL),
(390, 1, 'P20221390', 'AprilYandi Dwi W 390', '56419974390', '3276022304010010390', 'Depok', '2001-12-12', 'Perempuan', '08810243390', 'Kp.Babakan No. 390', 'Islam', 8, 9, '150000.00', 3, 'Sudah', '2022-12-12 03:40:46', NULL, NULL, NULL),
(391, 1, 'P20221391', 'AprilYandi Dwi W 391', '56419974391', '3276022304010010391', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243391', 'Kp.Babakan No. 391', 'Islam', 9, 2, '150000.00', 3, 'Sudah', '2022-12-12 03:40:46', NULL, NULL, NULL),
(392, 1, 'P20221392', 'AprilYandi Dwi W 392', '56419974392', '3276022304010010392', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243392', 'Kp.Babakan No. 392', 'Islam', 2, 2, '150000.00', 1, 'Belum', '2022-12-12 03:40:46', NULL, NULL, NULL),
(393, 1, 'P20221393', 'AprilYandi Dwi W 393', '56419974393', '3276022304010010393', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243393', 'Kp.Babakan No. 393', 'Islam', 10, 6, '150000.00', 1, 'Sudah', '2022-12-12 03:40:46', NULL, NULL, NULL),
(394, 2, 'P20222394', 'AprilYandi Dwi W 394', '56419974394', '3276022304010010394', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243394', 'Kp.Babakan No. 394', 'Islam', 7, 12, '150000.00', 2, 'Sudah', '2022-12-12 03:40:46', NULL, NULL, NULL),
(395, 3, 'P20223395', 'AprilYandi Dwi W 395', '56419974395', '3276022304010010395', 'Depok', '2001-12-04', 'Perempuan', '08810243395', 'Kp.Babakan No. 395', 'Islam', 8, 13, NULL, NULL, 'Gratis', '2022-12-12 03:40:47', NULL, NULL, NULL),
(396, 1, 'P20221396', 'AprilYandi Dwi W 396', '56419974396', '3276022304010010396', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243396', 'Kp.Babakan No. 396', 'Islam', 2, 10, '150000.00', 3, 'Sudah', '2022-12-12 03:40:47', NULL, NULL, NULL),
(397, 1, 'P20221397', 'AprilYandi Dwi W 397', '56419974397', '3276022304010010397', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243397', 'Kp.Babakan No. 397', 'Islam', 7, 3, '150000.00', 1, 'Sudah', '2022-12-12 03:40:47', NULL, NULL, NULL),
(398, 3, 'P20223398', 'AprilYandi Dwi W 398', '56419974398', '3276022304010010398', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243398', 'Kp.Babakan No. 398', 'Islam', 8, 4, NULL, NULL, 'Gratis', '2022-12-12 03:40:47', NULL, NULL, NULL),
(399, 1, 'P20221399', 'AprilYandi Dwi W 399', '56419974399', '3276022304010010399', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243399', 'Kp.Babakan No. 399', 'Islam', 4, 11, '150000.00', 1, 'Belum', '2022-12-12 03:40:47', NULL, NULL, NULL),
(400, 2, 'P20222400', 'AprilYandi Dwi W 400', '56419974400', '3276022304010010400', 'Depok', '2001-12-17', 'Perempuan', '08810243400', 'Kp.Babakan No. 400', 'Islam', 2, 11, '150000.00', 2, 'Sudah', '2022-12-12 03:40:47', NULL, NULL, NULL),
(401, 3, 'P20223401', 'AprilYandi Dwi W 401', '56419974401', '3276022304010010401', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243401', 'Kp.Babakan No. 401', 'Islam', 6, 7, NULL, NULL, 'Gratis', '2022-12-12 03:40:47', NULL, NULL, NULL),
(402, 1, 'P20221402', 'AprilYandi Dwi W 402', '56419974402', '3276022304010010402', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243402', 'Kp.Babakan No. 402', 'Islam', 10, 12, '150000.00', 3, 'Sudah', '2022-12-12 03:40:47', NULL, NULL, NULL),
(403, 1, 'P20221403', 'AprilYandi Dwi W 403', '56419974403', '3276022304010010403', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243403', 'Kp.Babakan No. 403', 'Islam', 6, 4, '150000.00', 4, 'Sudah', '2022-12-12 03:40:47', NULL, NULL, NULL),
(404, 3, 'P20223404', 'AprilYandi Dwi W 404', '56419974404', '3276022304010010404', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243404', 'Kp.Babakan No. 404', 'Islam', 12, 6, NULL, NULL, 'Gratis', '2022-12-12 03:40:47', NULL, NULL, NULL),
(405, 3, 'P20223405', 'AprilYandi Dwi W 405', '56419974405', '3276022304010010405', 'Depok', '2001-12-25', 'Perempuan', '08810243405', 'Kp.Babakan No. 405', 'Islam', 1, 10, NULL, NULL, 'Gratis', '2022-12-12 03:40:47', NULL, NULL, NULL),
(406, 1, 'P20221406', 'AprilYandi Dwi W 406', '56419974406', '3276022304010010406', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243406', 'Kp.Babakan No. 406', 'Islam', 8, 4, '150000.00', 2, 'Belum', '2022-12-12 03:40:47', NULL, NULL, NULL),
(407, 3, 'P20223407', 'AprilYandi Dwi W 407', '56419974407', '3276022304010010407', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243407', 'Kp.Babakan No. 407', 'Islam', 8, 6, NULL, NULL, 'Gratis', '2022-12-12 03:40:48', NULL, NULL, NULL),
(408, 2, 'P20222408', 'AprilYandi Dwi W 408', '56419974408', '3276022304010010408', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243408', 'Kp.Babakan No. 408', 'Islam', 8, 10, '150000.00', 2, 'Sudah', '2022-12-12 03:40:48', NULL, NULL, NULL),
(409, 1, 'P20221409', 'AprilYandi Dwi W 409', '56419974409', '3276022304010010409', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243409', 'Kp.Babakan No. 409', 'Islam', 5, 10, '150000.00', 3, 'Sudah', '2022-12-12 03:40:48', NULL, NULL, NULL),
(410, 1, 'P20221410', 'AprilYandi Dwi W 410', '56419974410', '3276022304010010410', 'Depok', '2001-12-28', 'Perempuan', '08810243410', 'Kp.Babakan No. 410', 'Islam', 9, 9, '150000.00', 3, 'Sudah', '2022-12-12 03:40:48', NULL, NULL, NULL),
(411, 3, 'P20223411', 'AprilYandi Dwi W 411', '56419974411', '3276022304010010411', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243411', 'Kp.Babakan No. 411', 'Islam', 12, 10, NULL, NULL, 'Gratis', '2022-12-12 03:40:48', NULL, NULL, NULL),
(412, 1, 'P20221412', 'AprilYandi Dwi W 412', '56419974412', '3276022304010010412', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243412', 'Kp.Babakan No. 412', 'Islam', 12, 2, '150000.00', 1, 'Sudah', '2022-12-12 03:40:48', NULL, NULL, NULL),
(413, 3, 'P20223413', 'AprilYandi Dwi W 413', '56419974413', '3276022304010010413', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243413', 'Kp.Babakan No. 413', 'Islam', 1, 7, NULL, NULL, 'Belum', '2022-12-12 03:40:48', NULL, NULL, NULL),
(414, 2, 'P20222414', 'AprilYandi Dwi W 414', '56419974414', '3276022304010010414', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243414', 'Kp.Babakan No. 414', 'Islam', 2, 8, '150000.00', 3, 'Sudah', '2022-12-12 03:40:48', NULL, NULL, NULL),
(415, 3, 'P20223415', 'AprilYandi Dwi W 415', '56419974415', '3276022304010010415', 'Depok', '2001-12-13', 'Perempuan', '08810243415', 'Kp.Babakan No. 415', 'Islam', 12, 6, NULL, NULL, 'Gratis', '2022-12-12 03:40:48', NULL, NULL, NULL),
(416, 1, 'P20221416', 'AprilYandi Dwi W 416', '56419974416', '3276022304010010416', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243416', 'Kp.Babakan No. 416', 'Islam', 6, 6, '150000.00', 3, 'Sudah', '2022-12-12 03:40:48', NULL, NULL, NULL),
(417, 2, 'P20222417', 'AprilYandi Dwi W 417', '56419974417', '3276022304010010417', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243417', 'Kp.Babakan No. 417', 'Islam', 11, 13, '150000.00', 1, 'Sudah', '2022-12-12 03:40:48', NULL, NULL, NULL),
(418, 2, 'P20222418', 'AprilYandi Dwi W 418', '56419974418', '3276022304010010418', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243418', 'Kp.Babakan No. 418', 'Islam', 4, 6, '150000.00', 2, 'Sudah', '2022-12-12 03:40:49', NULL, NULL, NULL),
(419, 1, 'P20221419', 'AprilYandi Dwi W 419', '56419974419', '3276022304010010419', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243419', 'Kp.Babakan No. 419', 'Islam', 13, 7, '150000.00', 2, 'Sudah', '2022-12-12 03:40:49', NULL, NULL, NULL);
INSERT INTO `pendaftar` (`id_pendaftar`, `id_jalur`, `no_pendaftar`, `nama`, `nisn`, `nik`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `no_hp`, `alamat`, `agama`, `id_prodi1`, `id_prodi2`, `nominal_bayar`, `id_bank`, `status_bayar`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(420, 1, 'P20221420', 'AprilYandi Dwi W 420', '56419974420', '3276022304010010420', 'Depok', '2001-12-22', 'Perempuan', '08810243420', 'Kp.Babakan No. 420', 'Islam', 2, 4, '150000.00', 3, 'Belum', '2022-12-12 03:40:49', NULL, NULL, NULL),
(421, 1, 'P20221421', 'AprilYandi Dwi W 421', '56419974421', '3276022304010010421', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243421', 'Kp.Babakan No. 421', 'Islam', 13, 2, '150000.00', 4, 'Sudah', '2022-12-12 03:40:49', NULL, NULL, NULL),
(422, 3, 'P20223422', 'AprilYandi Dwi W 422', '56419974422', '3276022304010010422', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243422', 'Kp.Babakan No. 422', 'Islam', 13, 9, NULL, NULL, 'Gratis', '2022-12-12 03:40:49', NULL, NULL, NULL),
(423, 1, 'P20221423', 'AprilYandi Dwi W 423', '56419974423', '3276022304010010423', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243423', 'Kp.Babakan No. 423', 'Islam', 1, 11, '150000.00', 1, 'Sudah', '2022-12-12 03:40:49', NULL, NULL, NULL),
(424, 3, 'P20223424', 'AprilYandi Dwi W 424', '56419974424', '3276022304010010424', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243424', 'Kp.Babakan No. 424', 'Islam', 11, 8, NULL, NULL, 'Gratis', '2022-12-12 03:40:49', NULL, NULL, NULL),
(425, 1, 'P20221425', 'AprilYandi Dwi W 425', '56419974425', '3276022304010010425', 'Depok', '2001-12-05', 'Perempuan', '08810243425', 'Kp.Babakan No. 425', 'Islam', 5, 5, '150000.00', 3, 'Sudah', '2022-12-12 03:40:49', NULL, NULL, NULL),
(426, 3, 'P20223426', 'AprilYandi Dwi W 426', '56419974426', '3276022304010010426', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243426', 'Kp.Babakan No. 426', 'Islam', 1, 12, NULL, NULL, 'Gratis', '2022-12-12 03:40:49', NULL, NULL, NULL),
(427, 3, 'P20223427', 'AprilYandi Dwi W 427', '56419974427', '3276022304010010427', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243427', 'Kp.Babakan No. 427', 'Islam', 13, 3, NULL, NULL, 'Belum', '2022-12-12 03:40:49', NULL, NULL, NULL),
(428, 1, 'P20221428', 'AprilYandi Dwi W 428', '56419974428', '3276022304010010428', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243428', 'Kp.Babakan No. 428', 'Islam', 5, 11, '150000.00', 4, 'Sudah', '2022-12-12 03:40:49', NULL, NULL, NULL),
(429, 1, 'P20221429', 'AprilYandi Dwi W 429', '56419974429', '3276022304010010429', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243429', 'Kp.Babakan No. 429', 'Islam', 8, 7, '150000.00', 3, 'Sudah', '2022-12-12 03:40:49', NULL, NULL, NULL),
(430, 1, 'P20221430', 'AprilYandi Dwi W 430', '56419974430', '3276022304010010430', 'Depok', '2001-12-02', 'Perempuan', '08810243430', 'Kp.Babakan No. 430', 'Islam', 3, 5, '150000.00', 4, 'Sudah', '2022-12-12 03:40:49', NULL, NULL, NULL),
(431, 3, 'P20223431', 'AprilYandi Dwi W 431', '56419974431', '3276022304010010431', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243431', 'Kp.Babakan No. 431', 'Islam', 7, 13, NULL, NULL, 'Gratis', '2022-12-12 03:40:50', NULL, NULL, NULL),
(432, 2, 'P20222432', 'AprilYandi Dwi W 432', '56419974432', '3276022304010010432', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243432', 'Kp.Babakan No. 432', 'Islam', 4, 8, '150000.00', 2, 'Sudah', '2022-12-12 03:40:50', NULL, NULL, NULL),
(433, 2, 'P20222433', 'AprilYandi Dwi W 433', '56419974433', '3276022304010010433', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243433', 'Kp.Babakan No. 433', 'Islam', 12, 13, '150000.00', 2, 'Sudah', '2022-12-12 03:40:50', NULL, NULL, NULL),
(434, 2, 'P20222434', 'AprilYandi Dwi W 434', '56419974434', '3276022304010010434', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243434', 'Kp.Babakan No. 434', 'Islam', 9, 9, '150000.00', 3, 'Belum', '2022-12-12 03:40:50', NULL, NULL, NULL),
(435, 2, 'P20222435', 'AprilYandi Dwi W 435', '56419974435', '3276022304010010435', 'Depok', '2001-12-08', 'Perempuan', '08810243435', 'Kp.Babakan No. 435', 'Islam', 10, 4, '150000.00', 3, 'Sudah', '2022-12-12 03:40:50', NULL, NULL, NULL),
(436, 2, 'P20222436', 'AprilYandi Dwi W 436', '56419974436', '3276022304010010436', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243436', 'Kp.Babakan No. 436', 'Islam', 2, 2, '150000.00', 1, 'Sudah', '2022-12-12 03:40:50', NULL, NULL, NULL),
(437, 3, 'P20223437', 'AprilYandi Dwi W 437', '56419974437', '3276022304010010437', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243437', 'Kp.Babakan No. 437', 'Islam', 2, 4, NULL, NULL, 'Gratis', '2022-12-12 03:40:50', NULL, NULL, NULL),
(438, 3, 'P20223438', 'AprilYandi Dwi W 438', '56419974438', '3276022304010010438', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243438', 'Kp.Babakan No. 438', 'Islam', 12, 7, NULL, NULL, 'Gratis', '2022-12-12 03:40:50', NULL, NULL, NULL),
(439, 3, 'P20223439', 'AprilYandi Dwi W 439', '56419974439', '3276022304010010439', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243439', 'Kp.Babakan No. 439', 'Islam', 5, 10, NULL, NULL, 'Gratis', '2022-12-12 03:40:50', NULL, NULL, NULL),
(440, 1, 'P20221440', 'AprilYandi Dwi W 440', '56419974440', '3276022304010010440', 'Depok', '2001-12-06', 'Perempuan', '08810243440', 'Kp.Babakan No. 440', 'Islam', 12, 10, '150000.00', 4, 'Sudah', '2022-12-12 03:40:51', NULL, NULL, NULL),
(441, 1, 'P20221441', 'AprilYandi Dwi W 441', '56419974441', '3276022304010010441', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243441', 'Kp.Babakan No. 441', 'Islam', 9, 11, '150000.00', 2, 'Belum', '2022-12-12 03:40:51', NULL, NULL, NULL),
(442, 3, 'P20223442', 'AprilYandi Dwi W 442', '56419974442', '3276022304010010442', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243442', 'Kp.Babakan No. 442', 'Islam', 7, 10, NULL, NULL, 'Gratis', '2022-12-12 03:40:51', NULL, NULL, NULL),
(443, 3, 'P20223443', 'AprilYandi Dwi W 443', '56419974443', '3276022304010010443', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243443', 'Kp.Babakan No. 443', 'Islam', 11, 2, NULL, NULL, 'Gratis', '2022-12-12 03:40:51', NULL, NULL, NULL),
(444, 2, 'P20222444', 'AprilYandi Dwi W 444', '56419974444', '3276022304010010444', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243444', 'Kp.Babakan No. 444', 'Islam', 2, 7, '150000.00', 3, 'Sudah', '2022-12-12 03:40:51', NULL, NULL, NULL),
(445, 2, 'P20222445', 'AprilYandi Dwi W 445', '56419974445', '3276022304010010445', 'Depok', '2001-12-28', 'Perempuan', '08810243445', 'Kp.Babakan No. 445', 'Islam', 1, 7, '150000.00', 2, 'Sudah', '2022-12-12 03:40:51', NULL, NULL, NULL),
(446, 1, 'P20221446', 'AprilYandi Dwi W 446', '56419974446', '3276022304010010446', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243446', 'Kp.Babakan No. 446', 'Islam', 13, 6, '150000.00', 4, 'Sudah', '2022-12-12 03:40:51', NULL, NULL, NULL),
(447, 1, 'P20221447', 'AprilYandi Dwi W 447', '56419974447', '3276022304010010447', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243447', 'Kp.Babakan No. 447', 'Islam', 3, 6, '150000.00', 3, 'Sudah', '2022-12-12 03:40:51', NULL, NULL, NULL),
(448, 2, 'P20222448', 'AprilYandi Dwi W 448', '56419974448', '3276022304010010448', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243448', 'Kp.Babakan No. 448', 'Islam', 7, 7, '150000.00', 2, 'Belum', '2022-12-12 03:40:51', NULL, NULL, NULL),
(449, 3, 'P20223449', 'AprilYandi Dwi W 449', '56419974449', '3276022304010010449', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243449', 'Kp.Babakan No. 449', 'Islam', 10, 10, NULL, NULL, 'Gratis', '2022-12-12 03:40:51', NULL, NULL, NULL),
(450, 3, 'P20223450', 'AprilYandi Dwi W 450', '56419974450', '3276022304010010450', 'Depok', '2001-12-19', 'Perempuan', '08810243450', 'Kp.Babakan No. 450', 'Islam', 2, 1, NULL, NULL, 'Gratis', '2022-12-12 03:40:51', NULL, NULL, NULL),
(451, 1, 'P20221451', 'AprilYandi Dwi W 451', '56419974451', '3276022304010010451', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243451', 'Kp.Babakan No. 451', 'Islam', 9, 3, '150000.00', 3, 'Sudah', '2022-12-12 03:40:51', NULL, NULL, NULL),
(452, 2, 'P20222452', 'AprilYandi Dwi W 452', '56419974452', '3276022304010010452', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243452', 'Kp.Babakan No. 452', 'Islam', 9, 7, '150000.00', 2, 'Sudah', '2022-12-12 03:40:52', NULL, NULL, NULL),
(453, 1, 'P20221453', 'AprilYandi Dwi W 453', '56419974453', '3276022304010010453', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243453', 'Kp.Babakan No. 453', 'Islam', 9, 10, '150000.00', 2, 'Sudah', '2022-12-12 03:40:52', NULL, NULL, NULL),
(454, 2, 'P20222454', 'AprilYandi Dwi W 454', '56419974454', '3276022304010010454', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243454', 'Kp.Babakan No. 454', 'Islam', 13, 1, '150000.00', 3, 'Sudah', '2022-12-12 03:40:52', NULL, NULL, NULL),
(455, 3, 'P20223455', 'AprilYandi Dwi W 455', '56419974455', '3276022304010010455', 'Depok', '2001-12-05', 'Perempuan', '08810243455', 'Kp.Babakan No. 455', 'Islam', 4, 8, NULL, NULL, 'Belum', '2022-12-12 03:40:52', NULL, NULL, NULL),
(456, 1, 'P20221456', 'AprilYandi Dwi W 456', '56419974456', '3276022304010010456', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243456', 'Kp.Babakan No. 456', 'Islam', 9, 10, '150000.00', 1, 'Sudah', '2022-12-12 03:40:52', NULL, NULL, NULL),
(457, 2, 'P20222457', 'AprilYandi Dwi W 457', '56419974457', '3276022304010010457', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243457', 'Kp.Babakan No. 457', 'Islam', 7, 1, '150000.00', 3, 'Sudah', '2022-12-12 03:40:52', NULL, NULL, NULL),
(458, 1, 'P20221458', 'AprilYandi Dwi W 458', '56419974458', '3276022304010010458', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243458', 'Kp.Babakan No. 458', 'Islam', 10, 2, '150000.00', 3, 'Sudah', '2022-12-12 03:40:52', NULL, NULL, NULL),
(459, 1, 'P20221459', 'AprilYandi Dwi W 459', '56419974459', '3276022304010010459', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243459', 'Kp.Babakan No. 459', 'Islam', 6, 6, '150000.00', 4, 'Sudah', '2022-12-12 03:40:52', NULL, NULL, NULL),
(460, 1, 'P20221460', 'AprilYandi Dwi W 460', '56419974460', '3276022304010010460', 'Depok', '2001-12-16', 'Perempuan', '08810243460', 'Kp.Babakan No. 460', 'Islam', 4, 11, '150000.00', 4, 'Sudah', '2022-12-12 03:40:52', NULL, NULL, NULL),
(461, 3, 'P20223461', 'AprilYandi Dwi W 461', '56419974461', '3276022304010010461', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243461', 'Kp.Babakan No. 461', 'Islam', 8, 2, NULL, NULL, 'Gratis', '2022-12-12 03:40:52', NULL, NULL, NULL),
(462, 1, 'P20221462', 'AprilYandi Dwi W 462', '56419974462', '3276022304010010462', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243462', 'Kp.Babakan No. 462', 'Islam', 4, 3, '150000.00', 4, 'Belum', '2022-12-12 03:40:53', NULL, NULL, NULL),
(463, 2, 'P20222463', 'AprilYandi Dwi W 463', '56419974463', '3276022304010010463', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243463', 'Kp.Babakan No. 463', 'Islam', 8, 12, '150000.00', 3, 'Sudah', '2022-12-12 03:40:53', NULL, NULL, NULL),
(464, 1, 'P20221464', 'AprilYandi Dwi W 464', '56419974464', '3276022304010010464', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243464', 'Kp.Babakan No. 464', 'Islam', 10, 11, '150000.00', 2, 'Sudah', '2022-12-12 03:40:53', NULL, NULL, NULL),
(465, 2, 'P20222465', 'AprilYandi Dwi W 465', '56419974465', '3276022304010010465', 'Depok', '2001-12-24', 'Perempuan', '08810243465', 'Kp.Babakan No. 465', 'Islam', 9, 11, '150000.00', 1, 'Sudah', '2022-12-12 03:40:53', NULL, NULL, NULL),
(466, 1, 'P20221466', 'AprilYandi Dwi W 466', '56419974466', '3276022304010010466', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243466', 'Kp.Babakan No. 466', 'Islam', 2, 3, '150000.00', 3, 'Sudah', '2022-12-12 03:40:53', NULL, NULL, NULL),
(467, 2, 'P20222467', 'AprilYandi Dwi W 467', '56419974467', '3276022304010010467', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243467', 'Kp.Babakan No. 467', 'Islam', 13, 7, '150000.00', 1, 'Sudah', '2022-12-12 03:40:53', NULL, NULL, NULL),
(468, 2, 'P20222468', 'AprilYandi Dwi W 468', '56419974468', '3276022304010010468', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243468', 'Kp.Babakan No. 468', 'Islam', 4, 2, '150000.00', 4, 'Sudah', '2022-12-12 03:40:53', NULL, NULL, NULL),
(469, 3, 'P20223469', 'AprilYandi Dwi W 469', '56419974469', '3276022304010010469', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243469', 'Kp.Babakan No. 469', 'Islam', 13, 8, NULL, NULL, 'Belum', '2022-12-12 03:40:53', NULL, NULL, NULL),
(470, 2, 'P20222470', 'AprilYandi Dwi W 470', '56419974470', '3276022304010010470', 'Depok', '2001-12-11', 'Perempuan', '08810243470', 'Kp.Babakan No. 470', 'Islam', 13, 7, '150000.00', 4, 'Sudah', '2022-12-12 03:40:53', NULL, NULL, NULL),
(471, 1, 'P20221471', 'AprilYandi Dwi W 471', '56419974471', '3276022304010010471', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243471', 'Kp.Babakan No. 471', 'Islam', 2, 4, '150000.00', 4, 'Sudah', '2022-12-12 03:40:53', NULL, NULL, NULL),
(472, 2, 'P20222472', 'AprilYandi Dwi W 472', '56419974472', '3276022304010010472', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243472', 'Kp.Babakan No. 472', 'Islam', 6, 11, '150000.00', 4, 'Sudah', '2022-12-12 03:40:53', NULL, NULL, NULL),
(473, 3, 'P20223473', 'AprilYandi Dwi W 473', '56419974473', '3276022304010010473', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243473', 'Kp.Babakan No. 473', 'Islam', 4, 11, NULL, NULL, 'Gratis', '2022-12-12 03:40:53', NULL, NULL, NULL),
(474, 1, 'P20221474', 'AprilYandi Dwi W 474', '56419974474', '3276022304010010474', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243474', 'Kp.Babakan No. 474', 'Islam', 4, 10, '150000.00', 1, 'Sudah', '2022-12-12 03:40:53', NULL, NULL, NULL),
(475, 2, 'P20222475', 'AprilYandi Dwi W 475', '56419974475', '3276022304010010475', 'Depok', '2001-12-14', 'Perempuan', '08810243475', 'Kp.Babakan No. 475', 'Islam', 9, 8, '150000.00', 1, 'Sudah', '2022-12-12 03:40:53', NULL, NULL, NULL),
(476, 3, 'P20223476', 'AprilYandi Dwi W 476', '56419974476', '3276022304010010476', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243476', 'Kp.Babakan No. 476', 'Islam', 11, 2, NULL, NULL, 'Belum', '2022-12-12 03:40:53', NULL, NULL, NULL),
(477, 2, 'P20222477', 'AprilYandi Dwi W 477', '56419974477', '3276022304010010477', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243477', 'Kp.Babakan No. 477', 'Islam', 4, 4, '150000.00', 4, 'Sudah', '2022-12-12 03:40:54', NULL, NULL, NULL),
(478, 1, 'P20221478', 'AprilYandi Dwi W 478', '56419974478', '3276022304010010478', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243478', 'Kp.Babakan No. 478', 'Islam', 8, 7, '150000.00', 2, 'Sudah', '2022-12-12 03:40:54', NULL, NULL, NULL),
(479, 2, 'P20222479', 'AprilYandi Dwi W 479', '56419974479', '3276022304010010479', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243479', 'Kp.Babakan No. 479', 'Islam', 9, 10, '150000.00', 4, 'Sudah', '2022-12-12 03:40:54', NULL, NULL, NULL),
(480, 1, 'P20221480', 'AprilYandi Dwi W 480', '56419974480', '3276022304010010480', 'Depok', '2001-12-24', 'Perempuan', '08810243480', 'Kp.Babakan No. 480', 'Islam', 10, 10, '150000.00', 2, 'Sudah', '2022-12-12 03:40:54', NULL, NULL, NULL),
(481, 1, 'P20221481', 'AprilYandi Dwi W 481', '56419974481', '3276022304010010481', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243481', 'Kp.Babakan No. 481', 'Islam', 9, 12, '150000.00', 4, 'Sudah', '2022-12-12 03:40:54', NULL, NULL, NULL),
(482, 3, 'P20223482', 'AprilYandi Dwi W 482', '56419974482', '3276022304010010482', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243482', 'Kp.Babakan No. 482', 'Islam', 4, 12, NULL, NULL, 'Gratis', '2022-12-12 03:40:54', NULL, NULL, NULL),
(483, 1, 'P20221483', 'AprilYandi Dwi W 483', '56419974483', '3276022304010010483', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243483', 'Kp.Babakan No. 483', 'Islam', 11, 3, '150000.00', 1, 'Belum', '2022-12-12 03:40:54', NULL, NULL, NULL),
(484, 2, 'P20222484', 'AprilYandi Dwi W 484', '56419974484', '3276022304010010484', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243484', 'Kp.Babakan No. 484', 'Islam', 13, 8, '150000.00', 3, 'Sudah', '2022-12-12 03:40:55', NULL, NULL, NULL),
(485, 3, 'P20223485', 'AprilYandi Dwi W 485', '56419974485', '3276022304010010485', 'Depok', '2001-12-07', 'Perempuan', '08810243485', 'Kp.Babakan No. 485', 'Islam', 12, 12, NULL, NULL, 'Gratis', '2022-12-12 03:40:55', NULL, NULL, NULL),
(486, 3, 'P20223486', 'AprilYandi Dwi W 486', '56419974486', '3276022304010010486', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243486', 'Kp.Babakan No. 486', 'Islam', 6, 8, NULL, NULL, 'Gratis', '2022-12-12 03:40:55', NULL, NULL, NULL),
(487, 3, 'P20223487', 'AprilYandi Dwi W 487', '56419974487', '3276022304010010487', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243487', 'Kp.Babakan No. 487', 'Islam', 5, 1, NULL, NULL, 'Gratis', '2022-12-12 03:40:55', NULL, NULL, NULL),
(488, 2, 'P20222488', 'AprilYandi Dwi W 488', '56419974488', '3276022304010010488', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243488', 'Kp.Babakan No. 488', 'Islam', 12, 11, '150000.00', 3, 'Sudah', '2022-12-12 03:40:55', NULL, NULL, NULL),
(489, 3, 'P20223489', 'AprilYandi Dwi W 489', '56419974489', '3276022304010010489', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243489', 'Kp.Babakan No. 489', 'Islam', 13, 13, NULL, NULL, 'Gratis', '2022-12-12 03:40:55', NULL, NULL, NULL),
(490, 1, 'P20221490', 'AprilYandi Dwi W 490', '56419974490', '3276022304010010490', 'Depok', '2001-12-08', 'Perempuan', '08810243490', 'Kp.Babakan No. 490', 'Islam', 4, 4, '150000.00', 3, 'Belum', '2022-12-12 03:40:55', NULL, NULL, NULL),
(491, 2, 'P20222491', 'AprilYandi Dwi W 491', '56419974491', '3276022304010010491', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243491', 'Kp.Babakan No. 491', 'Islam', 10, 10, '150000.00', 4, 'Sudah', '2022-12-12 03:40:55', NULL, NULL, NULL),
(492, 3, 'P20223492', 'AprilYandi Dwi W 492', '56419974492', '3276022304010010492', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243492', 'Kp.Babakan No. 492', 'Islam', 9, 6, NULL, NULL, 'Gratis', '2022-12-12 03:40:55', NULL, NULL, NULL),
(493, 2, 'P20222493', 'AprilYandi Dwi W 493', '56419974493', '3276022304010010493', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243493', 'Kp.Babakan No. 493', 'Islam', 7, 4, '150000.00', 2, 'Sudah', '2022-12-12 03:40:56', NULL, NULL, NULL),
(494, 3, 'P20223494', 'AprilYandi Dwi W 494', '56419974494', '3276022304010010494', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243494', 'Kp.Babakan No. 494', 'Islam', 10, 13, NULL, NULL, 'Gratis', '2022-12-12 03:40:56', NULL, NULL, NULL),
(495, 2, 'P20222495', 'AprilYandi Dwi W 495', '56419974495', '3276022304010010495', 'Depok', '2001-12-05', 'Perempuan', '08810243495', 'Kp.Babakan No. 495', 'Islam', 5, 7, '150000.00', 1, 'Sudah', '2022-12-12 03:40:56', NULL, NULL, NULL),
(496, 3, 'P20223496', 'AprilYandi Dwi W 496', '56419974496', '3276022304010010496', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243496', 'Kp.Babakan No. 496', 'Islam', 12, 13, NULL, NULL, 'Gratis', '2022-12-12 03:40:56', NULL, NULL, NULL),
(497, 2, 'P20222497', 'AprilYandi Dwi W 497', '56419974497', '3276022304010010497', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243497', 'Kp.Babakan No. 497', 'Islam', 6, 7, '150000.00', 3, 'Belum', '2022-12-12 03:40:56', NULL, NULL, NULL),
(498, 2, 'P20222498', 'AprilYandi Dwi W 498', '56419974498', '3276022304010010498', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243498', 'Kp.Babakan No. 498', 'Islam', 13, 7, '150000.00', 1, 'Sudah', '2022-12-12 03:40:56', NULL, NULL, NULL),
(499, 1, 'P20221499', 'AprilYandi Dwi W 499', '56419974499', '3276022304010010499', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243499', 'Kp.Babakan No. 499', 'Islam', 11, 6, '150000.00', 4, 'Sudah', '2022-12-12 03:40:56', NULL, NULL, NULL),
(500, 2, 'P20222500', 'AprilYandi Dwi W 500', '56419974500', '3276022304010010500', 'Depok', '2001-12-27', 'Perempuan', '08810243500', 'Kp.Babakan No. 500', 'Islam', 10, 3, '150000.00', 2, 'Sudah', '2022-12-12 03:40:56', NULL, NULL, NULL),
(501, 3, 'P20223501', 'AprilYandi Dwi W 501', '56419974501', '3276022304010010501', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243501', 'Kp.Babakan No. 501', 'Islam', 8, 13, NULL, NULL, 'Gratis', '2022-12-12 03:40:57', NULL, NULL, NULL),
(502, 1, 'P20221502', 'AprilYandi Dwi W 502', '56419974502', '3276022304010010502', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243502', 'Kp.Babakan No. 502', 'Islam', 2, 3, '150000.00', 4, 'Sudah', '2022-12-12 03:40:57', NULL, NULL, NULL),
(503, 2, 'P20222503', 'AprilYandi Dwi W 503', '56419974503', '3276022304010010503', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243503', 'Kp.Babakan No. 503', 'Islam', 3, 13, '150000.00', 4, 'Sudah', '2022-12-12 03:40:57', NULL, NULL, NULL),
(504, 2, 'P20222504', 'AprilYandi Dwi W 504', '56419974504', '3276022304010010504', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243504', 'Kp.Babakan No. 504', 'Islam', 7, 11, '150000.00', 4, 'Belum', '2022-12-12 03:40:57', NULL, NULL, NULL),
(505, 3, 'P20223505', 'AprilYandi Dwi W 505', '56419974505', '3276022304010010505', 'Depok', '2001-12-07', 'Perempuan', '08810243505', 'Kp.Babakan No. 505', 'Islam', 11, 1, NULL, NULL, 'Gratis', '2022-12-12 03:40:57', NULL, NULL, NULL),
(506, 2, 'P20222506', 'AprilYandi Dwi W 506', '56419974506', '3276022304010010506', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243506', 'Kp.Babakan No. 506', 'Islam', 1, 12, '150000.00', 3, 'Sudah', '2022-12-12 03:40:57', NULL, NULL, NULL),
(507, 2, 'P20222507', 'AprilYandi Dwi W 507', '56419974507', '3276022304010010507', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243507', 'Kp.Babakan No. 507', 'Islam', 12, 5, '150000.00', 4, 'Sudah', '2022-12-12 03:40:57', NULL, NULL, NULL),
(508, 1, 'P20221508', 'AprilYandi Dwi W 508', '56419974508', '3276022304010010508', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243508', 'Kp.Babakan No. 508', 'Islam', 10, 8, '150000.00', 4, 'Sudah', '2022-12-12 03:40:57', NULL, NULL, NULL),
(509, 1, 'P20221509', 'AprilYandi Dwi W 509', '56419974509', '3276022304010010509', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243509', 'Kp.Babakan No. 509', 'Islam', 5, 2, '150000.00', 1, 'Sudah', '2022-12-12 03:40:57', NULL, NULL, NULL),
(510, 1, 'P20221510', 'AprilYandi Dwi W 510', '56419974510', '3276022304010010510', 'Depok', '2001-12-27', 'Perempuan', '08810243510', 'Kp.Babakan No. 510', 'Islam', 12, 4, '150000.00', 4, 'Sudah', '2022-12-12 03:40:57', NULL, NULL, NULL),
(511, 3, 'P20223511', 'AprilYandi Dwi W 511', '56419974511', '3276022304010010511', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243511', 'Kp.Babakan No. 511', 'Islam', 8, 13, NULL, NULL, 'Belum', '2022-12-12 03:40:57', NULL, NULL, NULL),
(512, 2, 'P20222512', 'AprilYandi Dwi W 512', '56419974512', '3276022304010010512', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243512', 'Kp.Babakan No. 512', 'Islam', 1, 3, '150000.00', 3, 'Sudah', '2022-12-12 03:40:58', NULL, NULL, NULL),
(513, 2, 'P20222513', 'AprilYandi Dwi W 513', '56419974513', '3276022304010010513', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243513', 'Kp.Babakan No. 513', 'Islam', 6, 2, '150000.00', 3, 'Sudah', '2022-12-12 03:40:58', NULL, NULL, NULL),
(514, 3, 'P20223514', 'AprilYandi Dwi W 514', '56419974514', '3276022304010010514', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243514', 'Kp.Babakan No. 514', 'Islam', 7, 7, NULL, NULL, 'Gratis', '2022-12-12 03:40:58', NULL, NULL, NULL),
(515, 3, 'P20223515', 'AprilYandi Dwi W 515', '56419974515', '3276022304010010515', 'Depok', '2001-12-25', 'Perempuan', '08810243515', 'Kp.Babakan No. 515', 'Islam', 6, 11, NULL, NULL, 'Gratis', '2022-12-12 03:40:58', NULL, NULL, NULL),
(516, 2, 'P20222516', 'AprilYandi Dwi W 516', '56419974516', '3276022304010010516', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243516', 'Kp.Babakan No. 516', 'Islam', 8, 11, '150000.00', 1, 'Sudah', '2022-12-12 03:40:58', NULL, NULL, NULL),
(517, 3, 'P20223517', 'AprilYandi Dwi W 517', '56419974517', '3276022304010010517', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243517', 'Kp.Babakan No. 517', 'Islam', 5, 2, NULL, NULL, 'Gratis', '2022-12-12 03:40:58', NULL, NULL, NULL),
(518, 3, 'P20223518', 'AprilYandi Dwi W 518', '56419974518', '3276022304010010518', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243518', 'Kp.Babakan No. 518', 'Islam', 8, 13, NULL, NULL, 'Belum', '2022-12-12 03:40:58', NULL, NULL, NULL),
(519, 1, 'P20221519', 'AprilYandi Dwi W 519', '56419974519', '3276022304010010519', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243519', 'Kp.Babakan No. 519', 'Islam', 5, 12, '150000.00', 4, 'Sudah', '2022-12-12 03:40:58', NULL, NULL, NULL),
(520, 1, 'P20221520', 'AprilYandi Dwi W 520', '56419974520', '3276022304010010520', 'Depok', '2001-12-12', 'Perempuan', '08810243520', 'Kp.Babakan No. 520', 'Islam', 8, 5, '150000.00', 2, 'Sudah', '2022-12-12 03:40:58', NULL, NULL, NULL),
(521, 3, 'P20223521', 'AprilYandi Dwi W 521', '56419974521', '3276022304010010521', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243521', 'Kp.Babakan No. 521', 'Islam', 6, 2, NULL, NULL, 'Gratis', '2022-12-12 03:40:58', NULL, NULL, NULL),
(522, 3, 'P20223522', 'AprilYandi Dwi W 522', '56419974522', '3276022304010010522', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243522', 'Kp.Babakan No. 522', 'Islam', 3, 13, NULL, NULL, 'Gratis', '2022-12-12 03:40:59', NULL, NULL, NULL),
(523, 3, 'P20223523', 'AprilYandi Dwi W 523', '56419974523', '3276022304010010523', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243523', 'Kp.Babakan No. 523', 'Islam', 10, 13, NULL, NULL, 'Gratis', '2022-12-12 03:40:59', NULL, NULL, NULL),
(524, 1, 'P20221524', 'AprilYandi Dwi W 524', '56419974524', '3276022304010010524', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243524', 'Kp.Babakan No. 524', 'Islam', 4, 12, '150000.00', 1, 'Sudah', '2022-12-12 03:40:59', NULL, NULL, NULL),
(525, 3, 'P20223525', 'AprilYandi Dwi W 525', '56419974525', '3276022304010010525', 'Depok', '2001-12-28', 'Perempuan', '08810243525', 'Kp.Babakan No. 525', 'Islam', 10, 6, NULL, NULL, 'Belum', '2022-12-12 03:40:59', NULL, NULL, NULL),
(526, 3, 'P20223526', 'AprilYandi Dwi W 526', '56419974526', '3276022304010010526', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243526', 'Kp.Babakan No. 526', 'Islam', 9, 13, NULL, NULL, 'Gratis', '2022-12-12 03:40:59', NULL, NULL, NULL),
(527, 2, 'P20222527', 'AprilYandi Dwi W 527', '56419974527', '3276022304010010527', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243527', 'Kp.Babakan No. 527', 'Islam', 9, 11, '150000.00', 1, 'Sudah', '2022-12-12 03:41:00', NULL, NULL, NULL),
(528, 3, 'P20223528', 'AprilYandi Dwi W 528', '56419974528', '3276022304010010528', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243528', 'Kp.Babakan No. 528', 'Islam', 11, 11, NULL, NULL, 'Gratis', '2022-12-12 03:41:01', NULL, NULL, NULL),
(529, 3, 'P20223529', 'AprilYandi Dwi W 529', '56419974529', '3276022304010010529', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243529', 'Kp.Babakan No. 529', 'Islam', 5, 1, NULL, NULL, 'Gratis', '2022-12-12 03:41:01', NULL, NULL, NULL),
(530, 2, 'P20222530', 'AprilYandi Dwi W 530', '56419974530', '3276022304010010530', 'Depok', '2001-12-30', 'Perempuan', '08810243530', 'Kp.Babakan No. 530', 'Islam', 13, 4, '150000.00', 4, 'Sudah', '2022-12-12 03:41:01', NULL, NULL, NULL),
(531, 3, 'P20223531', 'AprilYandi Dwi W 531', '56419974531', '3276022304010010531', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243531', 'Kp.Babakan No. 531', 'Islam', 9, 10, NULL, NULL, 'Gratis', '2022-12-12 03:41:01', NULL, NULL, NULL),
(532, 1, 'P20221532', 'AprilYandi Dwi W 532', '56419974532', '3276022304010010532', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243532', 'Kp.Babakan No. 532', 'Islam', 12, 9, '150000.00', 1, 'Belum', '2022-12-12 03:41:02', NULL, NULL, NULL),
(533, 1, 'P20221533', 'AprilYandi Dwi W 533', '56419974533', '3276022304010010533', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243533', 'Kp.Babakan No. 533', 'Islam', 1, 8, '150000.00', 3, 'Sudah', '2022-12-12 03:41:02', NULL, NULL, NULL),
(534, 3, 'P20223534', 'AprilYandi Dwi W 534', '56419974534', '3276022304010010534', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243534', 'Kp.Babakan No. 534', 'Islam', 6, 11, NULL, NULL, 'Gratis', '2022-12-12 03:41:02', NULL, NULL, NULL),
(535, 2, 'P20222535', 'AprilYandi Dwi W 535', '56419974535', '3276022304010010535', 'Depok', '2001-12-29', 'Perempuan', '08810243535', 'Kp.Babakan No. 535', 'Islam', 6, 1, '150000.00', 2, 'Sudah', '2022-12-12 03:41:03', NULL, NULL, NULL),
(536, 3, 'P20223536', 'AprilYandi Dwi W 536', '56419974536', '3276022304010010536', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243536', 'Kp.Babakan No. 536', 'Islam', 6, 9, NULL, NULL, 'Gratis', '2022-12-12 03:41:03', NULL, NULL, NULL),
(537, 3, 'P20223537', 'AprilYandi Dwi W 537', '56419974537', '3276022304010010537', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243537', 'Kp.Babakan No. 537', 'Islam', 1, 7, NULL, NULL, 'Gratis', '2022-12-12 03:41:04', NULL, NULL, NULL),
(538, 3, 'P20223538', 'AprilYandi Dwi W 538', '56419974538', '3276022304010010538', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243538', 'Kp.Babakan No. 538', 'Islam', 13, 9, NULL, NULL, 'Gratis', '2022-12-12 03:41:04', NULL, NULL, NULL),
(539, 3, 'P20223539', 'AprilYandi Dwi W 539', '56419974539', '3276022304010010539', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243539', 'Kp.Babakan No. 539', 'Islam', 8, 5, NULL, NULL, 'Belum', '2022-12-12 03:41:04', NULL, NULL, NULL),
(540, 3, 'P20223540', 'AprilYandi Dwi W 540', '56419974540', '3276022304010010540', 'Depok', '2001-12-14', 'Perempuan', '08810243540', 'Kp.Babakan No. 540', 'Islam', 4, 1, NULL, NULL, 'Gratis', '2022-12-12 03:41:05', NULL, NULL, NULL),
(541, 1, 'P20221541', 'AprilYandi Dwi W 541', '56419974541', '3276022304010010541', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243541', 'Kp.Babakan No. 541', 'Islam', 12, 12, '150000.00', 1, 'Sudah', '2022-12-12 03:41:05', NULL, NULL, NULL),
(542, 2, 'P20222542', 'AprilYandi Dwi W 542', '56419974542', '3276022304010010542', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243542', 'Kp.Babakan No. 542', 'Islam', 10, 8, '150000.00', 2, 'Sudah', '2022-12-12 03:41:05', NULL, NULL, NULL),
(543, 2, 'P20222543', 'AprilYandi Dwi W 543', '56419974543', '3276022304010010543', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243543', 'Kp.Babakan No. 543', 'Islam', 3, 1, '150000.00', 3, 'Sudah', '2022-12-12 03:41:05', NULL, NULL, NULL),
(544, 2, 'P20222544', 'AprilYandi Dwi W 544', '56419974544', '3276022304010010544', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243544', 'Kp.Babakan No. 544', 'Islam', 9, 4, '150000.00', 4, 'Sudah', '2022-12-12 03:41:05', NULL, NULL, NULL),
(545, 3, 'P20223545', 'AprilYandi Dwi W 545', '56419974545', '3276022304010010545', 'Depok', '2001-12-30', 'Perempuan', '08810243545', 'Kp.Babakan No. 545', 'Islam', 8, 3, NULL, NULL, 'Gratis', '2022-12-12 03:41:05', NULL, NULL, NULL),
(546, 3, 'P20223546', 'AprilYandi Dwi W 546', '56419974546', '3276022304010010546', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243546', 'Kp.Babakan No. 546', 'Islam', 2, 4, NULL, NULL, 'Belum', '2022-12-12 03:41:06', NULL, NULL, NULL),
(547, 1, 'P20221547', 'AprilYandi Dwi W 547', '56419974547', '3276022304010010547', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243547', 'Kp.Babakan No. 547', 'Islam', 11, 8, '150000.00', 1, 'Sudah', '2022-12-12 03:41:06', NULL, NULL, NULL),
(548, 2, 'P20222548', 'AprilYandi Dwi W 548', '56419974548', '3276022304010010548', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243548', 'Kp.Babakan No. 548', 'Islam', 8, 5, '150000.00', 2, 'Sudah', '2022-12-12 03:41:06', NULL, NULL, NULL),
(549, 3, 'P20223549', 'AprilYandi Dwi W 549', '56419974549', '3276022304010010549', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243549', 'Kp.Babakan No. 549', 'Islam', 7, 7, NULL, NULL, 'Gratis', '2022-12-12 03:41:06', NULL, NULL, NULL),
(550, 2, 'P20222550', 'AprilYandi Dwi W 550', '56419974550', '3276022304010010550', 'Depok', '2001-12-31', 'Perempuan', '08810243550', 'Kp.Babakan No. 550', 'Islam', 7, 3, '150000.00', 2, 'Sudah', '2022-12-12 03:41:06', NULL, NULL, NULL),
(551, 3, 'P20223551', 'AprilYandi Dwi W 551', '56419974551', '3276022304010010551', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243551', 'Kp.Babakan No. 551', 'Islam', 4, 13, NULL, NULL, 'Gratis', '2022-12-12 03:41:06', NULL, NULL, NULL),
(552, 3, 'P20223552', 'AprilYandi Dwi W 552', '56419974552', '3276022304010010552', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243552', 'Kp.Babakan No. 552', 'Islam', 13, 7, NULL, NULL, 'Gratis', '2022-12-12 03:41:06', NULL, NULL, NULL),
(553, 2, 'P20222553', 'AprilYandi Dwi W 553', '56419974553', '3276022304010010553', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243553', 'Kp.Babakan No. 553', 'Islam', 2, 9, '150000.00', 2, 'Belum', '2022-12-12 03:41:06', NULL, NULL, NULL),
(554, 1, 'P20221554', 'AprilYandi Dwi W 554', '56419974554', '3276022304010010554', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243554', 'Kp.Babakan No. 554', 'Islam', 8, 7, '150000.00', 1, 'Sudah', '2022-12-12 03:41:06', NULL, NULL, NULL),
(555, 2, 'P20222555', 'AprilYandi Dwi W 555', '56419974555', '3276022304010010555', 'Depok', '2001-12-16', 'Perempuan', '08810243555', 'Kp.Babakan No. 555', 'Islam', 11, 6, '150000.00', 3, 'Sudah', '2022-12-12 03:41:07', NULL, NULL, NULL),
(556, 1, 'P20221556', 'AprilYandi Dwi W 556', '56419974556', '3276022304010010556', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243556', 'Kp.Babakan No. 556', 'Islam', 10, 3, '150000.00', 4, 'Sudah', '2022-12-12 03:41:07', NULL, NULL, NULL),
(557, 3, 'P20223557', 'AprilYandi Dwi W 557', '56419974557', '3276022304010010557', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243557', 'Kp.Babakan No. 557', 'Islam', 9, 4, NULL, NULL, 'Gratis', '2022-12-12 03:41:07', NULL, NULL, NULL),
(558, 1, 'P20221558', 'AprilYandi Dwi W 558', '56419974558', '3276022304010010558', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243558', 'Kp.Babakan No. 558', 'Islam', 4, 11, '150000.00', 3, 'Sudah', '2022-12-12 03:41:08', NULL, NULL, NULL),
(559, 2, 'P20222559', 'AprilYandi Dwi W 559', '56419974559', '3276022304010010559', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243559', 'Kp.Babakan No. 559', 'Islam', 10, 2, '150000.00', 3, 'Sudah', '2022-12-12 03:41:08', NULL, NULL, NULL),
(560, 3, 'P20223560', 'AprilYandi Dwi W 560', '56419974560', '3276022304010010560', 'Depok', '2001-12-16', 'Perempuan', '08810243560', 'Kp.Babakan No. 560', 'Islam', 9, 1, NULL, NULL, 'Belum', '2022-12-12 03:41:08', NULL, NULL, NULL),
(561, 1, 'P20221561', 'AprilYandi Dwi W 561', '56419974561', '3276022304010010561', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243561', 'Kp.Babakan No. 561', 'Islam', 9, 12, '150000.00', 1, 'Sudah', '2022-12-12 03:41:08', NULL, NULL, NULL),
(562, 1, 'P20221562', 'AprilYandi Dwi W 562', '56419974562', '3276022304010010562', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243562', 'Kp.Babakan No. 562', 'Islam', 1, 2, '150000.00', 4, 'Sudah', '2022-12-12 03:41:08', NULL, NULL, NULL),
(563, 2, 'P20222563', 'AprilYandi Dwi W 563', '56419974563', '3276022304010010563', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243563', 'Kp.Babakan No. 563', 'Islam', 1, 4, '150000.00', 2, 'Sudah', '2022-12-12 03:41:08', NULL, NULL, NULL),
(564, 1, 'P20221564', 'AprilYandi Dwi W 564', '56419974564', '3276022304010010564', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243564', 'Kp.Babakan No. 564', 'Islam', 11, 9, '150000.00', 2, 'Sudah', '2022-12-12 03:41:09', NULL, NULL, NULL),
(565, 2, 'P20222565', 'AprilYandi Dwi W 565', '56419974565', '3276022304010010565', 'Depok', '2001-12-15', 'Perempuan', '08810243565', 'Kp.Babakan No. 565', 'Islam', 10, 2, '150000.00', 1, 'Sudah', '2022-12-12 03:41:09', NULL, NULL, NULL),
(566, 1, 'P20221566', 'AprilYandi Dwi W 566', '56419974566', '3276022304010010566', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243566', 'Kp.Babakan No. 566', 'Islam', 5, 1, '150000.00', 3, 'Sudah', '2022-12-12 03:41:09', NULL, NULL, NULL),
(567, 1, 'P20221567', 'AprilYandi Dwi W 567', '56419974567', '3276022304010010567', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243567', 'Kp.Babakan No. 567', 'Islam', 5, 10, '150000.00', 2, 'Belum', '2022-12-12 03:41:09', NULL, NULL, NULL),
(568, 2, 'P20222568', 'AprilYandi Dwi W 568', '56419974568', '3276022304010010568', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243568', 'Kp.Babakan No. 568', 'Islam', 4, 5, '150000.00', 2, 'Sudah', '2022-12-12 03:41:09', NULL, NULL, NULL),
(569, 1, 'P20221569', 'AprilYandi Dwi W 569', '56419974569', '3276022304010010569', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243569', 'Kp.Babakan No. 569', 'Islam', 10, 10, '150000.00', 2, 'Sudah', '2022-12-12 03:41:09', NULL, NULL, NULL),
(570, 2, 'P20222570', 'AprilYandi Dwi W 570', '56419974570', '3276022304010010570', 'Depok', '2001-12-17', 'Perempuan', '08810243570', 'Kp.Babakan No. 570', 'Islam', 11, 2, '150000.00', 3, 'Sudah', '2022-12-12 03:41:10', NULL, NULL, NULL),
(571, 2, 'P20222571', 'AprilYandi Dwi W 571', '56419974571', '3276022304010010571', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243571', 'Kp.Babakan No. 571', 'Islam', 2, 13, '150000.00', 3, 'Sudah', '2022-12-12 03:41:10', NULL, NULL, NULL),
(572, 3, 'P20223572', 'AprilYandi Dwi W 572', '56419974572', '3276022304010010572', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243572', 'Kp.Babakan No. 572', 'Islam', 13, 9, NULL, NULL, 'Gratis', '2022-12-12 03:41:10', NULL, NULL, NULL),
(573, 3, 'P20223573', 'AprilYandi Dwi W 573', '56419974573', '3276022304010010573', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243573', 'Kp.Babakan No. 573', 'Islam', 2, 7, NULL, NULL, 'Gratis', '2022-12-12 03:41:10', NULL, NULL, NULL),
(574, 2, 'P20222574', 'AprilYandi Dwi W 574', '56419974574', '3276022304010010574', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243574', 'Kp.Babakan No. 574', 'Islam', 8, 10, '150000.00', 2, 'Belum', '2022-12-12 03:41:10', NULL, NULL, NULL),
(575, 1, 'P20221575', 'AprilYandi Dwi W 575', '56419974575', '3276022304010010575', 'Depok', '2001-12-30', 'Perempuan', '08810243575', 'Kp.Babakan No. 575', 'Islam', 3, 11, '150000.00', 3, 'Sudah', '2022-12-12 03:41:10', NULL, NULL, NULL),
(576, 3, 'P20223576', 'AprilYandi Dwi W 576', '56419974576', '3276022304010010576', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243576', 'Kp.Babakan No. 576', 'Islam', 9, 10, NULL, NULL, 'Gratis', '2022-12-12 03:41:10', NULL, NULL, NULL),
(577, 2, 'P20222577', 'AprilYandi Dwi W 577', '56419974577', '3276022304010010577', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243577', 'Kp.Babakan No. 577', 'Islam', 2, 4, '150000.00', 4, 'Sudah', '2022-12-12 03:41:11', NULL, NULL, NULL),
(578, 2, 'P20222578', 'AprilYandi Dwi W 578', '56419974578', '3276022304010010578', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243578', 'Kp.Babakan No. 578', 'Islam', 13, 3, '150000.00', 1, 'Sudah', '2022-12-12 03:41:11', NULL, NULL, NULL),
(579, 1, 'P20221579', 'AprilYandi Dwi W 579', '56419974579', '3276022304010010579', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243579', 'Kp.Babakan No. 579', 'Islam', 10, 7, '150000.00', 3, 'Sudah', '2022-12-12 03:41:11', NULL, NULL, NULL),
(580, 2, 'P20222580', 'AprilYandi Dwi W 580', '56419974580', '3276022304010010580', 'Depok', '2001-12-11', 'Perempuan', '08810243580', 'Kp.Babakan No. 580', 'Islam', 13, 6, '150000.00', 4, 'Sudah', '2022-12-12 03:41:11', NULL, NULL, NULL),
(581, 3, 'P20223581', 'AprilYandi Dwi W 581', '56419974581', '3276022304010010581', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243581', 'Kp.Babakan No. 581', 'Islam', 10, 7, NULL, NULL, 'Belum', '2022-12-12 03:41:11', NULL, NULL, NULL),
(582, 3, 'P20223582', 'AprilYandi Dwi W 582', '56419974582', '3276022304010010582', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243582', 'Kp.Babakan No. 582', 'Islam', 2, 6, NULL, NULL, 'Gratis', '2022-12-12 03:41:11', NULL, NULL, NULL),
(583, 3, 'P20223583', 'AprilYandi Dwi W 583', '56419974583', '3276022304010010583', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243583', 'Kp.Babakan No. 583', 'Islam', 6, 9, NULL, NULL, 'Gratis', '2022-12-12 03:41:11', NULL, NULL, NULL),
(584, 2, 'P20222584', 'AprilYandi Dwi W 584', '56419974584', '3276022304010010584', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243584', 'Kp.Babakan No. 584', 'Islam', 7, 11, '150000.00', 2, 'Sudah', '2022-12-12 03:41:11', NULL, NULL, NULL),
(585, 3, 'P20223585', 'AprilYandi Dwi W 585', '56419974585', '3276022304010010585', 'Depok', '2001-12-08', 'Perempuan', '08810243585', 'Kp.Babakan No. 585', 'Islam', 8, 8, NULL, NULL, 'Gratis', '2022-12-12 03:41:11', NULL, NULL, NULL),
(586, 3, 'P20223586', 'AprilYandi Dwi W 586', '56419974586', '3276022304010010586', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243586', 'Kp.Babakan No. 586', 'Islam', 9, 5, NULL, NULL, 'Gratis', '2022-12-12 03:41:12', NULL, NULL, NULL),
(587, 3, 'P20223587', 'AprilYandi Dwi W 587', '56419974587', '3276022304010010587', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243587', 'Kp.Babakan No. 587', 'Islam', 6, 8, NULL, NULL, 'Gratis', '2022-12-12 03:41:12', NULL, NULL, NULL),
(588, 3, 'P20223588', 'AprilYandi Dwi W 588', '56419974588', '3276022304010010588', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243588', 'Kp.Babakan No. 588', 'Islam', 12, 6, NULL, NULL, 'Belum', '2022-12-12 03:41:12', NULL, NULL, NULL),
(589, 3, 'P20223589', 'AprilYandi Dwi W 589', '56419974589', '3276022304010010589', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243589', 'Kp.Babakan No. 589', 'Islam', 4, 13, NULL, NULL, 'Gratis', '2022-12-12 03:41:12', NULL, NULL, NULL),
(590, 3, 'P20223590', 'AprilYandi Dwi W 590', '56419974590', '3276022304010010590', 'Depok', '2001-12-03', 'Perempuan', '08810243590', 'Kp.Babakan No. 590', 'Islam', 2, 11, NULL, NULL, 'Gratis', '2022-12-12 03:41:12', NULL, NULL, NULL),
(591, 1, 'P20221591', 'AprilYandi Dwi W 591', '56419974591', '3276022304010010591', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243591', 'Kp.Babakan No. 591', 'Islam', 10, 5, '150000.00', 4, 'Sudah', '2022-12-12 03:41:12', NULL, NULL, NULL),
(592, 1, 'P20221592', 'AprilYandi Dwi W 592', '56419974592', '3276022304010010592', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243592', 'Kp.Babakan No. 592', 'Islam', 7, 12, '150000.00', 1, 'Sudah', '2022-12-12 03:41:12', NULL, NULL, NULL),
(593, 1, 'P20221593', 'AprilYandi Dwi W 593', '56419974593', '3276022304010010593', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243593', 'Kp.Babakan No. 593', 'Islam', 10, 9, '150000.00', 4, 'Sudah', '2022-12-12 03:41:13', NULL, NULL, NULL),
(594, 3, 'P20223594', 'AprilYandi Dwi W 594', '56419974594', '3276022304010010594', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243594', 'Kp.Babakan No. 594', 'Islam', 8, 4, NULL, NULL, 'Gratis', '2022-12-12 03:41:13', NULL, NULL, NULL),
(595, 1, 'P20221595', 'AprilYandi Dwi W 595', '56419974595', '3276022304010010595', 'Depok', '2001-12-21', 'Perempuan', '08810243595', 'Kp.Babakan No. 595', 'Islam', 8, 2, '150000.00', 2, 'Belum', '2022-12-12 03:41:13', NULL, NULL, NULL),
(596, 3, 'P20223596', 'AprilYandi Dwi W 596', '56419974596', '3276022304010010596', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243596', 'Kp.Babakan No. 596', 'Islam', 5, 4, NULL, NULL, 'Gratis', '2022-12-12 03:41:13', NULL, NULL, NULL),
(597, 2, 'P20222597', 'AprilYandi Dwi W 597', '56419974597', '3276022304010010597', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243597', 'Kp.Babakan No. 597', 'Islam', 3, 8, '150000.00', 4, 'Sudah', '2022-12-12 03:41:13', NULL, NULL, NULL),
(598, 2, 'P20222598', 'AprilYandi Dwi W 598', '56419974598', '3276022304010010598', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243598', 'Kp.Babakan No. 598', 'Islam', 5, 4, '150000.00', 4, 'Sudah', '2022-12-12 03:41:13', NULL, NULL, NULL),
(599, 3, 'P20223599', 'AprilYandi Dwi W 599', '56419974599', '3276022304010010599', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243599', 'Kp.Babakan No. 599', 'Islam', 11, 5, NULL, NULL, 'Gratis', '2022-12-12 03:41:13', NULL, NULL, NULL),
(600, 2, 'P20222600', 'AprilYandi Dwi W 600', '56419974600', '3276022304010010600', 'Depok', '2001-12-21', 'Perempuan', '08810243600', 'Kp.Babakan No. 600', 'Islam', 12, 1, '150000.00', 4, 'Sudah', '2022-12-12 03:41:13', NULL, NULL, NULL),
(601, 3, 'P20223601', 'AprilYandi Dwi W 601', '56419974601', '3276022304010010601', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243601', 'Kp.Babakan No. 601', 'Islam', 6, 9, NULL, NULL, 'Gratis', '2022-12-12 03:41:14', NULL, NULL, NULL),
(602, 1, 'P20221602', 'AprilYandi Dwi W 602', '56419974602', '3276022304010010602', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243602', 'Kp.Babakan No. 602', 'Islam', 9, 8, '150000.00', 1, 'Belum', '2022-12-12 03:41:14', NULL, NULL, NULL),
(603, 1, 'P20221603', 'AprilYandi Dwi W 603', '56419974603', '3276022304010010603', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243603', 'Kp.Babakan No. 603', 'Islam', 9, 7, '150000.00', 3, 'Sudah', '2022-12-12 03:41:14', NULL, NULL, NULL),
(604, 2, 'P20222604', 'AprilYandi Dwi W 604', '56419974604', '3276022304010010604', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243604', 'Kp.Babakan No. 604', 'Islam', 2, 2, '150000.00', 4, 'Sudah', '2022-12-12 03:41:14', NULL, NULL, NULL),
(605, 1, 'P20221605', 'AprilYandi Dwi W 605', '56419974605', '3276022304010010605', 'Depok', '2001-12-03', 'Perempuan', '08810243605', 'Kp.Babakan No. 605', 'Islam', 1, 13, '150000.00', 4, 'Sudah', '2022-12-12 03:41:14', NULL, NULL, NULL),
(606, 1, 'P20221606', 'AprilYandi Dwi W 606', '56419974606', '3276022304010010606', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243606', 'Kp.Babakan No. 606', 'Islam', 12, 6, '150000.00', 1, 'Sudah', '2022-12-12 03:41:14', NULL, NULL, NULL),
(607, 1, 'P20221607', 'AprilYandi Dwi W 607', '56419974607', '3276022304010010607', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243607', 'Kp.Babakan No. 607', 'Islam', 2, 12, '150000.00', 4, 'Sudah', '2022-12-12 03:41:14', NULL, NULL, NULL),
(608, 2, 'P20222608', 'AprilYandi Dwi W 608', '56419974608', '3276022304010010608', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243608', 'Kp.Babakan No. 608', 'Islam', 13, 2, '150000.00', 2, 'Sudah', '2022-12-12 03:41:14', NULL, NULL, NULL),
(609, 1, 'P20221609', 'AprilYandi Dwi W 609', '56419974609', '3276022304010010609', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243609', 'Kp.Babakan No. 609', 'Islam', 8, 13, '150000.00', 2, 'Belum', '2022-12-12 03:41:15', NULL, NULL, NULL),
(610, 1, 'P20221610', 'AprilYandi Dwi W 610', '56419974610', '3276022304010010610', 'Depok', '2001-12-08', 'Perempuan', '08810243610', 'Kp.Babakan No. 610', 'Islam', 11, 10, '150000.00', 1, 'Sudah', '2022-12-12 03:41:15', NULL, NULL, NULL),
(611, 3, 'P20223611', 'AprilYandi Dwi W 611', '56419974611', '3276022304010010611', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243611', 'Kp.Babakan No. 611', 'Islam', 6, 8, NULL, NULL, 'Gratis', '2022-12-12 03:41:15', NULL, NULL, NULL),
(612, 3, 'P20223612', 'AprilYandi Dwi W 612', '56419974612', '3276022304010010612', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243612', 'Kp.Babakan No. 612', 'Islam', 2, 3, NULL, NULL, 'Gratis', '2022-12-12 03:41:15', NULL, NULL, NULL),
(613, 1, 'P20221613', 'AprilYandi Dwi W 613', '56419974613', '3276022304010010613', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243613', 'Kp.Babakan No. 613', 'Islam', 7, 8, '150000.00', 4, 'Sudah', '2022-12-12 03:41:15', NULL, NULL, NULL),
(614, 1, 'P20221614', 'AprilYandi Dwi W 614', '56419974614', '3276022304010010614', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243614', 'Kp.Babakan No. 614', 'Islam', 6, 7, '150000.00', 1, 'Sudah', '2022-12-12 03:41:15', NULL, NULL, NULL),
(615, 1, 'P20221615', 'AprilYandi Dwi W 615', '56419974615', '3276022304010010615', 'Depok', '2001-12-29', 'Perempuan', '08810243615', 'Kp.Babakan No. 615', 'Islam', 4, 13, '150000.00', 2, 'Sudah', '2022-12-12 03:41:15', NULL, NULL, NULL),
(616, 1, 'P20221616', 'AprilYandi Dwi W 616', '56419974616', '3276022304010010616', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243616', 'Kp.Babakan No. 616', 'Islam', 6, 8, '150000.00', 1, 'Belum', '2022-12-12 03:41:15', NULL, NULL, NULL),
(617, 2, 'P20222617', 'AprilYandi Dwi W 617', '56419974617', '3276022304010010617', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243617', 'Kp.Babakan No. 617', 'Islam', 10, 3, '150000.00', 4, 'Sudah', '2022-12-12 03:41:15', NULL, NULL, NULL),
(618, 1, 'P20221618', 'AprilYandi Dwi W 618', '56419974618', '3276022304010010618', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243618', 'Kp.Babakan No. 618', 'Islam', 8, 1, '150000.00', 4, 'Sudah', '2022-12-12 03:41:15', NULL, NULL, NULL),
(619, 1, 'P20221619', 'AprilYandi Dwi W 619', '56419974619', '3276022304010010619', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243619', 'Kp.Babakan No. 619', 'Islam', 12, 10, '150000.00', 2, 'Sudah', '2022-12-12 03:41:15', NULL, NULL, NULL),
(620, 3, 'P20223620', 'AprilYandi Dwi W 620', '56419974620', '3276022304010010620', 'Depok', '2001-12-20', 'Perempuan', '08810243620', 'Kp.Babakan No. 620', 'Islam', 5, 4, NULL, NULL, 'Gratis', '2022-12-12 03:41:15', NULL, NULL, NULL),
(621, 2, 'P20222621', 'AprilYandi Dwi W 621', '56419974621', '3276022304010010621', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243621', 'Kp.Babakan No. 621', 'Islam', 3, 1, '150000.00', 3, 'Sudah', '2022-12-12 03:41:16', NULL, NULL, NULL),
(622, 1, 'P20221622', 'AprilYandi Dwi W 622', '56419974622', '3276022304010010622', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243622', 'Kp.Babakan No. 622', 'Islam', 13, 8, '150000.00', 4, 'Sudah', '2022-12-12 03:41:16', NULL, NULL, NULL),
(623, 3, 'P20223623', 'AprilYandi Dwi W 623', '56419974623', '3276022304010010623', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243623', 'Kp.Babakan No. 623', 'Islam', 11, 10, NULL, NULL, 'Belum', '2022-12-12 03:41:16', NULL, NULL, NULL),
(624, 1, 'P20221624', 'AprilYandi Dwi W 624', '56419974624', '3276022304010010624', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243624', 'Kp.Babakan No. 624', 'Islam', 7, 3, '150000.00', 4, 'Sudah', '2022-12-12 03:41:16', NULL, NULL, NULL),
(625, 3, 'P20223625', 'AprilYandi Dwi W 625', '56419974625', '3276022304010010625', 'Depok', '2001-12-17', 'Perempuan', '08810243625', 'Kp.Babakan No. 625', 'Islam', 6, 11, NULL, NULL, 'Gratis', '2022-12-12 03:41:16', NULL, NULL, NULL),
(626, 3, 'P20223626', 'AprilYandi Dwi W 626', '56419974626', '3276022304010010626', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243626', 'Kp.Babakan No. 626', 'Islam', 7, 3, NULL, NULL, 'Gratis', '2022-12-12 03:41:16', NULL, NULL, NULL),
(627, 1, 'P20221627', 'AprilYandi Dwi W 627', '56419974627', '3276022304010010627', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243627', 'Kp.Babakan No. 627', 'Islam', 12, 13, '150000.00', 3, 'Sudah', '2022-12-12 03:41:16', NULL, NULL, NULL);
INSERT INTO `pendaftar` (`id_pendaftar`, `id_jalur`, `no_pendaftar`, `nama`, `nisn`, `nik`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `no_hp`, `alamat`, `agama`, `id_prodi1`, `id_prodi2`, `nominal_bayar`, `id_bank`, `status_bayar`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(628, 1, 'P20221628', 'AprilYandi Dwi W 628', '56419974628', '3276022304010010628', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243628', 'Kp.Babakan No. 628', 'Islam', 7, 4, '150000.00', 2, 'Sudah', '2022-12-12 03:41:16', NULL, NULL, NULL),
(629, 2, 'P20222629', 'AprilYandi Dwi W 629', '56419974629', '3276022304010010629', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243629', 'Kp.Babakan No. 629', 'Islam', 2, 5, '150000.00', 4, 'Sudah', '2022-12-12 03:41:16', NULL, NULL, NULL),
(630, 2, 'P20222630', 'AprilYandi Dwi W 630', '56419974630', '3276022304010010630', 'Depok', '2001-12-18', 'Perempuan', '08810243630', 'Kp.Babakan No. 630', 'Islam', 5, 7, '150000.00', 3, 'Belum', '2022-12-12 03:41:16', NULL, NULL, NULL),
(631, 1, 'P20221631', 'AprilYandi Dwi W 631', '56419974631', '3276022304010010631', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243631', 'Kp.Babakan No. 631', 'Islam', 8, 4, '150000.00', 1, 'Sudah', '2022-12-12 03:41:16', NULL, NULL, NULL),
(632, 3, 'P20223632', 'AprilYandi Dwi W 632', '56419974632', '3276022304010010632', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243632', 'Kp.Babakan No. 632', 'Islam', 11, 6, NULL, NULL, 'Gratis', '2022-12-12 03:41:17', NULL, NULL, NULL),
(633, 3, 'P20223633', 'AprilYandi Dwi W 633', '56419974633', '3276022304010010633', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243633', 'Kp.Babakan No. 633', 'Islam', 12, 5, NULL, NULL, 'Gratis', '2022-12-12 03:41:17', NULL, NULL, NULL),
(634, 3, 'P20223634', 'AprilYandi Dwi W 634', '56419974634', '3276022304010010634', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243634', 'Kp.Babakan No. 634', 'Islam', 4, 4, NULL, NULL, 'Gratis', '2022-12-12 03:41:17', NULL, NULL, NULL),
(635, 2, 'P20222635', 'AprilYandi Dwi W 635', '56419974635', '3276022304010010635', 'Depok', '2001-12-18', 'Perempuan', '08810243635', 'Kp.Babakan No. 635', 'Islam', 3, 7, '150000.00', 2, 'Sudah', '2022-12-12 03:41:17', NULL, NULL, NULL),
(636, 3, 'P20223636', 'AprilYandi Dwi W 636', '56419974636', '3276022304010010636', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243636', 'Kp.Babakan No. 636', 'Islam', 10, 4, NULL, NULL, 'Gratis', '2022-12-12 03:41:17', NULL, NULL, NULL),
(637, 2, 'P20222637', 'AprilYandi Dwi W 637', '56419974637', '3276022304010010637', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243637', 'Kp.Babakan No. 637', 'Islam', 2, 3, '150000.00', 2, 'Belum', '2022-12-12 03:41:17', NULL, NULL, NULL),
(638, 2, 'P20222638', 'AprilYandi Dwi W 638', '56419974638', '3276022304010010638', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243638', 'Kp.Babakan No. 638', 'Islam', 7, 6, '150000.00', 4, 'Sudah', '2022-12-12 03:41:17', NULL, NULL, NULL),
(639, 2, 'P20222639', 'AprilYandi Dwi W 639', '56419974639', '3276022304010010639', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243639', 'Kp.Babakan No. 639', 'Islam', 12, 12, '150000.00', 3, 'Sudah', '2022-12-12 03:41:17', NULL, NULL, NULL),
(640, 1, 'P20221640', 'AprilYandi Dwi W 640', '56419974640', '3276022304010010640', 'Depok', '2001-12-16', 'Perempuan', '08810243640', 'Kp.Babakan No. 640', 'Islam', 2, 13, '150000.00', 1, 'Sudah', '2022-12-12 03:41:17', NULL, NULL, NULL),
(641, 1, 'P20221641', 'AprilYandi Dwi W 641', '56419974641', '3276022304010010641', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243641', 'Kp.Babakan No. 641', 'Islam', 5, 2, '150000.00', 3, 'Sudah', '2022-12-12 03:41:17', NULL, NULL, NULL),
(642, 1, 'P20221642', 'AprilYandi Dwi W 642', '56419974642', '3276022304010010642', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243642', 'Kp.Babakan No. 642', 'Islam', 13, 7, '150000.00', 1, 'Sudah', '2022-12-12 03:41:17', NULL, NULL, NULL),
(643, 2, 'P20222643', 'AprilYandi Dwi W 643', '56419974643', '3276022304010010643', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243643', 'Kp.Babakan No. 643', 'Islam', 2, 2, '150000.00', 2, 'Sudah', '2022-12-12 03:41:17', NULL, NULL, NULL),
(644, 3, 'P20223644', 'AprilYandi Dwi W 644', '56419974644', '3276022304010010644', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243644', 'Kp.Babakan No. 644', 'Islam', 8, 12, NULL, NULL, 'Belum', '2022-12-12 03:41:18', NULL, NULL, NULL),
(645, 1, 'P20221645', 'AprilYandi Dwi W 645', '56419974645', '3276022304010010645', 'Depok', '2001-12-10', 'Perempuan', '08810243645', 'Kp.Babakan No. 645', 'Islam', 4, 11, '150000.00', 1, 'Sudah', '2022-12-12 03:41:18', NULL, NULL, NULL),
(646, 1, 'P20221646', 'AprilYandi Dwi W 646', '56419974646', '3276022304010010646', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243646', 'Kp.Babakan No. 646', 'Islam', 3, 1, '150000.00', 4, 'Sudah', '2022-12-12 03:41:18', NULL, NULL, NULL),
(647, 3, 'P20223647', 'AprilYandi Dwi W 647', '56419974647', '3276022304010010647', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243647', 'Kp.Babakan No. 647', 'Islam', 10, 1, NULL, NULL, 'Gratis', '2022-12-12 03:41:18', NULL, NULL, NULL),
(648, 1, 'P20221648', 'AprilYandi Dwi W 648', '56419974648', '3276022304010010648', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243648', 'Kp.Babakan No. 648', 'Islam', 4, 4, '150000.00', 4, 'Sudah', '2022-12-12 03:41:18', NULL, NULL, NULL),
(649, 3, 'P20223649', 'AprilYandi Dwi W 649', '56419974649', '3276022304010010649', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243649', 'Kp.Babakan No. 649', 'Islam', 13, 6, NULL, NULL, 'Gratis', '2022-12-12 03:41:18', NULL, NULL, NULL),
(650, 1, 'P20221650', 'AprilYandi Dwi W 650', '56419974650', '3276022304010010650', 'Depok', '2001-12-21', 'Perempuan', '08810243650', 'Kp.Babakan No. 650', 'Islam', 13, 8, '150000.00', 3, 'Sudah', '2022-12-12 03:41:19', NULL, NULL, NULL),
(651, 2, 'P20222651', 'AprilYandi Dwi W 651', '56419974651', '3276022304010010651', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243651', 'Kp.Babakan No. 651', 'Islam', 5, 2, '150000.00', 3, 'Belum', '2022-12-12 03:41:19', NULL, NULL, NULL),
(652, 1, 'P20221652', 'AprilYandi Dwi W 652', '56419974652', '3276022304010010652', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243652', 'Kp.Babakan No. 652', 'Islam', 7, 2, '150000.00', 3, 'Sudah', '2022-12-12 03:41:19', NULL, NULL, NULL),
(653, 3, 'P20223653', 'AprilYandi Dwi W 653', '56419974653', '3276022304010010653', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243653', 'Kp.Babakan No. 653', 'Islam', 6, 10, NULL, NULL, 'Gratis', '2022-12-12 03:41:19', NULL, NULL, NULL),
(654, 2, 'P20222654', 'AprilYandi Dwi W 654', '56419974654', '3276022304010010654', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243654', 'Kp.Babakan No. 654', 'Islam', 10, 3, '150000.00', 4, 'Sudah', '2022-12-12 03:41:19', NULL, NULL, NULL),
(655, 3, 'P20223655', 'AprilYandi Dwi W 655', '56419974655', '3276022304010010655', 'Depok', '2001-12-10', 'Perempuan', '08810243655', 'Kp.Babakan No. 655', 'Islam', 12, 7, NULL, NULL, 'Gratis', '2022-12-12 03:41:19', NULL, NULL, NULL),
(656, 1, 'P20221656', 'AprilYandi Dwi W 656', '56419974656', '3276022304010010656', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243656', 'Kp.Babakan No. 656', 'Islam', 7, 8, '150000.00', 1, 'Sudah', '2022-12-12 03:41:19', NULL, NULL, NULL),
(657, 3, 'P20223657', 'AprilYandi Dwi W 657', '56419974657', '3276022304010010657', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243657', 'Kp.Babakan No. 657', 'Islam', 1, 5, NULL, NULL, 'Gratis', '2022-12-12 03:41:19', NULL, NULL, NULL),
(658, 3, 'P20223658', 'AprilYandi Dwi W 658', '56419974658', '3276022304010010658', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243658', 'Kp.Babakan No. 658', 'Islam', 12, 3, NULL, NULL, 'Belum', '2022-12-12 03:41:19', NULL, NULL, NULL),
(659, 2, 'P20222659', 'AprilYandi Dwi W 659', '56419974659', '3276022304010010659', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243659', 'Kp.Babakan No. 659', 'Islam', 3, 3, '150000.00', 1, 'Sudah', '2022-12-12 03:41:19', NULL, NULL, NULL),
(660, 2, 'P20222660', 'AprilYandi Dwi W 660', '56419974660', '3276022304010010660', 'Depok', '2001-12-22', 'Perempuan', '08810243660', 'Kp.Babakan No. 660', 'Islam', 6, 8, '150000.00', 3, 'Sudah', '2022-12-12 03:41:19', NULL, NULL, NULL),
(661, 2, 'P20222661', 'AprilYandi Dwi W 661', '56419974661', '3276022304010010661', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243661', 'Kp.Babakan No. 661', 'Islam', 13, 2, '150000.00', 3, 'Sudah', '2022-12-12 03:41:20', NULL, NULL, NULL),
(662, 2, 'P20222662', 'AprilYandi Dwi W 662', '56419974662', '3276022304010010662', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243662', 'Kp.Babakan No. 662', 'Islam', 8, 11, '150000.00', 1, 'Sudah', '2022-12-12 03:41:20', NULL, NULL, NULL),
(663, 3, 'P20223663', 'AprilYandi Dwi W 663', '56419974663', '3276022304010010663', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243663', 'Kp.Babakan No. 663', 'Islam', 3, 1, NULL, NULL, 'Gratis', '2022-12-12 03:41:20', NULL, NULL, NULL),
(664, 2, 'P20222664', 'AprilYandi Dwi W 664', '56419974664', '3276022304010010664', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243664', 'Kp.Babakan No. 664', 'Islam', 11, 2, '150000.00', 3, 'Sudah', '2022-12-12 03:41:20', NULL, NULL, NULL),
(665, 2, 'P20222665', 'AprilYandi Dwi W 665', '56419974665', '3276022304010010665', 'Depok', '2001-12-28', 'Perempuan', '08810243665', 'Kp.Babakan No. 665', 'Islam', 2, 6, '150000.00', 2, 'Belum', '2022-12-12 03:41:20', NULL, NULL, NULL),
(666, 3, 'P20223666', 'AprilYandi Dwi W 666', '56419974666', '3276022304010010666', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243666', 'Kp.Babakan No. 666', 'Islam', 1, 8, NULL, NULL, 'Gratis', '2022-12-12 03:41:20', NULL, NULL, NULL),
(667, 3, 'P20223667', 'AprilYandi Dwi W 667', '56419974667', '3276022304010010667', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243667', 'Kp.Babakan No. 667', 'Islam', 10, 6, NULL, NULL, 'Gratis', '2022-12-12 03:41:20', NULL, NULL, NULL),
(668, 3, 'P20223668', 'AprilYandi Dwi W 668', '56419974668', '3276022304010010668', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243668', 'Kp.Babakan No. 668', 'Islam', 6, 9, NULL, NULL, 'Gratis', '2022-12-12 03:41:20', NULL, NULL, NULL),
(669, 3, 'P20223669', 'AprilYandi Dwi W 669', '56419974669', '3276022304010010669', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243669', 'Kp.Babakan No. 669', 'Islam', 13, 2, NULL, NULL, 'Gratis', '2022-12-12 03:41:20', NULL, NULL, NULL),
(670, 3, 'P20223670', 'AprilYandi Dwi W 670', '56419974670', '3276022304010010670', 'Depok', '2001-12-21', 'Perempuan', '08810243670', 'Kp.Babakan No. 670', 'Islam', 4, 13, NULL, NULL, 'Gratis', '2022-12-12 03:41:20', NULL, NULL, NULL),
(671, 3, 'P20223671', 'AprilYandi Dwi W 671', '56419974671', '3276022304010010671', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243671', 'Kp.Babakan No. 671', 'Islam', 9, 12, NULL, NULL, 'Gratis', '2022-12-12 03:41:20', NULL, NULL, NULL),
(672, 3, 'P20223672', 'AprilYandi Dwi W 672', '56419974672', '3276022304010010672', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243672', 'Kp.Babakan No. 672', 'Islam', 7, 5, NULL, NULL, 'Belum', '2022-12-12 03:41:20', NULL, NULL, NULL),
(673, 3, 'P20223673', 'AprilYandi Dwi W 673', '56419974673', '3276022304010010673', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243673', 'Kp.Babakan No. 673', 'Islam', 7, 4, NULL, NULL, 'Gratis', '2022-12-12 03:41:21', NULL, NULL, NULL),
(674, 2, 'P20222674', 'AprilYandi Dwi W 674', '56419974674', '3276022304010010674', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243674', 'Kp.Babakan No. 674', 'Islam', 3, 3, '150000.00', 2, 'Sudah', '2022-12-12 03:41:21', NULL, NULL, NULL),
(675, 2, 'P20222675', 'AprilYandi Dwi W 675', '56419974675', '3276022304010010675', 'Depok', '2001-12-19', 'Perempuan', '08810243675', 'Kp.Babakan No. 675', 'Islam', 4, 2, '150000.00', 2, 'Sudah', '2022-12-12 03:41:21', NULL, NULL, NULL),
(676, 2, 'P20222676', 'AprilYandi Dwi W 676', '56419974676', '3276022304010010676', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243676', 'Kp.Babakan No. 676', 'Islam', 3, 4, '150000.00', 2, 'Sudah', '2022-12-12 03:41:21', NULL, NULL, NULL),
(677, 1, 'P20221677', 'AprilYandi Dwi W 677', '56419974677', '3276022304010010677', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243677', 'Kp.Babakan No. 677', 'Islam', 6, 2, '150000.00', 1, 'Sudah', '2022-12-12 03:41:21', NULL, NULL, NULL),
(678, 3, 'P20223678', 'AprilYandi Dwi W 678', '56419974678', '3276022304010010678', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243678', 'Kp.Babakan No. 678', 'Islam', 6, 9, NULL, NULL, 'Gratis', '2022-12-12 03:41:21', NULL, NULL, NULL),
(679, 1, 'P20221679', 'AprilYandi Dwi W 679', '56419974679', '3276022304010010679', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243679', 'Kp.Babakan No. 679', 'Islam', 12, 1, '150000.00', 4, 'Belum', '2022-12-12 03:41:21', NULL, NULL, NULL),
(680, 3, 'P20223680', 'AprilYandi Dwi W 680', '56419974680', '3276022304010010680', 'Depok', '2001-12-04', 'Perempuan', '08810243680', 'Kp.Babakan No. 680', 'Islam', 6, 1, NULL, NULL, 'Gratis', '2022-12-12 03:41:21', NULL, NULL, NULL),
(681, 1, 'P20221681', 'AprilYandi Dwi W 681', '56419974681', '3276022304010010681', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243681', 'Kp.Babakan No. 681', 'Islam', 5, 7, '150000.00', 3, 'Sudah', '2022-12-12 03:41:21', NULL, NULL, NULL),
(682, 1, 'P20221682', 'AprilYandi Dwi W 682', '56419974682', '3276022304010010682', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243682', 'Kp.Babakan No. 682', 'Islam', 12, 13, '150000.00', 2, 'Sudah', '2022-12-12 03:41:21', NULL, NULL, NULL),
(683, 1, 'P20221683', 'AprilYandi Dwi W 683', '56419974683', '3276022304010010683', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243683', 'Kp.Babakan No. 683', 'Islam', 13, 5, '150000.00', 4, 'Sudah', '2022-12-12 03:41:21', NULL, NULL, NULL),
(684, 3, 'P20223684', 'AprilYandi Dwi W 684', '56419974684', '3276022304010010684', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243684', 'Kp.Babakan No. 684', 'Islam', 7, 3, NULL, NULL, 'Gratis', '2022-12-12 03:41:21', NULL, NULL, NULL),
(685, 2, 'P20222685', 'AprilYandi Dwi W 685', '56419974685', '3276022304010010685', 'Depok', '2001-12-16', 'Perempuan', '08810243685', 'Kp.Babakan No. 685', 'Islam', 4, 4, '150000.00', 2, 'Sudah', '2022-12-12 03:41:22', NULL, NULL, NULL),
(686, 3, 'P20223686', 'AprilYandi Dwi W 686', '56419974686', '3276022304010010686', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243686', 'Kp.Babakan No. 686', 'Islam', 9, 2, NULL, NULL, 'Belum', '2022-12-12 03:41:22', NULL, NULL, NULL),
(687, 2, 'P20222687', 'AprilYandi Dwi W 687', '56419974687', '3276022304010010687', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243687', 'Kp.Babakan No. 687', 'Islam', 7, 12, '150000.00', 1, 'Sudah', '2022-12-12 03:41:22', NULL, NULL, NULL),
(688, 3, 'P20223688', 'AprilYandi Dwi W 688', '56419974688', '3276022304010010688', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243688', 'Kp.Babakan No. 688', 'Islam', 12, 1, NULL, NULL, 'Gratis', '2022-12-12 03:41:22', NULL, NULL, NULL),
(689, 2, 'P20222689', 'AprilYandi Dwi W 689', '56419974689', '3276022304010010689', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243689', 'Kp.Babakan No. 689', 'Islam', 10, 4, '150000.00', 4, 'Sudah', '2022-12-12 03:41:23', NULL, NULL, NULL),
(690, 2, 'P20222690', 'AprilYandi Dwi W 690', '56419974690', '3276022304010010690', 'Depok', '2001-12-11', 'Perempuan', '08810243690', 'Kp.Babakan No. 690', 'Islam', 9, 13, '150000.00', 1, 'Sudah', '2022-12-12 03:41:23', NULL, NULL, NULL),
(691, 1, 'P20221691', 'AprilYandi Dwi W 691', '56419974691', '3276022304010010691', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243691', 'Kp.Babakan No. 691', 'Islam', 7, 5, '150000.00', 3, 'Sudah', '2022-12-12 03:41:23', NULL, NULL, NULL),
(692, 2, 'P20222692', 'AprilYandi Dwi W 692', '56419974692', '3276022304010010692', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243692', 'Kp.Babakan No. 692', 'Islam', 11, 8, '150000.00', 2, 'Sudah', '2022-12-12 03:41:23', NULL, NULL, NULL),
(693, 1, 'P20221693', 'AprilYandi Dwi W 693', '56419974693', '3276022304010010693', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243693', 'Kp.Babakan No. 693', 'Islam', 3, 6, '150000.00', 1, 'Belum', '2022-12-12 03:41:23', NULL, NULL, NULL),
(694, 1, 'P20221694', 'AprilYandi Dwi W 694', '56419974694', '3276022304010010694', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243694', 'Kp.Babakan No. 694', 'Islam', 9, 11, '150000.00', 1, 'Sudah', '2022-12-12 03:41:23', NULL, NULL, NULL),
(695, 3, 'P20223695', 'AprilYandi Dwi W 695', '56419974695', '3276022304010010695', 'Depok', '2001-12-31', 'Perempuan', '08810243695', 'Kp.Babakan No. 695', 'Islam', 4, 9, NULL, NULL, 'Gratis', '2022-12-12 03:41:24', NULL, NULL, NULL),
(696, 1, 'P20221696', 'AprilYandi Dwi W 696', '56419974696', '3276022304010010696', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243696', 'Kp.Babakan No. 696', 'Islam', 12, 3, '150000.00', 3, 'Sudah', '2022-12-12 03:41:24', NULL, NULL, NULL),
(697, 2, 'P20222697', 'AprilYandi Dwi W 697', '56419974697', '3276022304010010697', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243697', 'Kp.Babakan No. 697', 'Islam', 6, 7, '150000.00', 1, 'Sudah', '2022-12-12 03:41:24', NULL, NULL, NULL),
(698, 1, 'P20221698', 'AprilYandi Dwi W 698', '56419974698', '3276022304010010698', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243698', 'Kp.Babakan No. 698', 'Islam', 11, 1, '150000.00', 3, 'Sudah', '2022-12-12 03:41:24', NULL, NULL, NULL),
(699, 2, 'P20222699', 'AprilYandi Dwi W 699', '56419974699', '3276022304010010699', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243699', 'Kp.Babakan No. 699', 'Islam', 7, 5, '150000.00', 1, 'Sudah', '2022-12-12 03:41:24', NULL, NULL, NULL),
(700, 3, 'P20223700', 'AprilYandi Dwi W 700', '56419974700', '3276022304010010700', 'Depok', '2001-12-15', 'Perempuan', '08810243700', 'Kp.Babakan No. 700', 'Islam', 7, 9, NULL, NULL, 'Belum', '2022-12-12 03:41:25', NULL, NULL, NULL),
(701, 1, 'P20221701', 'AprilYandi Dwi W 701', '56419974701', '3276022304010010701', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243701', 'Kp.Babakan No. 701', 'Islam', 4, 11, '150000.00', 4, 'Sudah', '2022-12-12 03:41:25', NULL, NULL, NULL),
(702, 1, 'P20221702', 'AprilYandi Dwi W 702', '56419974702', '3276022304010010702', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243702', 'Kp.Babakan No. 702', 'Islam', 1, 13, '150000.00', 3, 'Sudah', '2022-12-12 03:41:25', NULL, NULL, NULL),
(703, 3, 'P20223703', 'AprilYandi Dwi W 703', '56419974703', '3276022304010010703', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243703', 'Kp.Babakan No. 703', 'Islam', 5, 13, NULL, NULL, 'Gratis', '2022-12-12 03:41:25', NULL, NULL, NULL),
(704, 3, 'P20223704', 'AprilYandi Dwi W 704', '56419974704', '3276022304010010704', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243704', 'Kp.Babakan No. 704', 'Islam', 2, 10, NULL, NULL, 'Gratis', '2022-12-12 03:41:25', NULL, NULL, NULL),
(705, 2, 'P20222705', 'AprilYandi Dwi W 705', '56419974705', '3276022304010010705', 'Depok', '2001-12-04', 'Perempuan', '08810243705', 'Kp.Babakan No. 705', 'Islam', 12, 2, '150000.00', 4, 'Sudah', '2022-12-12 03:41:25', NULL, NULL, NULL),
(706, 1, 'P20221706', 'AprilYandi Dwi W 706', '56419974706', '3276022304010010706', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243706', 'Kp.Babakan No. 706', 'Islam', 10, 5, '150000.00', 2, 'Sudah', '2022-12-12 03:41:25', NULL, NULL, NULL),
(707, 3, 'P20223707', 'AprilYandi Dwi W 707', '56419974707', '3276022304010010707', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243707', 'Kp.Babakan No. 707', 'Islam', 11, 2, NULL, NULL, 'Belum', '2022-12-12 03:41:25', NULL, NULL, NULL),
(708, 3, 'P20223708', 'AprilYandi Dwi W 708', '56419974708', '3276022304010010708', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243708', 'Kp.Babakan No. 708', 'Islam', 3, 1, NULL, NULL, 'Gratis', '2022-12-12 03:41:25', NULL, NULL, NULL),
(709, 1, 'P20221709', 'AprilYandi Dwi W 709', '56419974709', '3276022304010010709', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243709', 'Kp.Babakan No. 709', 'Islam', 12, 8, '150000.00', 2, 'Sudah', '2022-12-12 03:41:26', NULL, NULL, NULL),
(710, 3, 'P20223710', 'AprilYandi Dwi W 710', '56419974710', '3276022304010010710', 'Depok', '2001-12-05', 'Perempuan', '08810243710', 'Kp.Babakan No. 710', 'Islam', 10, 6, NULL, NULL, 'Gratis', '2022-12-12 03:41:26', NULL, NULL, NULL),
(711, 2, 'P20222711', 'AprilYandi Dwi W 711', '56419974711', '3276022304010010711', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243711', 'Kp.Babakan No. 711', 'Islam', 1, 7, '150000.00', 4, 'Sudah', '2022-12-12 03:41:26', NULL, NULL, NULL),
(712, 3, 'P20223712', 'AprilYandi Dwi W 712', '56419974712', '3276022304010010712', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243712', 'Kp.Babakan No. 712', 'Islam', 7, 1, NULL, NULL, 'Gratis', '2022-12-12 03:41:26', NULL, NULL, NULL),
(713, 2, 'P20222713', 'AprilYandi Dwi W 713', '56419974713', '3276022304010010713', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243713', 'Kp.Babakan No. 713', 'Islam', 9, 11, '150000.00', 3, 'Sudah', '2022-12-12 03:41:27', NULL, NULL, NULL),
(714, 3, 'P20223714', 'AprilYandi Dwi W 714', '56419974714', '3276022304010010714', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243714', 'Kp.Babakan No. 714', 'Islam', 1, 4, NULL, NULL, 'Belum', '2022-12-12 03:41:27', NULL, NULL, NULL),
(715, 2, 'P20222715', 'AprilYandi Dwi W 715', '56419974715', '3276022304010010715', 'Depok', '2001-12-16', 'Perempuan', '08810243715', 'Kp.Babakan No. 715', 'Islam', 6, 12, '150000.00', 4, 'Sudah', '2022-12-12 03:41:27', NULL, NULL, NULL),
(716, 1, 'P20221716', 'AprilYandi Dwi W 716', '56419974716', '3276022304010010716', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243716', 'Kp.Babakan No. 716', 'Islam', 12, 1, '150000.00', 4, 'Sudah', '2022-12-12 03:41:27', NULL, NULL, NULL),
(717, 2, 'P20222717', 'AprilYandi Dwi W 717', '56419974717', '3276022304010010717', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243717', 'Kp.Babakan No. 717', 'Islam', 13, 8, '150000.00', 1, 'Sudah', '2022-12-12 03:41:27', NULL, NULL, NULL),
(718, 1, 'P20221718', 'AprilYandi Dwi W 718', '56419974718', '3276022304010010718', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243718', 'Kp.Babakan No. 718', 'Islam', 12, 9, '150000.00', 2, 'Sudah', '2022-12-12 03:41:27', NULL, NULL, NULL),
(719, 3, 'P20223719', 'AprilYandi Dwi W 719', '56419974719', '3276022304010010719', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243719', 'Kp.Babakan No. 719', 'Islam', 6, 4, NULL, NULL, 'Gratis', '2022-12-12 03:41:28', NULL, NULL, NULL),
(720, 1, 'P20221720', 'AprilYandi Dwi W 720', '56419974720', '3276022304010010720', 'Depok', '2001-12-18', 'Perempuan', '08810243720', 'Kp.Babakan No. 720', 'Islam', 12, 5, '150000.00', 4, 'Sudah', '2022-12-12 03:41:28', NULL, NULL, NULL),
(721, 2, 'P20222721', 'AprilYandi Dwi W 721', '56419974721', '3276022304010010721', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243721', 'Kp.Babakan No. 721', 'Islam', 2, 1, '150000.00', 4, 'Belum', '2022-12-12 03:41:28', NULL, NULL, NULL),
(722, 3, 'P20223722', 'AprilYandi Dwi W 722', '56419974722', '3276022304010010722', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243722', 'Kp.Babakan No. 722', 'Islam', 1, 1, NULL, NULL, 'Gratis', '2022-12-12 03:41:28', NULL, NULL, NULL),
(723, 2, 'P20222723', 'AprilYandi Dwi W 723', '56419974723', '3276022304010010723', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243723', 'Kp.Babakan No. 723', 'Islam', 10, 2, '150000.00', 4, 'Sudah', '2022-12-12 03:41:28', NULL, NULL, NULL),
(724, 1, 'P20221724', 'AprilYandi Dwi W 724', '56419974724', '3276022304010010724', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243724', 'Kp.Babakan No. 724', 'Islam', 12, 2, '150000.00', 2, 'Sudah', '2022-12-12 03:41:28', NULL, NULL, NULL),
(725, 1, 'P20221725', 'AprilYandi Dwi W 725', '56419974725', '3276022304010010725', 'Depok', '2001-12-19', 'Perempuan', '08810243725', 'Kp.Babakan No. 725', 'Islam', 5, 2, '150000.00', 2, 'Sudah', '2022-12-12 03:41:28', NULL, NULL, NULL),
(726, 3, 'P20223726', 'AprilYandi Dwi W 726', '56419974726', '3276022304010010726', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243726', 'Kp.Babakan No. 726', 'Islam', 2, 7, NULL, NULL, 'Gratis', '2022-12-12 03:41:28', NULL, NULL, NULL),
(727, 3, 'P20223727', 'AprilYandi Dwi W 727', '56419974727', '3276022304010010727', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243727', 'Kp.Babakan No. 727', 'Islam', 9, 3, NULL, NULL, 'Gratis', '2022-12-12 03:41:28', NULL, NULL, NULL),
(728, 1, 'P20221728', 'AprilYandi Dwi W 728', '56419974728', '3276022304010010728', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243728', 'Kp.Babakan No. 728', 'Islam', 3, 4, '150000.00', 3, 'Belum', '2022-12-12 03:41:29', NULL, NULL, NULL),
(729, 2, 'P20222729', 'AprilYandi Dwi W 729', '56419974729', '3276022304010010729', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243729', 'Kp.Babakan No. 729', 'Islam', 12, 7, '150000.00', 3, 'Sudah', '2022-12-12 03:41:29', NULL, NULL, NULL),
(730, 2, 'P20222730', 'AprilYandi Dwi W 730', '56419974730', '3276022304010010730', 'Depok', '2001-12-19', 'Perempuan', '08810243730', 'Kp.Babakan No. 730', 'Islam', 9, 7, '150000.00', 2, 'Sudah', '2022-12-12 03:41:29', NULL, NULL, NULL),
(731, 1, 'P20221731', 'AprilYandi Dwi W 731', '56419974731', '3276022304010010731', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243731', 'Kp.Babakan No. 731', 'Islam', 3, 9, '150000.00', 1, 'Sudah', '2022-12-12 03:41:29', NULL, NULL, NULL),
(732, 2, 'P20222732', 'AprilYandi Dwi W 732', '56419974732', '3276022304010010732', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243732', 'Kp.Babakan No. 732', 'Islam', 1, 4, '150000.00', 3, 'Sudah', '2022-12-12 03:41:29', NULL, NULL, NULL),
(733, 3, 'P20223733', 'AprilYandi Dwi W 733', '56419974733', '3276022304010010733', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243733', 'Kp.Babakan No. 733', 'Islam', 9, 5, NULL, NULL, 'Gratis', '2022-12-12 03:41:29', NULL, NULL, NULL),
(734, 1, 'P20221734', 'AprilYandi Dwi W 734', '56419974734', '3276022304010010734', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243734', 'Kp.Babakan No. 734', 'Islam', 7, 1, '150000.00', 3, 'Sudah', '2022-12-12 03:41:29', NULL, NULL, NULL),
(735, 3, 'P20223735', 'AprilYandi Dwi W 735', '56419974735', '3276022304010010735', 'Depok', '2001-12-31', 'Perempuan', '08810243735', 'Kp.Babakan No. 735', 'Islam', 12, 1, NULL, NULL, 'Belum', '2022-12-12 03:41:29', NULL, NULL, NULL),
(736, 2, 'P20222736', 'AprilYandi Dwi W 736', '56419974736', '3276022304010010736', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243736', 'Kp.Babakan No. 736', 'Islam', 8, 8, '150000.00', 4, 'Sudah', '2022-12-12 03:41:29', NULL, NULL, NULL),
(737, 2, 'P20222737', 'AprilYandi Dwi W 737', '56419974737', '3276022304010010737', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243737', 'Kp.Babakan No. 737', 'Islam', 6, 11, '150000.00', 3, 'Sudah', '2022-12-12 03:41:29', NULL, NULL, NULL),
(738, 2, 'P20222738', 'AprilYandi Dwi W 738', '56419974738', '3276022304010010738', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243738', 'Kp.Babakan No. 738', 'Islam', 3, 7, '150000.00', 4, 'Sudah', '2022-12-12 03:41:29', NULL, NULL, NULL),
(739, 1, 'P20221739', 'AprilYandi Dwi W 739', '56419974739', '3276022304010010739', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243739', 'Kp.Babakan No. 739', 'Islam', 7, 1, '150000.00', 2, 'Sudah', '2022-12-12 03:41:29', NULL, NULL, NULL),
(740, 2, 'P20222740', 'AprilYandi Dwi W 740', '56419974740', '3276022304010010740', 'Depok', '2001-12-21', 'Perempuan', '08810243740', 'Kp.Babakan No. 740', 'Islam', 7, 6, '150000.00', 4, 'Sudah', '2022-12-12 03:41:29', NULL, NULL, NULL),
(741, 1, 'P20221741', 'AprilYandi Dwi W 741', '56419974741', '3276022304010010741', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243741', 'Kp.Babakan No. 741', 'Islam', 10, 9, '150000.00', 1, 'Sudah', '2022-12-12 03:41:29', NULL, NULL, NULL),
(742, 1, 'P20221742', 'AprilYandi Dwi W 742', '56419974742', '3276022304010010742', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243742', 'Kp.Babakan No. 742', 'Islam', 8, 1, '150000.00', 2, 'Belum', '2022-12-12 03:41:29', NULL, NULL, NULL),
(743, 2, 'P20222743', 'AprilYandi Dwi W 743', '56419974743', '3276022304010010743', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243743', 'Kp.Babakan No. 743', 'Islam', 12, 10, '150000.00', 4, 'Sudah', '2022-12-12 03:41:29', NULL, NULL, NULL),
(744, 1, 'P20221744', 'AprilYandi Dwi W 744', '56419974744', '3276022304010010744', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243744', 'Kp.Babakan No. 744', 'Islam', 1, 10, '150000.00', 1, 'Sudah', '2022-12-12 03:41:29', NULL, NULL, NULL),
(745, 3, 'P20223745', 'AprilYandi Dwi W 745', '56419974745', '3276022304010010745', 'Depok', '2001-12-07', 'Perempuan', '08810243745', 'Kp.Babakan No. 745', 'Islam', 9, 11, NULL, NULL, 'Gratis', '2022-12-12 03:41:30', NULL, NULL, NULL),
(746, 1, 'P20221746', 'AprilYandi Dwi W 746', '56419974746', '3276022304010010746', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243746', 'Kp.Babakan No. 746', 'Islam', 6, 8, '150000.00', 2, 'Sudah', '2022-12-12 03:41:30', NULL, NULL, NULL),
(747, 1, 'P20221747', 'AprilYandi Dwi W 747', '56419974747', '3276022304010010747', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243747', 'Kp.Babakan No. 747', 'Islam', 12, 13, '150000.00', 2, 'Sudah', '2022-12-12 03:41:30', NULL, NULL, NULL),
(748, 2, 'P20222748', 'AprilYandi Dwi W 748', '56419974748', '3276022304010010748', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243748', 'Kp.Babakan No. 748', 'Islam', 10, 11, '150000.00', 2, 'Sudah', '2022-12-12 03:41:30', NULL, NULL, NULL),
(749, 2, 'P20222749', 'AprilYandi Dwi W 749', '56419974749', '3276022304010010749', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243749', 'Kp.Babakan No. 749', 'Islam', 12, 7, '150000.00', 2, 'Belum', '2022-12-12 03:41:30', NULL, NULL, NULL),
(750, 2, 'P20222750', 'AprilYandi Dwi W 750', '56419974750', '3276022304010010750', 'Depok', '2001-12-17', 'Perempuan', '08810243750', 'Kp.Babakan No. 750', 'Islam', 12, 2, '150000.00', 2, 'Sudah', '2022-12-12 03:41:30', NULL, NULL, NULL),
(751, 2, 'P20222751', 'AprilYandi Dwi W 751', '56419974751', '3276022304010010751', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243751', 'Kp.Babakan No. 751', 'Islam', 4, 10, '150000.00', 2, 'Sudah', '2022-12-12 03:41:30', NULL, NULL, NULL),
(752, 3, 'P20223752', 'AprilYandi Dwi W 752', '56419974752', '3276022304010010752', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243752', 'Kp.Babakan No. 752', 'Islam', 1, 12, NULL, NULL, 'Gratis', '2022-12-12 03:41:30', NULL, NULL, NULL),
(753, 2, 'P20222753', 'AprilYandi Dwi W 753', '56419974753', '3276022304010010753', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243753', 'Kp.Babakan No. 753', 'Islam', 9, 6, '150000.00', 2, 'Sudah', '2022-12-12 03:41:31', NULL, NULL, NULL),
(754, 3, 'P20223754', 'AprilYandi Dwi W 754', '56419974754', '3276022304010010754', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243754', 'Kp.Babakan No. 754', 'Islam', 3, 13, NULL, NULL, 'Gratis', '2022-12-12 03:41:31', NULL, NULL, NULL),
(755, 1, 'P20221755', 'AprilYandi Dwi W 755', '56419974755', '3276022304010010755', 'Depok', '2001-12-06', 'Perempuan', '08810243755', 'Kp.Babakan No. 755', 'Islam', 12, 3, '150000.00', 1, 'Sudah', '2022-12-12 03:41:31', NULL, NULL, NULL),
(756, 2, 'P20222756', 'AprilYandi Dwi W 756', '56419974756', '3276022304010010756', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243756', 'Kp.Babakan No. 756', 'Islam', 8, 12, '150000.00', 3, 'Belum', '2022-12-12 03:41:31', NULL, NULL, NULL),
(757, 1, 'P20221757', 'AprilYandi Dwi W 757', '56419974757', '3276022304010010757', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243757', 'Kp.Babakan No. 757', 'Islam', 7, 3, '150000.00', 4, 'Sudah', '2022-12-12 03:41:31', NULL, NULL, NULL),
(758, 1, 'P20221758', 'AprilYandi Dwi W 758', '56419974758', '3276022304010010758', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243758', 'Kp.Babakan No. 758', 'Islam', 3, 4, '150000.00', 2, 'Sudah', '2022-12-12 03:41:31', NULL, NULL, NULL),
(759, 3, 'P20223759', 'AprilYandi Dwi W 759', '56419974759', '3276022304010010759', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243759', 'Kp.Babakan No. 759', 'Islam', 5, 9, NULL, NULL, 'Gratis', '2022-12-12 03:41:32', NULL, NULL, NULL),
(760, 2, 'P20222760', 'AprilYandi Dwi W 760', '56419974760', '3276022304010010760', 'Depok', '2001-12-02', 'Perempuan', '08810243760', 'Kp.Babakan No. 760', 'Islam', 8, 2, '150000.00', 2, 'Sudah', '2022-12-12 03:41:32', NULL, NULL, NULL),
(761, 1, 'P20221761', 'AprilYandi Dwi W 761', '56419974761', '3276022304010010761', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243761', 'Kp.Babakan No. 761', 'Islam', 12, 3, '150000.00', 4, 'Sudah', '2022-12-12 03:41:32', NULL, NULL, NULL),
(762, 2, 'P20222762', 'AprilYandi Dwi W 762', '56419974762', '3276022304010010762', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243762', 'Kp.Babakan No. 762', 'Islam', 5, 9, '150000.00', 3, 'Sudah', '2022-12-12 03:41:32', NULL, NULL, NULL),
(763, 3, 'P20223763', 'AprilYandi Dwi W 763', '56419974763', '3276022304010010763', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243763', 'Kp.Babakan No. 763', 'Islam', 8, 9, NULL, NULL, 'Belum', '2022-12-12 03:41:32', NULL, NULL, NULL),
(764, 1, 'P20221764', 'AprilYandi Dwi W 764', '56419974764', '3276022304010010764', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243764', 'Kp.Babakan No. 764', 'Islam', 9, 1, '150000.00', 1, 'Sudah', '2022-12-12 03:41:33', NULL, NULL, NULL),
(765, 2, 'P20222765', 'AprilYandi Dwi W 765', '56419974765', '3276022304010010765', 'Depok', '2001-12-13', 'Perempuan', '08810243765', 'Kp.Babakan No. 765', 'Islam', 13, 10, '150000.00', 1, 'Sudah', '2022-12-12 03:41:33', NULL, NULL, NULL),
(766, 1, 'P20221766', 'AprilYandi Dwi W 766', '56419974766', '3276022304010010766', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243766', 'Kp.Babakan No. 766', 'Islam', 6, 9, '150000.00', 4, 'Sudah', '2022-12-12 03:41:33', NULL, NULL, NULL),
(767, 1, 'P20221767', 'AprilYandi Dwi W 767', '56419974767', '3276022304010010767', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243767', 'Kp.Babakan No. 767', 'Islam', 1, 7, '150000.00', 2, 'Sudah', '2022-12-12 03:41:33', NULL, NULL, NULL),
(768, 3, 'P20223768', 'AprilYandi Dwi W 768', '56419974768', '3276022304010010768', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243768', 'Kp.Babakan No. 768', 'Islam', 11, 6, NULL, NULL, 'Gratis', '2022-12-12 03:41:33', NULL, NULL, NULL),
(769, 1, 'P20221769', 'AprilYandi Dwi W 769', '56419974769', '3276022304010010769', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243769', 'Kp.Babakan No. 769', 'Islam', 1, 6, '150000.00', 3, 'Sudah', '2022-12-12 03:41:34', NULL, NULL, NULL),
(770, 1, 'P20221770', 'AprilYandi Dwi W 770', '56419974770', '3276022304010010770', 'Depok', '2001-12-03', 'Perempuan', '08810243770', 'Kp.Babakan No. 770', 'Islam', 9, 9, '150000.00', 3, 'Belum', '2022-12-12 03:41:34', NULL, NULL, NULL),
(771, 3, 'P20223771', 'AprilYandi Dwi W 771', '56419974771', '3276022304010010771', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243771', 'Kp.Babakan No. 771', 'Islam', 4, 3, NULL, NULL, 'Gratis', '2022-12-12 03:41:34', NULL, NULL, NULL),
(772, 1, 'P20221772', 'AprilYandi Dwi W 772', '56419974772', '3276022304010010772', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243772', 'Kp.Babakan No. 772', 'Islam', 4, 6, '150000.00', 4, 'Sudah', '2022-12-12 03:41:34', NULL, NULL, NULL),
(773, 1, 'P20221773', 'AprilYandi Dwi W 773', '56419974773', '3276022304010010773', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243773', 'Kp.Babakan No. 773', 'Islam', 6, 10, '150000.00', 1, 'Sudah', '2022-12-12 03:41:34', NULL, NULL, NULL),
(774, 2, 'P20222774', 'AprilYandi Dwi W 774', '56419974774', '3276022304010010774', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243774', 'Kp.Babakan No. 774', 'Islam', 4, 12, '150000.00', 4, 'Sudah', '2022-12-12 03:41:34', NULL, NULL, NULL),
(775, 1, 'P20221775', 'AprilYandi Dwi W 775', '56419974775', '3276022304010010775', 'Depok', '2001-12-29', 'Perempuan', '08810243775', 'Kp.Babakan No. 775', 'Islam', 5, 13, '150000.00', 4, 'Sudah', '2022-12-12 03:41:34', NULL, NULL, NULL),
(776, 2, 'P20222776', 'AprilYandi Dwi W 776', '56419974776', '3276022304010010776', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243776', 'Kp.Babakan No. 776', 'Islam', 4, 1, '150000.00', 4, 'Sudah', '2022-12-12 03:41:34', NULL, NULL, NULL),
(777, 1, 'P20221777', 'AprilYandi Dwi W 777', '56419974777', '3276022304010010777', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243777', 'Kp.Babakan No. 777', 'Islam', 8, 10, '150000.00', 1, 'Belum', '2022-12-12 03:41:35', NULL, NULL, NULL),
(778, 3, 'P20223778', 'AprilYandi Dwi W 778', '56419974778', '3276022304010010778', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243778', 'Kp.Babakan No. 778', 'Islam', 3, 1, NULL, NULL, 'Gratis', '2022-12-12 03:41:35', NULL, NULL, NULL),
(779, 2, 'P20222779', 'AprilYandi Dwi W 779', '56419974779', '3276022304010010779', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243779', 'Kp.Babakan No. 779', 'Islam', 10, 10, '150000.00', 2, 'Sudah', '2022-12-12 03:41:35', NULL, NULL, NULL),
(780, 2, 'P20222780', 'AprilYandi Dwi W 780', '56419974780', '3276022304010010780', 'Depok', '2001-12-28', 'Perempuan', '08810243780', 'Kp.Babakan No. 780', 'Islam', 8, 10, '150000.00', 3, 'Sudah', '2022-12-12 03:41:35', NULL, NULL, NULL),
(781, 3, 'P20223781', 'AprilYandi Dwi W 781', '56419974781', '3276022304010010781', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243781', 'Kp.Babakan No. 781', 'Islam', 13, 7, NULL, NULL, 'Gratis', '2022-12-12 03:41:35', NULL, NULL, NULL),
(782, 2, 'P20222782', 'AprilYandi Dwi W 782', '56419974782', '3276022304010010782', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243782', 'Kp.Babakan No. 782', 'Islam', 8, 1, '150000.00', 3, 'Sudah', '2022-12-12 03:41:35', NULL, NULL, NULL),
(783, 1, 'P20221783', 'AprilYandi Dwi W 783', '56419974783', '3276022304010010783', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243783', 'Kp.Babakan No. 783', 'Islam', 9, 13, '150000.00', 2, 'Sudah', '2022-12-12 03:41:35', NULL, NULL, NULL),
(784, 3, 'P20223784', 'AprilYandi Dwi W 784', '56419974784', '3276022304010010784', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243784', 'Kp.Babakan No. 784', 'Islam', 10, 1, NULL, NULL, 'Belum', '2022-12-12 03:41:35', NULL, NULL, NULL),
(785, 2, 'P20222785', 'AprilYandi Dwi W 785', '56419974785', '3276022304010010785', 'Depok', '2001-12-14', 'Perempuan', '08810243785', 'Kp.Babakan No. 785', 'Islam', 2, 13, '150000.00', 3, 'Sudah', '2022-12-12 03:41:36', NULL, NULL, NULL),
(786, 2, 'P20222786', 'AprilYandi Dwi W 786', '56419974786', '3276022304010010786', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243786', 'Kp.Babakan No. 786', 'Islam', 13, 10, '150000.00', 3, 'Sudah', '2022-12-12 03:41:36', NULL, NULL, NULL),
(787, 3, 'P20223787', 'AprilYandi Dwi W 787', '56419974787', '3276022304010010787', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243787', 'Kp.Babakan No. 787', 'Islam', 4, 3, NULL, NULL, 'Gratis', '2022-12-12 03:41:36', NULL, NULL, NULL),
(788, 2, 'P20222788', 'AprilYandi Dwi W 788', '56419974788', '3276022304010010788', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243788', 'Kp.Babakan No. 788', 'Islam', 10, 3, '150000.00', 2, 'Sudah', '2022-12-12 03:41:36', NULL, NULL, NULL),
(789, 1, 'P20221789', 'AprilYandi Dwi W 789', '56419974789', '3276022304010010789', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243789', 'Kp.Babakan No. 789', 'Islam', 1, 11, '150000.00', 4, 'Sudah', '2022-12-12 03:41:36', NULL, NULL, NULL),
(790, 1, 'P20221790', 'AprilYandi Dwi W 790', '56419974790', '3276022304010010790', 'Depok', '2001-12-08', 'Perempuan', '08810243790', 'Kp.Babakan No. 790', 'Islam', 12, 3, '150000.00', 4, 'Sudah', '2022-12-12 03:41:36', NULL, NULL, NULL),
(791, 2, 'P20222791', 'AprilYandi Dwi W 791', '56419974791', '3276022304010010791', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243791', 'Kp.Babakan No. 791', 'Islam', 13, 12, '150000.00', 3, 'Belum', '2022-12-12 03:41:36', NULL, NULL, NULL),
(792, 3, 'P20223792', 'AprilYandi Dwi W 792', '56419974792', '3276022304010010792', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243792', 'Kp.Babakan No. 792', 'Islam', 4, 11, NULL, NULL, 'Gratis', '2022-12-12 03:41:36', NULL, NULL, NULL),
(793, 3, 'P20223793', 'AprilYandi Dwi W 793', '56419974793', '3276022304010010793', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243793', 'Kp.Babakan No. 793', 'Islam', 4, 10, NULL, NULL, 'Gratis', '2022-12-12 03:41:37', NULL, NULL, NULL),
(794, 3, 'P20223794', 'AprilYandi Dwi W 794', '56419974794', '3276022304010010794', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243794', 'Kp.Babakan No. 794', 'Islam', 12, 6, NULL, NULL, 'Gratis', '2022-12-12 03:41:37', NULL, NULL, NULL),
(795, 1, 'P20221795', 'AprilYandi Dwi W 795', '56419974795', '3276022304010010795', 'Depok', '2001-12-30', 'Perempuan', '08810243795', 'Kp.Babakan No. 795', 'Islam', 12, 5, '150000.00', 1, 'Sudah', '2022-12-12 03:41:37', NULL, NULL, NULL),
(796, 3, 'P20223796', 'AprilYandi Dwi W 796', '56419974796', '3276022304010010796', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243796', 'Kp.Babakan No. 796', 'Islam', 12, 3, NULL, NULL, 'Gratis', '2022-12-12 03:41:37', NULL, NULL, NULL),
(797, 3, 'P20223797', 'AprilYandi Dwi W 797', '56419974797', '3276022304010010797', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243797', 'Kp.Babakan No. 797', 'Islam', 2, 3, NULL, NULL, 'Gratis', '2022-12-12 03:41:38', NULL, NULL, NULL),
(798, 1, 'P20221798', 'AprilYandi Dwi W 798', '56419974798', '3276022304010010798', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243798', 'Kp.Babakan No. 798', 'Islam', 12, 6, '150000.00', 2, 'Belum', '2022-12-12 03:41:38', NULL, NULL, NULL),
(799, 2, 'P20222799', 'AprilYandi Dwi W 799', '56419974799', '3276022304010010799', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243799', 'Kp.Babakan No. 799', 'Islam', 10, 11, '150000.00', 1, 'Sudah', '2022-12-12 03:41:38', NULL, NULL, NULL),
(800, 2, 'P20222800', 'AprilYandi Dwi W 800', '56419974800', '3276022304010010800', 'Depok', '2001-12-03', 'Perempuan', '08810243800', 'Kp.Babakan No. 800', 'Islam', 2, 6, '150000.00', 1, 'Sudah', '2022-12-12 03:41:38', NULL, NULL, NULL),
(801, 3, 'P20223801', 'AprilYandi Dwi W 801', '56419974801', '3276022304010010801', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243801', 'Kp.Babakan No. 801', 'Islam', 2, 13, NULL, NULL, 'Gratis', '2022-12-12 03:41:38', NULL, NULL, NULL),
(802, 2, 'P20222802', 'AprilYandi Dwi W 802', '56419974802', '3276022304010010802', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243802', 'Kp.Babakan No. 802', 'Islam', 7, 1, '150000.00', 4, 'Sudah', '2022-12-12 03:41:38', NULL, NULL, NULL),
(803, 3, 'P20223803', 'AprilYandi Dwi W 803', '56419974803', '3276022304010010803', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243803', 'Kp.Babakan No. 803', 'Islam', 5, 8, NULL, NULL, 'Gratis', '2022-12-12 03:41:38', NULL, NULL, NULL),
(804, 2, 'P20222804', 'AprilYandi Dwi W 804', '56419974804', '3276022304010010804', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243804', 'Kp.Babakan No. 804', 'Islam', 9, 3, '150000.00', 4, 'Sudah', '2022-12-12 03:41:39', NULL, NULL, NULL),
(805, 3, 'P20223805', 'AprilYandi Dwi W 805', '56419974805', '3276022304010010805', 'Depok', '2001-12-21', 'Perempuan', '08810243805', 'Kp.Babakan No. 805', 'Islam', 9, 6, NULL, NULL, 'Belum', '2022-12-12 03:41:39', NULL, NULL, NULL),
(806, 1, 'P20221806', 'AprilYandi Dwi W 806', '56419974806', '3276022304010010806', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243806', 'Kp.Babakan No. 806', 'Islam', 13, 4, '150000.00', 1, 'Sudah', '2022-12-12 03:41:39', NULL, NULL, NULL),
(807, 3, 'P20223807', 'AprilYandi Dwi W 807', '56419974807', '3276022304010010807', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243807', 'Kp.Babakan No. 807', 'Islam', 8, 5, NULL, NULL, 'Gratis', '2022-12-12 03:41:39', NULL, NULL, NULL),
(808, 1, 'P20221808', 'AprilYandi Dwi W 808', '56419974808', '3276022304010010808', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243808', 'Kp.Babakan No. 808', 'Islam', 3, 10, '150000.00', 1, 'Sudah', '2022-12-12 03:41:39', NULL, NULL, NULL),
(809, 3, 'P20223809', 'AprilYandi Dwi W 809', '56419974809', '3276022304010010809', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243809', 'Kp.Babakan No. 809', 'Islam', 10, 1, NULL, NULL, 'Gratis', '2022-12-12 03:41:39', NULL, NULL, NULL),
(810, 2, 'P20222810', 'AprilYandi Dwi W 810', '56419974810', '3276022304010010810', 'Depok', '2001-12-06', 'Perempuan', '08810243810', 'Kp.Babakan No. 810', 'Islam', 2, 11, '150000.00', 1, 'Sudah', '2022-12-12 03:41:39', NULL, NULL, NULL),
(811, 2, 'P20222811', 'AprilYandi Dwi W 811', '56419974811', '3276022304010010811', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243811', 'Kp.Babakan No. 811', 'Islam', 2, 3, '150000.00', 1, 'Sudah', '2022-12-12 03:41:39', NULL, NULL, NULL),
(812, 1, 'P20221812', 'AprilYandi Dwi W 812', '56419974812', '3276022304010010812', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243812', 'Kp.Babakan No. 812', 'Islam', 12, 10, '150000.00', 3, 'Belum', '2022-12-12 03:41:40', NULL, NULL, NULL),
(813, 1, 'P20221813', 'AprilYandi Dwi W 813', '56419974813', '3276022304010010813', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243813', 'Kp.Babakan No. 813', 'Islam', 11, 11, '150000.00', 3, 'Sudah', '2022-12-12 03:41:40', NULL, NULL, NULL),
(814, 1, 'P20221814', 'AprilYandi Dwi W 814', '56419974814', '3276022304010010814', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243814', 'Kp.Babakan No. 814', 'Islam', 1, 2, '150000.00', 3, 'Sudah', '2022-12-12 03:41:40', NULL, NULL, NULL),
(815, 1, 'P20221815', 'AprilYandi Dwi W 815', '56419974815', '3276022304010010815', 'Depok', '2001-12-11', 'Perempuan', '08810243815', 'Kp.Babakan No. 815', 'Islam', 13, 1, '150000.00', 2, 'Sudah', '2022-12-12 03:41:40', NULL, NULL, NULL),
(816, 1, 'P20221816', 'AprilYandi Dwi W 816', '56419974816', '3276022304010010816', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243816', 'Kp.Babakan No. 816', 'Islam', 10, 8, '150000.00', 1, 'Sudah', '2022-12-12 03:41:40', NULL, NULL, NULL),
(817, 2, 'P20222817', 'AprilYandi Dwi W 817', '56419974817', '3276022304010010817', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243817', 'Kp.Babakan No. 817', 'Islam', 11, 4, '150000.00', 4, 'Sudah', '2022-12-12 03:41:40', NULL, NULL, NULL),
(818, 1, 'P20221818', 'AprilYandi Dwi W 818', '56419974818', '3276022304010010818', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243818', 'Kp.Babakan No. 818', 'Islam', 7, 5, '150000.00', 3, 'Sudah', '2022-12-12 03:41:40', NULL, NULL, NULL),
(819, 1, 'P20221819', 'AprilYandi Dwi W 819', '56419974819', '3276022304010010819', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243819', 'Kp.Babakan No. 819', 'Islam', 11, 4, '150000.00', 1, 'Belum', '2022-12-12 03:41:40', NULL, NULL, NULL),
(820, 1, 'P20221820', 'AprilYandi Dwi W 820', '56419974820', '3276022304010010820', 'Depok', '2001-12-23', 'Perempuan', '08810243820', 'Kp.Babakan No. 820', 'Islam', 4, 10, '150000.00', 2, 'Sudah', '2022-12-12 03:41:40', NULL, NULL, NULL),
(821, 3, 'P20223821', 'AprilYandi Dwi W 821', '56419974821', '3276022304010010821', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243821', 'Kp.Babakan No. 821', 'Islam', 7, 6, NULL, NULL, 'Gratis', '2022-12-12 03:41:40', NULL, NULL, NULL),
(822, 2, 'P20222822', 'AprilYandi Dwi W 822', '56419974822', '3276022304010010822', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243822', 'Kp.Babakan No. 822', 'Islam', 5, 4, '150000.00', 4, 'Sudah', '2022-12-12 03:41:41', NULL, NULL, NULL),
(823, 3, 'P20223823', 'AprilYandi Dwi W 823', '56419974823', '3276022304010010823', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243823', 'Kp.Babakan No. 823', 'Islam', 7, 3, NULL, NULL, 'Gratis', '2022-12-12 03:41:41', NULL, NULL, NULL),
(824, 1, 'P20221824', 'AprilYandi Dwi W 824', '56419974824', '3276022304010010824', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243824', 'Kp.Babakan No. 824', 'Islam', 10, 4, '150000.00', 3, 'Sudah', '2022-12-12 03:41:41', NULL, NULL, NULL),
(825, 3, 'P20223825', 'AprilYandi Dwi W 825', '56419974825', '3276022304010010825', 'Depok', '2001-12-06', 'Perempuan', '08810243825', 'Kp.Babakan No. 825', 'Islam', 8, 4, NULL, NULL, 'Gratis', '2022-12-12 03:41:42', NULL, NULL, NULL),
(826, 2, 'P20222826', 'AprilYandi Dwi W 826', '56419974826', '3276022304010010826', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243826', 'Kp.Babakan No. 826', 'Islam', 2, 5, '150000.00', 1, 'Belum', '2022-12-12 03:41:42', NULL, NULL, NULL),
(827, 3, 'P20223827', 'AprilYandi Dwi W 827', '56419974827', '3276022304010010827', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243827', 'Kp.Babakan No. 827', 'Islam', 11, 4, NULL, NULL, 'Gratis', '2022-12-12 03:41:42', NULL, NULL, NULL),
(828, 1, 'P20221828', 'AprilYandi Dwi W 828', '56419974828', '3276022304010010828', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243828', 'Kp.Babakan No. 828', 'Islam', 10, 5, '150000.00', 2, 'Sudah', '2022-12-12 03:41:42', NULL, NULL, NULL),
(829, 1, 'P20221829', 'AprilYandi Dwi W 829', '56419974829', '3276022304010010829', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243829', 'Kp.Babakan No. 829', 'Islam', 8, 11, '150000.00', 3, 'Sudah', '2022-12-12 03:41:43', NULL, NULL, NULL),
(830, 2, 'P20222830', 'AprilYandi Dwi W 830', '56419974830', '3276022304010010830', 'Depok', '2001-12-06', 'Perempuan', '08810243830', 'Kp.Babakan No. 830', 'Islam', 11, 6, '150000.00', 4, 'Sudah', '2022-12-12 03:41:43', NULL, NULL, NULL),
(831, 3, 'P20223831', 'AprilYandi Dwi W 831', '56419974831', '3276022304010010831', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243831', 'Kp.Babakan No. 831', 'Islam', 6, 12, NULL, NULL, 'Gratis', '2022-12-12 03:41:43', NULL, NULL, NULL),
(832, 2, 'P20222832', 'AprilYandi Dwi W 832', '56419974832', '3276022304010010832', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243832', 'Kp.Babakan No. 832', 'Islam', 6, 5, '150000.00', 1, 'Sudah', '2022-12-12 03:41:43', NULL, NULL, NULL),
(833, 2, 'P20222833', 'AprilYandi Dwi W 833', '56419974833', '3276022304010010833', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243833', 'Kp.Babakan No. 833', 'Islam', 6, 12, '150000.00', 1, 'Belum', '2022-12-12 03:41:43', NULL, NULL, NULL),
(834, 3, 'P20223834', 'AprilYandi Dwi W 834', '56419974834', '3276022304010010834', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243834', 'Kp.Babakan No. 834', 'Islam', 12, 9, NULL, NULL, 'Gratis', '2022-12-12 03:41:44', NULL, NULL, NULL),
(835, 1, 'P20221835', 'AprilYandi Dwi W 835', '56419974835', '3276022304010010835', 'Depok', '2001-12-03', 'Perempuan', '08810243835', 'Kp.Babakan No. 835', 'Islam', 13, 13, '150000.00', 3, 'Sudah', '2022-12-12 03:41:44', NULL, NULL, NULL);
INSERT INTO `pendaftar` (`id_pendaftar`, `id_jalur`, `no_pendaftar`, `nama`, `nisn`, `nik`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `no_hp`, `alamat`, `agama`, `id_prodi1`, `id_prodi2`, `nominal_bayar`, `id_bank`, `status_bayar`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(836, 3, 'P20223836', 'AprilYandi Dwi W 836', '56419974836', '3276022304010010836', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243836', 'Kp.Babakan No. 836', 'Islam', 7, 6, NULL, NULL, 'Gratis', '2022-12-12 03:41:44', NULL, NULL, NULL),
(837, 3, 'P20223837', 'AprilYandi Dwi W 837', '56419974837', '3276022304010010837', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243837', 'Kp.Babakan No. 837', 'Islam', 5, 2, NULL, NULL, 'Gratis', '2022-12-12 03:41:44', NULL, NULL, NULL),
(838, 2, 'P20222838', 'AprilYandi Dwi W 838', '56419974838', '3276022304010010838', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243838', 'Kp.Babakan No. 838', 'Islam', 1, 4, '150000.00', 1, 'Sudah', '2022-12-12 03:41:44', NULL, NULL, NULL),
(839, 3, 'P20223839', 'AprilYandi Dwi W 839', '56419974839', '3276022304010010839', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243839', 'Kp.Babakan No. 839', 'Islam', 7, 11, NULL, NULL, 'Gratis', '2022-12-12 03:41:44', NULL, NULL, NULL),
(840, 2, 'P20222840', 'AprilYandi Dwi W 840', '56419974840', '3276022304010010840', 'Depok', '2001-12-14', 'Perempuan', '08810243840', 'Kp.Babakan No. 840', 'Islam', 5, 6, '150000.00', 1, 'Belum', '2022-12-12 03:41:44', NULL, NULL, NULL),
(841, 1, 'P20221841', 'AprilYandi Dwi W 841', '56419974841', '3276022304010010841', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243841', 'Kp.Babakan No. 841', 'Islam', 6, 4, '150000.00', 1, 'Sudah', '2022-12-12 03:41:44', NULL, NULL, NULL),
(842, 3, 'P20223842', 'AprilYandi Dwi W 842', '56419974842', '3276022304010010842', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243842', 'Kp.Babakan No. 842', 'Islam', 8, 9, NULL, NULL, 'Gratis', '2022-12-12 03:41:45', NULL, NULL, NULL),
(843, 1, 'P20221843', 'AprilYandi Dwi W 843', '56419974843', '3276022304010010843', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243843', 'Kp.Babakan No. 843', 'Islam', 6, 1, '150000.00', 1, 'Sudah', '2022-12-12 03:41:45', NULL, NULL, NULL),
(844, 3, 'P20223844', 'AprilYandi Dwi W 844', '56419974844', '3276022304010010844', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243844', 'Kp.Babakan No. 844', 'Islam', 8, 7, NULL, NULL, 'Gratis', '2022-12-12 03:41:45', NULL, NULL, NULL),
(845, 3, 'P20223845', 'AprilYandi Dwi W 845', '56419974845', '3276022304010010845', 'Depok', '2001-12-03', 'Perempuan', '08810243845', 'Kp.Babakan No. 845', 'Islam', 5, 11, NULL, NULL, 'Gratis', '2022-12-12 03:41:45', NULL, NULL, NULL),
(846, 3, 'P20223846', 'AprilYandi Dwi W 846', '56419974846', '3276022304010010846', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243846', 'Kp.Babakan No. 846', 'Islam', 9, 6, NULL, NULL, 'Gratis', '2022-12-12 03:41:45', NULL, NULL, NULL),
(847, 2, 'P20222847', 'AprilYandi Dwi W 847', '56419974847', '3276022304010010847', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243847', 'Kp.Babakan No. 847', 'Islam', 10, 13, '150000.00', 4, 'Belum', '2022-12-12 03:41:45', NULL, NULL, NULL),
(848, 1, 'P20221848', 'AprilYandi Dwi W 848', '56419974848', '3276022304010010848', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243848', 'Kp.Babakan No. 848', 'Islam', 3, 7, '150000.00', 1, 'Sudah', '2022-12-12 03:41:45', NULL, NULL, NULL),
(849, 1, 'P20221849', 'AprilYandi Dwi W 849', '56419974849', '3276022304010010849', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243849', 'Kp.Babakan No. 849', 'Islam', 1, 13, '150000.00', 4, 'Sudah', '2022-12-12 03:41:45', NULL, NULL, NULL),
(850, 2, 'P20222850', 'AprilYandi Dwi W 850', '56419974850', '3276022304010010850', 'Depok', '2001-12-14', 'Perempuan', '08810243850', 'Kp.Babakan No. 850', 'Islam', 9, 11, '150000.00', 4, 'Sudah', '2022-12-12 03:41:45', NULL, NULL, NULL),
(851, 2, 'P20222851', 'AprilYandi Dwi W 851', '56419974851', '3276022304010010851', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243851', 'Kp.Babakan No. 851', 'Islam', 3, 7, '150000.00', 1, 'Sudah', '2022-12-12 03:41:45', NULL, NULL, NULL),
(852, 1, 'P20221852', 'AprilYandi Dwi W 852', '56419974852', '3276022304010010852', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243852', 'Kp.Babakan No. 852', 'Islam', 1, 8, '150000.00', 2, 'Sudah', '2022-12-12 03:41:45', NULL, NULL, NULL),
(853, 3, 'P20223853', 'AprilYandi Dwi W 853', '56419974853', '3276022304010010853', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243853', 'Kp.Babakan No. 853', 'Islam', 9, 2, NULL, NULL, 'Gratis', '2022-12-12 03:41:45', NULL, NULL, NULL),
(854, 2, 'P20222854', 'AprilYandi Dwi W 854', '56419974854', '3276022304010010854', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243854', 'Kp.Babakan No. 854', 'Islam', 5, 3, '150000.00', 2, 'Belum', '2022-12-12 03:41:45', NULL, NULL, NULL),
(855, 2, 'P20222855', 'AprilYandi Dwi W 855', '56419974855', '3276022304010010855', 'Depok', '2001-12-20', 'Perempuan', '08810243855', 'Kp.Babakan No. 855', 'Islam', 8, 6, '150000.00', 2, 'Sudah', '2022-12-12 03:41:45', NULL, NULL, NULL),
(856, 3, 'P20223856', 'AprilYandi Dwi W 856', '56419974856', '3276022304010010856', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243856', 'Kp.Babakan No. 856', 'Islam', 2, 4, NULL, NULL, 'Gratis', '2022-12-12 03:41:46', NULL, NULL, NULL),
(857, 3, 'P20223857', 'AprilYandi Dwi W 857', '56419974857', '3276022304010010857', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243857', 'Kp.Babakan No. 857', 'Islam', 7, 10, NULL, NULL, 'Gratis', '2022-12-12 03:41:46', NULL, NULL, NULL),
(858, 2, 'P20222858', 'AprilYandi Dwi W 858', '56419974858', '3276022304010010858', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243858', 'Kp.Babakan No. 858', 'Islam', 8, 3, '150000.00', 1, 'Sudah', '2022-12-12 03:41:46', NULL, NULL, NULL),
(859, 2, 'P20222859', 'AprilYandi Dwi W 859', '56419974859', '3276022304010010859', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243859', 'Kp.Babakan No. 859', 'Islam', 13, 9, '150000.00', 3, 'Sudah', '2022-12-12 03:41:46', NULL, NULL, NULL),
(860, 3, 'P20223860', 'AprilYandi Dwi W 860', '56419974860', '3276022304010010860', 'Depok', '2001-12-08', 'Perempuan', '08810243860', 'Kp.Babakan No. 860', 'Islam', 2, 5, NULL, NULL, 'Gratis', '2022-12-12 03:41:46', NULL, NULL, NULL),
(861, 2, 'P20222861', 'AprilYandi Dwi W 861', '56419974861', '3276022304010010861', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243861', 'Kp.Babakan No. 861', 'Islam', 12, 4, '150000.00', 4, 'Belum', '2022-12-12 03:41:46', NULL, NULL, NULL),
(862, 1, 'P20221862', 'AprilYandi Dwi W 862', '56419974862', '3276022304010010862', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243862', 'Kp.Babakan No. 862', 'Islam', 7, 2, '150000.00', 4, 'Sudah', '2022-12-12 03:41:46', NULL, NULL, NULL),
(863, 1, 'P20221863', 'AprilYandi Dwi W 863', '56419974863', '3276022304010010863', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243863', 'Kp.Babakan No. 863', 'Islam', 7, 7, '150000.00', 4, 'Sudah', '2022-12-12 03:41:46', NULL, NULL, NULL),
(864, 1, 'P20221864', 'AprilYandi Dwi W 864', '56419974864', '3276022304010010864', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243864', 'Kp.Babakan No. 864', 'Islam', 8, 1, '150000.00', 4, 'Sudah', '2022-12-12 03:41:46', NULL, NULL, NULL),
(865, 2, 'P20222865', 'AprilYandi Dwi W 865', '56419974865', '3276022304010010865', 'Depok', '2001-12-17', 'Perempuan', '08810243865', 'Kp.Babakan No. 865', 'Islam', 2, 1, '150000.00', 2, 'Sudah', '2022-12-12 03:41:46', NULL, NULL, NULL),
(866, 1, 'P20221866', 'AprilYandi Dwi W 866', '56419974866', '3276022304010010866', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243866', 'Kp.Babakan No. 866', 'Islam', 4, 2, '150000.00', 3, 'Sudah', '2022-12-12 03:41:47', NULL, NULL, NULL),
(867, 2, 'P20222867', 'AprilYandi Dwi W 867', '56419974867', '3276022304010010867', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243867', 'Kp.Babakan No. 867', 'Islam', 10, 5, '150000.00', 1, 'Sudah', '2022-12-12 03:41:47', NULL, NULL, NULL),
(868, 2, 'P20222868', 'AprilYandi Dwi W 868', '56419974868', '3276022304010010868', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243868', 'Kp.Babakan No. 868', 'Islam', 10, 6, '150000.00', 4, 'Belum', '2022-12-12 03:41:47', NULL, NULL, NULL),
(869, 3, 'P20223869', 'AprilYandi Dwi W 869', '56419974869', '3276022304010010869', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243869', 'Kp.Babakan No. 869', 'Islam', 2, 1, NULL, NULL, 'Gratis', '2022-12-12 03:41:47', NULL, NULL, NULL),
(870, 2, 'P20222870', 'AprilYandi Dwi W 870', '56419974870', '3276022304010010870', 'Depok', '2001-12-28', 'Perempuan', '08810243870', 'Kp.Babakan No. 870', 'Islam', 10, 4, '150000.00', 4, 'Sudah', '2022-12-12 03:41:47', NULL, NULL, NULL),
(871, 2, 'P20222871', 'AprilYandi Dwi W 871', '56419974871', '3276022304010010871', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243871', 'Kp.Babakan No. 871', 'Islam', 8, 3, '150000.00', 1, 'Sudah', '2022-12-12 03:41:47', NULL, NULL, NULL),
(872, 1, 'P20221872', 'AprilYandi Dwi W 872', '56419974872', '3276022304010010872', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243872', 'Kp.Babakan No. 872', 'Islam', 2, 10, '150000.00', 1, 'Sudah', '2022-12-12 03:41:48', NULL, NULL, NULL),
(873, 2, 'P20222873', 'AprilYandi Dwi W 873', '56419974873', '3276022304010010873', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243873', 'Kp.Babakan No. 873', 'Islam', 2, 11, '150000.00', 3, 'Sudah', '2022-12-12 03:41:48', NULL, NULL, NULL),
(874, 2, 'P20222874', 'AprilYandi Dwi W 874', '56419974874', '3276022304010010874', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243874', 'Kp.Babakan No. 874', 'Islam', 8, 12, '150000.00', 1, 'Sudah', '2022-12-12 03:41:48', NULL, NULL, NULL),
(875, 3, 'P20223875', 'AprilYandi Dwi W 875', '56419974875', '3276022304010010875', 'Depok', '2001-12-22', 'Perempuan', '08810243875', 'Kp.Babakan No. 875', 'Islam', 8, 8, NULL, NULL, 'Belum', '2022-12-12 03:41:48', NULL, NULL, NULL),
(876, 3, 'P20223876', 'AprilYandi Dwi W 876', '56419974876', '3276022304010010876', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243876', 'Kp.Babakan No. 876', 'Islam', 8, 7, NULL, NULL, 'Gratis', '2022-12-12 03:41:48', NULL, NULL, NULL),
(877, 3, 'P20223877', 'AprilYandi Dwi W 877', '56419974877', '3276022304010010877', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243877', 'Kp.Babakan No. 877', 'Islam', 11, 13, NULL, NULL, 'Gratis', '2022-12-12 03:41:48', NULL, NULL, NULL),
(878, 2, 'P20222878', 'AprilYandi Dwi W 878', '56419974878', '3276022304010010878', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243878', 'Kp.Babakan No. 878', 'Islam', 9, 4, '150000.00', 3, 'Sudah', '2022-12-12 03:41:48', NULL, NULL, NULL),
(879, 2, 'P20222879', 'AprilYandi Dwi W 879', '56419974879', '3276022304010010879', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243879', 'Kp.Babakan No. 879', 'Islam', 6, 12, '150000.00', 1, 'Sudah', '2022-12-12 03:41:49', NULL, NULL, NULL),
(880, 3, 'P20223880', 'AprilYandi Dwi W 880', '56419974880', '3276022304010010880', 'Depok', '2001-12-21', 'Perempuan', '08810243880', 'Kp.Babakan No. 880', 'Islam', 12, 9, NULL, NULL, 'Gratis', '2022-12-12 03:41:49', NULL, NULL, NULL),
(881, 2, 'P20222881', 'AprilYandi Dwi W 881', '56419974881', '3276022304010010881', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243881', 'Kp.Babakan No. 881', 'Islam', 4, 9, '150000.00', 1, 'Sudah', '2022-12-12 03:41:49', NULL, NULL, NULL),
(882, 2, 'P20222882', 'AprilYandi Dwi W 882', '56419974882', '3276022304010010882', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243882', 'Kp.Babakan No. 882', 'Islam', 10, 11, '150000.00', 3, 'Belum', '2022-12-12 03:41:49', NULL, NULL, NULL),
(883, 2, 'P20222883', 'AprilYandi Dwi W 883', '56419974883', '3276022304010010883', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243883', 'Kp.Babakan No. 883', 'Islam', 10, 11, '150000.00', 3, 'Sudah', '2022-12-12 03:41:49', NULL, NULL, NULL),
(884, 1, 'P20221884', 'AprilYandi Dwi W 884', '56419974884', '3276022304010010884', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243884', 'Kp.Babakan No. 884', 'Islam', 1, 4, '150000.00', 2, 'Sudah', '2022-12-12 03:41:50', NULL, NULL, NULL),
(885, 2, 'P20222885', 'AprilYandi Dwi W 885', '56419974885', '3276022304010010885', 'Depok', '2001-12-13', 'Perempuan', '08810243885', 'Kp.Babakan No. 885', 'Islam', 9, 10, '150000.00', 1, 'Sudah', '2022-12-12 03:41:50', NULL, NULL, NULL),
(886, 1, 'P20221886', 'AprilYandi Dwi W 886', '56419974886', '3276022304010010886', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243886', 'Kp.Babakan No. 886', 'Islam', 6, 3, '150000.00', 2, 'Sudah', '2022-12-12 03:41:50', NULL, NULL, NULL),
(887, 2, 'P20222887', 'AprilYandi Dwi W 887', '56419974887', '3276022304010010887', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243887', 'Kp.Babakan No. 887', 'Islam', 12, 10, '150000.00', 2, 'Sudah', '2022-12-12 03:41:51', NULL, NULL, NULL),
(888, 1, 'P20221888', 'AprilYandi Dwi W 888', '56419974888', '3276022304010010888', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243888', 'Kp.Babakan No. 888', 'Islam', 8, 11, '150000.00', 1, 'Sudah', '2022-12-12 03:41:51', NULL, NULL, NULL),
(889, 2, 'P20222889', 'AprilYandi Dwi W 889', '56419974889', '3276022304010010889', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243889', 'Kp.Babakan No. 889', 'Islam', 8, 12, '150000.00', 3, 'Belum', '2022-12-12 03:41:51', NULL, NULL, NULL),
(890, 1, 'P20221890', 'AprilYandi Dwi W 890', '56419974890', '3276022304010010890', 'Depok', '2001-12-04', 'Perempuan', '08810243890', 'Kp.Babakan No. 890', 'Islam', 2, 3, '150000.00', 2, 'Sudah', '2022-12-12 03:41:51', NULL, NULL, NULL),
(891, 3, 'P20223891', 'AprilYandi Dwi W 891', '56419974891', '3276022304010010891', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243891', 'Kp.Babakan No. 891', 'Islam', 11, 2, NULL, NULL, 'Gratis', '2022-12-12 03:41:52', NULL, NULL, NULL),
(892, 1, 'P20221892', 'AprilYandi Dwi W 892', '56419974892', '3276022304010010892', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243892', 'Kp.Babakan No. 892', 'Islam', 10, 13, '150000.00', 3, 'Sudah', '2022-12-12 03:41:52', NULL, NULL, NULL),
(893, 1, 'P20221893', 'AprilYandi Dwi W 893', '56419974893', '3276022304010010893', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243893', 'Kp.Babakan No. 893', 'Islam', 10, 13, '150000.00', 2, 'Sudah', '2022-12-12 03:41:52', NULL, NULL, NULL),
(894, 1, 'P20221894', 'AprilYandi Dwi W 894', '56419974894', '3276022304010010894', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243894', 'Kp.Babakan No. 894', 'Islam', 2, 9, '150000.00', 2, 'Sudah', '2022-12-12 03:41:52', NULL, NULL, NULL),
(895, 2, 'P20222895', 'AprilYandi Dwi W 895', '56419974895', '3276022304010010895', 'Depok', '2001-12-20', 'Perempuan', '08810243895', 'Kp.Babakan No. 895', 'Islam', 8, 6, '150000.00', 1, 'Sudah', '2022-12-12 03:41:52', NULL, NULL, NULL),
(896, 2, 'P20222896', 'AprilYandi Dwi W 896', '56419974896', '3276022304010010896', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243896', 'Kp.Babakan No. 896', 'Islam', 10, 4, '150000.00', 1, 'Belum', '2022-12-12 03:41:52', NULL, NULL, NULL),
(897, 1, 'P20221897', 'AprilYandi Dwi W 897', '56419974897', '3276022304010010897', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243897', 'Kp.Babakan No. 897', 'Islam', 1, 12, '150000.00', 3, 'Sudah', '2022-12-12 03:41:52', NULL, NULL, NULL),
(898, 1, 'P20221898', 'AprilYandi Dwi W 898', '56419974898', '3276022304010010898', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243898', 'Kp.Babakan No. 898', 'Islam', 12, 4, '150000.00', 4, 'Sudah', '2022-12-12 03:41:52', NULL, NULL, NULL),
(899, 3, 'P20223899', 'AprilYandi Dwi W 899', '56419974899', '3276022304010010899', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243899', 'Kp.Babakan No. 899', 'Islam', 9, 6, NULL, NULL, 'Gratis', '2022-12-12 03:41:52', NULL, NULL, NULL),
(900, 1, 'P20221900', 'AprilYandi Dwi W 900', '56419974900', '3276022304010010900', 'Depok', '2001-12-06', 'Perempuan', '08810243900', 'Kp.Babakan No. 900', 'Islam', 7, 9, '150000.00', 2, 'Sudah', '2022-12-12 03:41:52', NULL, NULL, NULL),
(901, 2, 'P20222901', 'AprilYandi Dwi W 901', '56419974901', '3276022304010010901', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243901', 'Kp.Babakan No. 901', 'Islam', 12, 4, '150000.00', 2, 'Sudah', '2022-12-12 03:41:52', NULL, NULL, NULL),
(902, 2, 'P20222902', 'AprilYandi Dwi W 902', '56419974902', '3276022304010010902', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243902', 'Kp.Babakan No. 902', 'Islam', 1, 12, '150000.00', 3, 'Sudah', '2022-12-12 03:41:52', NULL, NULL, NULL),
(903, 1, 'P20221903', 'AprilYandi Dwi W 903', '56419974903', '3276022304010010903', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243903', 'Kp.Babakan No. 903', 'Islam', 12, 2, '150000.00', 2, 'Belum', '2022-12-12 03:41:52', NULL, NULL, NULL),
(904, 1, 'P20221904', 'AprilYandi Dwi W 904', '56419974904', '3276022304010010904', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243904', 'Kp.Babakan No. 904', 'Islam', 6, 11, '150000.00', 3, 'Sudah', '2022-12-12 03:41:52', NULL, NULL, NULL),
(905, 2, 'P20222905', 'AprilYandi Dwi W 905', '56419974905', '3276022304010010905', 'Depok', '2001-12-12', 'Perempuan', '08810243905', 'Kp.Babakan No. 905', 'Islam', 11, 8, '150000.00', 1, 'Sudah', '2022-12-12 03:41:52', NULL, NULL, NULL),
(906, 1, 'P20221906', 'AprilYandi Dwi W 906', '56419974906', '3276022304010010906', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243906', 'Kp.Babakan No. 906', 'Islam', 11, 9, '150000.00', 1, 'Sudah', '2022-12-12 03:41:52', NULL, NULL, NULL),
(907, 3, 'P20223907', 'AprilYandi Dwi W 907', '56419974907', '3276022304010010907', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243907', 'Kp.Babakan No. 907', 'Islam', 1, 7, NULL, NULL, 'Gratis', '2022-12-12 03:41:52', NULL, NULL, NULL),
(908, 2, 'P20222908', 'AprilYandi Dwi W 908', '56419974908', '3276022304010010908', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243908', 'Kp.Babakan No. 908', 'Islam', 3, 1, '150000.00', 2, 'Sudah', '2022-12-12 03:41:53', NULL, NULL, NULL),
(909, 2, 'P20222909', 'AprilYandi Dwi W 909', '56419974909', '3276022304010010909', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243909', 'Kp.Babakan No. 909', 'Islam', 13, 2, '150000.00', 3, 'Sudah', '2022-12-12 03:41:53', NULL, NULL, NULL),
(910, 1, 'P20221910', 'AprilYandi Dwi W 910', '56419974910', '3276022304010010910', 'Depok', '2001-12-17', 'Perempuan', '08810243910', 'Kp.Babakan No. 910', 'Islam', 1, 9, '150000.00', 2, 'Belum', '2022-12-12 03:41:53', NULL, NULL, NULL),
(911, 3, 'P20223911', 'AprilYandi Dwi W 911', '56419974911', '3276022304010010911', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243911', 'Kp.Babakan No. 911', 'Islam', 3, 5, NULL, NULL, 'Gratis', '2022-12-12 03:41:53', NULL, NULL, NULL),
(912, 1, 'P20221912', 'AprilYandi Dwi W 912', '56419974912', '3276022304010010912', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243912', 'Kp.Babakan No. 912', 'Islam', 12, 6, '150000.00', 1, 'Sudah', '2022-12-12 03:41:53', NULL, NULL, NULL),
(913, 2, 'P20222913', 'AprilYandi Dwi W 913', '56419974913', '3276022304010010913', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243913', 'Kp.Babakan No. 913', 'Islam', 8, 5, '150000.00', 2, 'Sudah', '2022-12-12 03:41:53', NULL, NULL, NULL),
(914, 3, 'P20223914', 'AprilYandi Dwi W 914', '56419974914', '3276022304010010914', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243914', 'Kp.Babakan No. 914', 'Islam', 5, 6, NULL, NULL, 'Gratis', '2022-12-12 03:41:53', NULL, NULL, NULL),
(915, 1, 'P20221915', 'AprilYandi Dwi W 915', '56419974915', '3276022304010010915', 'Depok', '2001-12-25', 'Perempuan', '08810243915', 'Kp.Babakan No. 915', 'Islam', 13, 1, '150000.00', 2, 'Sudah', '2022-12-12 03:41:53', NULL, NULL, NULL),
(916, 3, 'P20223916', 'AprilYandi Dwi W 916', '56419974916', '3276022304010010916', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243916', 'Kp.Babakan No. 916', 'Islam', 5, 1, NULL, NULL, 'Gratis', '2022-12-12 03:41:53', NULL, NULL, NULL),
(917, 3, 'P20223917', 'AprilYandi Dwi W 917', '56419974917', '3276022304010010917', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243917', 'Kp.Babakan No. 917', 'Islam', 9, 2, NULL, NULL, 'Belum', '2022-12-12 03:41:53', NULL, NULL, NULL),
(918, 2, 'P20222918', 'AprilYandi Dwi W 918', '56419974918', '3276022304010010918', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243918', 'Kp.Babakan No. 918', 'Islam', 4, 13, '150000.00', 3, 'Sudah', '2022-12-12 03:41:54', NULL, NULL, NULL),
(919, 2, 'P20222919', 'AprilYandi Dwi W 919', '56419974919', '3276022304010010919', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243919', 'Kp.Babakan No. 919', 'Islam', 5, 13, '150000.00', 2, 'Sudah', '2022-12-12 03:41:54', NULL, NULL, NULL),
(920, 3, 'P20223920', 'AprilYandi Dwi W 920', '56419974920', '3276022304010010920', 'Depok', '2001-12-19', 'Perempuan', '08810243920', 'Kp.Babakan No. 920', 'Islam', 5, 1, NULL, NULL, 'Gratis', '2022-12-12 03:41:54', NULL, NULL, NULL),
(921, 3, 'P20223921', 'AprilYandi Dwi W 921', '56419974921', '3276022304010010921', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243921', 'Kp.Babakan No. 921', 'Islam', 1, 12, NULL, NULL, 'Gratis', '2022-12-12 03:41:54', NULL, NULL, NULL),
(922, 3, 'P20223922', 'AprilYandi Dwi W 922', '56419974922', '3276022304010010922', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243922', 'Kp.Babakan No. 922', 'Islam', 10, 3, NULL, NULL, 'Gratis', '2022-12-12 03:41:54', NULL, NULL, NULL),
(923, 1, 'P20221923', 'AprilYandi Dwi W 923', '56419974923', '3276022304010010923', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243923', 'Kp.Babakan No. 923', 'Islam', 12, 12, '150000.00', 1, 'Sudah', '2022-12-12 03:41:54', NULL, NULL, NULL),
(924, 3, 'P20223924', 'AprilYandi Dwi W 924', '56419974924', '3276022304010010924', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243924', 'Kp.Babakan No. 924', 'Islam', 3, 6, NULL, NULL, 'Belum', '2022-12-12 03:41:54', NULL, NULL, NULL),
(925, 1, 'P20221925', 'AprilYandi Dwi W 925', '56419974925', '3276022304010010925', 'Depok', '2001-12-14', 'Perempuan', '08810243925', 'Kp.Babakan No. 925', 'Islam', 13, 3, '150000.00', 1, 'Sudah', '2022-12-12 03:41:54', NULL, NULL, NULL),
(926, 1, 'P20221926', 'AprilYandi Dwi W 926', '56419974926', '3276022304010010926', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243926', 'Kp.Babakan No. 926', 'Islam', 4, 12, '150000.00', 2, 'Sudah', '2022-12-12 03:41:54', NULL, NULL, NULL),
(927, 1, 'P20221927', 'AprilYandi Dwi W 927', '56419974927', '3276022304010010927', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243927', 'Kp.Babakan No. 927', 'Islam', 12, 1, '150000.00', 4, 'Sudah', '2022-12-12 03:41:54', NULL, NULL, NULL),
(928, 1, 'P20221928', 'AprilYandi Dwi W 928', '56419974928', '3276022304010010928', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243928', 'Kp.Babakan No. 928', 'Islam', 6, 12, '150000.00', 1, 'Sudah', '2022-12-12 03:41:54', NULL, NULL, NULL),
(929, 1, 'P20221929', 'AprilYandi Dwi W 929', '56419974929', '3276022304010010929', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243929', 'Kp.Babakan No. 929', 'Islam', 9, 2, '150000.00', 4, 'Sudah', '2022-12-12 03:41:54', NULL, NULL, NULL),
(930, 3, 'P20223930', 'AprilYandi Dwi W 930', '56419974930', '3276022304010010930', 'Depok', '2001-12-10', 'Perempuan', '08810243930', 'Kp.Babakan No. 930', 'Islam', 6, 5, NULL, NULL, 'Gratis', '2022-12-12 03:41:54', NULL, NULL, NULL),
(931, 2, 'P20222931', 'AprilYandi Dwi W 931', '56419974931', '3276022304010010931', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243931', 'Kp.Babakan No. 931', 'Islam', 2, 2, '150000.00', 2, 'Belum', '2022-12-12 03:41:55', NULL, NULL, NULL),
(932, 1, 'P20221932', 'AprilYandi Dwi W 932', '56419974932', '3276022304010010932', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243932', 'Kp.Babakan No. 932', 'Islam', 3, 9, '150000.00', 4, 'Sudah', '2022-12-12 03:41:55', NULL, NULL, NULL),
(933, 1, 'P20221933', 'AprilYandi Dwi W 933', '56419974933', '3276022304010010933', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243933', 'Kp.Babakan No. 933', 'Islam', 6, 12, '150000.00', 4, 'Sudah', '2022-12-12 03:41:55', NULL, NULL, NULL),
(934, 1, 'P20221934', 'AprilYandi Dwi W 934', '56419974934', '3276022304010010934', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243934', 'Kp.Babakan No. 934', 'Islam', 4, 11, '150000.00', 3, 'Sudah', '2022-12-12 03:41:55', NULL, NULL, NULL),
(935, 3, 'P20223935', 'AprilYandi Dwi W 935', '56419974935', '3276022304010010935', 'Depok', '2001-12-29', 'Perempuan', '08810243935', 'Kp.Babakan No. 935', 'Islam', 12, 7, NULL, NULL, 'Gratis', '2022-12-12 03:41:55', NULL, NULL, NULL),
(936, 3, 'P20223936', 'AprilYandi Dwi W 936', '56419974936', '3276022304010010936', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243936', 'Kp.Babakan No. 936', 'Islam', 6, 7, NULL, NULL, 'Gratis', '2022-12-12 03:41:55', NULL, NULL, NULL),
(937, 2, 'P20222937', 'AprilYandi Dwi W 937', '56419974937', '3276022304010010937', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243937', 'Kp.Babakan No. 937', 'Islam', 2, 12, '150000.00', 3, 'Sudah', '2022-12-12 03:41:55', NULL, NULL, NULL),
(938, 1, 'P20221938', 'AprilYandi Dwi W 938', '56419974938', '3276022304010010938', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243938', 'Kp.Babakan No. 938', 'Islam', 2, 9, '150000.00', 4, 'Belum', '2022-12-12 03:41:55', NULL, NULL, NULL),
(939, 2, 'P20222939', 'AprilYandi Dwi W 939', '56419974939', '3276022304010010939', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243939', 'Kp.Babakan No. 939', 'Islam', 11, 11, '150000.00', 2, 'Sudah', '2022-12-12 03:41:55', NULL, NULL, NULL),
(940, 1, 'P20221940', 'AprilYandi Dwi W 940', '56419974940', '3276022304010010940', 'Depok', '2001-12-06', 'Perempuan', '08810243940', 'Kp.Babakan No. 940', 'Islam', 6, 5, '150000.00', 1, 'Sudah', '2022-12-12 03:41:55', NULL, NULL, NULL),
(941, 2, 'P20222941', 'AprilYandi Dwi W 941', '56419974941', '3276022304010010941', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243941', 'Kp.Babakan No. 941', 'Islam', 4, 7, '150000.00', 2, 'Sudah', '2022-12-12 03:41:55', NULL, NULL, NULL),
(942, 3, 'P20223942', 'AprilYandi Dwi W 942', '56419974942', '3276022304010010942', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243942', 'Kp.Babakan No. 942', 'Islam', 6, 10, NULL, NULL, 'Gratis', '2022-12-12 03:41:55', NULL, NULL, NULL),
(943, 2, 'P20222943', 'AprilYandi Dwi W 943', '56419974943', '3276022304010010943', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243943', 'Kp.Babakan No. 943', 'Islam', 3, 13, '150000.00', 4, 'Sudah', '2022-12-12 03:41:55', NULL, NULL, NULL),
(944, 2, 'P20222944', 'AprilYandi Dwi W 944', '56419974944', '3276022304010010944', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243944', 'Kp.Babakan No. 944', 'Islam', 9, 5, '150000.00', 1, 'Sudah', '2022-12-12 03:41:55', NULL, NULL, NULL),
(945, 3, 'P20223945', 'AprilYandi Dwi W 945', '56419974945', '3276022304010010945', 'Depok', '2001-12-07', 'Perempuan', '08810243945', 'Kp.Babakan No. 945', 'Islam', 9, 13, NULL, NULL, 'Belum', '2022-12-12 03:41:56', NULL, NULL, NULL),
(946, 2, 'P20222946', 'AprilYandi Dwi W 946', '56419974946', '3276022304010010946', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243946', 'Kp.Babakan No. 946', 'Islam', 6, 6, '150000.00', 4, 'Sudah', '2022-12-12 03:41:56', NULL, NULL, NULL),
(947, 3, 'P20223947', 'AprilYandi Dwi W 947', '56419974947', '3276022304010010947', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243947', 'Kp.Babakan No. 947', 'Islam', 12, 12, NULL, NULL, 'Gratis', '2022-12-12 03:41:56', NULL, NULL, NULL),
(948, 3, 'P20223948', 'AprilYandi Dwi W 948', '56419974948', '3276022304010010948', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243948', 'Kp.Babakan No. 948', 'Islam', 8, 9, NULL, NULL, 'Gratis', '2022-12-12 03:41:56', NULL, NULL, NULL),
(949, 3, 'P20223949', 'AprilYandi Dwi W 949', '56419974949', '3276022304010010949', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243949', 'Kp.Babakan No. 949', 'Islam', 10, 3, NULL, NULL, 'Gratis', '2022-12-12 03:41:56', NULL, NULL, NULL),
(950, 3, 'P20223950', 'AprilYandi Dwi W 950', '56419974950', '3276022304010010950', 'Depok', '2001-12-07', 'Perempuan', '08810243950', 'Kp.Babakan No. 950', 'Islam', 4, 9, NULL, NULL, 'Gratis', '2022-12-12 03:41:56', NULL, NULL, NULL),
(951, 3, 'P20223951', 'AprilYandi Dwi W 951', '56419974951', '3276022304010010951', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243951', 'Kp.Babakan No. 951', 'Islam', 6, 3, NULL, NULL, 'Gratis', '2022-12-12 03:41:56', NULL, NULL, NULL),
(952, 1, 'P20221952', 'AprilYandi Dwi W 952', '56419974952', '3276022304010010952', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243952', 'Kp.Babakan No. 952', 'Islam', 9, 13, '150000.00', 4, 'Belum', '2022-12-12 03:41:56', NULL, NULL, NULL),
(953, 3, 'P20223953', 'AprilYandi Dwi W 953', '56419974953', '3276022304010010953', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243953', 'Kp.Babakan No. 953', 'Islam', 11, 8, NULL, NULL, 'Gratis', '2022-12-12 03:41:56', NULL, NULL, NULL),
(954, 3, 'P20223954', 'AprilYandi Dwi W 954', '56419974954', '3276022304010010954', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243954', 'Kp.Babakan No. 954', 'Islam', 11, 1, NULL, NULL, 'Gratis', '2022-12-12 03:41:56', NULL, NULL, NULL),
(955, 3, 'P20223955', 'AprilYandi Dwi W 955', '56419974955', '3276022304010010955', 'Depok', '2001-12-27', 'Perempuan', '08810243955', 'Kp.Babakan No. 955', 'Islam', 7, 7, NULL, NULL, 'Gratis', '2022-12-12 03:41:57', NULL, NULL, NULL),
(956, 2, 'P20222956', 'AprilYandi Dwi W 956', '56419974956', '3276022304010010956', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243956', 'Kp.Babakan No. 956', 'Islam', 3, 9, '150000.00', 1, 'Sudah', '2022-12-12 03:41:57', NULL, NULL, NULL),
(957, 1, 'P20221957', 'AprilYandi Dwi W 957', '56419974957', '3276022304010010957', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243957', 'Kp.Babakan No. 957', 'Islam', 5, 11, '150000.00', 4, 'Sudah', '2022-12-12 03:41:57', NULL, NULL, NULL),
(958, 2, 'P20222958', 'AprilYandi Dwi W 958', '56419974958', '3276022304010010958', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243958', 'Kp.Babakan No. 958', 'Islam', 3, 1, '150000.00', 1, 'Sudah', '2022-12-12 03:41:57', NULL, NULL, NULL),
(959, 2, 'P20222959', 'AprilYandi Dwi W 959', '56419974959', '3276022304010010959', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243959', 'Kp.Babakan No. 959', 'Islam', 2, 6, '150000.00', 1, 'Belum', '2022-12-12 03:41:57', NULL, NULL, NULL),
(960, 3, 'P20223960', 'AprilYandi Dwi W 960', '56419974960', '3276022304010010960', 'Depok', '2001-12-26', 'Perempuan', '08810243960', 'Kp.Babakan No. 960', 'Islam', 6, 12, NULL, NULL, 'Gratis', '2022-12-12 03:41:57', NULL, NULL, NULL),
(961, 1, 'P20221961', 'AprilYandi Dwi W 961', '56419974961', '3276022304010010961', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243961', 'Kp.Babakan No. 961', 'Islam', 7, 12, '150000.00', 3, 'Sudah', '2022-12-12 03:41:57', NULL, NULL, NULL),
(962, 3, 'P20223962', 'AprilYandi Dwi W 962', '56419974962', '3276022304010010962', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243962', 'Kp.Babakan No. 962', 'Islam', 11, 4, NULL, NULL, 'Gratis', '2022-12-12 03:41:57', NULL, NULL, NULL),
(963, 1, 'P20221963', 'AprilYandi Dwi W 963', '56419974963', '3276022304010010963', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243963', 'Kp.Babakan No. 963', 'Islam', 13, 13, '150000.00', 3, 'Sudah', '2022-12-12 03:41:57', NULL, NULL, NULL),
(964, 2, 'P20222964', 'AprilYandi Dwi W 964', '56419974964', '3276022304010010964', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243964', 'Kp.Babakan No. 964', 'Islam', 2, 13, '150000.00', 1, 'Sudah', '2022-12-12 03:41:57', NULL, NULL, NULL),
(965, 3, 'P20223965', 'AprilYandi Dwi W 965', '56419974965', '3276022304010010965', 'Depok', '2001-12-27', 'Perempuan', '08810243965', 'Kp.Babakan No. 965', 'Islam', 2, 8, NULL, NULL, 'Gratis', '2022-12-12 03:41:57', NULL, NULL, NULL),
(966, 3, 'P20223966', 'AprilYandi Dwi W 966', '56419974966', '3276022304010010966', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243966', 'Kp.Babakan No. 966', 'Islam', 12, 7, NULL, NULL, 'Belum', '2022-12-12 03:41:57', NULL, NULL, NULL),
(967, 1, 'P20221967', 'AprilYandi Dwi W 967', '56419974967', '3276022304010010967', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243967', 'Kp.Babakan No. 967', 'Islam', 10, 6, '150000.00', 4, 'Sudah', '2022-12-12 03:41:58', NULL, NULL, NULL),
(968, 3, 'P20223968', 'AprilYandi Dwi W 968', '56419974968', '3276022304010010968', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243968', 'Kp.Babakan No. 968', 'Islam', 10, 9, NULL, NULL, 'Gratis', '2022-12-12 03:41:58', NULL, NULL, NULL),
(969, 1, 'P20221969', 'AprilYandi Dwi W 969', '56419974969', '3276022304010010969', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243969', 'Kp.Babakan No. 969', 'Islam', 6, 4, '150000.00', 2, 'Sudah', '2022-12-12 03:41:58', NULL, NULL, NULL),
(970, 2, 'P20222970', 'AprilYandi Dwi W 970', '56419974970', '3276022304010010970', 'Depok', '2001-12-21', 'Perempuan', '08810243970', 'Kp.Babakan No. 970', 'Islam', 13, 5, '150000.00', 4, 'Sudah', '2022-12-12 03:41:58', NULL, NULL, NULL),
(971, 1, 'P20221971', 'AprilYandi Dwi W 971', '56419974971', '3276022304010010971', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243971', 'Kp.Babakan No. 971', 'Islam', 3, 10, '150000.00', 2, 'Sudah', '2022-12-12 03:41:58', NULL, NULL, NULL),
(972, 3, 'P20223972', 'AprilYandi Dwi W 972', '56419974972', '3276022304010010972', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243972', 'Kp.Babakan No. 972', 'Islam', 6, 8, NULL, NULL, 'Gratis', '2022-12-12 03:41:59', NULL, NULL, NULL),
(973, 3, 'P20223973', 'AprilYandi Dwi W 973', '56419974973', '3276022304010010973', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243973', 'Kp.Babakan No. 973', 'Islam', 7, 1, NULL, NULL, 'Belum', '2022-12-12 03:42:00', NULL, NULL, NULL),
(974, 3, 'P20223974', 'AprilYandi Dwi W 974', '56419974974', '3276022304010010974', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243974', 'Kp.Babakan No. 974', 'Islam', 11, 5, NULL, NULL, 'Gratis', '2022-12-12 03:42:00', NULL, NULL, NULL),
(975, 2, 'P20222975', 'AprilYandi Dwi W 975', '56419974975', '3276022304010010975', 'Depok', '2001-12-28', 'Perempuan', '08810243975', 'Kp.Babakan No. 975', 'Islam', 8, 11, '150000.00', 4, 'Sudah', '2022-12-12 03:42:00', NULL, NULL, NULL),
(976, 1, 'P20221976', 'AprilYandi Dwi W 976', '56419974976', '3276022304010010976', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243976', 'Kp.Babakan No. 976', 'Islam', 2, 9, '150000.00', 1, 'Sudah', '2022-12-12 03:42:00', NULL, NULL, NULL),
(977, 1, 'P20221977', 'AprilYandi Dwi W 977', '56419974977', '3276022304010010977', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243977', 'Kp.Babakan No. 977', 'Islam', 2, 7, '150000.00', 1, 'Sudah', '2022-12-12 03:42:00', NULL, NULL, NULL),
(978, 2, 'P20222978', 'AprilYandi Dwi W 978', '56419974978', '3276022304010010978', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243978', 'Kp.Babakan No. 978', 'Islam', 3, 7, '150000.00', 3, 'Sudah', '2022-12-12 03:42:01', NULL, NULL, NULL),
(979, 3, 'P20223979', 'AprilYandi Dwi W 979', '56419974979', '3276022304010010979', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243979', 'Kp.Babakan No. 979', 'Islam', 4, 9, NULL, NULL, 'Gratis', '2022-12-12 03:42:01', NULL, NULL, NULL),
(980, 1, 'P20221980', 'AprilYandi Dwi W 980', '56419974980', '3276022304010010980', 'Depok', '2001-12-30', 'Perempuan', '08810243980', 'Kp.Babakan No. 980', 'Islam', 3, 4, '150000.00', 1, 'Belum', '2022-12-12 03:42:01', NULL, NULL, NULL),
(981, 3, 'P20223981', 'AprilYandi Dwi W 981', '56419974981', '3276022304010010981', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243981', 'Kp.Babakan No. 981', 'Islam', 7, 11, NULL, NULL, 'Gratis', '2022-12-12 03:42:02', NULL, NULL, NULL),
(982, 1, 'P20221982', 'AprilYandi Dwi W 982', '56419974982', '3276022304010010982', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243982', 'Kp.Babakan No. 982', 'Islam', 8, 13, '150000.00', 3, 'Sudah', '2022-12-12 03:42:02', NULL, NULL, NULL),
(983, 3, 'P20223983', 'AprilYandi Dwi W 983', '56419974983', '3276022304010010983', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243983', 'Kp.Babakan No. 983', 'Islam', 12, 8, NULL, NULL, 'Gratis', '2022-12-12 03:42:02', NULL, NULL, NULL),
(984, 1, 'P20221984', 'AprilYandi Dwi W 984', '56419974984', '3276022304010010984', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243984', 'Kp.Babakan No. 984', 'Islam', 13, 13, '150000.00', 2, 'Sudah', '2022-12-12 03:42:02', NULL, NULL, NULL),
(985, 3, 'P20223985', 'AprilYandi Dwi W 985', '56419974985', '3276022304010010985', 'Depok', '2001-12-05', 'Perempuan', '08810243985', 'Kp.Babakan No. 985', 'Islam', 4, 4, NULL, NULL, 'Gratis', '2022-12-12 03:42:02', NULL, NULL, NULL),
(986, 1, 'P20221986', 'AprilYandi Dwi W 986', '56419974986', '3276022304010010986', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243986', 'Kp.Babakan No. 986', 'Islam', 6, 11, '150000.00', 2, 'Sudah', '2022-12-12 03:42:02', NULL, NULL, NULL),
(987, 2, 'P20222987', 'AprilYandi Dwi W 987', '56419974987', '3276022304010010987', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243987', 'Kp.Babakan No. 987', 'Islam', 2, 8, '150000.00', 1, 'Belum', '2022-12-12 03:42:02', NULL, NULL, NULL),
(988, 1, 'P20221988', 'AprilYandi Dwi W 988', '56419974988', '3276022304010010988', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243988', 'Kp.Babakan No. 988', 'Islam', 10, 4, '150000.00', 4, 'Sudah', '2022-12-12 03:42:02', NULL, NULL, NULL),
(989, 3, 'P20223989', 'AprilYandi Dwi W 989', '56419974989', '3276022304010010989', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243989', 'Kp.Babakan No. 989', 'Islam', 11, 5, NULL, NULL, 'Gratis', '2022-12-12 03:42:03', NULL, NULL, NULL),
(990, 1, 'P20221990', 'AprilYandi Dwi W 990', '56419974990', '3276022304010010990', 'Depok', '2001-12-22', 'Perempuan', '08810243990', 'Kp.Babakan No. 990', 'Islam', 3, 4, '150000.00', 2, 'Sudah', '2022-12-12 03:42:03', NULL, NULL, NULL),
(991, 3, 'P20223991', 'AprilYandi Dwi W 991', '56419974991', '3276022304010010991', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243991', 'Kp.Babakan No. 991', 'Islam', 2, 5, NULL, NULL, 'Gratis', '2022-12-12 03:42:03', NULL, NULL, NULL),
(992, 1, 'P20221992', 'AprilYandi Dwi W 992', '56419974992', '3276022304010010992', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243992', 'Kp.Babakan No. 992', 'Islam', 10, 13, '150000.00', 2, 'Sudah', '2022-12-12 03:42:03', NULL, NULL, NULL),
(993, 2, 'P20222993', 'AprilYandi Dwi W 993', '56419974993', '3276022304010010993', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243993', 'Kp.Babakan No. 993', 'Islam', 4, 10, '150000.00', 2, 'Sudah', '2022-12-12 03:42:03', NULL, NULL, NULL),
(994, 3, 'P20223994', 'AprilYandi Dwi W 994', '56419974994', '3276022304010010994', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243994', 'Kp.Babakan No. 994', 'Islam', 13, 10, NULL, NULL, 'Belum', '2022-12-12 03:42:03', NULL, NULL, NULL),
(995, 3, 'P20223995', 'AprilYandi Dwi W 995', '56419974995', '3276022304010010995', 'Depok', '2001-12-11', 'Perempuan', '08810243995', 'Kp.Babakan No. 995', 'Islam', 1, 13, NULL, NULL, 'Gratis', '2022-12-12 03:42:03', NULL, NULL, NULL),
(996, 2, 'P20222996', 'AprilYandi Dwi W 996', '56419974996', '3276022304010010996', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243996', 'Kp.Babakan No. 996', 'Islam', 1, 2, '150000.00', 4, 'Sudah', '2022-12-12 03:42:04', NULL, NULL, NULL),
(997, 3, 'P20223997', 'AprilYandi Dwi W 997', '56419974997', '3276022304010010997', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243997', 'Kp.Babakan No. 997', 'Islam', 13, 3, NULL, NULL, 'Gratis', '2022-12-12 03:42:04', NULL, NULL, NULL),
(998, 3, 'P20223998', 'AprilYandi Dwi W 998', '56419974998', '3276022304010010998', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243998', 'Kp.Babakan No. 998', 'Islam', 5, 13, NULL, NULL, 'Gratis', '2022-12-12 03:42:04', NULL, NULL, NULL),
(999, 1, 'P20221999', 'AprilYandi Dwi W 999', '56419974999', '3276022304010010999', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243999', 'Kp.Babakan No. 999', 'Islam', 12, 9, '150000.00', 2, 'Sudah', '2022-12-12 03:42:04', NULL, NULL, NULL),
(1000, 2, 'P202221000', 'AprilYandi Dwi W 1000', '564199741000', '32760223040100101000', 'Depok', '2001-12-31', 'Perempuan', '088102431000', 'Kp.Babakan No. 1000', 'Islam', 4, 6, '150000.00', 2, 'Sudah', '2022-12-12 03:42:04', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pendaftar_prestasi`
--

CREATE TABLE `pendaftar_prestasi` (
  `id` int(11) NOT NULL,
  `id_pendaftar` int(11) NOT NULL DEFAULT 0,
  `tingkat_prestasi` enum('NASIONAL','INTERNASIONAL') NOT NULL DEFAULT 'NASIONAL',
  `nama_prestasi` varchar(255) NOT NULL,
  `tahun` int(11) NOT NULL,
  `url_dokumen` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pendaftar_prestasi`
--

INSERT INTO `pendaftar_prestasi` (`id`, `id_pendaftar`, `tingkat_prestasi`, `nama_prestasi`, `tahun`, `url_dokumen`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 2, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 2', 2022, 'public/uploads/prestasi/2', '2022-12-12 03:39:27', NULL, NULL, NULL),
(2, 3, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 3', 2022, 'public/uploads/prestasi/3', '2022-12-12 03:39:27', NULL, NULL, NULL),
(3, 4, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 4', 2022, 'public/uploads/prestasi/4', '2022-12-12 03:39:27', NULL, NULL, NULL),
(4, 6, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 6', 2022, 'public/uploads/prestasi/6', '2022-12-12 03:39:28', NULL, NULL, NULL),
(5, 7, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 7', 2022, 'public/uploads/prestasi/7', '2022-12-12 03:39:28', NULL, NULL, NULL),
(6, 10, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 10', 2022, 'public/uploads/prestasi/10', '2022-12-12 03:39:29', NULL, NULL, NULL),
(7, 11, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 11', 2022, 'public/uploads/prestasi/11', '2022-12-12 03:39:29', NULL, NULL, NULL),
(8, 16, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 16', 2022, 'public/uploads/prestasi/16', '2022-12-12 03:39:30', NULL, NULL, NULL),
(9, 20, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 20', 2022, 'public/uploads/prestasi/20', '2022-12-12 03:39:30', NULL, NULL, NULL),
(10, 21, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 21', 2022, 'public/uploads/prestasi/21', '2022-12-12 03:39:31', NULL, NULL, NULL),
(11, 23, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 23', 2022, 'public/uploads/prestasi/23', '2022-12-12 03:39:31', NULL, NULL, NULL),
(12, 24, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 24', 2022, 'public/uploads/prestasi/24', '2022-12-12 03:39:31', NULL, NULL, NULL),
(13, 28, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 28', 2022, 'public/uploads/prestasi/28', '2022-12-12 03:39:32', NULL, NULL, NULL),
(14, 29, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 29', 2022, 'public/uploads/prestasi/29', '2022-12-12 03:39:32', NULL, NULL, NULL),
(15, 32, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 32', 2022, 'public/uploads/prestasi/32', '2022-12-12 03:39:32', NULL, NULL, NULL),
(16, 35, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 35', 2022, 'public/uploads/prestasi/35', '2022-12-12 03:39:33', NULL, NULL, NULL),
(17, 36, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 36', 2022, 'public/uploads/prestasi/36', '2022-12-12 03:39:33', NULL, NULL, NULL),
(18, 37, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 37', 2022, 'public/uploads/prestasi/37', '2022-12-12 03:39:33', NULL, NULL, NULL),
(19, 42, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 42', 2022, 'public/uploads/prestasi/42', '2022-12-12 03:39:34', NULL, NULL, NULL),
(20, 44, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 44', 2022, 'public/uploads/prestasi/44', '2022-12-12 03:39:34', NULL, NULL, NULL),
(21, 45, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 45', 2022, 'public/uploads/prestasi/45', '2022-12-12 03:39:35', NULL, NULL, NULL),
(22, 47, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 47', 2022, 'public/uploads/prestasi/47', '2022-12-12 03:39:35', NULL, NULL, NULL),
(23, 49, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 49', 2022, 'public/uploads/prestasi/49', '2022-12-12 03:39:35', NULL, NULL, NULL),
(24, 50, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 50', 2022, 'public/uploads/prestasi/50', '2022-12-12 03:39:35', NULL, NULL, NULL),
(25, 51, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 51', 2022, 'public/uploads/prestasi/51', '2022-12-12 03:39:35', NULL, NULL, NULL),
(26, 52, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 52', 2022, 'public/uploads/prestasi/52', '2022-12-12 03:39:35', NULL, NULL, NULL),
(27, 55, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 55', 2022, 'public/uploads/prestasi/55', '2022-12-12 03:39:35', NULL, NULL, NULL),
(28, 56, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 56', 2022, 'public/uploads/prestasi/56', '2022-12-12 03:39:36', NULL, NULL, NULL),
(29, 60, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 60', 2022, 'public/uploads/prestasi/60', '2022-12-12 03:39:36', NULL, NULL, NULL),
(30, 61, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 61', 2022, 'public/uploads/prestasi/61', '2022-12-12 03:39:36', NULL, NULL, NULL),
(31, 68, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 68', 2022, 'public/uploads/prestasi/68', '2022-12-12 03:39:37', NULL, NULL, NULL),
(32, 69, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 69', 2022, 'public/uploads/prestasi/69', '2022-12-12 03:39:37', NULL, NULL, NULL),
(33, 73, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 73', 2022, 'public/uploads/prestasi/73', '2022-12-12 03:39:37', NULL, NULL, NULL),
(34, 75, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 75', 2022, 'public/uploads/prestasi/75', '2022-12-12 03:39:38', NULL, NULL, NULL),
(35, 82, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 82', 2022, 'public/uploads/prestasi/82', '2022-12-12 03:39:39', NULL, NULL, NULL),
(36, 88, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 88', 2022, 'public/uploads/prestasi/88', '2022-12-12 03:39:39', NULL, NULL, NULL),
(37, 89, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 89', 2022, 'public/uploads/prestasi/89', '2022-12-12 03:39:39', NULL, NULL, NULL),
(38, 90, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 90', 2022, 'public/uploads/prestasi/90', '2022-12-12 03:39:39', NULL, NULL, NULL),
(39, 95, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 95', 2022, 'public/uploads/prestasi/95', '2022-12-12 03:39:41', NULL, NULL, NULL),
(40, 101, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 101', 2022, 'public/uploads/prestasi/101', '2022-12-12 03:39:42', NULL, NULL, NULL),
(41, 102, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 102', 2022, 'public/uploads/prestasi/102', '2022-12-12 03:39:43', NULL, NULL, NULL),
(42, 105, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 105', 2022, 'public/uploads/prestasi/105', '2022-12-12 03:39:43', NULL, NULL, NULL),
(43, 109, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 109', 2022, 'public/uploads/prestasi/109', '2022-12-12 03:39:44', NULL, NULL, NULL),
(44, 110, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 110', 2022, 'public/uploads/prestasi/110', '2022-12-12 03:39:44', NULL, NULL, NULL),
(45, 111, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 111', 2022, 'public/uploads/prestasi/111', '2022-12-12 03:39:45', NULL, NULL, NULL),
(46, 113, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 113', 2022, 'public/uploads/prestasi/113', '2022-12-12 03:39:45', NULL, NULL, NULL),
(47, 117, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 117', 2022, 'public/uploads/prestasi/117', '2022-12-12 03:39:46', NULL, NULL, NULL),
(48, 121, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 121', 2022, 'public/uploads/prestasi/121', '2022-12-12 03:39:47', NULL, NULL, NULL),
(49, 126, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 126', 2022, 'public/uploads/prestasi/126', '2022-12-12 03:39:47', NULL, NULL, NULL),
(50, 132, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 132', 2022, 'public/uploads/prestasi/132', '2022-12-12 03:39:49', NULL, NULL, NULL),
(51, 139, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 139', 2022, 'public/uploads/prestasi/139', '2022-12-12 03:39:50', NULL, NULL, NULL),
(52, 142, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 142', 2022, 'public/uploads/prestasi/142', '2022-12-12 03:39:51', NULL, NULL, NULL),
(53, 144, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 144', 2022, 'public/uploads/prestasi/144', '2022-12-12 03:39:51', NULL, NULL, NULL),
(54, 145, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 145', 2022, 'public/uploads/prestasi/145', '2022-12-12 03:39:51', NULL, NULL, NULL),
(55, 147, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 147', 2022, 'public/uploads/prestasi/147', '2022-12-12 03:39:51', NULL, NULL, NULL),
(56, 149, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 149', 2022, 'public/uploads/prestasi/149', '2022-12-12 03:39:51', NULL, NULL, NULL),
(57, 150, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 150', 2022, 'public/uploads/prestasi/150', '2022-12-12 03:39:51', NULL, NULL, NULL),
(58, 151, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 151', 2022, 'public/uploads/prestasi/151', '2022-12-12 03:39:51', NULL, NULL, NULL),
(59, 158, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 158', 2022, 'public/uploads/prestasi/158', '2022-12-12 03:39:52', NULL, NULL, NULL),
(60, 167, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 167', 2022, 'public/uploads/prestasi/167', '2022-12-12 03:39:53', NULL, NULL, NULL),
(61, 168, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 168', 2022, 'public/uploads/prestasi/168', '2022-12-12 03:39:53', NULL, NULL, NULL),
(62, 171, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 171', 2022, 'public/uploads/prestasi/171', '2022-12-12 03:39:53', NULL, NULL, NULL),
(63, 172, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 172', 2022, 'public/uploads/prestasi/172', '2022-12-12 03:39:53', NULL, NULL, NULL),
(64, 174, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 174', 2022, 'public/uploads/prestasi/174', '2022-12-12 03:39:53', NULL, NULL, NULL),
(65, 176, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 176', 2022, 'public/uploads/prestasi/176', '2022-12-12 03:39:58', NULL, NULL, NULL),
(66, 179, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 179', 2022, 'public/uploads/prestasi/179', '2022-12-12 03:39:59', NULL, NULL, NULL),
(67, 181, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 181', 2022, 'public/uploads/prestasi/181', '2022-12-12 03:40:00', NULL, NULL, NULL),
(68, 186, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 186', 2022, 'public/uploads/prestasi/186', '2022-12-12 03:40:00', NULL, NULL, NULL),
(69, 190, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 190', 2022, 'public/uploads/prestasi/190', '2022-12-12 03:40:01', NULL, NULL, NULL),
(70, 193, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 193', 2022, 'public/uploads/prestasi/193', '2022-12-12 03:40:01', NULL, NULL, NULL),
(71, 194, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 194', 2022, 'public/uploads/prestasi/194', '2022-12-12 03:40:01', NULL, NULL, NULL),
(72, 195, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 195', 2022, 'public/uploads/prestasi/195', '2022-12-12 03:40:01', NULL, NULL, NULL),
(73, 197, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 197', 2022, 'public/uploads/prestasi/197', '2022-12-12 03:40:01', NULL, NULL, NULL),
(74, 198, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 198', 2022, 'public/uploads/prestasi/198', '2022-12-12 03:40:01', NULL, NULL, NULL),
(75, 203, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 203', 2022, 'public/uploads/prestasi/203', '2022-12-12 03:40:02', NULL, NULL, NULL),
(76, 205, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 205', 2022, 'public/uploads/prestasi/205', '2022-12-12 03:40:02', NULL, NULL, NULL),
(77, 206, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 206', 2022, 'public/uploads/prestasi/206', '2022-12-12 03:40:02', NULL, NULL, NULL),
(78, 209, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 209', 2022, 'public/uploads/prestasi/209', '2022-12-12 03:40:02', NULL, NULL, NULL),
(79, 210, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 210', 2022, 'public/uploads/prestasi/210', '2022-12-12 03:40:02', NULL, NULL, NULL),
(80, 214, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 214', 2022, 'public/uploads/prestasi/214', '2022-12-12 03:40:03', NULL, NULL, NULL),
(81, 216, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 216', 2022, 'public/uploads/prestasi/216', '2022-12-12 03:40:03', NULL, NULL, NULL),
(82, 217, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 217', 2022, 'public/uploads/prestasi/217', '2022-12-12 03:40:03', NULL, NULL, NULL),
(83, 219, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 219', 2022, 'public/uploads/prestasi/219', '2022-12-12 03:40:03', NULL, NULL, NULL),
(84, 221, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 221', 2022, 'public/uploads/prestasi/221', '2022-12-12 03:40:04', NULL, NULL, NULL),
(85, 224, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 224', 2022, 'public/uploads/prestasi/224', '2022-12-12 03:40:04', NULL, NULL, NULL),
(86, 225, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 225', 2022, 'public/uploads/prestasi/225', '2022-12-12 03:40:04', NULL, NULL, NULL),
(87, 236, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 236', 2022, 'public/uploads/prestasi/236', '2022-12-12 03:40:05', NULL, NULL, NULL),
(88, 243, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 243', 2022, 'public/uploads/prestasi/243', '2022-12-12 03:40:06', NULL, NULL, NULL),
(89, 244, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 244', 2022, 'public/uploads/prestasi/244', '2022-12-12 03:40:06', NULL, NULL, NULL),
(90, 249, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 249', 2022, 'public/uploads/prestasi/249', '2022-12-12 03:40:07', NULL, NULL, NULL),
(91, 250, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 250', 2022, 'public/uploads/prestasi/250', '2022-12-12 03:40:07', NULL, NULL, NULL),
(92, 251, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 251', 2022, 'public/uploads/prestasi/251', '2022-12-12 03:40:07', NULL, NULL, NULL),
(93, 253, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 253', 2022, 'public/uploads/prestasi/253', '2022-12-12 03:40:07', NULL, NULL, NULL),
(94, 254, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 254', 2022, 'public/uploads/prestasi/254', '2022-12-12 03:40:08', NULL, NULL, NULL),
(95, 257, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 257', 2022, 'public/uploads/prestasi/257', '2022-12-12 03:40:08', NULL, NULL, NULL),
(96, 258, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 258', 2022, 'public/uploads/prestasi/258', '2022-12-12 03:40:08', NULL, NULL, NULL),
(97, 265, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 265', 2022, 'public/uploads/prestasi/265', '2022-12-12 03:40:09', NULL, NULL, NULL),
(98, 269, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 269', 2022, 'public/uploads/prestasi/269', '2022-12-12 03:40:10', NULL, NULL, NULL),
(99, 270, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 270', 2022, 'public/uploads/prestasi/270', '2022-12-12 03:40:11', NULL, NULL, NULL),
(100, 273, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 273', 2022, 'public/uploads/prestasi/273', '2022-12-12 03:40:12', NULL, NULL, NULL),
(101, 281, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 281', 2022, 'public/uploads/prestasi/281', '2022-12-12 03:40:15', NULL, NULL, NULL),
(102, 284, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 284', 2022, 'public/uploads/prestasi/284', '2022-12-12 03:40:15', NULL, NULL, NULL),
(103, 288, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 288', 2022, 'public/uploads/prestasi/288', '2022-12-12 03:40:16', NULL, NULL, NULL),
(104, 295, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 295', 2022, 'public/uploads/prestasi/295', '2022-12-12 03:40:18', NULL, NULL, NULL),
(105, 296, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 296', 2022, 'public/uploads/prestasi/296', '2022-12-12 03:40:19', NULL, NULL, NULL),
(106, 302, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 302', 2022, 'public/uploads/prestasi/302', '2022-12-12 03:40:21', NULL, NULL, NULL),
(107, 305, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 305', 2022, 'public/uploads/prestasi/305', '2022-12-12 03:40:23', NULL, NULL, NULL),
(108, 310, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 310', 2022, 'public/uploads/prestasi/310', '2022-12-12 03:40:24', NULL, NULL, NULL),
(109, 311, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 311', 2022, 'public/uploads/prestasi/311', '2022-12-12 03:40:25', NULL, NULL, NULL),
(110, 314, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 314', 2022, 'public/uploads/prestasi/314', '2022-12-12 03:40:26', NULL, NULL, NULL),
(111, 315, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 315', 2022, 'public/uploads/prestasi/315', '2022-12-12 03:40:26', NULL, NULL, NULL),
(112, 317, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 317', 2022, 'public/uploads/prestasi/317', '2022-12-12 03:40:27', NULL, NULL, NULL),
(113, 318, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 318', 2022, 'public/uploads/prestasi/318', '2022-12-12 03:40:27', NULL, NULL, NULL),
(114, 319, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 319', 2022, 'public/uploads/prestasi/319', '2022-12-12 03:40:28', NULL, NULL, NULL),
(115, 321, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 321', 2022, 'public/uploads/prestasi/321', '2022-12-12 03:40:29', NULL, NULL, NULL),
(116, 330, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 330', 2022, 'public/uploads/prestasi/330', '2022-12-12 03:40:31', NULL, NULL, NULL),
(117, 331, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 331', 2022, 'public/uploads/prestasi/331', '2022-12-12 03:40:31', NULL, NULL, NULL),
(118, 333, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 333', 2022, 'public/uploads/prestasi/333', '2022-12-12 03:40:32', NULL, NULL, NULL),
(119, 335, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 335', 2022, 'public/uploads/prestasi/335', '2022-12-12 03:40:32', NULL, NULL, NULL),
(120, 338, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 338', 2022, 'public/uploads/prestasi/338', '2022-12-12 03:40:35', NULL, NULL, NULL),
(121, 341, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 341', 2022, 'public/uploads/prestasi/341', '2022-12-12 03:40:36', NULL, NULL, NULL),
(122, 342, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 342', 2022, 'public/uploads/prestasi/342', '2022-12-12 03:40:36', NULL, NULL, NULL),
(123, 344, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 344', 2022, 'public/uploads/prestasi/344', '2022-12-12 03:40:37', NULL, NULL, NULL),
(124, 345, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 345', 2022, 'public/uploads/prestasi/345', '2022-12-12 03:40:37', NULL, NULL, NULL),
(125, 350, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 350', 2022, 'public/uploads/prestasi/350', '2022-12-12 03:40:38', NULL, NULL, NULL),
(126, 352, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 352', 2022, 'public/uploads/prestasi/352', '2022-12-12 03:40:39', NULL, NULL, NULL),
(127, 353, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 353', 2022, 'public/uploads/prestasi/353', '2022-12-12 03:40:39', NULL, NULL, NULL),
(128, 355, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 355', 2022, 'public/uploads/prestasi/355', '2022-12-12 03:40:40', NULL, NULL, NULL),
(129, 356, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 356', 2022, 'public/uploads/prestasi/356', '2022-12-12 03:40:40', NULL, NULL, NULL),
(130, 357, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 357', 2022, 'public/uploads/prestasi/357', '2022-12-12 03:40:40', NULL, NULL, NULL),
(131, 359, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 359', 2022, 'public/uploads/prestasi/359', '2022-12-12 03:40:41', NULL, NULL, NULL),
(132, 360, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 360', 2022, 'public/uploads/prestasi/360', '2022-12-12 03:40:41', NULL, NULL, NULL),
(133, 363, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 363', 2022, 'public/uploads/prestasi/363', '2022-12-12 03:40:42', NULL, NULL, NULL),
(134, 369, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 369', 2022, 'public/uploads/prestasi/369', '2022-12-12 03:40:43', NULL, NULL, NULL),
(135, 370, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 370', 2022, 'public/uploads/prestasi/370', '2022-12-12 03:40:44', NULL, NULL, NULL),
(136, 372, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 372', 2022, 'public/uploads/prestasi/372', '2022-12-12 03:40:44', NULL, NULL, NULL),
(137, 374, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 374', 2022, 'public/uploads/prestasi/374', '2022-12-12 03:40:45', NULL, NULL, NULL),
(138, 376, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 376', 2022, 'public/uploads/prestasi/376', '2022-12-12 03:40:45', NULL, NULL, NULL),
(139, 378, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 378', 2022, 'public/uploads/prestasi/378', '2022-12-12 03:40:45', NULL, NULL, NULL),
(140, 380, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 380', 2022, 'public/uploads/prestasi/380', '2022-12-12 03:40:46', NULL, NULL, NULL),
(141, 381, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 381', 2022, 'public/uploads/prestasi/381', '2022-12-12 03:40:46', NULL, NULL, NULL),
(142, 382, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 382', 2022, 'public/uploads/prestasi/382', '2022-12-12 03:40:46', NULL, NULL, NULL),
(143, 384, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 384', 2022, 'public/uploads/prestasi/384', '2022-12-12 03:40:46', NULL, NULL, NULL),
(144, 395, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 395', 2022, 'public/uploads/prestasi/395', '2022-12-12 03:40:47', NULL, NULL, NULL),
(145, 398, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 398', 2022, 'public/uploads/prestasi/398', '2022-12-12 03:40:47', NULL, NULL, NULL),
(146, 401, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 401', 2022, 'public/uploads/prestasi/401', '2022-12-12 03:40:47', NULL, NULL, NULL),
(147, 404, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 404', 2022, 'public/uploads/prestasi/404', '2022-12-12 03:40:47', NULL, NULL, NULL),
(148, 405, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 405', 2022, 'public/uploads/prestasi/405', '2022-12-12 03:40:47', NULL, NULL, NULL),
(149, 407, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 407', 2022, 'public/uploads/prestasi/407', '2022-12-12 03:40:48', NULL, NULL, NULL),
(150, 411, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 411', 2022, 'public/uploads/prestasi/411', '2022-12-12 03:40:48', NULL, NULL, NULL),
(151, 413, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 413', 2022, 'public/uploads/prestasi/413', '2022-12-12 03:40:48', NULL, NULL, NULL),
(152, 415, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 415', 2022, 'public/uploads/prestasi/415', '2022-12-12 03:40:48', NULL, NULL, NULL),
(153, 422, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 422', 2022, 'public/uploads/prestasi/422', '2022-12-12 03:40:49', NULL, NULL, NULL),
(154, 424, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 424', 2022, 'public/uploads/prestasi/424', '2022-12-12 03:40:49', NULL, NULL, NULL),
(155, 426, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 426', 2022, 'public/uploads/prestasi/426', '2022-12-12 03:40:49', NULL, NULL, NULL),
(156, 427, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 427', 2022, 'public/uploads/prestasi/427', '2022-12-12 03:40:49', NULL, NULL, NULL),
(157, 431, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 431', 2022, 'public/uploads/prestasi/431', '2022-12-12 03:40:50', NULL, NULL, NULL),
(158, 437, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 437', 2022, 'public/uploads/prestasi/437', '2022-12-12 03:40:50', NULL, NULL, NULL),
(159, 438, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 438', 2022, 'public/uploads/prestasi/438', '2022-12-12 03:40:50', NULL, NULL, NULL),
(160, 439, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 439', 2022, 'public/uploads/prestasi/439', '2022-12-12 03:40:50', NULL, NULL, NULL),
(161, 442, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 442', 2022, 'public/uploads/prestasi/442', '2022-12-12 03:40:51', NULL, NULL, NULL),
(162, 443, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 443', 2022, 'public/uploads/prestasi/443', '2022-12-12 03:40:51', NULL, NULL, NULL),
(163, 449, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 449', 2022, 'public/uploads/prestasi/449', '2022-12-12 03:40:51', NULL, NULL, NULL),
(164, 450, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 450', 2022, 'public/uploads/prestasi/450', '2022-12-12 03:40:51', NULL, NULL, NULL),
(165, 455, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 455', 2022, 'public/uploads/prestasi/455', '2022-12-12 03:40:52', NULL, NULL, NULL),
(166, 461, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 461', 2022, 'public/uploads/prestasi/461', '2022-12-12 03:40:53', NULL, NULL, NULL),
(167, 469, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 469', 2022, 'public/uploads/prestasi/469', '2022-12-12 03:40:53', NULL, NULL, NULL),
(168, 473, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 473', 2022, 'public/uploads/prestasi/473', '2022-12-12 03:40:53', NULL, NULL, NULL),
(169, 476, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 476', 2022, 'public/uploads/prestasi/476', '2022-12-12 03:40:54', NULL, NULL, NULL),
(170, 482, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 482', 2022, 'public/uploads/prestasi/482', '2022-12-12 03:40:54', NULL, NULL, NULL),
(171, 485, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 485', 2022, 'public/uploads/prestasi/485', '2022-12-12 03:40:55', NULL, NULL, NULL),
(172, 486, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 486', 2022, 'public/uploads/prestasi/486', '2022-12-12 03:40:55', NULL, NULL, NULL),
(173, 487, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 487', 2022, 'public/uploads/prestasi/487', '2022-12-12 03:40:55', NULL, NULL, NULL),
(174, 489, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 489', 2022, 'public/uploads/prestasi/489', '2022-12-12 03:40:55', NULL, NULL, NULL),
(175, 492, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 492', 2022, 'public/uploads/prestasi/492', '2022-12-12 03:40:56', NULL, NULL, NULL),
(176, 494, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 494', 2022, 'public/uploads/prestasi/494', '2022-12-12 03:40:56', NULL, NULL, NULL),
(177, 496, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 496', 2022, 'public/uploads/prestasi/496', '2022-12-12 03:40:56', NULL, NULL, NULL),
(178, 501, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 501', 2022, 'public/uploads/prestasi/501', '2022-12-12 03:40:57', NULL, NULL, NULL),
(179, 505, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 505', 2022, 'public/uploads/prestasi/505', '2022-12-12 03:40:57', NULL, NULL, NULL),
(180, 511, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 511', 2022, 'public/uploads/prestasi/511', '2022-12-12 03:40:57', NULL, NULL, NULL),
(181, 514, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 514', 2022, 'public/uploads/prestasi/514', '2022-12-12 03:40:58', NULL, NULL, NULL),
(182, 515, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 515', 2022, 'public/uploads/prestasi/515', '2022-12-12 03:40:58', NULL, NULL, NULL),
(183, 517, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 517', 2022, 'public/uploads/prestasi/517', '2022-12-12 03:40:58', NULL, NULL, NULL),
(184, 518, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 518', 2022, 'public/uploads/prestasi/518', '2022-12-12 03:40:58', NULL, NULL, NULL),
(185, 521, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 521', 2022, 'public/uploads/prestasi/521', '2022-12-12 03:40:58', NULL, NULL, NULL),
(186, 522, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 522', 2022, 'public/uploads/prestasi/522', '2022-12-12 03:40:59', NULL, NULL, NULL),
(187, 523, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 523', 2022, 'public/uploads/prestasi/523', '2022-12-12 03:40:59', NULL, NULL, NULL),
(188, 525, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 525', 2022, 'public/uploads/prestasi/525', '2022-12-12 03:40:59', NULL, NULL, NULL),
(189, 526, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 526', 2022, 'public/uploads/prestasi/526', '2022-12-12 03:41:00', NULL, NULL, NULL),
(190, 528, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 528', 2022, 'public/uploads/prestasi/528', '2022-12-12 03:41:01', NULL, NULL, NULL),
(191, 529, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 529', 2022, 'public/uploads/prestasi/529', '2022-12-12 03:41:01', NULL, NULL, NULL),
(192, 531, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 531', 2022, 'public/uploads/prestasi/531', '2022-12-12 03:41:02', NULL, NULL, NULL),
(193, 534, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 534', 2022, 'public/uploads/prestasi/534', '2022-12-12 03:41:03', NULL, NULL, NULL),
(194, 536, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 536', 2022, 'public/uploads/prestasi/536', '2022-12-12 03:41:03', NULL, NULL, NULL),
(195, 537, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 537', 2022, 'public/uploads/prestasi/537', '2022-12-12 03:41:04', NULL, NULL, NULL),
(196, 538, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 538', 2022, 'public/uploads/prestasi/538', '2022-12-12 03:41:04', NULL, NULL, NULL),
(197, 539, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 539', 2022, 'public/uploads/prestasi/539', '2022-12-12 03:41:05', NULL, NULL, NULL),
(198, 540, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 540', 2022, 'public/uploads/prestasi/540', '2022-12-12 03:41:05', NULL, NULL, NULL),
(199, 545, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 545', 2022, 'public/uploads/prestasi/545', '2022-12-12 03:41:05', NULL, NULL, NULL),
(200, 546, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 546', 2022, 'public/uploads/prestasi/546', '2022-12-12 03:41:06', NULL, NULL, NULL),
(201, 549, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 549', 2022, 'public/uploads/prestasi/549', '2022-12-12 03:41:06', NULL, NULL, NULL),
(202, 551, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 551', 2022, 'public/uploads/prestasi/551', '2022-12-12 03:41:06', NULL, NULL, NULL),
(203, 552, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 552', 2022, 'public/uploads/prestasi/552', '2022-12-12 03:41:06', NULL, NULL, NULL),
(204, 557, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 557', 2022, 'public/uploads/prestasi/557', '2022-12-12 03:41:07', NULL, NULL, NULL),
(205, 560, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 560', 2022, 'public/uploads/prestasi/560', '2022-12-12 03:41:08', NULL, NULL, NULL),
(206, 572, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 572', 2022, 'public/uploads/prestasi/572', '2022-12-12 03:41:10', NULL, NULL, NULL),
(207, 573, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 573', 2022, 'public/uploads/prestasi/573', '2022-12-12 03:41:10', NULL, NULL, NULL),
(208, 576, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 576', 2022, 'public/uploads/prestasi/576', '2022-12-12 03:41:10', NULL, NULL, NULL),
(209, 581, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 581', 2022, 'public/uploads/prestasi/581', '2022-12-12 03:41:11', NULL, NULL, NULL),
(210, 582, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 582', 2022, 'public/uploads/prestasi/582', '2022-12-12 03:41:11', NULL, NULL, NULL),
(211, 583, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 583', 2022, 'public/uploads/prestasi/583', '2022-12-12 03:41:11', NULL, NULL, NULL),
(212, 585, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 585', 2022, 'public/uploads/prestasi/585', '2022-12-12 03:41:11', NULL, NULL, NULL),
(213, 586, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 586', 2022, 'public/uploads/prestasi/586', '2022-12-12 03:41:12', NULL, NULL, NULL),
(214, 587, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 587', 2022, 'public/uploads/prestasi/587', '2022-12-12 03:41:12', NULL, NULL, NULL),
(215, 588, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 588', 2022, 'public/uploads/prestasi/588', '2022-12-12 03:41:12', NULL, NULL, NULL),
(216, 589, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 589', 2022, 'public/uploads/prestasi/589', '2022-12-12 03:41:12', NULL, NULL, NULL),
(217, 590, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 590', 2022, 'public/uploads/prestasi/590', '2022-12-12 03:41:12', NULL, NULL, NULL),
(218, 594, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 594', 2022, 'public/uploads/prestasi/594', '2022-12-12 03:41:13', NULL, NULL, NULL),
(219, 596, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 596', 2022, 'public/uploads/prestasi/596', '2022-12-12 03:41:13', NULL, NULL, NULL),
(220, 599, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 599', 2022, 'public/uploads/prestasi/599', '2022-12-12 03:41:13', NULL, NULL, NULL),
(221, 601, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 601', 2022, 'public/uploads/prestasi/601', '2022-12-12 03:41:14', NULL, NULL, NULL),
(222, 611, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 611', 2022, 'public/uploads/prestasi/611', '2022-12-12 03:41:15', NULL, NULL, NULL),
(223, 612, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 612', 2022, 'public/uploads/prestasi/612', '2022-12-12 03:41:15', NULL, NULL, NULL),
(224, 620, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 620', 2022, 'public/uploads/prestasi/620', '2022-12-12 03:41:16', NULL, NULL, NULL),
(225, 623, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 623', 2022, 'public/uploads/prestasi/623', '2022-12-12 03:41:16', NULL, NULL, NULL),
(226, 625, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 625', 2022, 'public/uploads/prestasi/625', '2022-12-12 03:41:16', NULL, NULL, NULL),
(227, 626, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 626', 2022, 'public/uploads/prestasi/626', '2022-12-12 03:41:16', NULL, NULL, NULL),
(228, 632, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 632', 2022, 'public/uploads/prestasi/632', '2022-12-12 03:41:17', NULL, NULL, NULL),
(229, 633, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 633', 2022, 'public/uploads/prestasi/633', '2022-12-12 03:41:17', NULL, NULL, NULL),
(230, 634, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 634', 2022, 'public/uploads/prestasi/634', '2022-12-12 03:41:17', NULL, NULL, NULL),
(231, 636, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 636', 2022, 'public/uploads/prestasi/636', '2022-12-12 03:41:17', NULL, NULL, NULL),
(232, 644, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 644', 2022, 'public/uploads/prestasi/644', '2022-12-12 03:41:18', NULL, NULL, NULL),
(233, 647, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 647', 2022, 'public/uploads/prestasi/647', '2022-12-12 03:41:18', NULL, NULL, NULL),
(234, 649, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 649', 2022, 'public/uploads/prestasi/649', '2022-12-12 03:41:18', NULL, NULL, NULL),
(235, 653, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 653', 2022, 'public/uploads/prestasi/653', '2022-12-12 03:41:19', NULL, NULL, NULL),
(236, 655, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 655', 2022, 'public/uploads/prestasi/655', '2022-12-12 03:41:19', NULL, NULL, NULL),
(237, 657, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 657', 2022, 'public/uploads/prestasi/657', '2022-12-12 03:41:19', NULL, NULL, NULL),
(238, 658, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 658', 2022, 'public/uploads/prestasi/658', '2022-12-12 03:41:19', NULL, NULL, NULL),
(239, 663, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 663', 2022, 'public/uploads/prestasi/663', '2022-12-12 03:41:20', NULL, NULL, NULL),
(240, 666, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 666', 2022, 'public/uploads/prestasi/666', '2022-12-12 03:41:20', NULL, NULL, NULL),
(241, 667, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 667', 2022, 'public/uploads/prestasi/667', '2022-12-12 03:41:20', NULL, NULL, NULL),
(242, 668, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 668', 2022, 'public/uploads/prestasi/668', '2022-12-12 03:41:20', NULL, NULL, NULL),
(243, 669, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 669', 2022, 'public/uploads/prestasi/669', '2022-12-12 03:41:20', NULL, NULL, NULL),
(244, 670, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 670', 2022, 'public/uploads/prestasi/670', '2022-12-12 03:41:20', NULL, NULL, NULL),
(245, 671, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 671', 2022, 'public/uploads/prestasi/671', '2022-12-12 03:41:20', NULL, NULL, NULL),
(246, 672, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 672', 2022, 'public/uploads/prestasi/672', '2022-12-12 03:41:20', NULL, NULL, NULL),
(247, 673, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 673', 2022, 'public/uploads/prestasi/673', '2022-12-12 03:41:21', NULL, NULL, NULL),
(248, 678, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 678', 2022, 'public/uploads/prestasi/678', '2022-12-12 03:41:21', NULL, NULL, NULL),
(249, 680, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 680', 2022, 'public/uploads/prestasi/680', '2022-12-12 03:41:21', NULL, NULL, NULL),
(250, 684, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 684', 2022, 'public/uploads/prestasi/684', '2022-12-12 03:41:22', NULL, NULL, NULL),
(251, 686, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 686', 2022, 'public/uploads/prestasi/686', '2022-12-12 03:41:22', NULL, NULL, NULL),
(252, 688, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 688', 2022, 'public/uploads/prestasi/688', '2022-12-12 03:41:23', NULL, NULL, NULL),
(253, 695, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 695', 2022, 'public/uploads/prestasi/695', '2022-12-12 03:41:24', NULL, NULL, NULL),
(254, 700, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 700', 2022, 'public/uploads/prestasi/700', '2022-12-12 03:41:25', NULL, NULL, NULL),
(255, 703, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 703', 2022, 'public/uploads/prestasi/703', '2022-12-12 03:41:25', NULL, NULL, NULL),
(256, 704, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 704', 2022, 'public/uploads/prestasi/704', '2022-12-12 03:41:25', NULL, NULL, NULL),
(257, 707, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 707', 2022, 'public/uploads/prestasi/707', '2022-12-12 03:41:25', NULL, NULL, NULL),
(258, 708, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 708', 2022, 'public/uploads/prestasi/708', '2022-12-12 03:41:26', NULL, NULL, NULL),
(259, 710, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 710', 2022, 'public/uploads/prestasi/710', '2022-12-12 03:41:26', NULL, NULL, NULL),
(260, 712, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 712', 2022, 'public/uploads/prestasi/712', '2022-12-12 03:41:27', NULL, NULL, NULL),
(261, 714, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 714', 2022, 'public/uploads/prestasi/714', '2022-12-12 03:41:27', NULL, NULL, NULL),
(262, 719, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 719', 2022, 'public/uploads/prestasi/719', '2022-12-12 03:41:28', NULL, NULL, NULL),
(263, 722, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 722', 2022, 'public/uploads/prestasi/722', '2022-12-12 03:41:28', NULL, NULL, NULL),
(264, 726, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 726', 2022, 'public/uploads/prestasi/726', '2022-12-12 03:41:28', NULL, NULL, NULL),
(265, 727, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 727', 2022, 'public/uploads/prestasi/727', '2022-12-12 03:41:29', NULL, NULL, NULL),
(266, 733, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 733', 2022, 'public/uploads/prestasi/733', '2022-12-12 03:41:29', NULL, NULL, NULL),
(267, 735, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 735', 2022, 'public/uploads/prestasi/735', '2022-12-12 03:41:29', NULL, NULL, NULL),
(268, 745, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 745', 2022, 'public/uploads/prestasi/745', '2022-12-12 03:41:30', NULL, NULL, NULL),
(269, 752, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 752', 2022, 'public/uploads/prestasi/752', '2022-12-12 03:41:30', NULL, NULL, NULL),
(270, 754, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 754', 2022, 'public/uploads/prestasi/754', '2022-12-12 03:41:31', NULL, NULL, NULL),
(271, 759, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 759', 2022, 'public/uploads/prestasi/759', '2022-12-12 03:41:32', NULL, NULL, NULL),
(272, 763, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 763', 2022, 'public/uploads/prestasi/763', '2022-12-12 03:41:32', NULL, NULL, NULL),
(273, 768, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 768', 2022, 'public/uploads/prestasi/768', '2022-12-12 03:41:34', NULL, NULL, NULL),
(274, 771, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 771', 2022, 'public/uploads/prestasi/771', '2022-12-12 03:41:34', NULL, NULL, NULL),
(275, 778, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 778', 2022, 'public/uploads/prestasi/778', '2022-12-12 03:41:35', NULL, NULL, NULL),
(276, 781, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 781', 2022, 'public/uploads/prestasi/781', '2022-12-12 03:41:35', NULL, NULL, NULL),
(277, 784, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 784', 2022, 'public/uploads/prestasi/784', '2022-12-12 03:41:36', NULL, NULL, NULL),
(278, 787, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 787', 2022, 'public/uploads/prestasi/787', '2022-12-12 03:41:36', NULL, NULL, NULL),
(279, 792, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 792', 2022, 'public/uploads/prestasi/792', '2022-12-12 03:41:37', NULL, NULL, NULL),
(280, 793, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 793', 2022, 'public/uploads/prestasi/793', '2022-12-12 03:41:37', NULL, NULL, NULL),
(281, 794, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 794', 2022, 'public/uploads/prestasi/794', '2022-12-12 03:41:37', NULL, NULL, NULL),
(282, 796, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 796', 2022, 'public/uploads/prestasi/796', '2022-12-12 03:41:37', NULL, NULL, NULL),
(283, 797, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 797', 2022, 'public/uploads/prestasi/797', '2022-12-12 03:41:38', NULL, NULL, NULL),
(284, 801, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 801', 2022, 'public/uploads/prestasi/801', '2022-12-12 03:41:38', NULL, NULL, NULL),
(285, 803, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 803', 2022, 'public/uploads/prestasi/803', '2022-12-12 03:41:39', NULL, NULL, NULL),
(286, 805, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 805', 2022, 'public/uploads/prestasi/805', '2022-12-12 03:41:39', NULL, NULL, NULL),
(287, 807, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 807', 2022, 'public/uploads/prestasi/807', '2022-12-12 03:41:39', NULL, NULL, NULL),
(288, 809, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 809', 2022, 'public/uploads/prestasi/809', '2022-12-12 03:41:39', NULL, NULL, NULL),
(289, 821, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 821', 2022, 'public/uploads/prestasi/821', '2022-12-12 03:41:40', NULL, NULL, NULL),
(290, 823, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 823', 2022, 'public/uploads/prestasi/823', '2022-12-12 03:41:41', NULL, NULL, NULL),
(291, 825, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 825', 2022, 'public/uploads/prestasi/825', '2022-12-12 03:41:42', NULL, NULL, NULL),
(292, 827, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 827', 2022, 'public/uploads/prestasi/827', '2022-12-12 03:41:42', NULL, NULL, NULL),
(293, 831, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 831', 2022, 'public/uploads/prestasi/831', '2022-12-12 03:41:43', NULL, NULL, NULL),
(294, 834, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 834', 2022, 'public/uploads/prestasi/834', '2022-12-12 03:41:44', NULL, NULL, NULL),
(295, 836, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 836', 2022, 'public/uploads/prestasi/836', '2022-12-12 03:41:44', NULL, NULL, NULL),
(296, 837, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 837', 2022, 'public/uploads/prestasi/837', '2022-12-12 03:41:44', NULL, NULL, NULL),
(297, 839, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 839', 2022, 'public/uploads/prestasi/839', '2022-12-12 03:41:44', NULL, NULL, NULL),
(298, 842, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 842', 2022, 'public/uploads/prestasi/842', '2022-12-12 03:41:45', NULL, NULL, NULL),
(299, 844, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 844', 2022, 'public/uploads/prestasi/844', '2022-12-12 03:41:45', NULL, NULL, NULL),
(300, 845, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 845', 2022, 'public/uploads/prestasi/845', '2022-12-12 03:41:45', NULL, NULL, NULL),
(301, 846, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 846', 2022, 'public/uploads/prestasi/846', '2022-12-12 03:41:45', NULL, NULL, NULL),
(302, 853, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 853', 2022, 'public/uploads/prestasi/853', '2022-12-12 03:41:45', NULL, NULL, NULL),
(303, 856, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 856', 2022, 'public/uploads/prestasi/856', '2022-12-12 03:41:46', NULL, NULL, NULL),
(304, 857, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 857', 2022, 'public/uploads/prestasi/857', '2022-12-12 03:41:46', NULL, NULL, NULL),
(305, 860, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 860', 2022, 'public/uploads/prestasi/860', '2022-12-12 03:41:46', NULL, NULL, NULL),
(306, 869, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 869', 2022, 'public/uploads/prestasi/869', '2022-12-12 03:41:47', NULL, NULL, NULL),
(307, 875, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 875', 2022, 'public/uploads/prestasi/875', '2022-12-12 03:41:48', NULL, NULL, NULL),
(308, 876, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 876', 2022, 'public/uploads/prestasi/876', '2022-12-12 03:41:48', NULL, NULL, NULL),
(309, 877, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 877', 2022, 'public/uploads/prestasi/877', '2022-12-12 03:41:48', NULL, NULL, NULL),
(310, 880, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 880', 2022, 'public/uploads/prestasi/880', '2022-12-12 03:41:49', NULL, NULL, NULL),
(311, 891, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 891', 2022, 'public/uploads/prestasi/891', '2022-12-12 03:41:52', NULL, NULL, NULL),
(312, 899, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 899', 2022, 'public/uploads/prestasi/899', '2022-12-12 03:41:52', NULL, NULL, NULL),
(313, 907, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 907', 2022, 'public/uploads/prestasi/907', '2022-12-12 03:41:53', NULL, NULL, NULL),
(314, 911, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 911', 2022, 'public/uploads/prestasi/911', '2022-12-12 03:41:53', NULL, NULL, NULL),
(315, 914, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 914', 2022, 'public/uploads/prestasi/914', '2022-12-12 03:41:53', NULL, NULL, NULL),
(316, 916, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 916', 2022, 'public/uploads/prestasi/916', '2022-12-12 03:41:53', NULL, NULL, NULL),
(317, 917, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 917', 2022, 'public/uploads/prestasi/917', '2022-12-12 03:41:54', NULL, NULL, NULL),
(318, 920, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 920', 2022, 'public/uploads/prestasi/920', '2022-12-12 03:41:54', NULL, NULL, NULL),
(319, 921, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 921', 2022, 'public/uploads/prestasi/921', '2022-12-12 03:41:54', NULL, NULL, NULL),
(320, 922, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 922', 2022, 'public/uploads/prestasi/922', '2022-12-12 03:41:54', NULL, NULL, NULL),
(321, 924, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 924', 2022, 'public/uploads/prestasi/924', '2022-12-12 03:41:54', NULL, NULL, NULL),
(322, 930, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 930', 2022, 'public/uploads/prestasi/930', '2022-12-12 03:41:55', NULL, NULL, NULL),
(323, 935, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 935', 2022, 'public/uploads/prestasi/935', '2022-12-12 03:41:55', NULL, NULL, NULL),
(324, 936, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 936', 2022, 'public/uploads/prestasi/936', '2022-12-12 03:41:55', NULL, NULL, NULL),
(325, 942, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 942', 2022, 'public/uploads/prestasi/942', '2022-12-12 03:41:55', NULL, NULL, NULL),
(326, 945, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 945', 2022, 'public/uploads/prestasi/945', '2022-12-12 03:41:56', NULL, NULL, NULL),
(327, 947, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 947', 2022, 'public/uploads/prestasi/947', '2022-12-12 03:41:56', NULL, NULL, NULL),
(328, 948, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 948', 2022, 'public/uploads/prestasi/948', '2022-12-12 03:41:56', NULL, NULL, NULL),
(329, 949, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 949', 2022, 'public/uploads/prestasi/949', '2022-12-12 03:41:56', NULL, NULL, NULL),
(330, 950, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 950', 2022, 'public/uploads/prestasi/950', '2022-12-12 03:41:56', NULL, NULL, NULL),
(331, 951, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 951', 2022, 'public/uploads/prestasi/951', '2022-12-12 03:41:56', NULL, NULL, NULL),
(332, 953, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 953', 2022, 'public/uploads/prestasi/953', '2022-12-12 03:41:56', NULL, NULL, NULL),
(333, 954, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 954', 2022, 'public/uploads/prestasi/954', '2022-12-12 03:41:57', NULL, NULL, NULL),
(334, 955, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 955', 2022, 'public/uploads/prestasi/955', '2022-12-12 03:41:57', NULL, NULL, NULL),
(335, 960, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 960', 2022, 'public/uploads/prestasi/960', '2022-12-12 03:41:57', NULL, NULL, NULL),
(336, 962, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 962', 2022, 'public/uploads/prestasi/962', '2022-12-12 03:41:57', NULL, NULL, NULL),
(337, 965, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 965', 2022, 'public/uploads/prestasi/965', '2022-12-12 03:41:57', NULL, NULL, NULL),
(338, 966, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 966', 2022, 'public/uploads/prestasi/966', '2022-12-12 03:41:58', NULL, NULL, NULL),
(339, 968, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 968', 2022, 'public/uploads/prestasi/968', '2022-12-12 03:41:58', NULL, NULL, NULL),
(340, 972, 'INTERNASIONAL', 'Prestasi INTERNASIONAL AprilYandi Dwi W 972', 2022, 'public/uploads/prestasi/972', '2022-12-12 03:41:59', NULL, NULL, NULL),
(341, 973, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 973', 2022, 'public/uploads/prestasi/973', '2022-12-12 03:42:00', NULL, NULL, NULL),
(342, 974, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 974', 2022, 'public/uploads/prestasi/974', '2022-12-12 03:42:00', NULL, NULL, NULL),
(343, 979, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 979', 2022, 'public/uploads/prestasi/979', '2022-12-12 03:42:01', NULL, NULL, NULL),
(344, 981, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 981', 2022, 'public/uploads/prestasi/981', '2022-12-12 03:42:02', NULL, NULL, NULL),
(345, 983, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 983', 2022, 'public/uploads/prestasi/983', '2022-12-12 03:42:02', NULL, NULL, NULL),
(346, 985, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 985', 2022, 'public/uploads/prestasi/985', '2022-12-12 03:42:02', NULL, NULL, NULL),
(347, 989, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 989', 2022, 'public/uploads/prestasi/989', '2022-12-12 03:42:03', NULL, NULL, NULL);
INSERT INTO `pendaftar_prestasi` (`id`, `id_pendaftar`, `tingkat_prestasi`, `nama_prestasi`, `tahun`, `url_dokumen`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(348, 991, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 991', 2022, 'public/uploads/prestasi/991', '2022-12-12 03:42:03', NULL, NULL, NULL),
(349, 994, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 994', 2022, 'public/uploads/prestasi/994', '2022-12-12 03:42:03', NULL, NULL, NULL),
(350, 995, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 995', 2022, 'public/uploads/prestasi/995', '2022-12-12 03:42:03', NULL, NULL, NULL),
(351, 997, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 997', 2022, 'public/uploads/prestasi/997', '2022-12-12 03:42:04', NULL, NULL, NULL),
(352, 998, 'NASIONAL', 'Prestasi NASIONAL AprilYandi Dwi W 998', 2022, 'public/uploads/prestasi/998', '2022-12-12 03:42:04', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `perguruan_tinggi`
--

CREATE TABLE `perguruan_tinggi` (
  `id_perguruan_tinggi` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `perguruan_tinggi`
--

INSERT INTO `perguruan_tinggi` (`id_perguruan_tinggi`, `nama`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 'AMD Academy', '2022-12-07 04:58:50', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `prestasi`
--

CREATE TABLE `prestasi` (
  `id` int(11) NOT NULL,
  `tingkat_prestasi` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `prestasi`
--

INSERT INTO `prestasi` (`id`, `tingkat_prestasi`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 'NASIONAL', '2022-12-08 08:38:03', NULL, NULL, NULL),
(2, 'INTERNASIONAL', '2022-12-08 08:38:03', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `prodi`
--

CREATE TABLE `prodi` (
  `id_prodi` int(11) NOT NULL,
  `id_fakultas` int(11) NOT NULL,
  `nama_prodi` varchar(255) NOT NULL,
  `jenjang` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `prodi`
--

INSERT INTO `prodi` (`id_prodi`, `id_fakultas`, `nama_prodi`, `jenjang`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 1, 'Teknik Informatika', 'S1', '2022-12-07 05:11:46', NULL, NULL, '2022-12-07 05:26:33'),
(2, 1, 'Teknik Industri', 'S1', '2022-12-07 05:11:46', NULL, NULL, '2022-12-07 05:22:51'),
(3, 1, 'Teknin Mesin', 'S1', '2022-12-07 05:17:31', NULL, NULL, '2022-12-07 05:22:55'),
(4, 1, 'Teknik Elektro', 'S1', '2022-12-07 05:17:31', NULL, NULL, '2022-12-07 05:22:58'),
(5, 2, 'Sastra Inggris', 'S1', '2022-12-07 05:18:25', NULL, NULL, '2022-12-07 05:23:01'),
(6, 3, 'Sistem Infromasi', 'S1', '2022-12-07 05:18:25', NULL, NULL, '2022-12-07 05:23:04'),
(7, 4, 'Manajemen', 'S1', '2022-12-07 05:20:04', NULL, NULL, '2022-12-07 05:23:07'),
(8, 4, 'Akuntansi', 'S1', '2022-12-07 05:20:04', NULL, NULL, '2022-12-07 05:23:10'),
(9, 4, 'Ilmu Ekonomi', 'S1', '2022-12-07 05:22:28', NULL, NULL, '2022-12-07 05:23:14'),
(10, 5, 'Psikologi', 'S1', '2022-12-07 05:22:28', NULL, NULL, '2022-12-07 05:23:19'),
(11, 5, 'Psikologi', 'S2', '2022-12-07 05:25:10', NULL, NULL, '2022-12-07 05:25:31'),
(12, 2, 'Sastra Inggris', 'S2', '2022-12-07 05:25:10', NULL, NULL, '2022-12-07 05:26:55'),
(13, 1, 'Teknik Mesin', 'S2', '2022-12-07 05:26:01', NULL, NULL, '2022-12-07 05:27:02');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`id_bank`);

--
-- Indeks untuk tabel `fakultas`
--
ALTER TABLE `fakultas`
  ADD PRIMARY KEY (`id_fakultas`),
  ADD KEY `id_perguruan_tinggi` (`id_perguruan_tinggi`),
  ADD KEY `id_perguruan_tinggi_2` (`id_perguruan_tinggi`);

--
-- Indeks untuk tabel `jalur_masuk`
--
ALTER TABLE `jalur_masuk`
  ADD PRIMARY KEY (`id_jalur`),
  ADD KEY `nama_jalur` (`nama_jalur`);

--
-- Indeks untuk tabel `pendaftar`
--
ALTER TABLE `pendaftar`
  ADD PRIMARY KEY (`id_pendaftar`),
  ADD KEY `MUL` (`id_jalur`),
  ADD KEY `id_prodi1` (`id_prodi1`),
  ADD KEY `id_prodi2` (`id_prodi2`),
  ADD KEY `id_bank` (`id_bank`),
  ADD KEY `no_pendaftar` (`no_pendaftar`);

--
-- Indeks untuk tabel `pendaftar_prestasi`
--
ALTER TABLE `pendaftar_prestasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pendaftar` (`id_pendaftar`);

--
-- Indeks untuk tabel `perguruan_tinggi`
--
ALTER TABLE `perguruan_tinggi`
  ADD PRIMARY KEY (`id_perguruan_tinggi`);

--
-- Indeks untuk tabel `prestasi`
--
ALTER TABLE `prestasi`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `prodi`
--
ALTER TABLE `prodi`
  ADD PRIMARY KEY (`id_prodi`),
  ADD KEY `id_fakultas` (`id_fakultas`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `bank`
--
ALTER TABLE `bank`
  MODIFY `id_bank` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `fakultas`
--
ALTER TABLE `fakultas`
  MODIFY `id_fakultas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `jalur_masuk`
--
ALTER TABLE `jalur_masuk`
  MODIFY `id_jalur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `pendaftar`
--
ALTER TABLE `pendaftar`
  MODIFY `id_pendaftar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1001;

--
-- AUTO_INCREMENT untuk tabel `pendaftar_prestasi`
--
ALTER TABLE `pendaftar_prestasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=353;

--
-- AUTO_INCREMENT untuk tabel `perguruan_tinggi`
--
ALTER TABLE `perguruan_tinggi`
  MODIFY `id_perguruan_tinggi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `prestasi`
--
ALTER TABLE `prestasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `prodi`
--
ALTER TABLE `prodi`
  MODIFY `id_prodi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `fakultas`
--
ALTER TABLE `fakultas`
  ADD CONSTRAINT `fakultas_ibfk_1` FOREIGN KEY (`id_perguruan_tinggi`) REFERENCES `perguruan_tinggi` (`id_perguruan_tinggi`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pendaftar`
--
ALTER TABLE `pendaftar`
  ADD CONSTRAINT `pendaftar_ibfk_1` FOREIGN KEY (`id_prodi1`) REFERENCES `prodi` (`id_prodi`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pendaftar_ibfk_2` FOREIGN KEY (`id_prodi2`) REFERENCES `prodi` (`id_prodi`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pendaftar_ibfk_3` FOREIGN KEY (`id_bank`) REFERENCES `bank` (`id_bank`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pendaftar_ibfk_4` FOREIGN KEY (`id_jalur`) REFERENCES `jalur_masuk` (`id_jalur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pendaftar_prestasi`
--
ALTER TABLE `pendaftar_prestasi`
  ADD CONSTRAINT `pendaftar_prestasi_ibfk_1` FOREIGN KEY (`id_pendaftar`) REFERENCES `pendaftar` (`id_pendaftar`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `prodi`
--
ALTER TABLE `prodi`
  ADD CONSTRAINT `prodi_ibfk_1` FOREIGN KEY (`id_fakultas`) REFERENCES `fakultas` (`id_fakultas`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
