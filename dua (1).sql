-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Waktu pembuatan: 23 Des 2022 pada 02.16
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
    SET nama = (SELECT CONCAT('Satrio ', (i+1)));
    SET nisn = (SELECT CONCAT('56419974', (i+1)));
    SET nik = (SELECT CONCAT('3276022304010010', (i+1)));
    SET tempat_lahir = 'Jakarta';
    SET tanggal_lahir = (SELECT '2001-12-31'- INTERVAL FLOOR(RAND() * 30) DAY);
    SET jenis_kelamin = 'Laki-Laki';
    SET no_hp = (SELECT CONCAT('08810243', (i+1)));
    SET alamat = (SELECT CONCAT('Malang. ', (i+1)));
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
(1, 1, 'P202211', 'Satrio 1', '564199741', '32760223040100101', 'Jakarta', '2001-12-14', 'Laki-Laki', '088102431', 'Malang. 1', 'Islam', 2, 12, '150000.00', 4, 'Sudah', '2022-12-23 01:13:44', NULL, NULL, NULL),
(2, 1, 'P202212', 'Satrio 2', '564199742', '32760223040100102', 'Jakarta', '2001-12-31', 'Laki-Laki', '088102432', 'Malang. 2', 'Islam', 9, 6, '150000.00', 4, 'Sudah', '2022-12-23 01:13:44', NULL, NULL, NULL),
(3, 1, 'P202213', 'Satrio 3', '564199743', '32760223040100103', 'Jakarta', '2001-12-04', 'Laki-Laki', '088102433', 'Malang. 3', 'Islam', 6, 3, '150000.00', 2, 'Sudah', '2022-12-23 01:13:44', NULL, NULL, NULL),
(4, 2, 'P202224', 'Satrio 4', '564199744', '32760223040100104', 'Jakarta', '2001-12-19', 'Laki-Laki', '088102434', 'Malang. 4', 'Islam', 8, 7, '150000.00', 1, 'Sudah', '2022-12-23 01:13:44', NULL, NULL, NULL),
(5, 2, 'P202225', 'Satrio 5', '564199745', '32760223040100105', 'Depok', '2001-12-08', 'Perempuan', '088102435', 'Malang. 5', 'Islam', 7, 5, '150000.00', 3, 'Sudah', '2022-12-23 01:13:44', NULL, NULL, NULL),
(6, 3, 'P202236', 'Satrio 6', '564199746', '32760223040100106', 'Jakarta', '2001-12-21', 'Laki-Laki', '088102436', 'Malang. 6', 'Islam', 8, 5, NULL, NULL, 'Gratis', '2022-12-23 01:13:44', NULL, NULL, NULL),
(7, 3, 'P202237', 'Satrio 7', '564199747', '32760223040100107', 'Jakarta', '2001-12-06', 'Laki-Laki', '088102437', 'Malang. 7', 'Islam', 4, 10, NULL, NULL, 'Belum', '2022-12-23 01:13:44', NULL, NULL, NULL),
(8, 3, 'P202238', 'Satrio 8', '564199748', '32760223040100108', 'Jakarta', '2001-12-21', 'Laki-Laki', '088102438', 'Malang. 8', 'Islam', 1, 10, NULL, NULL, 'Gratis', '2022-12-23 01:13:44', NULL, NULL, NULL),
(9, 2, 'P202229', 'Satrio 9', '564199749', '32760223040100109', 'Jakarta', '2001-12-20', 'Laki-Laki', '088102439', 'Malang. 9', 'Islam', 2, 6, '150000.00', 4, 'Sudah', '2022-12-23 01:13:44', NULL, NULL, NULL),
(10, 3, 'P2022310', 'Satrio 10', '5641997410', '327602230401001010', 'Depok', '2001-12-18', 'Perempuan', '0881024310', 'Malang. 10', 'Islam', 1, 5, NULL, NULL, 'Gratis', '2022-12-23 01:13:44', NULL, NULL, NULL),
(11, 2, 'P2022211', 'Satrio 11', '5641997411', '327602230401001011', 'Jakarta', '2001-12-12', 'Laki-Laki', '0881024311', 'Malang. 11', 'Islam', 13, 6, '150000.00', 4, 'Sudah', '2022-12-23 01:13:44', NULL, NULL, NULL),
(12, 1, 'P2022112', 'Satrio 12', '5641997412', '327602230401001012', 'Jakarta', '2001-12-27', 'Laki-Laki', '0881024312', 'Malang. 12', 'Islam', 9, 12, '150000.00', 1, 'Sudah', '2022-12-23 01:13:45', NULL, NULL, NULL),
(13, 3, 'P2022313', 'Satrio 13', '5641997413', '327602230401001013', 'Jakarta', '2001-12-31', 'Laki-Laki', '0881024313', 'Malang. 13', 'Islam', 8, 5, NULL, NULL, 'Gratis', '2022-12-23 01:13:45', NULL, NULL, NULL),
(14, 3, 'P2022314', 'Satrio 14', '5641997414', '327602230401001014', 'Jakarta', '2001-12-09', 'Laki-Laki', '0881024314', 'Malang. 14', 'Islam', 13, 6, NULL, NULL, 'Belum', '2022-12-23 01:13:45', NULL, NULL, NULL),
(15, 2, 'P2022215', 'Satrio 15', '5641997415', '327602230401001015', 'Depok', '2001-12-28', 'Perempuan', '0881024315', 'Malang. 15', 'Islam', 4, 8, '150000.00', 1, 'Sudah', '2022-12-23 01:13:45', NULL, NULL, NULL),
(16, 3, 'P2022316', 'Satrio 16', '5641997416', '327602230401001016', 'Jakarta', '2001-12-02', 'Laki-Laki', '0881024316', 'Malang. 16', 'Islam', 8, 10, NULL, NULL, 'Gratis', '2022-12-23 01:13:45', NULL, NULL, NULL),
(17, 1, 'P2022117', 'Satrio 17', '5641997417', '327602230401001017', 'Jakarta', '2001-12-03', 'Laki-Laki', '0881024317', 'Malang. 17', 'Islam', 9, 4, '150000.00', 2, 'Sudah', '2022-12-23 01:13:45', NULL, NULL, NULL),
(18, 3, 'P2022318', 'Satrio 18', '5641997418', '327602230401001018', 'Jakarta', '2001-12-09', 'Laki-Laki', '0881024318', 'Malang. 18', 'Islam', 3, 11, NULL, NULL, 'Gratis', '2022-12-23 01:13:45', NULL, NULL, NULL),
(19, 3, 'P2022319', 'Satrio 19', '5641997419', '327602230401001019', 'Jakarta', '2001-12-17', 'Laki-Laki', '0881024319', 'Malang. 19', 'Islam', 13, 11, NULL, NULL, 'Gratis', '2022-12-23 01:13:45', NULL, NULL, NULL),
(20, 2, 'P2022220', 'Satrio 20', '5641997420', '327602230401001020', 'Depok', '2001-12-15', 'Perempuan', '0881024320', 'Malang. 20', 'Islam', 11, 13, '150000.00', 3, 'Sudah', '2022-12-23 01:13:45', NULL, NULL, NULL),
(21, 1, 'P2022121', 'Satrio 21', '5641997421', '327602230401001021', 'Jakarta', '2001-12-05', 'Laki-Laki', '0881024321', 'Malang. 21', 'Islam', 6, 9, '150000.00', 4, 'Belum', '2022-12-23 01:13:45', NULL, NULL, NULL),
(22, 3, 'P2022322', 'Satrio 22', '5641997422', '327602230401001022', 'Jakarta', '2001-12-31', 'Laki-Laki', '0881024322', 'Malang. 22', 'Islam', 2, 1, NULL, NULL, 'Gratis', '2022-12-23 01:13:45', NULL, NULL, NULL),
(23, 2, 'P2022223', 'Satrio 23', '5641997423', '327602230401001023', 'Jakarta', '2001-12-12', 'Laki-Laki', '0881024323', 'Malang. 23', 'Islam', 5, 4, '150000.00', 3, 'Sudah', '2022-12-23 01:13:45', NULL, NULL, NULL),
(24, 2, 'P2022224', 'Satrio 24', '5641997424', '327602230401001024', 'Jakarta', '2001-12-08', 'Laki-Laki', '0881024324', 'Malang. 24', 'Islam', 3, 13, '150000.00', 2, 'Sudah', '2022-12-23 01:13:45', NULL, NULL, NULL),
(25, 2, 'P2022225', 'Satrio 25', '5641997425', '327602230401001025', 'Depok', '2001-12-25', 'Perempuan', '0881024325', 'Malang. 25', 'Islam', 11, 6, '150000.00', 3, 'Sudah', '2022-12-23 01:13:45', NULL, NULL, NULL),
(26, 3, 'P2022326', 'Satrio 26', '5641997426', '327602230401001026', 'Jakarta', '2001-12-08', 'Laki-Laki', '0881024326', 'Malang. 26', 'Islam', 12, 7, NULL, NULL, 'Gratis', '2022-12-23 01:13:46', NULL, NULL, NULL),
(27, 1, 'P2022127', 'Satrio 27', '5641997427', '327602230401001027', 'Jakarta', '2001-12-10', 'Laki-Laki', '0881024327', 'Malang. 27', 'Islam', 2, 1, '150000.00', 3, 'Sudah', '2022-12-23 01:13:46', NULL, NULL, NULL),
(28, 2, 'P2022228', 'Satrio 28', '5641997428', '327602230401001028', 'Jakarta', '2001-12-02', 'Laki-Laki', '0881024328', 'Malang. 28', 'Islam', 5, 10, '150000.00', 4, 'Belum', '2022-12-23 01:13:46', NULL, NULL, NULL),
(29, 1, 'P2022129', 'Satrio 29', '5641997429', '327602230401001029', 'Jakarta', '2001-12-31', 'Laki-Laki', '0881024329', 'Malang. 29', 'Islam', 3, 10, '150000.00', 1, 'Sudah', '2022-12-23 01:13:46', NULL, NULL, NULL),
(30, 3, 'P2022330', 'Satrio 30', '5641997430', '327602230401001030', 'Depok', '2001-12-21', 'Perempuan', '0881024330', 'Malang. 30', 'Islam', 1, 4, NULL, NULL, 'Gratis', '2022-12-23 01:13:46', NULL, NULL, NULL),
(31, 2, 'P2022231', 'Satrio 31', '5641997431', '327602230401001031', 'Jakarta', '2001-12-16', 'Laki-Laki', '0881024331', 'Malang. 31', 'Islam', 10, 12, '150000.00', 3, 'Sudah', '2022-12-23 01:13:46', NULL, NULL, NULL),
(32, 1, 'P2022132', 'Satrio 32', '5641997432', '327602230401001032', 'Jakarta', '2001-12-22', 'Laki-Laki', '0881024332', 'Malang. 32', 'Islam', 3, 1, '150000.00', 2, 'Sudah', '2022-12-23 01:13:46', NULL, NULL, NULL),
(33, 2, 'P2022233', 'Satrio 33', '5641997433', '327602230401001033', 'Jakarta', '2001-12-18', 'Laki-Laki', '0881024333', 'Malang. 33', 'Islam', 9, 5, '150000.00', 1, 'Sudah', '2022-12-23 01:13:46', NULL, NULL, NULL),
(34, 2, 'P2022234', 'Satrio 34', '5641997434', '327602230401001034', 'Jakarta', '2001-12-27', 'Laki-Laki', '0881024334', 'Malang. 34', 'Islam', 9, 2, '150000.00', 4, 'Sudah', '2022-12-23 01:13:46', NULL, NULL, NULL),
(35, 2, 'P2022235', 'Satrio 35', '5641997435', '327602230401001035', 'Depok', '2001-12-27', 'Perempuan', '0881024335', 'Malang. 35', 'Islam', 6, 13, '150000.00', 1, 'Belum', '2022-12-23 01:13:46', NULL, NULL, NULL),
(36, 2, 'P2022236', 'Satrio 36', '5641997436', '327602230401001036', 'Jakarta', '2001-12-24', 'Laki-Laki', '0881024336', 'Malang. 36', 'Islam', 4, 6, '150000.00', 4, 'Sudah', '2022-12-23 01:13:46', NULL, NULL, NULL),
(37, 3, 'P2022337', 'Satrio 37', '5641997437', '327602230401001037', 'Jakarta', '2001-12-28', 'Laki-Laki', '0881024337', 'Malang. 37', 'Islam', 7, 5, NULL, NULL, 'Gratis', '2022-12-23 01:13:46', NULL, NULL, NULL),
(38, 3, 'P2022338', 'Satrio 38', '5641997438', '327602230401001038', 'Jakarta', '2001-12-25', 'Laki-Laki', '0881024338', 'Malang. 38', 'Islam', 7, 5, NULL, NULL, 'Gratis', '2022-12-23 01:13:46', NULL, NULL, NULL),
(39, 3, 'P2022339', 'Satrio 39', '5641997439', '327602230401001039', 'Jakarta', '2001-12-25', 'Laki-Laki', '0881024339', 'Malang. 39', 'Islam', 3, 3, NULL, NULL, 'Gratis', '2022-12-23 01:13:46', NULL, NULL, NULL),
(40, 2, 'P2022240', 'Satrio 40', '5641997440', '327602230401001040', 'Depok', '2001-12-18', 'Perempuan', '0881024340', 'Malang. 40', 'Islam', 3, 12, '150000.00', 1, 'Sudah', '2022-12-23 01:13:46', NULL, NULL, NULL),
(41, 1, 'P2022141', 'Satrio 41', '5641997441', '327602230401001041', 'Jakarta', '2001-12-25', 'Laki-Laki', '0881024341', 'Malang. 41', 'Islam', 6, 2, '150000.00', 1, 'Sudah', '2022-12-23 01:13:46', NULL, NULL, NULL),
(42, 2, 'P2022242', 'Satrio 42', '5641997442', '327602230401001042', 'Jakarta', '2001-12-23', 'Laki-Laki', '0881024342', 'Malang. 42', 'Islam', 4, 9, '150000.00', 3, 'Belum', '2022-12-23 01:13:46', NULL, NULL, NULL),
(43, 3, 'P2022343', 'Satrio 43', '5641997443', '327602230401001043', 'Jakarta', '2001-12-14', 'Laki-Laki', '0881024343', 'Malang. 43', 'Islam', 5, 1, NULL, NULL, 'Gratis', '2022-12-23 01:13:47', NULL, NULL, NULL),
(44, 1, 'P2022144', 'Satrio 44', '5641997444', '327602230401001044', 'Jakarta', '2001-12-27', 'Laki-Laki', '0881024344', 'Malang. 44', 'Islam', 8, 1, '150000.00', 3, 'Sudah', '2022-12-23 01:13:47', NULL, NULL, NULL),
(45, 3, 'P2022345', 'Satrio 45', '5641997445', '327602230401001045', 'Depok', '2001-12-18', 'Perempuan', '0881024345', 'Malang. 45', 'Islam', 10, 12, NULL, NULL, 'Gratis', '2022-12-23 01:13:47', NULL, NULL, NULL),
(46, 3, 'P2022346', 'Satrio 46', '5641997446', '327602230401001046', 'Jakarta', '2001-12-28', 'Laki-Laki', '0881024346', 'Malang. 46', 'Islam', 7, 8, NULL, NULL, 'Gratis', '2022-12-23 01:13:47', NULL, NULL, NULL),
(47, 2, 'P2022247', 'Satrio 47', '5641997447', '327602230401001047', 'Jakarta', '2001-12-28', 'Laki-Laki', '0881024347', 'Malang. 47', 'Islam', 11, 10, '150000.00', 2, 'Sudah', '2022-12-23 01:13:47', NULL, NULL, NULL),
(48, 3, 'P2022348', 'Satrio 48', '5641997448', '327602230401001048', 'Jakarta', '2001-12-08', 'Laki-Laki', '0881024348', 'Malang. 48', 'Islam', 9, 10, NULL, NULL, 'Gratis', '2022-12-23 01:13:47', NULL, NULL, NULL),
(49, 2, 'P2022249', 'Satrio 49', '5641997449', '327602230401001049', 'Jakarta', '2001-12-19', 'Laki-Laki', '0881024349', 'Malang. 49', 'Islam', 1, 12, '150000.00', 3, 'Belum', '2022-12-23 01:13:47', NULL, NULL, NULL),
(50, 3, 'P2022350', 'Satrio 50', '5641997450', '327602230401001050', 'Depok', '2001-12-30', 'Perempuan', '0881024350', 'Malang. 50', 'Islam', 8, 1, NULL, NULL, 'Gratis', '2022-12-23 01:13:47', NULL, NULL, NULL),
(51, 1, 'P2022151', 'Satrio 51', '5641997451', '327602230401001051', 'Jakarta', '2001-12-14', 'Laki-Laki', '0881024351', 'Malang. 51', 'Islam', 4, 7, '150000.00', 3, 'Sudah', '2022-12-23 01:13:47', NULL, NULL, NULL),
(52, 2, 'P2022252', 'Satrio 52', '5641997452', '327602230401001052', 'Jakarta', '2001-12-12', 'Laki-Laki', '0881024352', 'Malang. 52', 'Islam', 8, 12, '150000.00', 2, 'Sudah', '2022-12-23 01:13:47', NULL, NULL, NULL),
(53, 2, 'P2022253', 'Satrio 53', '5641997453', '327602230401001053', 'Jakarta', '2001-12-05', 'Laki-Laki', '0881024353', 'Malang. 53', 'Islam', 10, 2, '150000.00', 3, 'Sudah', '2022-12-23 01:13:47', NULL, NULL, NULL),
(54, 3, 'P2022354', 'Satrio 54', '5641997454', '327602230401001054', 'Jakarta', '2001-12-03', 'Laki-Laki', '0881024354', 'Malang. 54', 'Islam', 13, 8, NULL, NULL, 'Gratis', '2022-12-23 01:13:47', NULL, NULL, NULL),
(55, 2, 'P2022255', 'Satrio 55', '5641997455', '327602230401001055', 'Depok', '2001-12-29', 'Perempuan', '0881024355', 'Malang. 55', 'Islam', 4, 12, '150000.00', 3, 'Sudah', '2022-12-23 01:13:47', NULL, NULL, NULL),
(56, 3, 'P2022356', 'Satrio 56', '5641997456', '327602230401001056', 'Jakarta', '2001-12-24', 'Laki-Laki', '0881024356', 'Malang. 56', 'Islam', 13, 13, NULL, NULL, 'Belum', '2022-12-23 01:13:47', NULL, NULL, NULL),
(57, 3, 'P2022357', 'Satrio 57', '5641997457', '327602230401001057', 'Jakarta', '2001-12-11', 'Laki-Laki', '0881024357', 'Malang. 57', 'Islam', 2, 2, NULL, NULL, 'Gratis', '2022-12-23 01:13:47', NULL, NULL, NULL),
(58, 3, 'P2022358', 'Satrio 58', '5641997458', '327602230401001058', 'Jakarta', '2001-12-14', 'Laki-Laki', '0881024358', 'Malang. 58', 'Islam', 2, 1, NULL, NULL, 'Gratis', '2022-12-23 01:13:48', NULL, NULL, NULL),
(59, 3, 'P2022359', 'Satrio 59', '5641997459', '327602230401001059', 'Jakarta', '2001-12-29', 'Laki-Laki', '0881024359', 'Malang. 59', 'Islam', 13, 10, NULL, NULL, 'Gratis', '2022-12-23 01:13:48', NULL, NULL, NULL),
(60, 1, 'P2022160', 'Satrio 60', '5641997460', '327602230401001060', 'Depok', '2001-12-05', 'Perempuan', '0881024360', 'Malang. 60', 'Islam', 4, 5, '150000.00', 4, 'Sudah', '2022-12-23 01:13:48', NULL, NULL, NULL),
(61, 1, 'P2022161', 'Satrio 61', '5641997461', '327602230401001061', 'Jakarta', '2001-12-09', 'Laki-Laki', '0881024361', 'Malang. 61', 'Islam', 1, 5, '150000.00', 2, 'Sudah', '2022-12-23 01:13:48', NULL, NULL, NULL),
(62, 1, 'P2022162', 'Satrio 62', '5641997462', '327602230401001062', 'Jakarta', '2001-12-25', 'Laki-Laki', '0881024362', 'Malang. 62', 'Islam', 6, 1, '150000.00', 3, 'Sudah', '2022-12-23 01:13:48', NULL, NULL, NULL),
(63, 1, 'P2022163', 'Satrio 63', '5641997463', '327602230401001063', 'Jakarta', '2001-12-11', 'Laki-Laki', '0881024363', 'Malang. 63', 'Islam', 6, 7, '150000.00', 2, 'Belum', '2022-12-23 01:13:48', NULL, NULL, NULL),
(64, 1, 'P2022164', 'Satrio 64', '5641997464', '327602230401001064', 'Jakarta', '2001-12-25', 'Laki-Laki', '0881024364', 'Malang. 64', 'Islam', 4, 9, '150000.00', 3, 'Sudah', '2022-12-23 01:13:48', NULL, NULL, NULL),
(65, 2, 'P2022265', 'Satrio 65', '5641997465', '327602230401001065', 'Depok', '2001-12-13', 'Perempuan', '0881024365', 'Malang. 65', 'Islam', 11, 7, '150000.00', 4, 'Sudah', '2022-12-23 01:13:48', NULL, NULL, NULL),
(66, 3, 'P2022366', 'Satrio 66', '5641997466', '327602230401001066', 'Jakarta', '2001-12-31', 'Laki-Laki', '0881024366', 'Malang. 66', 'Islam', 11, 12, NULL, NULL, 'Gratis', '2022-12-23 01:13:48', NULL, NULL, NULL),
(67, 1, 'P2022167', 'Satrio 67', '5641997467', '327602230401001067', 'Jakarta', '2001-12-18', 'Laki-Laki', '0881024367', 'Malang. 67', 'Islam', 7, 10, '150000.00', 1, 'Sudah', '2022-12-23 01:13:48', NULL, NULL, NULL),
(68, 3, 'P2022368', 'Satrio 68', '5641997468', '327602230401001068', 'Jakarta', '2001-12-27', 'Laki-Laki', '0881024368', 'Malang. 68', 'Islam', 7, 10, NULL, NULL, 'Gratis', '2022-12-23 01:13:48', NULL, NULL, NULL),
(69, 3, 'P2022369', 'Satrio 69', '5641997469', '327602230401001069', 'Jakarta', '2001-12-23', 'Laki-Laki', '0881024369', 'Malang. 69', 'Islam', 8, 7, NULL, NULL, 'Gratis', '2022-12-23 01:13:48', NULL, NULL, NULL),
(70, 2, 'P2022270', 'Satrio 70', '5641997470', '327602230401001070', 'Depok', '2001-12-29', 'Perempuan', '0881024370', 'Malang. 70', 'Islam', 13, 7, '150000.00', 4, 'Belum', '2022-12-23 01:13:48', NULL, NULL, NULL),
(71, 2, 'P2022271', 'Satrio 71', '5641997471', '327602230401001071', 'Jakarta', '2001-12-24', 'Laki-Laki', '0881024371', 'Malang. 71', 'Islam', 11, 11, '150000.00', 3, 'Sudah', '2022-12-23 01:13:48', NULL, NULL, NULL),
(72, 3, 'P2022372', 'Satrio 72', '5641997472', '327602230401001072', 'Jakarta', '2001-12-29', 'Laki-Laki', '0881024372', 'Malang. 72', 'Islam', 9, 11, NULL, NULL, 'Gratis', '2022-12-23 01:13:48', NULL, NULL, NULL),
(73, 1, 'P2022173', 'Satrio 73', '5641997473', '327602230401001073', 'Jakarta', '2001-12-22', 'Laki-Laki', '0881024373', 'Malang. 73', 'Islam', 9, 8, '150000.00', 3, 'Sudah', '2022-12-23 01:13:48', NULL, NULL, NULL),
(74, 1, 'P2022174', 'Satrio 74', '5641997474', '327602230401001074', 'Jakarta', '2001-12-30', 'Laki-Laki', '0881024374', 'Malang. 74', 'Islam', 5, 12, '150000.00', 2, 'Sudah', '2022-12-23 01:13:48', NULL, NULL, NULL),
(75, 1, 'P2022175', 'Satrio 75', '5641997475', '327602230401001075', 'Depok', '2001-12-13', 'Perempuan', '0881024375', 'Malang. 75', 'Islam', 8, 2, '150000.00', 2, 'Sudah', '2022-12-23 01:13:48', NULL, NULL, NULL),
(76, 2, 'P2022276', 'Satrio 76', '5641997476', '327602230401001076', 'Jakarta', '2001-12-29', 'Laki-Laki', '0881024376', 'Malang. 76', 'Islam', 9, 13, '150000.00', 3, 'Sudah', '2022-12-23 01:13:49', NULL, NULL, NULL),
(77, 1, 'P2022177', 'Satrio 77', '5641997477', '327602230401001077', 'Jakarta', '2001-12-08', 'Laki-Laki', '0881024377', 'Malang. 77', 'Islam', 7, 5, '150000.00', 4, 'Belum', '2022-12-23 01:13:49', NULL, NULL, NULL),
(78, 2, 'P2022278', 'Satrio 78', '5641997478', '327602230401001078', 'Jakarta', '2001-12-11', 'Laki-Laki', '0881024378', 'Malang. 78', 'Islam', 5, 9, '150000.00', 1, 'Sudah', '2022-12-23 01:13:49', NULL, NULL, NULL),
(79, 2, 'P2022279', 'Satrio 79', '5641997479', '327602230401001079', 'Jakarta', '2001-12-11', 'Laki-Laki', '0881024379', 'Malang. 79', 'Islam', 12, 11, '150000.00', 1, 'Sudah', '2022-12-23 01:13:49', NULL, NULL, NULL),
(80, 3, 'P2022380', 'Satrio 80', '5641997480', '327602230401001080', 'Depok', '2001-12-24', 'Perempuan', '0881024380', 'Malang. 80', 'Islam', 12, 7, NULL, NULL, 'Gratis', '2022-12-23 01:13:49', NULL, NULL, NULL),
(81, 1, 'P2022181', 'Satrio 81', '5641997481', '327602230401001081', 'Jakarta', '2001-12-27', 'Laki-Laki', '0881024381', 'Malang. 81', 'Islam', 5, 4, '150000.00', 4, 'Sudah', '2022-12-23 01:13:49', NULL, NULL, NULL),
(82, 1, 'P2022182', 'Satrio 82', '5641997482', '327602230401001082', 'Jakarta', '2001-12-22', 'Laki-Laki', '0881024382', 'Malang. 82', 'Islam', 4, 12, '150000.00', 2, 'Sudah', '2022-12-23 01:13:49', NULL, NULL, NULL),
(83, 2, 'P2022283', 'Satrio 83', '5641997483', '327602230401001083', 'Jakarta', '2001-12-29', 'Laki-Laki', '0881024383', 'Malang. 83', 'Islam', 4, 4, '150000.00', 4, 'Sudah', '2022-12-23 01:13:49', NULL, NULL, NULL),
(84, 1, 'P2022184', 'Satrio 84', '5641997484', '327602230401001084', 'Jakarta', '2001-12-20', 'Laki-Laki', '0881024384', 'Malang. 84', 'Islam', 3, 4, '150000.00', 1, 'Belum', '2022-12-23 01:13:49', NULL, NULL, NULL),
(85, 3, 'P2022385', 'Satrio 85', '5641997485', '327602230401001085', 'Depok', '2001-12-31', 'Perempuan', '0881024385', 'Malang. 85', 'Islam', 3, 7, NULL, NULL, 'Gratis', '2022-12-23 01:13:49', NULL, NULL, NULL),
(86, 2, 'P2022286', 'Satrio 86', '5641997486', '327602230401001086', 'Jakarta', '2001-12-24', 'Laki-Laki', '0881024386', 'Malang. 86', 'Islam', 9, 7, '150000.00', 3, 'Sudah', '2022-12-23 01:13:50', NULL, NULL, NULL),
(87, 3, 'P2022387', 'Satrio 87', '5641997487', '327602230401001087', 'Jakarta', '2001-12-02', 'Laki-Laki', '0881024387', 'Malang. 87', 'Islam', 8, 13, NULL, NULL, 'Gratis', '2022-12-23 01:13:50', NULL, NULL, NULL),
(88, 1, 'P2022188', 'Satrio 88', '5641997488', '327602230401001088', 'Jakarta', '2001-12-16', 'Laki-Laki', '0881024388', 'Malang. 88', 'Islam', 13, 6, '150000.00', 4, 'Sudah', '2022-12-23 01:13:50', NULL, NULL, NULL),
(89, 2, 'P2022289', 'Satrio 89', '5641997489', '327602230401001089', 'Jakarta', '2001-12-31', 'Laki-Laki', '0881024389', 'Malang. 89', 'Islam', 4, 7, '150000.00', 3, 'Sudah', '2022-12-23 01:13:50', NULL, NULL, NULL),
(90, 3, 'P2022390', 'Satrio 90', '5641997490', '327602230401001090', 'Depok', '2001-12-28', 'Perempuan', '0881024390', 'Malang. 90', 'Islam', 8, 5, NULL, NULL, 'Gratis', '2022-12-23 01:13:50', NULL, NULL, NULL),
(91, 1, 'P2022191', 'Satrio 91', '5641997491', '327602230401001091', 'Jakarta', '2001-12-08', 'Laki-Laki', '0881024391', 'Malang. 91', 'Islam', 3, 11, '150000.00', 1, 'Belum', '2022-12-23 01:13:50', NULL, NULL, NULL),
(92, 2, 'P2022292', 'Satrio 92', '5641997492', '327602230401001092', 'Jakarta', '2001-12-06', 'Laki-Laki', '0881024392', 'Malang. 92', 'Islam', 12, 12, '150000.00', 1, 'Sudah', '2022-12-23 01:13:50', NULL, NULL, NULL),
(93, 3, 'P2022393', 'Satrio 93', '5641997493', '327602230401001093', 'Jakarta', '2001-12-17', 'Laki-Laki', '0881024393', 'Malang. 93', 'Islam', 5, 11, NULL, NULL, 'Gratis', '2022-12-23 01:13:50', NULL, NULL, NULL),
(94, 3, 'P2022394', 'Satrio 94', '5641997494', '327602230401001094', 'Jakarta', '2001-12-29', 'Laki-Laki', '0881024394', 'Malang. 94', 'Islam', 6, 9, NULL, NULL, 'Gratis', '2022-12-23 01:13:50', NULL, NULL, NULL),
(95, 2, 'P2022295', 'Satrio 95', '5641997495', '327602230401001095', 'Depok', '2001-12-03', 'Perempuan', '0881024395', 'Malang. 95', 'Islam', 10, 10, '150000.00', 4, 'Sudah', '2022-12-23 01:13:50', NULL, NULL, NULL),
(96, 3, 'P2022396', 'Satrio 96', '5641997496', '327602230401001096', 'Jakarta', '2001-12-04', 'Laki-Laki', '0881024396', 'Malang. 96', 'Islam', 1, 8, NULL, NULL, 'Gratis', '2022-12-23 01:13:50', NULL, NULL, NULL),
(97, 2, 'P2022297', 'Satrio 97', '5641997497', '327602230401001097', 'Jakarta', '2001-12-20', 'Laki-Laki', '0881024397', 'Malang. 97', 'Islam', 7, 3, '150000.00', 1, 'Sudah', '2022-12-23 01:13:51', NULL, NULL, NULL),
(98, 3, 'P2022398', 'Satrio 98', '5641997498', '327602230401001098', 'Jakarta', '2001-12-29', 'Laki-Laki', '0881024398', 'Malang. 98', 'Islam', 2, 3, NULL, NULL, 'Belum', '2022-12-23 01:13:51', NULL, NULL, NULL),
(99, 2, 'P2022299', 'Satrio 99', '5641997499', '327602230401001099', 'Jakarta', '2001-12-15', 'Laki-Laki', '0881024399', 'Malang. 99', 'Islam', 6, 10, '150000.00', 2, 'Sudah', '2022-12-23 01:13:51', NULL, NULL, NULL),
(100, 2, 'P20222100', 'Satrio 100', '56419974100', '3276022304010010100', 'Depok', '2001-12-07', 'Perempuan', '08810243100', 'Malang. 100', 'Islam', 5, 12, '150000.00', 2, 'Sudah', '2022-12-23 01:13:51', NULL, NULL, NULL),
(101, 3, 'P20223101', 'Satrio 101', '56419974101', '3276022304010010101', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243101', 'Malang. 101', 'Islam', 8, 6, NULL, NULL, 'Gratis', '2022-12-23 01:13:51', NULL, NULL, NULL),
(102, 3, 'P20223102', 'Satrio 102', '56419974102', '3276022304010010102', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243102', 'Malang. 102', 'Islam', 12, 9, NULL, NULL, 'Gratis', '2022-12-23 01:13:51', NULL, NULL, NULL),
(103, 3, 'P20223103', 'Satrio 103', '56419974103', '3276022304010010103', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243103', 'Malang. 103', 'Islam', 7, 11, NULL, NULL, 'Gratis', '2022-12-23 01:13:52', NULL, NULL, NULL),
(104, 3, 'P20223104', 'Satrio 104', '56419974104', '3276022304010010104', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243104', 'Malang. 104', 'Islam', 4, 11, NULL, NULL, 'Gratis', '2022-12-23 01:13:52', NULL, NULL, NULL),
(105, 2, 'P20222105', 'Satrio 105', '56419974105', '3276022304010010105', 'Depok', '2001-12-28', 'Perempuan', '08810243105', 'Malang. 105', 'Islam', 3, 5, '150000.00', 4, 'Belum', '2022-12-23 01:13:52', NULL, NULL, NULL),
(106, 2, 'P20222106', 'Satrio 106', '56419974106', '3276022304010010106', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243106', 'Malang. 106', 'Islam', 11, 7, '150000.00', 3, 'Sudah', '2022-12-23 01:13:52', NULL, NULL, NULL),
(107, 2, 'P20222107', 'Satrio 107', '56419974107', '3276022304010010107', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243107', 'Malang. 107', 'Islam', 10, 2, '150000.00', 3, 'Sudah', '2022-12-23 01:13:52', NULL, NULL, NULL),
(108, 1, 'P20221108', 'Satrio 108', '56419974108', '3276022304010010108', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243108', 'Malang. 108', 'Islam', 11, 8, '150000.00', 1, 'Sudah', '2022-12-23 01:13:52', NULL, NULL, NULL),
(109, 3, 'P20223109', 'Satrio 109', '56419974109', '3276022304010010109', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243109', 'Malang. 109', 'Islam', 4, 5, NULL, NULL, 'Gratis', '2022-12-23 01:13:52', NULL, NULL, NULL),
(110, 2, 'P20222110', 'Satrio 110', '56419974110', '3276022304010010110', 'Depok', '2001-12-08', 'Perempuan', '08810243110', 'Malang. 110', 'Islam', 5, 11, '150000.00', 2, 'Sudah', '2022-12-23 01:13:52', NULL, NULL, NULL),
(111, 2, 'P20222111', 'Satrio 111', '56419974111', '3276022304010010111', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243111', 'Malang. 111', 'Islam', 4, 4, '150000.00', 3, 'Sudah', '2022-12-23 01:13:52', NULL, NULL, NULL),
(112, 3, 'P20223112', 'Satrio 112', '56419974112', '3276022304010010112', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243112', 'Malang. 112', 'Islam', 1, 13, NULL, NULL, 'Belum', '2022-12-23 01:13:53', NULL, NULL, NULL),
(113, 1, 'P20221113', 'Satrio 113', '56419974113', '3276022304010010113', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243113', 'Malang. 113', 'Islam', 7, 9, '150000.00', 1, 'Sudah', '2022-12-23 01:13:53', NULL, NULL, NULL),
(114, 1, 'P20221114', 'Satrio 114', '56419974114', '3276022304010010114', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243114', 'Malang. 114', 'Islam', 5, 9, '150000.00', 2, 'Sudah', '2022-12-23 01:13:53', NULL, NULL, NULL),
(115, 1, 'P20221115', 'Satrio 115', '56419974115', '3276022304010010115', 'Depok', '2001-12-07', 'Perempuan', '08810243115', 'Malang. 115', 'Islam', 7, 13, '150000.00', 2, 'Sudah', '2022-12-23 01:13:53', NULL, NULL, NULL),
(116, 3, 'P20223116', 'Satrio 116', '56419974116', '3276022304010010116', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243116', 'Malang. 116', 'Islam', 2, 8, NULL, NULL, 'Gratis', '2022-12-23 01:13:53', NULL, NULL, NULL),
(117, 3, 'P20223117', 'Satrio 117', '56419974117', '3276022304010010117', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243117', 'Malang. 117', 'Islam', 5, 11, NULL, NULL, 'Gratis', '2022-12-23 01:13:53', NULL, NULL, NULL),
(118, 2, 'P20222118', 'Satrio 118', '56419974118', '3276022304010010118', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243118', 'Malang. 118', 'Islam', 11, 2, '150000.00', 3, 'Sudah', '2022-12-23 01:13:53', NULL, NULL, NULL),
(119, 3, 'P20223119', 'Satrio 119', '56419974119', '3276022304010010119', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243119', 'Malang. 119', 'Islam', 12, 12, NULL, NULL, 'Belum', '2022-12-23 01:13:53', NULL, NULL, NULL),
(120, 1, 'P20221120', 'Satrio 120', '56419974120', '3276022304010010120', 'Depok', '2001-12-14', 'Perempuan', '08810243120', 'Malang. 120', 'Islam', 8, 6, '150000.00', 2, 'Sudah', '2022-12-23 01:13:53', NULL, NULL, NULL),
(121, 1, 'P20221121', 'Satrio 121', '56419974121', '3276022304010010121', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243121', 'Malang. 121', 'Islam', 2, 5, '150000.00', 1, 'Sudah', '2022-12-23 01:13:53', NULL, NULL, NULL),
(122, 1, 'P20221122', 'Satrio 122', '56419974122', '3276022304010010122', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243122', 'Malang. 122', 'Islam', 1, 11, '150000.00', 2, 'Sudah', '2022-12-23 01:13:53', NULL, NULL, NULL),
(123, 1, 'P20221123', 'Satrio 123', '56419974123', '3276022304010010123', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243123', 'Malang. 123', 'Islam', 10, 3, '150000.00', 4, 'Sudah', '2022-12-23 01:13:53', NULL, NULL, NULL),
(124, 1, 'P20221124', 'Satrio 124', '56419974124', '3276022304010010124', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243124', 'Malang. 124', 'Islam', 4, 10, '150000.00', 1, 'Sudah', '2022-12-23 01:13:54', NULL, NULL, NULL),
(125, 1, 'P20221125', 'Satrio 125', '56419974125', '3276022304010010125', 'Depok', '2001-12-25', 'Perempuan', '08810243125', 'Malang. 125', 'Islam', 12, 8, '150000.00', 1, 'Sudah', '2022-12-23 01:13:54', NULL, NULL, NULL),
(126, 1, 'P20221126', 'Satrio 126', '56419974126', '3276022304010010126', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243126', 'Malang. 126', 'Islam', 13, 13, '150000.00', 2, 'Belum', '2022-12-23 01:13:54', NULL, NULL, NULL),
(127, 1, 'P20221127', 'Satrio 127', '56419974127', '3276022304010010127', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243127', 'Malang. 127', 'Islam', 8, 11, '150000.00', 2, 'Sudah', '2022-12-23 01:13:54', NULL, NULL, NULL),
(128, 1, 'P20221128', 'Satrio 128', '56419974128', '3276022304010010128', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243128', 'Malang. 128', 'Islam', 7, 6, '150000.00', 4, 'Sudah', '2022-12-23 01:13:54', NULL, NULL, NULL),
(129, 2, 'P20222129', 'Satrio 129', '56419974129', '3276022304010010129', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243129', 'Malang. 129', 'Islam', 5, 6, '150000.00', 1, 'Sudah', '2022-12-23 01:13:54', NULL, NULL, NULL),
(130, 1, 'P20221130', 'Satrio 130', '56419974130', '3276022304010010130', 'Depok', '2001-12-11', 'Perempuan', '08810243130', 'Malang. 130', 'Islam', 11, 10, '150000.00', 4, 'Sudah', '2022-12-23 01:13:54', NULL, NULL, NULL),
(131, 3, 'P20223131', 'Satrio 131', '56419974131', '3276022304010010131', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243131', 'Malang. 131', 'Islam', 13, 12, NULL, NULL, 'Gratis', '2022-12-23 01:13:54', NULL, NULL, NULL),
(132, 1, 'P20221132', 'Satrio 132', '56419974132', '3276022304010010132', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243132', 'Malang. 132', 'Islam', 10, 10, '150000.00', 1, 'Sudah', '2022-12-23 01:13:54', NULL, NULL, NULL),
(133, 3, 'P20223133', 'Satrio 133', '56419974133', '3276022304010010133', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243133', 'Malang. 133', 'Islam', 3, 9, NULL, NULL, 'Belum', '2022-12-23 01:13:54', NULL, NULL, NULL),
(134, 3, 'P20223134', 'Satrio 134', '56419974134', '3276022304010010134', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243134', 'Malang. 134', 'Islam', 10, 2, NULL, NULL, 'Gratis', '2022-12-23 01:13:54', NULL, NULL, NULL),
(135, 2, 'P20222135', 'Satrio 135', '56419974135', '3276022304010010135', 'Depok', '2001-12-26', 'Perempuan', '08810243135', 'Malang. 135', 'Islam', 7, 6, '150000.00', 2, 'Sudah', '2022-12-23 01:13:54', NULL, NULL, NULL),
(136, 3, 'P20223136', 'Satrio 136', '56419974136', '3276022304010010136', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243136', 'Malang. 136', 'Islam', 8, 6, NULL, NULL, 'Gratis', '2022-12-23 01:13:54', NULL, NULL, NULL),
(137, 3, 'P20223137', 'Satrio 137', '56419974137', '3276022304010010137', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243137', 'Malang. 137', 'Islam', 5, 5, NULL, NULL, 'Gratis', '2022-12-23 01:13:55', NULL, NULL, NULL),
(138, 2, 'P20222138', 'Satrio 138', '56419974138', '3276022304010010138', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243138', 'Malang. 138', 'Islam', 13, 11, '150000.00', 4, 'Sudah', '2022-12-23 01:13:55', NULL, NULL, NULL),
(139, 3, 'P20223139', 'Satrio 139', '56419974139', '3276022304010010139', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243139', 'Malang. 139', 'Islam', 6, 6, NULL, NULL, 'Gratis', '2022-12-23 01:13:55', NULL, NULL, NULL),
(140, 3, 'P20223140', 'Satrio 140', '56419974140', '3276022304010010140', 'Depok', '2001-12-15', 'Perempuan', '08810243140', 'Malang. 140', 'Islam', 10, 13, NULL, NULL, 'Belum', '2022-12-23 01:13:55', NULL, NULL, NULL),
(141, 2, 'P20222141', 'Satrio 141', '56419974141', '3276022304010010141', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243141', 'Malang. 141', 'Islam', 6, 11, '150000.00', 3, 'Sudah', '2022-12-23 01:13:55', NULL, NULL, NULL),
(142, 3, 'P20223142', 'Satrio 142', '56419974142', '3276022304010010142', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243142', 'Malang. 142', 'Islam', 4, 8, NULL, NULL, 'Gratis', '2022-12-23 01:13:55', NULL, NULL, NULL),
(143, 3, 'P20223143', 'Satrio 143', '56419974143', '3276022304010010143', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243143', 'Malang. 143', 'Islam', 5, 1, NULL, NULL, 'Gratis', '2022-12-23 01:13:55', NULL, NULL, NULL),
(144, 2, 'P20222144', 'Satrio 144', '56419974144', '3276022304010010144', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243144', 'Malang. 144', 'Islam', 5, 6, '150000.00', 4, 'Sudah', '2022-12-23 01:13:55', NULL, NULL, NULL),
(145, 3, 'P20223145', 'Satrio 145', '56419974145', '3276022304010010145', 'Depok', '2001-12-17', 'Perempuan', '08810243145', 'Malang. 145', 'Islam', 4, 2, NULL, NULL, 'Gratis', '2022-12-23 01:13:55', NULL, NULL, NULL),
(146, 1, 'P20221146', 'Satrio 146', '56419974146', '3276022304010010146', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243146', 'Malang. 146', 'Islam', 3, 12, '150000.00', 2, 'Sudah', '2022-12-23 01:13:56', NULL, NULL, NULL),
(147, 2, 'P20222147', 'Satrio 147', '56419974147', '3276022304010010147', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243147', 'Malang. 147', 'Islam', 12, 5, '150000.00', 1, 'Belum', '2022-12-23 01:13:56', NULL, NULL, NULL),
(148, 3, 'P20223148', 'Satrio 148', '56419974148', '3276022304010010148', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243148', 'Malang. 148', 'Islam', 3, 2, NULL, NULL, 'Gratis', '2022-12-23 01:13:56', NULL, NULL, NULL),
(149, 2, 'P20222149', 'Satrio 149', '56419974149', '3276022304010010149', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243149', 'Malang. 149', 'Islam', 8, 5, '150000.00', 4, 'Sudah', '2022-12-23 01:13:56', NULL, NULL, NULL),
(150, 1, 'P20221150', 'Satrio 150', '56419974150', '3276022304010010150', 'Depok', '2001-12-02', 'Perempuan', '08810243150', 'Malang. 150', 'Islam', 8, 1, '150000.00', 4, 'Sudah', '2022-12-23 01:13:56', NULL, NULL, NULL),
(151, 2, 'P20222151', 'Satrio 151', '56419974151', '3276022304010010151', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243151', 'Malang. 151', 'Islam', 13, 10, '150000.00', 3, 'Sudah', '2022-12-23 01:13:56', NULL, NULL, NULL),
(152, 3, 'P20223152', 'Satrio 152', '56419974152', '3276022304010010152', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243152', 'Malang. 152', 'Islam', 2, 9, NULL, NULL, 'Gratis', '2022-12-23 01:13:56', NULL, NULL, NULL),
(153, 1, 'P20221153', 'Satrio 153', '56419974153', '3276022304010010153', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243153', 'Malang. 153', 'Islam', 12, 10, '150000.00', 1, 'Sudah', '2022-12-23 01:13:57', NULL, NULL, NULL),
(154, 1, 'P20221154', 'Satrio 154', '56419974154', '3276022304010010154', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243154', 'Malang. 154', 'Islam', 5, 7, '150000.00', 2, 'Belum', '2022-12-23 01:13:57', NULL, NULL, NULL),
(155, 3, 'P20223155', 'Satrio 155', '56419974155', '3276022304010010155', 'Depok', '2001-12-27', 'Perempuan', '08810243155', 'Malang. 155', 'Islam', 3, 4, NULL, NULL, 'Gratis', '2022-12-23 01:13:57', NULL, NULL, NULL),
(156, 3, 'P20223156', 'Satrio 156', '56419974156', '3276022304010010156', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243156', 'Malang. 156', 'Islam', 7, 7, NULL, NULL, 'Gratis', '2022-12-23 01:13:57', NULL, NULL, NULL),
(157, 1, 'P20221157', 'Satrio 157', '56419974157', '3276022304010010157', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243157', 'Malang. 157', 'Islam', 10, 8, '150000.00', 2, 'Sudah', '2022-12-23 01:13:57', NULL, NULL, NULL),
(158, 2, 'P20222158', 'Satrio 158', '56419974158', '3276022304010010158', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243158', 'Malang. 158', 'Islam', 4, 5, '150000.00', 1, 'Sudah', '2022-12-23 01:13:57', NULL, NULL, NULL),
(159, 3, 'P20223159', 'Satrio 159', '56419974159', '3276022304010010159', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243159', 'Malang. 159', 'Islam', 10, 11, NULL, NULL, 'Gratis', '2022-12-23 01:13:57', NULL, NULL, NULL),
(160, 3, 'P20223160', 'Satrio 160', '56419974160', '3276022304010010160', 'Depok', '2001-12-21', 'Perempuan', '08810243160', 'Malang. 160', 'Islam', 4, 13, NULL, NULL, 'Gratis', '2022-12-23 01:13:58', NULL, NULL, NULL),
(161, 1, 'P20221161', 'Satrio 161', '56419974161', '3276022304010010161', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243161', 'Malang. 161', 'Islam', 2, 8, '150000.00', 2, 'Belum', '2022-12-23 01:13:58', NULL, NULL, NULL),
(162, 2, 'P20222162', 'Satrio 162', '56419974162', '3276022304010010162', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243162', 'Malang. 162', 'Islam', 2, 13, '150000.00', 2, 'Sudah', '2022-12-23 01:13:58', NULL, NULL, NULL),
(163, 2, 'P20222163', 'Satrio 163', '56419974163', '3276022304010010163', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243163', 'Malang. 163', 'Islam', 13, 13, '150000.00', 4, 'Sudah', '2022-12-23 01:13:58', NULL, NULL, NULL),
(164, 3, 'P20223164', 'Satrio 164', '56419974164', '3276022304010010164', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243164', 'Malang. 164', 'Islam', 4, 4, NULL, NULL, 'Gratis', '2022-12-23 01:13:58', NULL, NULL, NULL),
(165, 1, 'P20221165', 'Satrio 165', '56419974165', '3276022304010010165', 'Depok', '2001-12-04', 'Perempuan', '08810243165', 'Malang. 165', 'Islam', 5, 2, '150000.00', 3, 'Sudah', '2022-12-23 01:13:59', NULL, NULL, NULL),
(166, 3, 'P20223166', 'Satrio 166', '56419974166', '3276022304010010166', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243166', 'Malang. 166', 'Islam', 4, 10, NULL, NULL, 'Gratis', '2022-12-23 01:13:59', NULL, NULL, NULL),
(167, 1, 'P20221167', 'Satrio 167', '56419974167', '3276022304010010167', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243167', 'Malang. 167', 'Islam', 10, 6, '150000.00', 4, 'Sudah', '2022-12-23 01:13:59', NULL, NULL, NULL),
(168, 3, 'P20223168', 'Satrio 168', '56419974168', '3276022304010010168', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243168', 'Malang. 168', 'Islam', 5, 13, NULL, NULL, 'Belum', '2022-12-23 01:13:59', NULL, NULL, NULL),
(169, 2, 'P20222169', 'Satrio 169', '56419974169', '3276022304010010169', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243169', 'Malang. 169', 'Islam', 12, 6, '150000.00', 4, 'Sudah', '2022-12-23 01:14:00', NULL, NULL, NULL),
(170, 2, 'P20222170', 'Satrio 170', '56419974170', '3276022304010010170', 'Depok', '2001-12-19', 'Perempuan', '08810243170', 'Malang. 170', 'Islam', 12, 9, '150000.00', 4, 'Sudah', '2022-12-23 01:14:00', NULL, NULL, NULL),
(171, 3, 'P20223171', 'Satrio 171', '56419974171', '3276022304010010171', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243171', 'Malang. 171', 'Islam', 9, 8, NULL, NULL, 'Gratis', '2022-12-23 01:14:00', NULL, NULL, NULL),
(172, 1, 'P20221172', 'Satrio 172', '56419974172', '3276022304010010172', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243172', 'Malang. 172', 'Islam', 8, 1, '150000.00', 2, 'Sudah', '2022-12-23 01:14:00', NULL, NULL, NULL),
(173, 3, 'P20223173', 'Satrio 173', '56419974173', '3276022304010010173', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243173', 'Malang. 173', 'Islam', 7, 2, NULL, NULL, 'Gratis', '2022-12-23 01:14:00', NULL, NULL, NULL),
(174, 3, 'P20223174', 'Satrio 174', '56419974174', '3276022304010010174', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243174', 'Malang. 174', 'Islam', 10, 13, NULL, NULL, 'Gratis', '2022-12-23 01:14:00', NULL, NULL, NULL),
(175, 3, 'P20223175', 'Satrio 175', '56419974175', '3276022304010010175', 'Depok', '2001-12-31', 'Perempuan', '08810243175', 'Malang. 175', 'Islam', 1, 2, NULL, NULL, 'Belum', '2022-12-23 01:14:00', NULL, NULL, NULL),
(176, 3, 'P20223176', 'Satrio 176', '56419974176', '3276022304010010176', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243176', 'Malang. 176', 'Islam', 4, 11, NULL, NULL, 'Gratis', '2022-12-23 01:14:00', NULL, NULL, NULL),
(177, 1, 'P20221177', 'Satrio 177', '56419974177', '3276022304010010177', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243177', 'Malang. 177', 'Islam', 12, 1, '150000.00', 3, 'Sudah', '2022-12-23 01:14:00', NULL, NULL, NULL),
(178, 2, 'P20222178', 'Satrio 178', '56419974178', '3276022304010010178', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243178', 'Malang. 178', 'Islam', 10, 5, '150000.00', 4, 'Sudah', '2022-12-23 01:14:01', NULL, NULL, NULL),
(179, 3, 'P20223179', 'Satrio 179', '56419974179', '3276022304010010179', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243179', 'Malang. 179', 'Islam', 1, 3, NULL, NULL, 'Gratis', '2022-12-23 01:14:01', NULL, NULL, NULL),
(180, 2, 'P20222180', 'Satrio 180', '56419974180', '3276022304010010180', 'Depok', '2001-12-27', 'Perempuan', '08810243180', 'Malang. 180', 'Islam', 10, 8, '150000.00', 4, 'Sudah', '2022-12-23 01:14:01', NULL, NULL, NULL),
(181, 2, 'P20222181', 'Satrio 181', '56419974181', '3276022304010010181', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243181', 'Malang. 181', 'Islam', 1, 13, '150000.00', 4, 'Sudah', '2022-12-23 01:14:01', NULL, NULL, NULL),
(182, 3, 'P20223182', 'Satrio 182', '56419974182', '3276022304010010182', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243182', 'Malang. 182', 'Islam', 13, 11, NULL, NULL, 'Belum', '2022-12-23 01:14:01', NULL, NULL, NULL),
(183, 3, 'P20223183', 'Satrio 183', '56419974183', '3276022304010010183', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243183', 'Malang. 183', 'Islam', 12, 10, NULL, NULL, 'Gratis', '2022-12-23 01:14:01', NULL, NULL, NULL),
(184, 3, 'P20223184', 'Satrio 184', '56419974184', '3276022304010010184', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243184', 'Malang. 184', 'Islam', 7, 3, NULL, NULL, 'Gratis', '2022-12-23 01:14:01', NULL, NULL, NULL),
(185, 2, 'P20222185', 'Satrio 185', '56419974185', '3276022304010010185', 'Depok', '2001-12-23', 'Perempuan', '08810243185', 'Malang. 185', 'Islam', 2, 6, '150000.00', 3, 'Sudah', '2022-12-23 01:14:01', NULL, NULL, NULL),
(186, 2, 'P20222186', 'Satrio 186', '56419974186', '3276022304010010186', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243186', 'Malang. 186', 'Islam', 2, 1, '150000.00', 4, 'Sudah', '2022-12-23 01:14:02', NULL, NULL, NULL),
(187, 2, 'P20222187', 'Satrio 187', '56419974187', '3276022304010010187', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243187', 'Malang. 187', 'Islam', 1, 6, '150000.00', 1, 'Sudah', '2022-12-23 01:14:02', NULL, NULL, NULL),
(188, 3, 'P20223188', 'Satrio 188', '56419974188', '3276022304010010188', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243188', 'Malang. 188', 'Islam', 4, 8, NULL, NULL, 'Gratis', '2022-12-23 01:14:02', NULL, NULL, NULL),
(189, 1, 'P20221189', 'Satrio 189', '56419974189', '3276022304010010189', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243189', 'Malang. 189', 'Islam', 12, 1, '150000.00', 4, 'Belum', '2022-12-23 01:14:02', NULL, NULL, NULL),
(190, 3, 'P20223190', 'Satrio 190', '56419974190', '3276022304010010190', 'Depok', '2001-12-29', 'Perempuan', '08810243190', 'Malang. 190', 'Islam', 2, 2, NULL, NULL, 'Gratis', '2022-12-23 01:14:02', NULL, NULL, NULL),
(191, 1, 'P20221191', 'Satrio 191', '56419974191', '3276022304010010191', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243191', 'Malang. 191', 'Islam', 12, 4, '150000.00', 3, 'Sudah', '2022-12-23 01:14:02', NULL, NULL, NULL),
(192, 3, 'P20223192', 'Satrio 192', '56419974192', '3276022304010010192', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243192', 'Malang. 192', 'Islam', 2, 7, NULL, NULL, 'Gratis', '2022-12-23 01:14:02', NULL, NULL, NULL),
(193, 2, 'P20222193', 'Satrio 193', '56419974193', '3276022304010010193', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243193', 'Malang. 193', 'Islam', 12, 7, '150000.00', 3, 'Sudah', '2022-12-23 01:14:02', NULL, NULL, NULL),
(194, 3, 'P20223194', 'Satrio 194', '56419974194', '3276022304010010194', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243194', 'Malang. 194', 'Islam', 12, 13, NULL, NULL, 'Gratis', '2022-12-23 01:14:02', NULL, NULL, NULL),
(195, 1, 'P20221195', 'Satrio 195', '56419974195', '3276022304010010195', 'Depok', '2001-12-16', 'Perempuan', '08810243195', 'Malang. 195', 'Islam', 4, 8, '150000.00', 1, 'Sudah', '2022-12-23 01:14:02', NULL, NULL, NULL),
(196, 1, 'P20221196', 'Satrio 196', '56419974196', '3276022304010010196', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243196', 'Malang. 196', 'Islam', 11, 9, '150000.00', 4, 'Belum', '2022-12-23 01:14:02', NULL, NULL, NULL),
(197, 3, 'P20223197', 'Satrio 197', '56419974197', '3276022304010010197', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243197', 'Malang. 197', 'Islam', 11, 2, NULL, NULL, 'Gratis', '2022-12-23 01:14:02', NULL, NULL, NULL),
(198, 2, 'P20222198', 'Satrio 198', '56419974198', '3276022304010010198', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243198', 'Malang. 198', 'Islam', 3, 2, '150000.00', 4, 'Sudah', '2022-12-23 01:14:02', NULL, NULL, NULL),
(199, 2, 'P20222199', 'Satrio 199', '56419974199', '3276022304010010199', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243199', 'Malang. 199', 'Islam', 1, 9, '150000.00', 4, 'Sudah', '2022-12-23 01:14:02', NULL, NULL, NULL),
(200, 3, 'P20223200', 'Satrio 200', '56419974200', '3276022304010010200', 'Depok', '2001-12-31', 'Perempuan', '08810243200', 'Malang. 200', 'Islam', 13, 6, NULL, NULL, 'Gratis', '2022-12-23 01:14:02', NULL, NULL, NULL),
(201, 2, 'P20222201', 'Satrio 201', '56419974201', '3276022304010010201', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243201', 'Malang. 201', 'Islam', 12, 2, '150000.00', 2, 'Sudah', '2022-12-23 01:14:02', NULL, NULL, NULL),
(202, 2, 'P20222202', 'Satrio 202', '56419974202', '3276022304010010202', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243202', 'Malang. 202', 'Islam', 5, 6, '150000.00', 1, 'Sudah', '2022-12-23 01:14:03', NULL, NULL, NULL),
(203, 1, 'P20221203', 'Satrio 203', '56419974203', '3276022304010010203', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243203', 'Malang. 203', 'Islam', 5, 2, '150000.00', 4, 'Belum', '2022-12-23 01:14:03', NULL, NULL, NULL),
(204, 1, 'P20221204', 'Satrio 204', '56419974204', '3276022304010010204', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243204', 'Malang. 204', 'Islam', 7, 4, '150000.00', 1, 'Sudah', '2022-12-23 01:14:03', NULL, NULL, NULL),
(205, 3, 'P20223205', 'Satrio 205', '56419974205', '3276022304010010205', 'Depok', '2001-12-31', 'Perempuan', '08810243205', 'Malang. 205', 'Islam', 7, 9, NULL, NULL, 'Gratis', '2022-12-23 01:14:03', NULL, NULL, NULL),
(206, 3, 'P20223206', 'Satrio 206', '56419974206', '3276022304010010206', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243206', 'Malang. 206', 'Islam', 7, 3, NULL, NULL, 'Gratis', '2022-12-23 01:14:03', NULL, NULL, NULL),
(207, 1, 'P20221207', 'Satrio 207', '56419974207', '3276022304010010207', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243207', 'Malang. 207', 'Islam', 11, 6, '150000.00', 1, 'Sudah', '2022-12-23 01:14:03', NULL, NULL, NULL),
(208, 2, 'P20222208', 'Satrio 208', '56419974208', '3276022304010010208', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243208', 'Malang. 208', 'Islam', 4, 11, '150000.00', 2, 'Sudah', '2022-12-23 01:14:03', NULL, NULL, NULL),
(209, 3, 'P20223209', 'Satrio 209', '56419974209', '3276022304010010209', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243209', 'Malang. 209', 'Islam', 9, 10, NULL, NULL, 'Gratis', '2022-12-23 01:14:03', NULL, NULL, NULL),
(210, 2, 'P20222210', 'Satrio 210', '56419974210', '3276022304010010210', 'Depok', '2001-12-17', 'Perempuan', '08810243210', 'Malang. 210', 'Islam', 7, 10, '150000.00', 2, 'Belum', '2022-12-23 01:14:03', NULL, NULL, NULL),
(211, 3, 'P20223211', 'Satrio 211', '56419974211', '3276022304010010211', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243211', 'Malang. 211', 'Islam', 7, 12, NULL, NULL, 'Gratis', '2022-12-23 01:14:03', NULL, NULL, NULL),
(212, 3, 'P20223212', 'Satrio 212', '56419974212', '3276022304010010212', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243212', 'Malang. 212', 'Islam', 5, 6, NULL, NULL, 'Gratis', '2022-12-23 01:14:03', NULL, NULL, NULL),
(213, 2, 'P20222213', 'Satrio 213', '56419974213', '3276022304010010213', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243213', 'Malang. 213', 'Islam', 12, 12, '150000.00', 2, 'Sudah', '2022-12-23 01:14:03', NULL, NULL, NULL),
(214, 1, 'P20221214', 'Satrio 214', '56419974214', '3276022304010010214', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243214', 'Malang. 214', 'Islam', 7, 11, '150000.00', 4, 'Sudah', '2022-12-23 01:14:03', NULL, NULL, NULL),
(215, 1, 'P20221215', 'Satrio 215', '56419974215', '3276022304010010215', 'Depok', '2001-12-13', 'Perempuan', '08810243215', 'Malang. 215', 'Islam', 10, 7, '150000.00', 2, 'Sudah', '2022-12-23 01:14:03', NULL, NULL, NULL),
(216, 3, 'P20223216', 'Satrio 216', '56419974216', '3276022304010010216', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243216', 'Malang. 216', 'Islam', 13, 7, NULL, NULL, 'Gratis', '2022-12-23 01:14:03', NULL, NULL, NULL),
(217, 3, 'P20223217', 'Satrio 217', '56419974217', '3276022304010010217', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243217', 'Malang. 217', 'Islam', 13, 6, NULL, NULL, 'Belum', '2022-12-23 01:14:03', NULL, NULL, NULL),
(218, 2, 'P20222218', 'Satrio 218', '56419974218', '3276022304010010218', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243218', 'Malang. 218', 'Islam', 4, 10, '150000.00', 3, 'Sudah', '2022-12-23 01:14:04', NULL, NULL, NULL),
(219, 2, 'P20222219', 'Satrio 219', '56419974219', '3276022304010010219', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243219', 'Malang. 219', 'Islam', 11, 6, '150000.00', 3, 'Sudah', '2022-12-23 01:14:04', NULL, NULL, NULL),
(220, 2, 'P20222220', 'Satrio 220', '56419974220', '3276022304010010220', 'Depok', '2001-12-27', 'Perempuan', '08810243220', 'Malang. 220', 'Islam', 3, 1, '150000.00', 3, 'Sudah', '2022-12-23 01:14:04', NULL, NULL, NULL),
(221, 1, 'P20221221', 'Satrio 221', '56419974221', '3276022304010010221', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243221', 'Malang. 221', 'Islam', 8, 8, '150000.00', 2, 'Sudah', '2022-12-23 01:14:04', NULL, NULL, NULL),
(222, 2, 'P20222222', 'Satrio 222', '56419974222', '3276022304010010222', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243222', 'Malang. 222', 'Islam', 2, 12, '150000.00', 2, 'Sudah', '2022-12-23 01:14:04', NULL, NULL, NULL),
(223, 1, 'P20221223', 'Satrio 223', '56419974223', '3276022304010010223', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243223', 'Malang. 223', 'Islam', 4, 12, '150000.00', 4, 'Sudah', '2022-12-23 01:14:04', NULL, NULL, NULL),
(224, 1, 'P20221224', 'Satrio 224', '56419974224', '3276022304010010224', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243224', 'Malang. 224', 'Islam', 2, 5, '150000.00', 2, 'Belum', '2022-12-23 01:14:04', NULL, NULL, NULL),
(225, 1, 'P20221225', 'Satrio 225', '56419974225', '3276022304010010225', 'Depok', '2001-12-30', 'Perempuan', '08810243225', 'Malang. 225', 'Islam', 9, 1, '150000.00', 4, 'Sudah', '2022-12-23 01:14:04', NULL, NULL, NULL),
(226, 3, 'P20223226', 'Satrio 226', '56419974226', '3276022304010010226', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243226', 'Malang. 226', 'Islam', 8, 5, NULL, NULL, 'Gratis', '2022-12-23 01:14:04', NULL, NULL, NULL),
(227, 3, 'P20223227', 'Satrio 227', '56419974227', '3276022304010010227', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243227', 'Malang. 227', 'Islam', 7, 7, NULL, NULL, 'Gratis', '2022-12-23 01:14:04', NULL, NULL, NULL),
(228, 2, 'P20222228', 'Satrio 228', '56419974228', '3276022304010010228', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243228', 'Malang. 228', 'Islam', 5, 11, '150000.00', 3, 'Sudah', '2022-12-23 01:14:04', NULL, NULL, NULL);
INSERT INTO `pendaftar` (`id_pendaftar`, `id_jalur`, `no_pendaftar`, `nama`, `nisn`, `nik`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `no_hp`, `alamat`, `agama`, `id_prodi1`, `id_prodi2`, `nominal_bayar`, `id_bank`, `status_bayar`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(229, 3, 'P20223229', 'Satrio 229', '56419974229', '3276022304010010229', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243229', 'Malang. 229', 'Islam', 3, 4, NULL, NULL, 'Gratis', '2022-12-23 01:14:04', NULL, NULL, NULL),
(230, 3, 'P20223230', 'Satrio 230', '56419974230', '3276022304010010230', 'Depok', '2001-12-20', 'Perempuan', '08810243230', 'Malang. 230', 'Islam', 11, 11, NULL, NULL, 'Gratis', '2022-12-23 01:14:04', NULL, NULL, NULL),
(231, 2, 'P20222231', 'Satrio 231', '56419974231', '3276022304010010231', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243231', 'Malang. 231', 'Islam', 3, 9, '150000.00', 3, 'Belum', '2022-12-23 01:14:04', NULL, NULL, NULL),
(232, 2, 'P20222232', 'Satrio 232', '56419974232', '3276022304010010232', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243232', 'Malang. 232', 'Islam', 1, 2, '150000.00', 3, 'Sudah', '2022-12-23 01:14:05', NULL, NULL, NULL),
(233, 3, 'P20223233', 'Satrio 233', '56419974233', '3276022304010010233', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243233', 'Malang. 233', 'Islam', 10, 8, NULL, NULL, 'Gratis', '2022-12-23 01:14:05', NULL, NULL, NULL),
(234, 2, 'P20222234', 'Satrio 234', '56419974234', '3276022304010010234', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243234', 'Malang. 234', 'Islam', 6, 13, '150000.00', 3, 'Sudah', '2022-12-23 01:14:05', NULL, NULL, NULL),
(235, 2, 'P20222235', 'Satrio 235', '56419974235', '3276022304010010235', 'Depok', '2001-12-12', 'Perempuan', '08810243235', 'Malang. 235', 'Islam', 13, 2, '150000.00', 3, 'Sudah', '2022-12-23 01:14:05', NULL, NULL, NULL),
(236, 3, 'P20223236', 'Satrio 236', '56419974236', '3276022304010010236', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243236', 'Malang. 236', 'Islam', 7, 8, NULL, NULL, 'Gratis', '2022-12-23 01:14:05', NULL, NULL, NULL),
(237, 1, 'P20221237', 'Satrio 237', '56419974237', '3276022304010010237', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243237', 'Malang. 237', 'Islam', 11, 8, '150000.00', 1, 'Sudah', '2022-12-23 01:14:05', NULL, NULL, NULL),
(238, 2, 'P20222238', 'Satrio 238', '56419974238', '3276022304010010238', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243238', 'Malang. 238', 'Islam', 13, 7, '150000.00', 3, 'Belum', '2022-12-23 01:14:05', NULL, NULL, NULL),
(239, 1, 'P20221239', 'Satrio 239', '56419974239', '3276022304010010239', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243239', 'Malang. 239', 'Islam', 2, 5, '150000.00', 1, 'Sudah', '2022-12-23 01:14:05', NULL, NULL, NULL),
(240, 1, 'P20221240', 'Satrio 240', '56419974240', '3276022304010010240', 'Depok', '2001-12-28', 'Perempuan', '08810243240', 'Malang. 240', 'Islam', 11, 3, '150000.00', 3, 'Sudah', '2022-12-23 01:14:05', NULL, NULL, NULL),
(241, 2, 'P20222241', 'Satrio 241', '56419974241', '3276022304010010241', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243241', 'Malang. 241', 'Islam', 6, 5, '150000.00', 4, 'Sudah', '2022-12-23 01:14:05', NULL, NULL, NULL),
(242, 1, 'P20221242', 'Satrio 242', '56419974242', '3276022304010010242', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243242', 'Malang. 242', 'Islam', 9, 9, '150000.00', 2, 'Sudah', '2022-12-23 01:14:05', NULL, NULL, NULL),
(243, 1, 'P20221243', 'Satrio 243', '56419974243', '3276022304010010243', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243243', 'Malang. 243', 'Islam', 3, 6, '150000.00', 1, 'Sudah', '2022-12-23 01:14:05', NULL, NULL, NULL),
(244, 2, 'P20222244', 'Satrio 244', '56419974244', '3276022304010010244', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243244', 'Malang. 244', 'Islam', 7, 9, '150000.00', 2, 'Sudah', '2022-12-23 01:14:05', NULL, NULL, NULL),
(245, 1, 'P20221245', 'Satrio 245', '56419974245', '3276022304010010245', 'Depok', '2001-12-27', 'Perempuan', '08810243245', 'Malang. 245', 'Islam', 13, 10, '150000.00', 4, 'Belum', '2022-12-23 01:14:06', NULL, NULL, NULL),
(246, 2, 'P20222246', 'Satrio 246', '56419974246', '3276022304010010246', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243246', 'Malang. 246', 'Islam', 8, 6, '150000.00', 4, 'Sudah', '2022-12-23 01:14:06', NULL, NULL, NULL),
(247, 2, 'P20222247', 'Satrio 247', '56419974247', '3276022304010010247', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243247', 'Malang. 247', 'Islam', 4, 9, '150000.00', 1, 'Sudah', '2022-12-23 01:14:06', NULL, NULL, NULL),
(248, 2, 'P20222248', 'Satrio 248', '56419974248', '3276022304010010248', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243248', 'Malang. 248', 'Islam', 12, 6, '150000.00', 1, 'Sudah', '2022-12-23 01:14:06', NULL, NULL, NULL),
(249, 1, 'P20221249', 'Satrio 249', '56419974249', '3276022304010010249', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243249', 'Malang. 249', 'Islam', 2, 6, '150000.00', 1, 'Sudah', '2022-12-23 01:14:06', NULL, NULL, NULL),
(250, 2, 'P20222250', 'Satrio 250', '56419974250', '3276022304010010250', 'Depok', '2001-12-13', 'Perempuan', '08810243250', 'Malang. 250', 'Islam', 2, 10, '150000.00', 4, 'Sudah', '2022-12-23 01:14:06', NULL, NULL, NULL),
(251, 2, 'P20222251', 'Satrio 251', '56419974251', '3276022304010010251', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243251', 'Malang. 251', 'Islam', 1, 13, '150000.00', 3, 'Sudah', '2022-12-23 01:14:06', NULL, NULL, NULL),
(252, 3, 'P20223252', 'Satrio 252', '56419974252', '3276022304010010252', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243252', 'Malang. 252', 'Islam', 8, 11, NULL, NULL, 'Belum', '2022-12-23 01:14:06', NULL, NULL, NULL),
(253, 2, 'P20222253', 'Satrio 253', '56419974253', '3276022304010010253', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243253', 'Malang. 253', 'Islam', 2, 1, '150000.00', 2, 'Sudah', '2022-12-23 01:14:06', NULL, NULL, NULL),
(254, 1, 'P20221254', 'Satrio 254', '56419974254', '3276022304010010254', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243254', 'Malang. 254', 'Islam', 3, 12, '150000.00', 2, 'Sudah', '2022-12-23 01:14:06', NULL, NULL, NULL),
(255, 3, 'P20223255', 'Satrio 255', '56419974255', '3276022304010010255', 'Depok', '2001-12-08', 'Perempuan', '08810243255', 'Malang. 255', 'Islam', 10, 13, NULL, NULL, 'Gratis', '2022-12-23 01:14:06', NULL, NULL, NULL),
(256, 1, 'P20221256', 'Satrio 256', '56419974256', '3276022304010010256', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243256', 'Malang. 256', 'Islam', 12, 7, '150000.00', 1, 'Sudah', '2022-12-23 01:14:06', NULL, NULL, NULL),
(257, 3, 'P20223257', 'Satrio 257', '56419974257', '3276022304010010257', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243257', 'Malang. 257', 'Islam', 6, 13, NULL, NULL, 'Gratis', '2022-12-23 01:14:06', NULL, NULL, NULL),
(258, 2, 'P20222258', 'Satrio 258', '56419974258', '3276022304010010258', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243258', 'Malang. 258', 'Islam', 13, 13, '150000.00', 1, 'Sudah', '2022-12-23 01:14:06', NULL, NULL, NULL),
(259, 2, 'P20222259', 'Satrio 259', '56419974259', '3276022304010010259', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243259', 'Malang. 259', 'Islam', 6, 4, '150000.00', 3, 'Belum', '2022-12-23 01:14:06', NULL, NULL, NULL),
(260, 1, 'P20221260', 'Satrio 260', '56419974260', '3276022304010010260', 'Depok', '2001-12-11', 'Perempuan', '08810243260', 'Malang. 260', 'Islam', 8, 4, '150000.00', 4, 'Sudah', '2022-12-23 01:14:07', NULL, NULL, NULL),
(261, 2, 'P20222261', 'Satrio 261', '56419974261', '3276022304010010261', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243261', 'Malang. 261', 'Islam', 6, 7, '150000.00', 4, 'Sudah', '2022-12-23 01:14:07', NULL, NULL, NULL),
(262, 2, 'P20222262', 'Satrio 262', '56419974262', '3276022304010010262', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243262', 'Malang. 262', 'Islam', 7, 8, '150000.00', 1, 'Sudah', '2022-12-23 01:14:07', NULL, NULL, NULL),
(263, 1, 'P20221263', 'Satrio 263', '56419974263', '3276022304010010263', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243263', 'Malang. 263', 'Islam', 9, 12, '150000.00', 1, 'Sudah', '2022-12-23 01:14:07', NULL, NULL, NULL),
(264, 3, 'P20223264', 'Satrio 264', '56419974264', '3276022304010010264', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243264', 'Malang. 264', 'Islam', 7, 3, NULL, NULL, 'Gratis', '2022-12-23 01:14:07', NULL, NULL, NULL),
(265, 1, 'P20221265', 'Satrio 265', '56419974265', '3276022304010010265', 'Depok', '2001-12-05', 'Perempuan', '08810243265', 'Malang. 265', 'Islam', 9, 10, '150000.00', 2, 'Sudah', '2022-12-23 01:14:07', NULL, NULL, NULL),
(266, 1, 'P20221266', 'Satrio 266', '56419974266', '3276022304010010266', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243266', 'Malang. 266', 'Islam', 13, 12, '150000.00', 2, 'Belum', '2022-12-23 01:14:07', NULL, NULL, NULL),
(267, 1, 'P20221267', 'Satrio 267', '56419974267', '3276022304010010267', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243267', 'Malang. 267', 'Islam', 10, 9, '150000.00', 3, 'Sudah', '2022-12-23 01:14:07', NULL, NULL, NULL),
(268, 2, 'P20222268', 'Satrio 268', '56419974268', '3276022304010010268', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243268', 'Malang. 268', 'Islam', 3, 13, '150000.00', 2, 'Sudah', '2022-12-23 01:14:07', NULL, NULL, NULL),
(269, 2, 'P20222269', 'Satrio 269', '56419974269', '3276022304010010269', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243269', 'Malang. 269', 'Islam', 3, 3, '150000.00', 1, 'Sudah', '2022-12-23 01:14:07', NULL, NULL, NULL),
(270, 1, 'P20221270', 'Satrio 270', '56419974270', '3276022304010010270', 'Depok', '2001-12-30', 'Perempuan', '08810243270', 'Malang. 270', 'Islam', 9, 4, '150000.00', 4, 'Sudah', '2022-12-23 01:14:07', NULL, NULL, NULL),
(271, 2, 'P20222271', 'Satrio 271', '56419974271', '3276022304010010271', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243271', 'Malang. 271', 'Islam', 1, 2, '150000.00', 4, 'Sudah', '2022-12-23 01:14:07', NULL, NULL, NULL),
(272, 1, 'P20221272', 'Satrio 272', '56419974272', '3276022304010010272', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243272', 'Malang. 272', 'Islam', 13, 12, '150000.00', 3, 'Sudah', '2022-12-23 01:14:07', NULL, NULL, NULL),
(273, 2, 'P20222273', 'Satrio 273', '56419974273', '3276022304010010273', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243273', 'Malang. 273', 'Islam', 10, 6, '150000.00', 3, 'Belum', '2022-12-23 01:14:07', NULL, NULL, NULL),
(274, 3, 'P20223274', 'Satrio 274', '56419974274', '3276022304010010274', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243274', 'Malang. 274', 'Islam', 4, 7, NULL, NULL, 'Gratis', '2022-12-23 01:14:07', NULL, NULL, NULL),
(275, 2, 'P20222275', 'Satrio 275', '56419974275', '3276022304010010275', 'Depok', '2001-12-21', 'Perempuan', '08810243275', 'Malang. 275', 'Islam', 10, 11, '150000.00', 4, 'Sudah', '2022-12-23 01:14:07', NULL, NULL, NULL),
(276, 2, 'P20222276', 'Satrio 276', '56419974276', '3276022304010010276', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243276', 'Malang. 276', 'Islam', 8, 13, '150000.00', 4, 'Sudah', '2022-12-23 01:14:08', NULL, NULL, NULL),
(277, 3, 'P20223277', 'Satrio 277', '56419974277', '3276022304010010277', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243277', 'Malang. 277', 'Islam', 8, 5, NULL, NULL, 'Gratis', '2022-12-23 01:14:08', NULL, NULL, NULL),
(278, 2, 'P20222278', 'Satrio 278', '56419974278', '3276022304010010278', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243278', 'Malang. 278', 'Islam', 10, 10, '150000.00', 4, 'Sudah', '2022-12-23 01:14:08', NULL, NULL, NULL),
(279, 1, 'P20221279', 'Satrio 279', '56419974279', '3276022304010010279', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243279', 'Malang. 279', 'Islam', 6, 8, '150000.00', 3, 'Sudah', '2022-12-23 01:14:08', NULL, NULL, NULL),
(280, 2, 'P20222280', 'Satrio 280', '56419974280', '3276022304010010280', 'Depok', '2001-12-07', 'Perempuan', '08810243280', 'Malang. 280', 'Islam', 2, 11, '150000.00', 1, 'Belum', '2022-12-23 01:14:08', NULL, NULL, NULL),
(281, 3, 'P20223281', 'Satrio 281', '56419974281', '3276022304010010281', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243281', 'Malang. 281', 'Islam', 10, 8, NULL, NULL, 'Gratis', '2022-12-23 01:14:08', NULL, NULL, NULL),
(282, 1, 'P20221282', 'Satrio 282', '56419974282', '3276022304010010282', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243282', 'Malang. 282', 'Islam', 1, 2, '150000.00', 2, 'Sudah', '2022-12-23 01:14:08', NULL, NULL, NULL),
(283, 3, 'P20223283', 'Satrio 283', '56419974283', '3276022304010010283', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243283', 'Malang. 283', 'Islam', 4, 9, NULL, NULL, 'Gratis', '2022-12-23 01:14:08', NULL, NULL, NULL),
(284, 2, 'P20222284', 'Satrio 284', '56419974284', '3276022304010010284', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243284', 'Malang. 284', 'Islam', 9, 10, '150000.00', 2, 'Sudah', '2022-12-23 01:14:08', NULL, NULL, NULL),
(285, 3, 'P20223285', 'Satrio 285', '56419974285', '3276022304010010285', 'Depok', '2001-12-04', 'Perempuan', '08810243285', 'Malang. 285', 'Islam', 3, 13, NULL, NULL, 'Gratis', '2022-12-23 01:14:08', NULL, NULL, NULL),
(286, 1, 'P20221286', 'Satrio 286', '56419974286', '3276022304010010286', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243286', 'Malang. 286', 'Islam', 13, 12, '150000.00', 4, 'Sudah', '2022-12-23 01:14:08', NULL, NULL, NULL),
(287, 1, 'P20221287', 'Satrio 287', '56419974287', '3276022304010010287', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243287', 'Malang. 287', 'Islam', 3, 12, '150000.00', 4, 'Belum', '2022-12-23 01:14:08', NULL, NULL, NULL),
(288, 3, 'P20223288', 'Satrio 288', '56419974288', '3276022304010010288', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243288', 'Malang. 288', 'Islam', 5, 4, NULL, NULL, 'Gratis', '2022-12-23 01:14:08', NULL, NULL, NULL),
(289, 2, 'P20222289', 'Satrio 289', '56419974289', '3276022304010010289', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243289', 'Malang. 289', 'Islam', 13, 1, '150000.00', 3, 'Sudah', '2022-12-23 01:14:08', NULL, NULL, NULL),
(290, 3, 'P20223290', 'Satrio 290', '56419974290', '3276022304010010290', 'Depok', '2001-12-06', 'Perempuan', '08810243290', 'Malang. 290', 'Islam', 10, 2, NULL, NULL, 'Gratis', '2022-12-23 01:14:08', NULL, NULL, NULL),
(291, 1, 'P20221291', 'Satrio 291', '56419974291', '3276022304010010291', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243291', 'Malang. 291', 'Islam', 1, 10, '150000.00', 4, 'Sudah', '2022-12-23 01:14:08', NULL, NULL, NULL),
(292, 1, 'P20221292', 'Satrio 292', '56419974292', '3276022304010010292', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243292', 'Malang. 292', 'Islam', 4, 9, '150000.00', 2, 'Sudah', '2022-12-23 01:14:08', NULL, NULL, NULL),
(293, 2, 'P20222293', 'Satrio 293', '56419974293', '3276022304010010293', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243293', 'Malang. 293', 'Islam', 4, 8, '150000.00', 2, 'Sudah', '2022-12-23 01:14:09', NULL, NULL, NULL),
(294, 1, 'P20221294', 'Satrio 294', '56419974294', '3276022304010010294', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243294', 'Malang. 294', 'Islam', 9, 8, '150000.00', 1, 'Belum', '2022-12-23 01:14:09', NULL, NULL, NULL),
(295, 2, 'P20222295', 'Satrio 295', '56419974295', '3276022304010010295', 'Depok', '2001-12-19', 'Perempuan', '08810243295', 'Malang. 295', 'Islam', 10, 10, '150000.00', 4, 'Sudah', '2022-12-23 01:14:09', NULL, NULL, NULL),
(296, 1, 'P20221296', 'Satrio 296', '56419974296', '3276022304010010296', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243296', 'Malang. 296', 'Islam', 3, 11, '150000.00', 4, 'Sudah', '2022-12-23 01:14:09', NULL, NULL, NULL),
(297, 1, 'P20221297', 'Satrio 297', '56419974297', '3276022304010010297', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243297', 'Malang. 297', 'Islam', 12, 12, '150000.00', 1, 'Sudah', '2022-12-23 01:14:09', NULL, NULL, NULL),
(298, 1, 'P20221298', 'Satrio 298', '56419974298', '3276022304010010298', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243298', 'Malang. 298', 'Islam', 12, 6, '150000.00', 2, 'Sudah', '2022-12-23 01:14:09', NULL, NULL, NULL),
(299, 1, 'P20221299', 'Satrio 299', '56419974299', '3276022304010010299', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243299', 'Malang. 299', 'Islam', 3, 8, '150000.00', 2, 'Sudah', '2022-12-23 01:14:09', NULL, NULL, NULL),
(300, 2, 'P20222300', 'Satrio 300', '56419974300', '3276022304010010300', 'Depok', '2001-12-25', 'Perempuan', '08810243300', 'Malang. 300', 'Islam', 4, 13, '150000.00', 3, 'Sudah', '2022-12-23 01:14:09', NULL, NULL, NULL),
(301, 1, 'P20221301', 'Satrio 301', '56419974301', '3276022304010010301', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243301', 'Malang. 301', 'Islam', 3, 7, '150000.00', 2, 'Belum', '2022-12-23 01:14:09', NULL, NULL, NULL),
(302, 3, 'P20223302', 'Satrio 302', '56419974302', '3276022304010010302', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243302', 'Malang. 302', 'Islam', 11, 8, NULL, NULL, 'Gratis', '2022-12-23 01:14:09', NULL, NULL, NULL),
(303, 3, 'P20223303', 'Satrio 303', '56419974303', '3276022304010010303', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243303', 'Malang. 303', 'Islam', 10, 9, NULL, NULL, 'Gratis', '2022-12-23 01:14:09', NULL, NULL, NULL),
(304, 2, 'P20222304', 'Satrio 304', '56419974304', '3276022304010010304', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243304', 'Malang. 304', 'Islam', 9, 12, '150000.00', 1, 'Sudah', '2022-12-23 01:14:09', NULL, NULL, NULL),
(305, 2, 'P20222305', 'Satrio 305', '56419974305', '3276022304010010305', 'Depok', '2001-12-12', 'Perempuan', '08810243305', 'Malang. 305', 'Islam', 5, 13, '150000.00', 4, 'Sudah', '2022-12-23 01:14:09', NULL, NULL, NULL),
(306, 3, 'P20223306', 'Satrio 306', '56419974306', '3276022304010010306', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243306', 'Malang. 306', 'Islam', 6, 7, NULL, NULL, 'Gratis', '2022-12-23 01:14:09', NULL, NULL, NULL),
(307, 3, 'P20223307', 'Satrio 307', '56419974307', '3276022304010010307', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243307', 'Malang. 307', 'Islam', 9, 10, NULL, NULL, 'Gratis', '2022-12-23 01:14:09', NULL, NULL, NULL),
(308, 1, 'P20221308', 'Satrio 308', '56419974308', '3276022304010010308', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243308', 'Malang. 308', 'Islam', 9, 7, '150000.00', 2, 'Belum', '2022-12-23 01:14:09', NULL, NULL, NULL),
(309, 2, 'P20222309', 'Satrio 309', '56419974309', '3276022304010010309', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243309', 'Malang. 309', 'Islam', 13, 2, '150000.00', 2, 'Sudah', '2022-12-23 01:14:09', NULL, NULL, NULL),
(310, 1, 'P20221310', 'Satrio 310', '56419974310', '3276022304010010310', 'Depok', '2001-12-02', 'Perempuan', '08810243310', 'Malang. 310', 'Islam', 1, 7, '150000.00', 3, 'Sudah', '2022-12-23 01:14:09', NULL, NULL, NULL),
(311, 1, 'P20221311', 'Satrio 311', '56419974311', '3276022304010010311', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243311', 'Malang. 311', 'Islam', 1, 4, '150000.00', 4, 'Sudah', '2022-12-23 01:14:10', NULL, NULL, NULL),
(312, 3, 'P20223312', 'Satrio 312', '56419974312', '3276022304010010312', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243312', 'Malang. 312', 'Islam', 7, 3, NULL, NULL, 'Gratis', '2022-12-23 01:14:10', NULL, NULL, NULL),
(313, 3, 'P20223313', 'Satrio 313', '56419974313', '3276022304010010313', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243313', 'Malang. 313', 'Islam', 13, 11, NULL, NULL, 'Gratis', '2022-12-23 01:14:10', NULL, NULL, NULL),
(314, 1, 'P20221314', 'Satrio 314', '56419974314', '3276022304010010314', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243314', 'Malang. 314', 'Islam', 1, 10, '150000.00', 4, 'Sudah', '2022-12-23 01:14:10', NULL, NULL, NULL),
(315, 3, 'P20223315', 'Satrio 315', '56419974315', '3276022304010010315', 'Depok', '2001-12-16', 'Perempuan', '08810243315', 'Malang. 315', 'Islam', 7, 12, NULL, NULL, 'Belum', '2022-12-23 01:14:10', NULL, NULL, NULL),
(316, 2, 'P20222316', 'Satrio 316', '56419974316', '3276022304010010316', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243316', 'Malang. 316', 'Islam', 12, 7, '150000.00', 4, 'Sudah', '2022-12-23 01:14:10', NULL, NULL, NULL),
(317, 3, 'P20223317', 'Satrio 317', '56419974317', '3276022304010010317', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243317', 'Malang. 317', 'Islam', 10, 9, NULL, NULL, 'Gratis', '2022-12-23 01:14:10', NULL, NULL, NULL),
(318, 2, 'P20222318', 'Satrio 318', '56419974318', '3276022304010010318', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243318', 'Malang. 318', 'Islam', 5, 13, '150000.00', 1, 'Sudah', '2022-12-23 01:14:10', NULL, NULL, NULL),
(319, 3, 'P20223319', 'Satrio 319', '56419974319', '3276022304010010319', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243319', 'Malang. 319', 'Islam', 13, 12, NULL, NULL, 'Gratis', '2022-12-23 01:14:11', NULL, NULL, NULL),
(320, 3, 'P20223320', 'Satrio 320', '56419974320', '3276022304010010320', 'Depok', '2001-12-14', 'Perempuan', '08810243320', 'Malang. 320', 'Islam', 2, 2, NULL, NULL, 'Gratis', '2022-12-23 01:14:11', NULL, NULL, NULL),
(321, 3, 'P20223321', 'Satrio 321', '56419974321', '3276022304010010321', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243321', 'Malang. 321', 'Islam', 13, 4, NULL, NULL, 'Gratis', '2022-12-23 01:14:11', NULL, NULL, NULL),
(322, 1, 'P20221322', 'Satrio 322', '56419974322', '3276022304010010322', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243322', 'Malang. 322', 'Islam', 5, 7, '150000.00', 2, 'Belum', '2022-12-23 01:14:11', NULL, NULL, NULL),
(323, 1, 'P20221323', 'Satrio 323', '56419974323', '3276022304010010323', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243323', 'Malang. 323', 'Islam', 4, 12, '150000.00', 4, 'Sudah', '2022-12-23 01:14:11', NULL, NULL, NULL),
(324, 2, 'P20222324', 'Satrio 324', '56419974324', '3276022304010010324', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243324', 'Malang. 324', 'Islam', 12, 2, '150000.00', 3, 'Sudah', '2022-12-23 01:14:11', NULL, NULL, NULL),
(325, 2, 'P20222325', 'Satrio 325', '56419974325', '3276022304010010325', 'Depok', '2001-12-15', 'Perempuan', '08810243325', 'Malang. 325', 'Islam', 6, 4, '150000.00', 2, 'Sudah', '2022-12-23 01:14:11', NULL, NULL, NULL),
(326, 3, 'P20223326', 'Satrio 326', '56419974326', '3276022304010010326', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243326', 'Malang. 326', 'Islam', 4, 1, NULL, NULL, 'Gratis', '2022-12-23 01:14:11', NULL, NULL, NULL),
(327, 3, 'P20223327', 'Satrio 327', '56419974327', '3276022304010010327', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243327', 'Malang. 327', 'Islam', 3, 8, NULL, NULL, 'Gratis', '2022-12-23 01:14:12', NULL, NULL, NULL),
(328, 1, 'P20221328', 'Satrio 328', '56419974328', '3276022304010010328', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243328', 'Malang. 328', 'Islam', 9, 13, '150000.00', 2, 'Sudah', '2022-12-23 01:14:12', NULL, NULL, NULL),
(329, 2, 'P20222329', 'Satrio 329', '56419974329', '3276022304010010329', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243329', 'Malang. 329', 'Islam', 7, 1, '150000.00', 1, 'Belum', '2022-12-23 01:14:13', NULL, NULL, NULL),
(330, 1, 'P20221330', 'Satrio 330', '56419974330', '3276022304010010330', 'Depok', '2001-12-29', 'Perempuan', '08810243330', 'Malang. 330', 'Islam', 4, 12, '150000.00', 3, 'Sudah', '2022-12-23 01:14:13', NULL, NULL, NULL),
(331, 3, 'P20223331', 'Satrio 331', '56419974331', '3276022304010010331', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243331', 'Malang. 331', 'Islam', 1, 1, NULL, NULL, 'Gratis', '2022-12-23 01:14:13', NULL, NULL, NULL),
(332, 1, 'P20221332', 'Satrio 332', '56419974332', '3276022304010010332', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243332', 'Malang. 332', 'Islam', 8, 2, '150000.00', 4, 'Sudah', '2022-12-23 01:14:13', NULL, NULL, NULL),
(333, 1, 'P20221333', 'Satrio 333', '56419974333', '3276022304010010333', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243333', 'Malang. 333', 'Islam', 3, 5, '150000.00', 3, 'Sudah', '2022-12-23 01:14:14', NULL, NULL, NULL),
(334, 3, 'P20223334', 'Satrio 334', '56419974334', '3276022304010010334', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243334', 'Malang. 334', 'Islam', 13, 5, NULL, NULL, 'Gratis', '2022-12-23 01:14:14', NULL, NULL, NULL),
(335, 1, 'P20221335', 'Satrio 335', '56419974335', '3276022304010010335', 'Depok', '2001-12-26', 'Perempuan', '08810243335', 'Malang. 335', 'Islam', 11, 9, '150000.00', 3, 'Sudah', '2022-12-23 01:14:14', NULL, NULL, NULL),
(336, 1, 'P20221336', 'Satrio 336', '56419974336', '3276022304010010336', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243336', 'Malang. 336', 'Islam', 5, 10, '150000.00', 1, 'Belum', '2022-12-23 01:14:14', NULL, NULL, NULL),
(337, 1, 'P20221337', 'Satrio 337', '56419974337', '3276022304010010337', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243337', 'Malang. 337', 'Islam', 9, 2, '150000.00', 2, 'Sudah', '2022-12-23 01:14:14', NULL, NULL, NULL),
(338, 2, 'P20222338', 'Satrio 338', '56419974338', '3276022304010010338', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243338', 'Malang. 338', 'Islam', 12, 10, '150000.00', 3, 'Sudah', '2022-12-23 01:14:14', NULL, NULL, NULL),
(339, 2, 'P20222339', 'Satrio 339', '56419974339', '3276022304010010339', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243339', 'Malang. 339', 'Islam', 8, 4, '150000.00', 2, 'Sudah', '2022-12-23 01:14:14', NULL, NULL, NULL),
(340, 1, 'P20221340', 'Satrio 340', '56419974340', '3276022304010010340', 'Depok', '2001-12-04', 'Perempuan', '08810243340', 'Malang. 340', 'Islam', 5, 2, '150000.00', 1, 'Sudah', '2022-12-23 01:14:14', NULL, NULL, NULL),
(341, 3, 'P20223341', 'Satrio 341', '56419974341', '3276022304010010341', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243341', 'Malang. 341', 'Islam', 9, 1, NULL, NULL, 'Gratis', '2022-12-23 01:14:14', NULL, NULL, NULL),
(342, 2, 'P20222342', 'Satrio 342', '56419974342', '3276022304010010342', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243342', 'Malang. 342', 'Islam', 10, 10, '150000.00', 2, 'Sudah', '2022-12-23 01:14:15', NULL, NULL, NULL),
(343, 3, 'P20223343', 'Satrio 343', '56419974343', '3276022304010010343', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243343', 'Malang. 343', 'Islam', 8, 8, NULL, NULL, 'Belum', '2022-12-23 01:14:15', NULL, NULL, NULL),
(344, 2, 'P20222344', 'Satrio 344', '56419974344', '3276022304010010344', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243344', 'Malang. 344', 'Islam', 10, 6, '150000.00', 2, 'Sudah', '2022-12-23 01:14:15', NULL, NULL, NULL),
(345, 3, 'P20223345', 'Satrio 345', '56419974345', '3276022304010010345', 'Depok', '2001-12-24', 'Perempuan', '08810243345', 'Malang. 345', 'Islam', 1, 12, NULL, NULL, 'Gratis', '2022-12-23 01:14:15', NULL, NULL, NULL),
(346, 1, 'P20221346', 'Satrio 346', '56419974346', '3276022304010010346', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243346', 'Malang. 346', 'Islam', 7, 12, '150000.00', 4, 'Sudah', '2022-12-23 01:14:15', NULL, NULL, NULL),
(347, 2, 'P20222347', 'Satrio 347', '56419974347', '3276022304010010347', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243347', 'Malang. 347', 'Islam', 11, 7, '150000.00', 4, 'Sudah', '2022-12-23 01:14:15', NULL, NULL, NULL),
(348, 1, 'P20221348', 'Satrio 348', '56419974348', '3276022304010010348', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243348', 'Malang. 348', 'Islam', 7, 9, '150000.00', 1, 'Sudah', '2022-12-23 01:14:15', NULL, NULL, NULL),
(349, 2, 'P20222349', 'Satrio 349', '56419974349', '3276022304010010349', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243349', 'Malang. 349', 'Islam', 8, 3, '150000.00', 2, 'Sudah', '2022-12-23 01:14:15', NULL, NULL, NULL),
(350, 1, 'P20221350', 'Satrio 350', '56419974350', '3276022304010010350', 'Depok', '2001-12-23', 'Perempuan', '08810243350', 'Malang. 350', 'Islam', 9, 4, '150000.00', 2, 'Belum', '2022-12-23 01:14:15', NULL, NULL, NULL),
(351, 2, 'P20222351', 'Satrio 351', '56419974351', '3276022304010010351', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243351', 'Malang. 351', 'Islam', 12, 9, '150000.00', 1, 'Sudah', '2022-12-23 01:14:15', NULL, NULL, NULL),
(352, 1, 'P20221352', 'Satrio 352', '56419974352', '3276022304010010352', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243352', 'Malang. 352', 'Islam', 8, 5, '150000.00', 2, 'Sudah', '2022-12-23 01:14:15', NULL, NULL, NULL),
(353, 2, 'P20222353', 'Satrio 353', '56419974353', '3276022304010010353', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243353', 'Malang. 353', 'Islam', 3, 2, '150000.00', 2, 'Sudah', '2022-12-23 01:14:15', NULL, NULL, NULL),
(354, 2, 'P20222354', 'Satrio 354', '56419974354', '3276022304010010354', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243354', 'Malang. 354', 'Islam', 3, 1, '150000.00', 4, 'Sudah', '2022-12-23 01:14:15', NULL, NULL, NULL),
(355, 1, 'P20221355', 'Satrio 355', '56419974355', '3276022304010010355', 'Depok', '2001-12-30', 'Perempuan', '08810243355', 'Malang. 355', 'Islam', 3, 6, '150000.00', 4, 'Sudah', '2022-12-23 01:14:15', NULL, NULL, NULL),
(356, 1, 'P20221356', 'Satrio 356', '56419974356', '3276022304010010356', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243356', 'Malang. 356', 'Islam', 4, 4, '150000.00', 3, 'Sudah', '2022-12-23 01:14:15', NULL, NULL, NULL),
(357, 3, 'P20223357', 'Satrio 357', '56419974357', '3276022304010010357', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243357', 'Malang. 357', 'Islam', 3, 4, NULL, NULL, 'Belum', '2022-12-23 01:14:15', NULL, NULL, NULL),
(358, 2, 'P20222358', 'Satrio 358', '56419974358', '3276022304010010358', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243358', 'Malang. 358', 'Islam', 4, 3, '150000.00', 2, 'Sudah', '2022-12-23 01:14:15', NULL, NULL, NULL),
(359, 3, 'P20223359', 'Satrio 359', '56419974359', '3276022304010010359', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243359', 'Malang. 359', 'Islam', 4, 5, NULL, NULL, 'Gratis', '2022-12-23 01:14:15', NULL, NULL, NULL),
(360, 3, 'P20223360', 'Satrio 360', '56419974360', '3276022304010010360', 'Depok', '2001-12-26', 'Perempuan', '08810243360', 'Malang. 360', 'Islam', 3, 12, NULL, NULL, 'Gratis', '2022-12-23 01:14:16', NULL, NULL, NULL),
(361, 3, 'P20223361', 'Satrio 361', '56419974361', '3276022304010010361', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243361', 'Malang. 361', 'Islam', 4, 13, NULL, NULL, 'Gratis', '2022-12-23 01:14:16', NULL, NULL, NULL),
(362, 3, 'P20223362', 'Satrio 362', '56419974362', '3276022304010010362', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243362', 'Malang. 362', 'Islam', 4, 11, NULL, NULL, 'Gratis', '2022-12-23 01:14:16', NULL, NULL, NULL),
(363, 2, 'P20222363', 'Satrio 363', '56419974363', '3276022304010010363', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243363', 'Malang. 363', 'Islam', 10, 9, '150000.00', 1, 'Sudah', '2022-12-23 01:14:16', NULL, NULL, NULL),
(364, 2, 'P20222364', 'Satrio 364', '56419974364', '3276022304010010364', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243364', 'Malang. 364', 'Islam', 12, 2, '150000.00', 2, 'Belum', '2022-12-23 01:14:16', NULL, NULL, NULL),
(365, 1, 'P20221365', 'Satrio 365', '56419974365', '3276022304010010365', 'Depok', '2001-12-11', 'Perempuan', '08810243365', 'Malang. 365', 'Islam', 8, 1, '150000.00', 1, 'Sudah', '2022-12-23 01:14:16', NULL, NULL, NULL),
(366, 2, 'P20222366', 'Satrio 366', '56419974366', '3276022304010010366', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243366', 'Malang. 366', 'Islam', 10, 12, '150000.00', 2, 'Sudah', '2022-12-23 01:14:16', NULL, NULL, NULL),
(367, 1, 'P20221367', 'Satrio 367', '56419974367', '3276022304010010367', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243367', 'Malang. 367', 'Islam', 2, 8, '150000.00', 1, 'Sudah', '2022-12-23 01:14:16', NULL, NULL, NULL),
(368, 2, 'P20222368', 'Satrio 368', '56419974368', '3276022304010010368', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243368', 'Malang. 368', 'Islam', 13, 9, '150000.00', 2, 'Sudah', '2022-12-23 01:14:16', NULL, NULL, NULL),
(369, 3, 'P20223369', 'Satrio 369', '56419974369', '3276022304010010369', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243369', 'Malang. 369', 'Islam', 9, 13, NULL, NULL, 'Gratis', '2022-12-23 01:14:16', NULL, NULL, NULL),
(370, 3, 'P20223370', 'Satrio 370', '56419974370', '3276022304010010370', 'Depok', '2001-12-10', 'Perempuan', '08810243370', 'Malang. 370', 'Islam', 4, 3, NULL, NULL, 'Gratis', '2022-12-23 01:14:16', NULL, NULL, NULL),
(371, 3, 'P20223371', 'Satrio 371', '56419974371', '3276022304010010371', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243371', 'Malang. 371', 'Islam', 1, 10, NULL, NULL, 'Belum', '2022-12-23 01:14:16', NULL, NULL, NULL),
(372, 2, 'P20222372', 'Satrio 372', '56419974372', '3276022304010010372', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243372', 'Malang. 372', 'Islam', 6, 1, '150000.00', 3, 'Sudah', '2022-12-23 01:14:17', NULL, NULL, NULL),
(373, 1, 'P20221373', 'Satrio 373', '56419974373', '3276022304010010373', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243373', 'Malang. 373', 'Islam', 9, 4, '150000.00', 1, 'Sudah', '2022-12-23 01:14:17', NULL, NULL, NULL),
(374, 3, 'P20223374', 'Satrio 374', '56419974374', '3276022304010010374', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243374', 'Malang. 374', 'Islam', 3, 5, NULL, NULL, 'Gratis', '2022-12-23 01:14:17', NULL, NULL, NULL),
(375, 1, 'P20221375', 'Satrio 375', '56419974375', '3276022304010010375', 'Depok', '2001-12-13', 'Perempuan', '08810243375', 'Malang. 375', 'Islam', 5, 7, '150000.00', 3, 'Sudah', '2022-12-23 01:14:17', NULL, NULL, NULL),
(376, 2, 'P20222376', 'Satrio 376', '56419974376', '3276022304010010376', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243376', 'Malang. 376', 'Islam', 7, 7, '150000.00', 1, 'Sudah', '2022-12-23 01:14:17', NULL, NULL, NULL),
(377, 2, 'P20222377', 'Satrio 377', '56419974377', '3276022304010010377', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243377', 'Malang. 377', 'Islam', 7, 7, '150000.00', 4, 'Sudah', '2022-12-23 01:14:17', NULL, NULL, NULL),
(378, 3, 'P20223378', 'Satrio 378', '56419974378', '3276022304010010378', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243378', 'Malang. 378', 'Islam', 10, 9, NULL, NULL, 'Belum', '2022-12-23 01:14:17', NULL, NULL, NULL),
(379, 1, 'P20221379', 'Satrio 379', '56419974379', '3276022304010010379', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243379', 'Malang. 379', 'Islam', 7, 7, '150000.00', 2, 'Sudah', '2022-12-23 01:14:17', NULL, NULL, NULL),
(380, 1, 'P20221380', 'Satrio 380', '56419974380', '3276022304010010380', 'Depok', '2001-12-26', 'Perempuan', '08810243380', 'Malang. 380', 'Islam', 5, 7, '150000.00', 4, 'Sudah', '2022-12-23 01:14:17', NULL, NULL, NULL),
(381, 2, 'P20222381', 'Satrio 381', '56419974381', '3276022304010010381', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243381', 'Malang. 381', 'Islam', 13, 1, '150000.00', 3, 'Sudah', '2022-12-23 01:14:17', NULL, NULL, NULL),
(382, 2, 'P20222382', 'Satrio 382', '56419974382', '3276022304010010382', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243382', 'Malang. 382', 'Islam', 10, 12, '150000.00', 1, 'Sudah', '2022-12-23 01:14:17', NULL, NULL, NULL),
(383, 2, 'P20222383', 'Satrio 383', '56419974383', '3276022304010010383', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243383', 'Malang. 383', 'Islam', 1, 3, '150000.00', 2, 'Sudah', '2022-12-23 01:14:17', NULL, NULL, NULL),
(384, 2, 'P20222384', 'Satrio 384', '56419974384', '3276022304010010384', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243384', 'Malang. 384', 'Islam', 8, 11, '150000.00', 4, 'Sudah', '2022-12-23 01:14:17', NULL, NULL, NULL),
(385, 3, 'P20223385', 'Satrio 385', '56419974385', '3276022304010010385', 'Depok', '2001-12-29', 'Perempuan', '08810243385', 'Malang. 385', 'Islam', 11, 12, NULL, NULL, 'Belum', '2022-12-23 01:14:17', NULL, NULL, NULL),
(386, 1, 'P20221386', 'Satrio 386', '56419974386', '3276022304010010386', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243386', 'Malang. 386', 'Islam', 12, 11, '150000.00', 1, 'Sudah', '2022-12-23 01:14:17', NULL, NULL, NULL),
(387, 2, 'P20222387', 'Satrio 387', '56419974387', '3276022304010010387', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243387', 'Malang. 387', 'Islam', 1, 9, '150000.00', 4, 'Sudah', '2022-12-23 01:14:17', NULL, NULL, NULL),
(388, 1, 'P20221388', 'Satrio 388', '56419974388', '3276022304010010388', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243388', 'Malang. 388', 'Islam', 2, 7, '150000.00', 3, 'Sudah', '2022-12-23 01:14:17', NULL, NULL, NULL),
(389, 2, 'P20222389', 'Satrio 389', '56419974389', '3276022304010010389', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243389', 'Malang. 389', 'Islam', 2, 6, '150000.00', 1, 'Sudah', '2022-12-23 01:14:18', NULL, NULL, NULL),
(390, 3, 'P20223390', 'Satrio 390', '56419974390', '3276022304010010390', 'Depok', '2001-12-05', 'Perempuan', '08810243390', 'Malang. 390', 'Islam', 5, 5, NULL, NULL, 'Gratis', '2022-12-23 01:14:18', NULL, NULL, NULL),
(391, 3, 'P20223391', 'Satrio 391', '56419974391', '3276022304010010391', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243391', 'Malang. 391', 'Islam', 7, 7, NULL, NULL, 'Gratis', '2022-12-23 01:14:18', NULL, NULL, NULL),
(392, 1, 'P20221392', 'Satrio 392', '56419974392', '3276022304010010392', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243392', 'Malang. 392', 'Islam', 5, 2, '150000.00', 2, 'Belum', '2022-12-23 01:14:18', NULL, NULL, NULL),
(393, 1, 'P20221393', 'Satrio 393', '56419974393', '3276022304010010393', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243393', 'Malang. 393', 'Islam', 7, 4, '150000.00', 1, 'Sudah', '2022-12-23 01:14:18', NULL, NULL, NULL),
(394, 3, 'P20223394', 'Satrio 394', '56419974394', '3276022304010010394', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243394', 'Malang. 394', 'Islam', 4, 11, NULL, NULL, 'Gratis', '2022-12-23 01:14:18', NULL, NULL, NULL),
(395, 3, 'P20223395', 'Satrio 395', '56419974395', '3276022304010010395', 'Depok', '2001-12-12', 'Perempuan', '08810243395', 'Malang. 395', 'Islam', 1, 11, NULL, NULL, 'Gratis', '2022-12-23 01:14:18', NULL, NULL, NULL),
(396, 3, 'P20223396', 'Satrio 396', '56419974396', '3276022304010010396', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243396', 'Malang. 396', 'Islam', 5, 8, NULL, NULL, 'Gratis', '2022-12-23 01:14:18', NULL, NULL, NULL),
(397, 1, 'P20221397', 'Satrio 397', '56419974397', '3276022304010010397', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243397', 'Malang. 397', 'Islam', 4, 1, '150000.00', 1, 'Sudah', '2022-12-23 01:14:18', NULL, NULL, NULL),
(398, 2, 'P20222398', 'Satrio 398', '56419974398', '3276022304010010398', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243398', 'Malang. 398', 'Islam', 4, 10, '150000.00', 1, 'Sudah', '2022-12-23 01:14:19', NULL, NULL, NULL),
(399, 1, 'P20221399', 'Satrio 399', '56419974399', '3276022304010010399', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243399', 'Malang. 399', 'Islam', 11, 6, '150000.00', 1, 'Belum', '2022-12-23 01:14:19', NULL, NULL, NULL),
(400, 2, 'P20222400', 'Satrio 400', '56419974400', '3276022304010010400', 'Depok', '2001-12-04', 'Perempuan', '08810243400', 'Malang. 400', 'Islam', 5, 6, '150000.00', 4, 'Sudah', '2022-12-23 01:14:19', NULL, NULL, NULL),
(401, 3, 'P20223401', 'Satrio 401', '56419974401', '3276022304010010401', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243401', 'Malang. 401', 'Islam', 8, 12, NULL, NULL, 'Gratis', '2022-12-23 01:14:19', NULL, NULL, NULL),
(402, 3, 'P20223402', 'Satrio 402', '56419974402', '3276022304010010402', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243402', 'Malang. 402', 'Islam', 8, 9, NULL, NULL, 'Gratis', '2022-12-23 01:14:19', NULL, NULL, NULL),
(403, 1, 'P20221403', 'Satrio 403', '56419974403', '3276022304010010403', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243403', 'Malang. 403', 'Islam', 4, 4, '150000.00', 2, 'Sudah', '2022-12-23 01:14:19', NULL, NULL, NULL),
(404, 3, 'P20223404', 'Satrio 404', '56419974404', '3276022304010010404', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243404', 'Malang. 404', 'Islam', 11, 10, NULL, NULL, 'Gratis', '2022-12-23 01:14:19', NULL, NULL, NULL),
(405, 2, 'P20222405', 'Satrio 405', '56419974405', '3276022304010010405', 'Depok', '2001-12-13', 'Perempuan', '08810243405', 'Malang. 405', 'Islam', 10, 1, '150000.00', 3, 'Sudah', '2022-12-23 01:14:19', NULL, NULL, NULL),
(406, 1, 'P20221406', 'Satrio 406', '56419974406', '3276022304010010406', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243406', 'Malang. 406', 'Islam', 9, 13, '150000.00', 3, 'Belum', '2022-12-23 01:14:19', NULL, NULL, NULL),
(407, 1, 'P20221407', 'Satrio 407', '56419974407', '3276022304010010407', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243407', 'Malang. 407', 'Islam', 1, 8, '150000.00', 4, 'Sudah', '2022-12-23 01:14:19', NULL, NULL, NULL),
(408, 1, 'P20221408', 'Satrio 408', '56419974408', '3276022304010010408', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243408', 'Malang. 408', 'Islam', 6, 6, '150000.00', 1, 'Sudah', '2022-12-23 01:14:19', NULL, NULL, NULL),
(409, 3, 'P20223409', 'Satrio 409', '56419974409', '3276022304010010409', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243409', 'Malang. 409', 'Islam', 4, 8, NULL, NULL, 'Gratis', '2022-12-23 01:14:19', NULL, NULL, NULL),
(410, 1, 'P20221410', 'Satrio 410', '56419974410', '3276022304010010410', 'Depok', '2001-12-20', 'Perempuan', '08810243410', 'Malang. 410', 'Islam', 9, 11, '150000.00', 1, 'Sudah', '2022-12-23 01:14:19', NULL, NULL, NULL),
(411, 2, 'P20222411', 'Satrio 411', '56419974411', '3276022304010010411', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243411', 'Malang. 411', 'Islam', 13, 7, '150000.00', 4, 'Sudah', '2022-12-23 01:14:19', NULL, NULL, NULL),
(412, 3, 'P20223412', 'Satrio 412', '56419974412', '3276022304010010412', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243412', 'Malang. 412', 'Islam', 13, 5, NULL, NULL, 'Gratis', '2022-12-23 01:14:20', NULL, NULL, NULL),
(413, 1, 'P20221413', 'Satrio 413', '56419974413', '3276022304010010413', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243413', 'Malang. 413', 'Islam', 8, 4, '150000.00', 1, 'Belum', '2022-12-23 01:14:20', NULL, NULL, NULL),
(414, 2, 'P20222414', 'Satrio 414', '56419974414', '3276022304010010414', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243414', 'Malang. 414', 'Islam', 2, 2, '150000.00', 3, 'Sudah', '2022-12-23 01:14:20', NULL, NULL, NULL),
(415, 3, 'P20223415', 'Satrio 415', '56419974415', '3276022304010010415', 'Depok', '2001-12-23', 'Perempuan', '08810243415', 'Malang. 415', 'Islam', 3, 9, NULL, NULL, 'Gratis', '2022-12-23 01:14:20', NULL, NULL, NULL),
(416, 1, 'P20221416', 'Satrio 416', '56419974416', '3276022304010010416', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243416', 'Malang. 416', 'Islam', 6, 3, '150000.00', 4, 'Sudah', '2022-12-23 01:14:20', NULL, NULL, NULL),
(417, 2, 'P20222417', 'Satrio 417', '56419974417', '3276022304010010417', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243417', 'Malang. 417', 'Islam', 9, 1, '150000.00', 1, 'Sudah', '2022-12-23 01:14:20', NULL, NULL, NULL),
(418, 1, 'P20221418', 'Satrio 418', '56419974418', '3276022304010010418', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243418', 'Malang. 418', 'Islam', 11, 3, '150000.00', 2, 'Sudah', '2022-12-23 01:14:20', NULL, NULL, NULL),
(419, 1, 'P20221419', 'Satrio 419', '56419974419', '3276022304010010419', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243419', 'Malang. 419', 'Islam', 7, 7, '150000.00', 3, 'Sudah', '2022-12-23 01:14:20', NULL, NULL, NULL),
(420, 3, 'P20223420', 'Satrio 420', '56419974420', '3276022304010010420', 'Depok', '2001-12-04', 'Perempuan', '08810243420', 'Malang. 420', 'Islam', 8, 11, NULL, NULL, 'Belum', '2022-12-23 01:14:20', NULL, NULL, NULL),
(421, 2, 'P20222421', 'Satrio 421', '56419974421', '3276022304010010421', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243421', 'Malang. 421', 'Islam', 5, 2, '150000.00', 4, 'Sudah', '2022-12-23 01:14:20', NULL, NULL, NULL),
(422, 2, 'P20222422', 'Satrio 422', '56419974422', '3276022304010010422', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243422', 'Malang. 422', 'Islam', 4, 13, '150000.00', 3, 'Sudah', '2022-12-23 01:14:20', NULL, NULL, NULL),
(423, 3, 'P20223423', 'Satrio 423', '56419974423', '3276022304010010423', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243423', 'Malang. 423', 'Islam', 11, 1, NULL, NULL, 'Gratis', '2022-12-23 01:14:21', NULL, NULL, NULL),
(424, 1, 'P20221424', 'Satrio 424', '56419974424', '3276022304010010424', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243424', 'Malang. 424', 'Islam', 1, 9, '150000.00', 3, 'Sudah', '2022-12-23 01:14:21', NULL, NULL, NULL),
(425, 2, 'P20222425', 'Satrio 425', '56419974425', '3276022304010010425', 'Depok', '2001-12-15', 'Perempuan', '08810243425', 'Malang. 425', 'Islam', 10, 7, '150000.00', 4, 'Sudah', '2022-12-23 01:14:21', NULL, NULL, NULL),
(426, 2, 'P20222426', 'Satrio 426', '56419974426', '3276022304010010426', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243426', 'Malang. 426', 'Islam', 6, 11, '150000.00', 3, 'Sudah', '2022-12-23 01:14:21', NULL, NULL, NULL),
(427, 1, 'P20221427', 'Satrio 427', '56419974427', '3276022304010010427', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243427', 'Malang. 427', 'Islam', 13, 13, '150000.00', 1, 'Belum', '2022-12-23 01:14:21', NULL, NULL, NULL),
(428, 2, 'P20222428', 'Satrio 428', '56419974428', '3276022304010010428', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243428', 'Malang. 428', 'Islam', 6, 11, '150000.00', 1, 'Sudah', '2022-12-23 01:14:21', NULL, NULL, NULL),
(429, 3, 'P20223429', 'Satrio 429', '56419974429', '3276022304010010429', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243429', 'Malang. 429', 'Islam', 1, 13, NULL, NULL, 'Gratis', '2022-12-23 01:14:21', NULL, NULL, NULL),
(430, 2, 'P20222430', 'Satrio 430', '56419974430', '3276022304010010430', 'Depok', '2001-12-18', 'Perempuan', '08810243430', 'Malang. 430', 'Islam', 3, 12, '150000.00', 4, 'Sudah', '2022-12-23 01:14:21', NULL, NULL, NULL),
(431, 3, 'P20223431', 'Satrio 431', '56419974431', '3276022304010010431', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243431', 'Malang. 431', 'Islam', 1, 1, NULL, NULL, 'Gratis', '2022-12-23 01:14:21', NULL, NULL, NULL),
(432, 1, 'P20221432', 'Satrio 432', '56419974432', '3276022304010010432', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243432', 'Malang. 432', 'Islam', 6, 1, '150000.00', 4, 'Sudah', '2022-12-23 01:14:21', NULL, NULL, NULL),
(433, 1, 'P20221433', 'Satrio 433', '56419974433', '3276022304010010433', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243433', 'Malang. 433', 'Islam', 11, 10, '150000.00', 2, 'Sudah', '2022-12-23 01:14:21', NULL, NULL, NULL),
(434, 2, 'P20222434', 'Satrio 434', '56419974434', '3276022304010010434', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243434', 'Malang. 434', 'Islam', 11, 3, '150000.00', 3, 'Belum', '2022-12-23 01:14:21', NULL, NULL, NULL),
(435, 2, 'P20222435', 'Satrio 435', '56419974435', '3276022304010010435', 'Depok', '2001-12-03', 'Perempuan', '08810243435', 'Malang. 435', 'Islam', 4, 8, '150000.00', 1, 'Sudah', '2022-12-23 01:14:21', NULL, NULL, NULL),
(436, 1, 'P20221436', 'Satrio 436', '56419974436', '3276022304010010436', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243436', 'Malang. 436', 'Islam', 6, 8, '150000.00', 1, 'Sudah', '2022-12-23 01:14:21', NULL, NULL, NULL),
(437, 1, 'P20221437', 'Satrio 437', '56419974437', '3276022304010010437', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243437', 'Malang. 437', 'Islam', 12, 5, '150000.00', 1, 'Sudah', '2022-12-23 01:14:21', NULL, NULL, NULL),
(438, 1, 'P20221438', 'Satrio 438', '56419974438', '3276022304010010438', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243438', 'Malang. 438', 'Islam', 3, 7, '150000.00', 4, 'Sudah', '2022-12-23 01:14:21', NULL, NULL, NULL),
(439, 2, 'P20222439', 'Satrio 439', '56419974439', '3276022304010010439', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243439', 'Malang. 439', 'Islam', 3, 4, '150000.00', 2, 'Sudah', '2022-12-23 01:14:21', NULL, NULL, NULL),
(440, 2, 'P20222440', 'Satrio 440', '56419974440', '3276022304010010440', 'Depok', '2001-12-16', 'Perempuan', '08810243440', 'Malang. 440', 'Islam', 2, 5, '150000.00', 2, 'Sudah', '2022-12-23 01:14:22', NULL, NULL, NULL),
(441, 1, 'P20221441', 'Satrio 441', '56419974441', '3276022304010010441', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243441', 'Malang. 441', 'Islam', 4, 8, '150000.00', 1, 'Belum', '2022-12-23 01:14:22', NULL, NULL, NULL),
(442, 1, 'P20221442', 'Satrio 442', '56419974442', '3276022304010010442', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243442', 'Malang. 442', 'Islam', 7, 7, '150000.00', 2, 'Sudah', '2022-12-23 01:14:22', NULL, NULL, NULL),
(443, 1, 'P20221443', 'Satrio 443', '56419974443', '3276022304010010443', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243443', 'Malang. 443', 'Islam', 4, 4, '150000.00', 1, 'Sudah', '2022-12-23 01:14:22', NULL, NULL, NULL),
(444, 3, 'P20223444', 'Satrio 444', '56419974444', '3276022304010010444', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243444', 'Malang. 444', 'Islam', 10, 1, NULL, NULL, 'Gratis', '2022-12-23 01:14:22', NULL, NULL, NULL),
(445, 3, 'P20223445', 'Satrio 445', '56419974445', '3276022304010010445', 'Depok', '2001-12-18', 'Perempuan', '08810243445', 'Malang. 445', 'Islam', 12, 12, NULL, NULL, 'Gratis', '2022-12-23 01:14:22', NULL, NULL, NULL),
(446, 3, 'P20223446', 'Satrio 446', '56419974446', '3276022304010010446', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243446', 'Malang. 446', 'Islam', 9, 6, NULL, NULL, 'Gratis', '2022-12-23 01:14:22', NULL, NULL, NULL),
(447, 2, 'P20222447', 'Satrio 447', '56419974447', '3276022304010010447', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243447', 'Malang. 447', 'Islam', 13, 12, '150000.00', 1, 'Sudah', '2022-12-23 01:14:22', NULL, NULL, NULL),
(448, 2, 'P20222448', 'Satrio 448', '56419974448', '3276022304010010448', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243448', 'Malang. 448', 'Islam', 7, 6, '150000.00', 2, 'Belum', '2022-12-23 01:14:22', NULL, NULL, NULL),
(449, 3, 'P20223449', 'Satrio 449', '56419974449', '3276022304010010449', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243449', 'Malang. 449', 'Islam', 2, 2, NULL, NULL, 'Gratis', '2022-12-23 01:14:22', NULL, NULL, NULL),
(450, 2, 'P20222450', 'Satrio 450', '56419974450', '3276022304010010450', 'Depok', '2001-12-02', 'Perempuan', '08810243450', 'Malang. 450', 'Islam', 2, 3, '150000.00', 2, 'Sudah', '2022-12-23 01:14:22', NULL, NULL, NULL),
(451, 2, 'P20222451', 'Satrio 451', '56419974451', '3276022304010010451', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243451', 'Malang. 451', 'Islam', 6, 7, '150000.00', 4, 'Sudah', '2022-12-23 01:14:22', NULL, NULL, NULL),
(452, 1, 'P20221452', 'Satrio 452', '56419974452', '3276022304010010452', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243452', 'Malang. 452', 'Islam', 13, 8, '150000.00', 3, 'Sudah', '2022-12-23 01:14:22', NULL, NULL, NULL);
INSERT INTO `pendaftar` (`id_pendaftar`, `id_jalur`, `no_pendaftar`, `nama`, `nisn`, `nik`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `no_hp`, `alamat`, `agama`, `id_prodi1`, `id_prodi2`, `nominal_bayar`, `id_bank`, `status_bayar`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(453, 1, 'P20221453', 'Satrio 453', '56419974453', '3276022304010010453', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243453', 'Malang. 453', 'Islam', 7, 1, '150000.00', 2, 'Sudah', '2022-12-23 01:14:22', NULL, NULL, NULL),
(454, 2, 'P20222454', 'Satrio 454', '56419974454', '3276022304010010454', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243454', 'Malang. 454', 'Islam', 4, 10, '150000.00', 3, 'Sudah', '2022-12-23 01:14:22', NULL, NULL, NULL),
(455, 2, 'P20222455', 'Satrio 455', '56419974455', '3276022304010010455', 'Depok', '2001-12-25', 'Perempuan', '08810243455', 'Malang. 455', 'Islam', 4, 1, '150000.00', 3, 'Belum', '2022-12-23 01:14:22', NULL, NULL, NULL),
(456, 3, 'P20223456', 'Satrio 456', '56419974456', '3276022304010010456', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243456', 'Malang. 456', 'Islam', 5, 11, NULL, NULL, 'Gratis', '2022-12-23 01:14:22', NULL, NULL, NULL),
(457, 1, 'P20221457', 'Satrio 457', '56419974457', '3276022304010010457', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243457', 'Malang. 457', 'Islam', 10, 3, '150000.00', 3, 'Sudah', '2022-12-23 01:14:23', NULL, NULL, NULL),
(458, 3, 'P20223458', 'Satrio 458', '56419974458', '3276022304010010458', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243458', 'Malang. 458', 'Islam', 4, 12, NULL, NULL, 'Gratis', '2022-12-23 01:14:23', NULL, NULL, NULL),
(459, 2, 'P20222459', 'Satrio 459', '56419974459', '3276022304010010459', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243459', 'Malang. 459', 'Islam', 3, 4, '150000.00', 3, 'Sudah', '2022-12-23 01:14:23', NULL, NULL, NULL),
(460, 2, 'P20222460', 'Satrio 460', '56419974460', '3276022304010010460', 'Depok', '2001-12-26', 'Perempuan', '08810243460', 'Malang. 460', 'Islam', 4, 3, '150000.00', 1, 'Sudah', '2022-12-23 01:14:23', NULL, NULL, NULL),
(461, 1, 'P20221461', 'Satrio 461', '56419974461', '3276022304010010461', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243461', 'Malang. 461', 'Islam', 6, 13, '150000.00', 1, 'Sudah', '2022-12-23 01:14:23', NULL, NULL, NULL),
(462, 2, 'P20222462', 'Satrio 462', '56419974462', '3276022304010010462', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243462', 'Malang. 462', 'Islam', 6, 5, '150000.00', 2, 'Belum', '2022-12-23 01:14:23', NULL, NULL, NULL),
(463, 1, 'P20221463', 'Satrio 463', '56419974463', '3276022304010010463', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243463', 'Malang. 463', 'Islam', 2, 2, '150000.00', 1, 'Sudah', '2022-12-23 01:14:23', NULL, NULL, NULL),
(464, 2, 'P20222464', 'Satrio 464', '56419974464', '3276022304010010464', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243464', 'Malang. 464', 'Islam', 6, 9, '150000.00', 2, 'Sudah', '2022-12-23 01:14:23', NULL, NULL, NULL),
(465, 2, 'P20222465', 'Satrio 465', '56419974465', '3276022304010010465', 'Depok', '2001-12-30', 'Perempuan', '08810243465', 'Malang. 465', 'Islam', 6, 7, '150000.00', 4, 'Sudah', '2022-12-23 01:14:23', NULL, NULL, NULL),
(466, 3, 'P20223466', 'Satrio 466', '56419974466', '3276022304010010466', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243466', 'Malang. 466', 'Islam', 5, 1, NULL, NULL, 'Gratis', '2022-12-23 01:14:23', NULL, NULL, NULL),
(467, 2, 'P20222467', 'Satrio 467', '56419974467', '3276022304010010467', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243467', 'Malang. 467', 'Islam', 5, 6, '150000.00', 3, 'Sudah', '2022-12-23 01:14:23', NULL, NULL, NULL),
(468, 1, 'P20221468', 'Satrio 468', '56419974468', '3276022304010010468', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243468', 'Malang. 468', 'Islam', 10, 6, '150000.00', 3, 'Sudah', '2022-12-23 01:14:23', NULL, NULL, NULL),
(469, 1, 'P20221469', 'Satrio 469', '56419974469', '3276022304010010469', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243469', 'Malang. 469', 'Islam', 1, 13, '150000.00', 1, 'Belum', '2022-12-23 01:14:23', NULL, NULL, NULL),
(470, 3, 'P20223470', 'Satrio 470', '56419974470', '3276022304010010470', 'Depok', '2001-12-13', 'Perempuan', '08810243470', 'Malang. 470', 'Islam', 8, 6, NULL, NULL, 'Gratis', '2022-12-23 01:14:23', NULL, NULL, NULL),
(471, 3, 'P20223471', 'Satrio 471', '56419974471', '3276022304010010471', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243471', 'Malang. 471', 'Islam', 3, 8, NULL, NULL, 'Gratis', '2022-12-23 01:14:23', NULL, NULL, NULL),
(472, 3, 'P20223472', 'Satrio 472', '56419974472', '3276022304010010472', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243472', 'Malang. 472', 'Islam', 9, 1, NULL, NULL, 'Gratis', '2022-12-23 01:14:23', NULL, NULL, NULL),
(473, 3, 'P20223473', 'Satrio 473', '56419974473', '3276022304010010473', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243473', 'Malang. 473', 'Islam', 4, 8, NULL, NULL, 'Gratis', '2022-12-23 01:14:23', NULL, NULL, NULL),
(474, 2, 'P20222474', 'Satrio 474', '56419974474', '3276022304010010474', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243474', 'Malang. 474', 'Islam', 10, 9, '150000.00', 4, 'Sudah', '2022-12-23 01:14:24', NULL, NULL, NULL),
(475, 3, 'P20223475', 'Satrio 475', '56419974475', '3276022304010010475', 'Depok', '2001-12-19', 'Perempuan', '08810243475', 'Malang. 475', 'Islam', 9, 4, NULL, NULL, 'Gratis', '2022-12-23 01:14:24', NULL, NULL, NULL),
(476, 1, 'P20221476', 'Satrio 476', '56419974476', '3276022304010010476', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243476', 'Malang. 476', 'Islam', 1, 4, '150000.00', 3, 'Belum', '2022-12-23 01:14:24', NULL, NULL, NULL),
(477, 3, 'P20223477', 'Satrio 477', '56419974477', '3276022304010010477', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243477', 'Malang. 477', 'Islam', 12, 12, NULL, NULL, 'Gratis', '2022-12-23 01:14:24', NULL, NULL, NULL),
(478, 1, 'P20221478', 'Satrio 478', '56419974478', '3276022304010010478', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243478', 'Malang. 478', 'Islam', 5, 9, '150000.00', 2, 'Sudah', '2022-12-23 01:14:24', NULL, NULL, NULL),
(479, 3, 'P20223479', 'Satrio 479', '56419974479', '3276022304010010479', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243479', 'Malang. 479', 'Islam', 5, 3, NULL, NULL, 'Gratis', '2022-12-23 01:14:24', NULL, NULL, NULL),
(480, 1, 'P20221480', 'Satrio 480', '56419974480', '3276022304010010480', 'Depok', '2001-12-11', 'Perempuan', '08810243480', 'Malang. 480', 'Islam', 2, 8, '150000.00', 4, 'Sudah', '2022-12-23 01:14:24', NULL, NULL, NULL),
(481, 1, 'P20221481', 'Satrio 481', '56419974481', '3276022304010010481', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243481', 'Malang. 481', 'Islam', 10, 12, '150000.00', 1, 'Sudah', '2022-12-23 01:14:24', NULL, NULL, NULL),
(482, 3, 'P20223482', 'Satrio 482', '56419974482', '3276022304010010482', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243482', 'Malang. 482', 'Islam', 13, 11, NULL, NULL, 'Gratis', '2022-12-23 01:14:24', NULL, NULL, NULL),
(483, 1, 'P20221483', 'Satrio 483', '56419974483', '3276022304010010483', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243483', 'Malang. 483', 'Islam', 11, 6, '150000.00', 4, 'Belum', '2022-12-23 01:14:24', NULL, NULL, NULL),
(484, 1, 'P20221484', 'Satrio 484', '56419974484', '3276022304010010484', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243484', 'Malang. 484', 'Islam', 4, 4, '150000.00', 2, 'Sudah', '2022-12-23 01:14:24', NULL, NULL, NULL),
(485, 2, 'P20222485', 'Satrio 485', '56419974485', '3276022304010010485', 'Depok', '2001-12-02', 'Perempuan', '08810243485', 'Malang. 485', 'Islam', 5, 9, '150000.00', 3, 'Sudah', '2022-12-23 01:14:24', NULL, NULL, NULL),
(486, 1, 'P20221486', 'Satrio 486', '56419974486', '3276022304010010486', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243486', 'Malang. 486', 'Islam', 2, 4, '150000.00', 4, 'Sudah', '2022-12-23 01:14:24', NULL, NULL, NULL),
(487, 2, 'P20222487', 'Satrio 487', '56419974487', '3276022304010010487', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243487', 'Malang. 487', 'Islam', 4, 11, '150000.00', 4, 'Sudah', '2022-12-23 01:14:24', NULL, NULL, NULL),
(488, 1, 'P20221488', 'Satrio 488', '56419974488', '3276022304010010488', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243488', 'Malang. 488', 'Islam', 2, 5, '150000.00', 1, 'Sudah', '2022-12-23 01:14:24', NULL, NULL, NULL),
(489, 1, 'P20221489', 'Satrio 489', '56419974489', '3276022304010010489', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243489', 'Malang. 489', 'Islam', 10, 1, '150000.00', 1, 'Sudah', '2022-12-23 01:14:24', NULL, NULL, NULL),
(490, 1, 'P20221490', 'Satrio 490', '56419974490', '3276022304010010490', 'Depok', '2001-12-30', 'Perempuan', '08810243490', 'Malang. 490', 'Islam', 2, 8, '150000.00', 3, 'Belum', '2022-12-23 01:14:24', NULL, NULL, NULL),
(491, 1, 'P20221491', 'Satrio 491', '56419974491', '3276022304010010491', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243491', 'Malang. 491', 'Islam', 12, 9, '150000.00', 1, 'Sudah', '2022-12-23 01:14:24', NULL, NULL, NULL),
(492, 2, 'P20222492', 'Satrio 492', '56419974492', '3276022304010010492', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243492', 'Malang. 492', 'Islam', 6, 12, '150000.00', 3, 'Sudah', '2022-12-23 01:14:24', NULL, NULL, NULL),
(493, 1, 'P20221493', 'Satrio 493', '56419974493', '3276022304010010493', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243493', 'Malang. 493', 'Islam', 13, 11, '150000.00', 2, 'Sudah', '2022-12-23 01:14:25', NULL, NULL, NULL),
(494, 2, 'P20222494', 'Satrio 494', '56419974494', '3276022304010010494', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243494', 'Malang. 494', 'Islam', 8, 4, '150000.00', 3, 'Sudah', '2022-12-23 01:14:25', NULL, NULL, NULL),
(495, 3, 'P20223495', 'Satrio 495', '56419974495', '3276022304010010495', 'Depok', '2001-12-04', 'Perempuan', '08810243495', 'Malang. 495', 'Islam', 1, 11, NULL, NULL, 'Gratis', '2022-12-23 01:14:25', NULL, NULL, NULL),
(496, 2, 'P20222496', 'Satrio 496', '56419974496', '3276022304010010496', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243496', 'Malang. 496', 'Islam', 10, 2, '150000.00', 1, 'Sudah', '2022-12-23 01:14:25', NULL, NULL, NULL),
(497, 2, 'P20222497', 'Satrio 497', '56419974497', '3276022304010010497', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243497', 'Malang. 497', 'Islam', 13, 7, '150000.00', 2, 'Belum', '2022-12-23 01:14:25', NULL, NULL, NULL),
(498, 3, 'P20223498', 'Satrio 498', '56419974498', '3276022304010010498', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243498', 'Malang. 498', 'Islam', 7, 6, NULL, NULL, 'Gratis', '2022-12-23 01:14:25', NULL, NULL, NULL),
(499, 2, 'P20222499', 'Satrio 499', '56419974499', '3276022304010010499', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243499', 'Malang. 499', 'Islam', 6, 11, '150000.00', 3, 'Sudah', '2022-12-23 01:14:25', NULL, NULL, NULL),
(500, 2, 'P20222500', 'Satrio 500', '56419974500', '3276022304010010500', 'Depok', '2001-12-31', 'Perempuan', '08810243500', 'Malang. 500', 'Islam', 11, 13, '150000.00', 4, 'Sudah', '2022-12-23 01:14:25', NULL, NULL, NULL),
(501, 1, 'P20221501', 'Satrio 501', '56419974501', '3276022304010010501', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243501', 'Malang. 501', 'Islam', 9, 9, '150000.00', 1, 'Sudah', '2022-12-23 01:14:25', NULL, NULL, NULL),
(502, 1, 'P20221502', 'Satrio 502', '56419974502', '3276022304010010502', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243502', 'Malang. 502', 'Islam', 4, 4, '150000.00', 3, 'Sudah', '2022-12-23 01:14:25', NULL, NULL, NULL),
(503, 2, 'P20222503', 'Satrio 503', '56419974503', '3276022304010010503', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243503', 'Malang. 503', 'Islam', 4, 9, '150000.00', 4, 'Sudah', '2022-12-23 01:14:25', NULL, NULL, NULL),
(504, 2, 'P20222504', 'Satrio 504', '56419974504', '3276022304010010504', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243504', 'Malang. 504', 'Islam', 2, 4, '150000.00', 3, 'Belum', '2022-12-23 01:14:25', NULL, NULL, NULL),
(505, 3, 'P20223505', 'Satrio 505', '56419974505', '3276022304010010505', 'Depok', '2001-12-20', 'Perempuan', '08810243505', 'Malang. 505', 'Islam', 6, 10, NULL, NULL, 'Gratis', '2022-12-23 01:14:25', NULL, NULL, NULL),
(506, 3, 'P20223506', 'Satrio 506', '56419974506', '3276022304010010506', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243506', 'Malang. 506', 'Islam', 1, 5, NULL, NULL, 'Gratis', '2022-12-23 01:14:26', NULL, NULL, NULL),
(507, 3, 'P20223507', 'Satrio 507', '56419974507', '3276022304010010507', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243507', 'Malang. 507', 'Islam', 7, 7, NULL, NULL, 'Gratis', '2022-12-23 01:14:26', NULL, NULL, NULL),
(508, 2, 'P20222508', 'Satrio 508', '56419974508', '3276022304010010508', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243508', 'Malang. 508', 'Islam', 9, 11, '150000.00', 4, 'Sudah', '2022-12-23 01:14:26', NULL, NULL, NULL),
(509, 3, 'P20223509', 'Satrio 509', '56419974509', '3276022304010010509', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243509', 'Malang. 509', 'Islam', 10, 3, NULL, NULL, 'Gratis', '2022-12-23 01:14:26', NULL, NULL, NULL),
(510, 1, 'P20221510', 'Satrio 510', '56419974510', '3276022304010010510', 'Depok', '2001-12-29', 'Perempuan', '08810243510', 'Malang. 510', 'Islam', 7, 13, '150000.00', 2, 'Sudah', '2022-12-23 01:14:26', NULL, NULL, NULL),
(511, 2, 'P20222511', 'Satrio 511', '56419974511', '3276022304010010511', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243511', 'Malang. 511', 'Islam', 2, 8, '150000.00', 1, 'Belum', '2022-12-23 01:14:26', NULL, NULL, NULL),
(512, 3, 'P20223512', 'Satrio 512', '56419974512', '3276022304010010512', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243512', 'Malang. 512', 'Islam', 9, 7, NULL, NULL, 'Gratis', '2022-12-23 01:14:26', NULL, NULL, NULL),
(513, 1, 'P20221513', 'Satrio 513', '56419974513', '3276022304010010513', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243513', 'Malang. 513', 'Islam', 3, 13, '150000.00', 3, 'Sudah', '2022-12-23 01:14:26', NULL, NULL, NULL),
(514, 1, 'P20221514', 'Satrio 514', '56419974514', '3276022304010010514', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243514', 'Malang. 514', 'Islam', 8, 3, '150000.00', 4, 'Sudah', '2022-12-23 01:14:26', NULL, NULL, NULL),
(515, 3, 'P20223515', 'Satrio 515', '56419974515', '3276022304010010515', 'Depok', '2001-12-23', 'Perempuan', '08810243515', 'Malang. 515', 'Islam', 12, 13, NULL, NULL, 'Gratis', '2022-12-23 01:14:26', NULL, NULL, NULL),
(516, 2, 'P20222516', 'Satrio 516', '56419974516', '3276022304010010516', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243516', 'Malang. 516', 'Islam', 13, 5, '150000.00', 2, 'Sudah', '2022-12-23 01:14:27', NULL, NULL, NULL),
(517, 3, 'P20223517', 'Satrio 517', '56419974517', '3276022304010010517', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243517', 'Malang. 517', 'Islam', 2, 11, NULL, NULL, 'Gratis', '2022-12-23 01:14:27', NULL, NULL, NULL),
(518, 2, 'P20222518', 'Satrio 518', '56419974518', '3276022304010010518', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243518', 'Malang. 518', 'Islam', 13, 10, '150000.00', 4, 'Belum', '2022-12-23 01:14:27', NULL, NULL, NULL),
(519, 2, 'P20222519', 'Satrio 519', '56419974519', '3276022304010010519', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243519', 'Malang. 519', 'Islam', 5, 2, '150000.00', 3, 'Sudah', '2022-12-23 01:14:27', NULL, NULL, NULL),
(520, 2, 'P20222520', 'Satrio 520', '56419974520', '3276022304010010520', 'Depok', '2001-12-28', 'Perempuan', '08810243520', 'Malang. 520', 'Islam', 6, 5, '150000.00', 2, 'Sudah', '2022-12-23 01:14:27', NULL, NULL, NULL),
(521, 2, 'P20222521', 'Satrio 521', '56419974521', '3276022304010010521', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243521', 'Malang. 521', 'Islam', 9, 13, '150000.00', 1, 'Sudah', '2022-12-23 01:14:27', NULL, NULL, NULL),
(522, 1, 'P20221522', 'Satrio 522', '56419974522', '3276022304010010522', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243522', 'Malang. 522', 'Islam', 11, 9, '150000.00', 3, 'Sudah', '2022-12-23 01:14:27', NULL, NULL, NULL),
(523, 3, 'P20223523', 'Satrio 523', '56419974523', '3276022304010010523', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243523', 'Malang. 523', 'Islam', 12, 4, NULL, NULL, 'Gratis', '2022-12-23 01:14:27', NULL, NULL, NULL),
(524, 2, 'P20222524', 'Satrio 524', '56419974524', '3276022304010010524', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243524', 'Malang. 524', 'Islam', 3, 5, '150000.00', 4, 'Sudah', '2022-12-23 01:14:28', NULL, NULL, NULL),
(525, 3, 'P20223525', 'Satrio 525', '56419974525', '3276022304010010525', 'Depok', '2001-12-11', 'Perempuan', '08810243525', 'Malang. 525', 'Islam', 12, 4, NULL, NULL, 'Belum', '2022-12-23 01:14:28', NULL, NULL, NULL),
(526, 3, 'P20223526', 'Satrio 526', '56419974526', '3276022304010010526', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243526', 'Malang. 526', 'Islam', 11, 1, NULL, NULL, 'Gratis', '2022-12-23 01:14:28', NULL, NULL, NULL),
(527, 2, 'P20222527', 'Satrio 527', '56419974527', '3276022304010010527', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243527', 'Malang. 527', 'Islam', 13, 10, '150000.00', 3, 'Sudah', '2022-12-23 01:14:28', NULL, NULL, NULL),
(528, 3, 'P20223528', 'Satrio 528', '56419974528', '3276022304010010528', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243528', 'Malang. 528', 'Islam', 1, 12, NULL, NULL, 'Gratis', '2022-12-23 01:14:28', NULL, NULL, NULL),
(529, 1, 'P20221529', 'Satrio 529', '56419974529', '3276022304010010529', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243529', 'Malang. 529', 'Islam', 10, 12, '150000.00', 3, 'Sudah', '2022-12-23 01:14:28', NULL, NULL, NULL),
(530, 1, 'P20221530', 'Satrio 530', '56419974530', '3276022304010010530', 'Depok', '2001-12-30', 'Perempuan', '08810243530', 'Malang. 530', 'Islam', 10, 2, '150000.00', 4, 'Sudah', '2022-12-23 01:14:28', NULL, NULL, NULL),
(531, 2, 'P20222531', 'Satrio 531', '56419974531', '3276022304010010531', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243531', 'Malang. 531', 'Islam', 6, 11, '150000.00', 4, 'Sudah', '2022-12-23 01:14:28', NULL, NULL, NULL),
(532, 2, 'P20222532', 'Satrio 532', '56419974532', '3276022304010010532', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243532', 'Malang. 532', 'Islam', 8, 8, '150000.00', 2, 'Belum', '2022-12-23 01:14:28', NULL, NULL, NULL),
(533, 2, 'P20222533', 'Satrio 533', '56419974533', '3276022304010010533', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243533', 'Malang. 533', 'Islam', 4, 10, '150000.00', 1, 'Sudah', '2022-12-23 01:14:28', NULL, NULL, NULL),
(534, 3, 'P20223534', 'Satrio 534', '56419974534', '3276022304010010534', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243534', 'Malang. 534', 'Islam', 1, 7, NULL, NULL, 'Gratis', '2022-12-23 01:14:28', NULL, NULL, NULL),
(535, 3, 'P20223535', 'Satrio 535', '56419974535', '3276022304010010535', 'Depok', '2001-12-08', 'Perempuan', '08810243535', 'Malang. 535', 'Islam', 13, 8, NULL, NULL, 'Gratis', '2022-12-23 01:14:28', NULL, NULL, NULL),
(536, 1, 'P20221536', 'Satrio 536', '56419974536', '3276022304010010536', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243536', 'Malang. 536', 'Islam', 1, 3, '150000.00', 1, 'Sudah', '2022-12-23 01:14:29', NULL, NULL, NULL),
(537, 3, 'P20223537', 'Satrio 537', '56419974537', '3276022304010010537', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243537', 'Malang. 537', 'Islam', 13, 12, NULL, NULL, 'Gratis', '2022-12-23 01:14:29', NULL, NULL, NULL),
(538, 1, 'P20221538', 'Satrio 538', '56419974538', '3276022304010010538', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243538', 'Malang. 538', 'Islam', 6, 12, '150000.00', 3, 'Sudah', '2022-12-23 01:14:29', NULL, NULL, NULL),
(539, 2, 'P20222539', 'Satrio 539', '56419974539', '3276022304010010539', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243539', 'Malang. 539', 'Islam', 12, 2, '150000.00', 4, 'Belum', '2022-12-23 01:14:29', NULL, NULL, NULL),
(540, 3, 'P20223540', 'Satrio 540', '56419974540', '3276022304010010540', 'Depok', '2001-12-18', 'Perempuan', '08810243540', 'Malang. 540', 'Islam', 8, 1, NULL, NULL, 'Gratis', '2022-12-23 01:14:29', NULL, NULL, NULL),
(541, 3, 'P20223541', 'Satrio 541', '56419974541', '3276022304010010541', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243541', 'Malang. 541', 'Islam', 7, 12, NULL, NULL, 'Gratis', '2022-12-23 01:14:29', NULL, NULL, NULL),
(542, 1, 'P20221542', 'Satrio 542', '56419974542', '3276022304010010542', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243542', 'Malang. 542', 'Islam', 4, 11, '150000.00', 4, 'Sudah', '2022-12-23 01:14:29', NULL, NULL, NULL),
(543, 1, 'P20221543', 'Satrio 543', '56419974543', '3276022304010010543', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243543', 'Malang. 543', 'Islam', 1, 3, '150000.00', 4, 'Sudah', '2022-12-23 01:14:29', NULL, NULL, NULL),
(544, 1, 'P20221544', 'Satrio 544', '56419974544', '3276022304010010544', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243544', 'Malang. 544', 'Islam', 4, 13, '150000.00', 2, 'Sudah', '2022-12-23 01:14:29', NULL, NULL, NULL),
(545, 3, 'P20223545', 'Satrio 545', '56419974545', '3276022304010010545', 'Depok', '2001-12-17', 'Perempuan', '08810243545', 'Malang. 545', 'Islam', 11, 9, NULL, NULL, 'Gratis', '2022-12-23 01:14:29', NULL, NULL, NULL),
(546, 2, 'P20222546', 'Satrio 546', '56419974546', '3276022304010010546', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243546', 'Malang. 546', 'Islam', 11, 6, '150000.00', 4, 'Belum', '2022-12-23 01:14:29', NULL, NULL, NULL),
(547, 2, 'P20222547', 'Satrio 547', '56419974547', '3276022304010010547', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243547', 'Malang. 547', 'Islam', 10, 2, '150000.00', 1, 'Sudah', '2022-12-23 01:14:29', NULL, NULL, NULL),
(548, 1, 'P20221548', 'Satrio 548', '56419974548', '3276022304010010548', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243548', 'Malang. 548', 'Islam', 10, 12, '150000.00', 1, 'Sudah', '2022-12-23 01:14:29', NULL, NULL, NULL),
(549, 1, 'P20221549', 'Satrio 549', '56419974549', '3276022304010010549', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243549', 'Malang. 549', 'Islam', 4, 2, '150000.00', 1, 'Sudah', '2022-12-23 01:14:29', NULL, NULL, NULL),
(550, 1, 'P20221550', 'Satrio 550', '56419974550', '3276022304010010550', 'Depok', '2001-12-19', 'Perempuan', '08810243550', 'Malang. 550', 'Islam', 1, 5, '150000.00', 3, 'Sudah', '2022-12-23 01:14:29', NULL, NULL, NULL),
(551, 2, 'P20222551', 'Satrio 551', '56419974551', '3276022304010010551', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243551', 'Malang. 551', 'Islam', 12, 13, '150000.00', 3, 'Sudah', '2022-12-23 01:14:29', NULL, NULL, NULL),
(552, 2, 'P20222552', 'Satrio 552', '56419974552', '3276022304010010552', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243552', 'Malang. 552', 'Islam', 11, 11, '150000.00', 4, 'Sudah', '2022-12-23 01:14:30', NULL, NULL, NULL),
(553, 3, 'P20223553', 'Satrio 553', '56419974553', '3276022304010010553', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243553', 'Malang. 553', 'Islam', 12, 8, NULL, NULL, 'Belum', '2022-12-23 01:14:30', NULL, NULL, NULL),
(554, 2, 'P20222554', 'Satrio 554', '56419974554', '3276022304010010554', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243554', 'Malang. 554', 'Islam', 4, 12, '150000.00', 2, 'Sudah', '2022-12-23 01:14:30', NULL, NULL, NULL),
(555, 2, 'P20222555', 'Satrio 555', '56419974555', '3276022304010010555', 'Depok', '2001-12-07', 'Perempuan', '08810243555', 'Malang. 555', 'Islam', 1, 2, '150000.00', 1, 'Sudah', '2022-12-23 01:14:30', NULL, NULL, NULL),
(556, 2, 'P20222556', 'Satrio 556', '56419974556', '3276022304010010556', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243556', 'Malang. 556', 'Islam', 9, 10, '150000.00', 2, 'Sudah', '2022-12-23 01:14:30', NULL, NULL, NULL),
(557, 2, 'P20222557', 'Satrio 557', '56419974557', '3276022304010010557', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243557', 'Malang. 557', 'Islam', 13, 11, '150000.00', 2, 'Sudah', '2022-12-23 01:14:30', NULL, NULL, NULL),
(558, 3, 'P20223558', 'Satrio 558', '56419974558', '3276022304010010558', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243558', 'Malang. 558', 'Islam', 11, 5, NULL, NULL, 'Gratis', '2022-12-23 01:14:30', NULL, NULL, NULL),
(559, 3, 'P20223559', 'Satrio 559', '56419974559', '3276022304010010559', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243559', 'Malang. 559', 'Islam', 3, 11, NULL, NULL, 'Gratis', '2022-12-23 01:14:30', NULL, NULL, NULL),
(560, 3, 'P20223560', 'Satrio 560', '56419974560', '3276022304010010560', 'Depok', '2001-12-04', 'Perempuan', '08810243560', 'Malang. 560', 'Islam', 4, 13, NULL, NULL, 'Belum', '2022-12-23 01:14:30', NULL, NULL, NULL),
(561, 3, 'P20223561', 'Satrio 561', '56419974561', '3276022304010010561', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243561', 'Malang. 561', 'Islam', 10, 4, NULL, NULL, 'Gratis', '2022-12-23 01:14:30', NULL, NULL, NULL),
(562, 1, 'P20221562', 'Satrio 562', '56419974562', '3276022304010010562', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243562', 'Malang. 562', 'Islam', 11, 7, '150000.00', 3, 'Sudah', '2022-12-23 01:14:30', NULL, NULL, NULL),
(563, 2, 'P20222563', 'Satrio 563', '56419974563', '3276022304010010563', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243563', 'Malang. 563', 'Islam', 4, 12, '150000.00', 4, 'Sudah', '2022-12-23 01:14:30', NULL, NULL, NULL),
(564, 3, 'P20223564', 'Satrio 564', '56419974564', '3276022304010010564', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243564', 'Malang. 564', 'Islam', 10, 13, NULL, NULL, 'Gratis', '2022-12-23 01:14:30', NULL, NULL, NULL),
(565, 3, 'P20223565', 'Satrio 565', '56419974565', '3276022304010010565', 'Depok', '2001-12-08', 'Perempuan', '08810243565', 'Malang. 565', 'Islam', 2, 7, NULL, NULL, 'Gratis', '2022-12-23 01:14:31', NULL, NULL, NULL),
(566, 1, 'P20221566', 'Satrio 566', '56419974566', '3276022304010010566', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243566', 'Malang. 566', 'Islam', 10, 5, '150000.00', 3, 'Sudah', '2022-12-23 01:14:31', NULL, NULL, NULL),
(567, 2, 'P20222567', 'Satrio 567', '56419974567', '3276022304010010567', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243567', 'Malang. 567', 'Islam', 11, 12, '150000.00', 3, 'Belum', '2022-12-23 01:14:31', NULL, NULL, NULL),
(568, 3, 'P20223568', 'Satrio 568', '56419974568', '3276022304010010568', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243568', 'Malang. 568', 'Islam', 4, 7, NULL, NULL, 'Gratis', '2022-12-23 01:14:31', NULL, NULL, NULL),
(569, 1, 'P20221569', 'Satrio 569', '56419974569', '3276022304010010569', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243569', 'Malang. 569', 'Islam', 4, 10, '150000.00', 2, 'Sudah', '2022-12-23 01:14:31', NULL, NULL, NULL),
(570, 3, 'P20223570', 'Satrio 570', '56419974570', '3276022304010010570', 'Depok', '2001-12-26', 'Perempuan', '08810243570', 'Malang. 570', 'Islam', 13, 1, NULL, NULL, 'Gratis', '2022-12-23 01:14:31', NULL, NULL, NULL),
(571, 2, 'P20222571', 'Satrio 571', '56419974571', '3276022304010010571', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243571', 'Malang. 571', 'Islam', 12, 12, '150000.00', 4, 'Sudah', '2022-12-23 01:14:31', NULL, NULL, NULL),
(572, 2, 'P20222572', 'Satrio 572', '56419974572', '3276022304010010572', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243572', 'Malang. 572', 'Islam', 12, 12, '150000.00', 4, 'Sudah', '2022-12-23 01:14:31', NULL, NULL, NULL),
(573, 1, 'P20221573', 'Satrio 573', '56419974573', '3276022304010010573', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243573', 'Malang. 573', 'Islam', 6, 5, '150000.00', 2, 'Sudah', '2022-12-23 01:14:31', NULL, NULL, NULL),
(574, 1, 'P20221574', 'Satrio 574', '56419974574', '3276022304010010574', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243574', 'Malang. 574', 'Islam', 6, 8, '150000.00', 2, 'Belum', '2022-12-23 01:14:31', NULL, NULL, NULL),
(575, 1, 'P20221575', 'Satrio 575', '56419974575', '3276022304010010575', 'Depok', '2001-12-20', 'Perempuan', '08810243575', 'Malang. 575', 'Islam', 3, 3, '150000.00', 3, 'Sudah', '2022-12-23 01:14:31', NULL, NULL, NULL),
(576, 1, 'P20221576', 'Satrio 576', '56419974576', '3276022304010010576', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243576', 'Malang. 576', 'Islam', 12, 6, '150000.00', 1, 'Sudah', '2022-12-23 01:14:31', NULL, NULL, NULL),
(577, 3, 'P20223577', 'Satrio 577', '56419974577', '3276022304010010577', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243577', 'Malang. 577', 'Islam', 2, 8, NULL, NULL, 'Gratis', '2022-12-23 01:14:31', NULL, NULL, NULL),
(578, 3, 'P20223578', 'Satrio 578', '56419974578', '3276022304010010578', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243578', 'Malang. 578', 'Islam', 3, 8, NULL, NULL, 'Gratis', '2022-12-23 01:14:32', NULL, NULL, NULL),
(579, 2, 'P20222579', 'Satrio 579', '56419974579', '3276022304010010579', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243579', 'Malang. 579', 'Islam', 3, 10, '150000.00', 2, 'Sudah', '2022-12-23 01:14:32', NULL, NULL, NULL),
(580, 3, 'P20223580', 'Satrio 580', '56419974580', '3276022304010010580', 'Depok', '2001-12-18', 'Perempuan', '08810243580', 'Malang. 580', 'Islam', 3, 2, NULL, NULL, 'Gratis', '2022-12-23 01:14:32', NULL, NULL, NULL),
(581, 2, 'P20222581', 'Satrio 581', '56419974581', '3276022304010010581', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243581', 'Malang. 581', 'Islam', 8, 9, '150000.00', 4, 'Belum', '2022-12-23 01:14:32', NULL, NULL, NULL),
(582, 1, 'P20221582', 'Satrio 582', '56419974582', '3276022304010010582', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243582', 'Malang. 582', 'Islam', 8, 6, '150000.00', 4, 'Sudah', '2022-12-23 01:14:32', NULL, NULL, NULL),
(583, 1, 'P20221583', 'Satrio 583', '56419974583', '3276022304010010583', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243583', 'Malang. 583', 'Islam', 7, 8, '150000.00', 2, 'Sudah', '2022-12-23 01:14:32', NULL, NULL, NULL),
(584, 1, 'P20221584', 'Satrio 584', '56419974584', '3276022304010010584', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243584', 'Malang. 584', 'Islam', 6, 9, '150000.00', 3, 'Sudah', '2022-12-23 01:14:32', NULL, NULL, NULL),
(585, 3, 'P20223585', 'Satrio 585', '56419974585', '3276022304010010585', 'Depok', '2001-12-29', 'Perempuan', '08810243585', 'Malang. 585', 'Islam', 8, 12, NULL, NULL, 'Gratis', '2022-12-23 01:14:32', NULL, NULL, NULL),
(586, 1, 'P20221586', 'Satrio 586', '56419974586', '3276022304010010586', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243586', 'Malang. 586', 'Islam', 6, 11, '150000.00', 3, 'Sudah', '2022-12-23 01:14:32', NULL, NULL, NULL),
(587, 3, 'P20223587', 'Satrio 587', '56419974587', '3276022304010010587', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243587', 'Malang. 587', 'Islam', 13, 10, NULL, NULL, 'Gratis', '2022-12-23 01:14:32', NULL, NULL, NULL),
(588, 3, 'P20223588', 'Satrio 588', '56419974588', '3276022304010010588', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243588', 'Malang. 588', 'Islam', 11, 11, NULL, NULL, 'Belum', '2022-12-23 01:14:32', NULL, NULL, NULL),
(589, 2, 'P20222589', 'Satrio 589', '56419974589', '3276022304010010589', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243589', 'Malang. 589', 'Islam', 4, 6, '150000.00', 4, 'Sudah', '2022-12-23 01:14:32', NULL, NULL, NULL),
(590, 2, 'P20222590', 'Satrio 590', '56419974590', '3276022304010010590', 'Depok', '2001-12-03', 'Perempuan', '08810243590', 'Malang. 590', 'Islam', 7, 12, '150000.00', 4, 'Sudah', '2022-12-23 01:14:33', NULL, NULL, NULL),
(591, 2, 'P20222591', 'Satrio 591', '56419974591', '3276022304010010591', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243591', 'Malang. 591', 'Islam', 6, 4, '150000.00', 3, 'Sudah', '2022-12-23 01:14:33', NULL, NULL, NULL),
(592, 1, 'P20221592', 'Satrio 592', '56419974592', '3276022304010010592', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243592', 'Malang. 592', 'Islam', 12, 13, '150000.00', 1, 'Sudah', '2022-12-23 01:14:33', NULL, NULL, NULL),
(593, 1, 'P20221593', 'Satrio 593', '56419974593', '3276022304010010593', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243593', 'Malang. 593', 'Islam', 2, 4, '150000.00', 2, 'Sudah', '2022-12-23 01:14:33', NULL, NULL, NULL),
(594, 1, 'P20221594', 'Satrio 594', '56419974594', '3276022304010010594', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243594', 'Malang. 594', 'Islam', 11, 13, '150000.00', 3, 'Sudah', '2022-12-23 01:14:33', NULL, NULL, NULL),
(595, 1, 'P20221595', 'Satrio 595', '56419974595', '3276022304010010595', 'Depok', '2001-12-07', 'Perempuan', '08810243595', 'Malang. 595', 'Islam', 9, 4, '150000.00', 1, 'Belum', '2022-12-23 01:14:33', NULL, NULL, NULL),
(596, 1, 'P20221596', 'Satrio 596', '56419974596', '3276022304010010596', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243596', 'Malang. 596', 'Islam', 5, 4, '150000.00', 3, 'Sudah', '2022-12-23 01:14:33', NULL, NULL, NULL),
(597, 3, 'P20223597', 'Satrio 597', '56419974597', '3276022304010010597', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243597', 'Malang. 597', 'Islam', 6, 12, NULL, NULL, 'Gratis', '2022-12-23 01:14:33', NULL, NULL, NULL),
(598, 3, 'P20223598', 'Satrio 598', '56419974598', '3276022304010010598', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243598', 'Malang. 598', 'Islam', 5, 9, NULL, NULL, 'Gratis', '2022-12-23 01:14:33', NULL, NULL, NULL),
(599, 2, 'P20222599', 'Satrio 599', '56419974599', '3276022304010010599', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243599', 'Malang. 599', 'Islam', 4, 13, '150000.00', 3, 'Sudah', '2022-12-23 01:14:33', NULL, NULL, NULL),
(600, 3, 'P20223600', 'Satrio 600', '56419974600', '3276022304010010600', 'Depok', '2001-12-25', 'Perempuan', '08810243600', 'Malang. 600', 'Islam', 5, 12, NULL, NULL, 'Gratis', '2022-12-23 01:14:33', NULL, NULL, NULL),
(601, 1, 'P20221601', 'Satrio 601', '56419974601', '3276022304010010601', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243601', 'Malang. 601', 'Islam', 9, 11, '150000.00', 3, 'Sudah', '2022-12-23 01:14:33', NULL, NULL, NULL),
(602, 1, 'P20221602', 'Satrio 602', '56419974602', '3276022304010010602', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243602', 'Malang. 602', 'Islam', 8, 6, '150000.00', 2, 'Belum', '2022-12-23 01:14:33', NULL, NULL, NULL),
(603, 2, 'P20222603', 'Satrio 603', '56419974603', '3276022304010010603', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243603', 'Malang. 603', 'Islam', 2, 6, '150000.00', 1, 'Sudah', '2022-12-23 01:14:34', NULL, NULL, NULL),
(604, 3, 'P20223604', 'Satrio 604', '56419974604', '3276022304010010604', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243604', 'Malang. 604', 'Islam', 10, 1, NULL, NULL, 'Gratis', '2022-12-23 01:14:34', NULL, NULL, NULL),
(605, 3, 'P20223605', 'Satrio 605', '56419974605', '3276022304010010605', 'Depok', '2001-12-23', 'Perempuan', '08810243605', 'Malang. 605', 'Islam', 8, 8, NULL, NULL, 'Gratis', '2022-12-23 01:14:34', NULL, NULL, NULL),
(606, 3, 'P20223606', 'Satrio 606', '56419974606', '3276022304010010606', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243606', 'Malang. 606', 'Islam', 6, 11, NULL, NULL, 'Gratis', '2022-12-23 01:14:34', NULL, NULL, NULL),
(607, 2, 'P20222607', 'Satrio 607', '56419974607', '3276022304010010607', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243607', 'Malang. 607', 'Islam', 1, 5, '150000.00', 3, 'Sudah', '2022-12-23 01:14:34', NULL, NULL, NULL),
(608, 2, 'P20222608', 'Satrio 608', '56419974608', '3276022304010010608', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243608', 'Malang. 608', 'Islam', 6, 8, '150000.00', 4, 'Sudah', '2022-12-23 01:14:34', NULL, NULL, NULL),
(609, 2, 'P20222609', 'Satrio 609', '56419974609', '3276022304010010609', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243609', 'Malang. 609', 'Islam', 11, 12, '150000.00', 3, 'Belum', '2022-12-23 01:14:34', NULL, NULL, NULL),
(610, 3, 'P20223610', 'Satrio 610', '56419974610', '3276022304010010610', 'Depok', '2001-12-26', 'Perempuan', '08810243610', 'Malang. 610', 'Islam', 1, 9, NULL, NULL, 'Gratis', '2022-12-23 01:14:34', NULL, NULL, NULL),
(611, 3, 'P20223611', 'Satrio 611', '56419974611', '3276022304010010611', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243611', 'Malang. 611', 'Islam', 13, 1, NULL, NULL, 'Gratis', '2022-12-23 01:14:34', NULL, NULL, NULL),
(612, 1, 'P20221612', 'Satrio 612', '56419974612', '3276022304010010612', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243612', 'Malang. 612', 'Islam', 8, 5, '150000.00', 4, 'Sudah', '2022-12-23 01:14:34', NULL, NULL, NULL),
(613, 1, 'P20221613', 'Satrio 613', '56419974613', '3276022304010010613', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243613', 'Malang. 613', 'Islam', 13, 11, '150000.00', 2, 'Sudah', '2022-12-23 01:14:34', NULL, NULL, NULL),
(614, 1, 'P20221614', 'Satrio 614', '56419974614', '3276022304010010614', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243614', 'Malang. 614', 'Islam', 6, 4, '150000.00', 1, 'Sudah', '2022-12-23 01:14:34', NULL, NULL, NULL),
(615, 2, 'P20222615', 'Satrio 615', '56419974615', '3276022304010010615', 'Depok', '2001-12-11', 'Perempuan', '08810243615', 'Malang. 615', 'Islam', 3, 1, '150000.00', 3, 'Sudah', '2022-12-23 01:14:35', NULL, NULL, NULL),
(616, 2, 'P20222616', 'Satrio 616', '56419974616', '3276022304010010616', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243616', 'Malang. 616', 'Islam', 7, 5, '150000.00', 3, 'Belum', '2022-12-23 01:14:35', NULL, NULL, NULL),
(617, 2, 'P20222617', 'Satrio 617', '56419974617', '3276022304010010617', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243617', 'Malang. 617', 'Islam', 9, 1, '150000.00', 1, 'Sudah', '2022-12-23 01:14:35', NULL, NULL, NULL),
(618, 2, 'P20222618', 'Satrio 618', '56419974618', '3276022304010010618', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243618', 'Malang. 618', 'Islam', 11, 8, '150000.00', 4, 'Sudah', '2022-12-23 01:14:35', NULL, NULL, NULL),
(619, 2, 'P20222619', 'Satrio 619', '56419974619', '3276022304010010619', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243619', 'Malang. 619', 'Islam', 5, 6, '150000.00', 1, 'Sudah', '2022-12-23 01:14:35', NULL, NULL, NULL),
(620, 1, 'P20221620', 'Satrio 620', '56419974620', '3276022304010010620', 'Depok', '2001-12-02', 'Perempuan', '08810243620', 'Malang. 620', 'Islam', 11, 9, '150000.00', 2, 'Sudah', '2022-12-23 01:14:35', NULL, NULL, NULL),
(621, 2, 'P20222621', 'Satrio 621', '56419974621', '3276022304010010621', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243621', 'Malang. 621', 'Islam', 1, 3, '150000.00', 3, 'Sudah', '2022-12-23 01:14:35', NULL, NULL, NULL),
(622, 3, 'P20223622', 'Satrio 622', '56419974622', '3276022304010010622', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243622', 'Malang. 622', 'Islam', 1, 3, NULL, NULL, 'Gratis', '2022-12-23 01:14:35', NULL, NULL, NULL),
(623, 2, 'P20222623', 'Satrio 623', '56419974623', '3276022304010010623', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243623', 'Malang. 623', 'Islam', 10, 1, '150000.00', 1, 'Belum', '2022-12-23 01:14:35', NULL, NULL, NULL),
(624, 1, 'P20221624', 'Satrio 624', '56419974624', '3276022304010010624', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243624', 'Malang. 624', 'Islam', 8, 13, '150000.00', 1, 'Sudah', '2022-12-23 01:14:35', NULL, NULL, NULL),
(625, 2, 'P20222625', 'Satrio 625', '56419974625', '3276022304010010625', 'Depok', '2001-12-18', 'Perempuan', '08810243625', 'Malang. 625', 'Islam', 11, 3, '150000.00', 3, 'Sudah', '2022-12-23 01:14:35', NULL, NULL, NULL),
(626, 3, 'P20223626', 'Satrio 626', '56419974626', '3276022304010010626', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243626', 'Malang. 626', 'Islam', 13, 6, NULL, NULL, 'Gratis', '2022-12-23 01:14:35', NULL, NULL, NULL),
(627, 2, 'P20222627', 'Satrio 627', '56419974627', '3276022304010010627', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243627', 'Malang. 627', 'Islam', 3, 6, '150000.00', 4, 'Sudah', '2022-12-23 01:14:35', NULL, NULL, NULL),
(628, 3, 'P20223628', 'Satrio 628', '56419974628', '3276022304010010628', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243628', 'Malang. 628', 'Islam', 7, 11, NULL, NULL, 'Gratis', '2022-12-23 01:14:35', NULL, NULL, NULL),
(629, 1, 'P20221629', 'Satrio 629', '56419974629', '3276022304010010629', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243629', 'Malang. 629', 'Islam', 1, 2, '150000.00', 1, 'Sudah', '2022-12-23 01:14:36', NULL, NULL, NULL),
(630, 3, 'P20223630', 'Satrio 630', '56419974630', '3276022304010010630', 'Depok', '2001-12-23', 'Perempuan', '08810243630', 'Malang. 630', 'Islam', 9, 1, NULL, NULL, 'Belum', '2022-12-23 01:14:36', NULL, NULL, NULL),
(631, 3, 'P20223631', 'Satrio 631', '56419974631', '3276022304010010631', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243631', 'Malang. 631', 'Islam', 9, 9, NULL, NULL, 'Gratis', '2022-12-23 01:14:36', NULL, NULL, NULL),
(632, 3, 'P20223632', 'Satrio 632', '56419974632', '3276022304010010632', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243632', 'Malang. 632', 'Islam', 11, 1, NULL, NULL, 'Gratis', '2022-12-23 01:14:36', NULL, NULL, NULL),
(633, 1, 'P20221633', 'Satrio 633', '56419974633', '3276022304010010633', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243633', 'Malang. 633', 'Islam', 13, 7, '150000.00', 1, 'Sudah', '2022-12-23 01:14:36', NULL, NULL, NULL),
(634, 3, 'P20223634', 'Satrio 634', '56419974634', '3276022304010010634', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243634', 'Malang. 634', 'Islam', 3, 1, NULL, NULL, 'Gratis', '2022-12-23 01:14:36', NULL, NULL, NULL),
(635, 1, 'P20221635', 'Satrio 635', '56419974635', '3276022304010010635', 'Depok', '2001-12-21', 'Perempuan', '08810243635', 'Malang. 635', 'Islam', 6, 2, '150000.00', 3, 'Sudah', '2022-12-23 01:14:36', NULL, NULL, NULL),
(636, 1, 'P20221636', 'Satrio 636', '56419974636', '3276022304010010636', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243636', 'Malang. 636', 'Islam', 13, 3, '150000.00', 1, 'Sudah', '2022-12-23 01:14:36', NULL, NULL, NULL),
(637, 1, 'P20221637', 'Satrio 637', '56419974637', '3276022304010010637', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243637', 'Malang. 637', 'Islam', 12, 7, '150000.00', 4, 'Belum', '2022-12-23 01:14:36', NULL, NULL, NULL),
(638, 1, 'P20221638', 'Satrio 638', '56419974638', '3276022304010010638', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243638', 'Malang. 638', 'Islam', 13, 5, '150000.00', 1, 'Sudah', '2022-12-23 01:14:36', NULL, NULL, NULL),
(639, 2, 'P20222639', 'Satrio 639', '56419974639', '3276022304010010639', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243639', 'Malang. 639', 'Islam', 3, 2, '150000.00', 1, 'Sudah', '2022-12-23 01:14:36', NULL, NULL, NULL),
(640, 3, 'P20223640', 'Satrio 640', '56419974640', '3276022304010010640', 'Depok', '2001-12-29', 'Perempuan', '08810243640', 'Malang. 640', 'Islam', 4, 7, NULL, NULL, 'Gratis', '2022-12-23 01:14:36', NULL, NULL, NULL),
(641, 1, 'P20221641', 'Satrio 641', '56419974641', '3276022304010010641', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243641', 'Malang. 641', 'Islam', 4, 11, '150000.00', 4, 'Sudah', '2022-12-23 01:14:36', NULL, NULL, NULL),
(642, 1, 'P20221642', 'Satrio 642', '56419974642', '3276022304010010642', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243642', 'Malang. 642', 'Islam', 12, 6, '150000.00', 3, 'Sudah', '2022-12-23 01:14:36', NULL, NULL, NULL),
(643, 3, 'P20223643', 'Satrio 643', '56419974643', '3276022304010010643', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243643', 'Malang. 643', 'Islam', 13, 1, NULL, NULL, 'Gratis', '2022-12-23 01:14:36', NULL, NULL, NULL),
(644, 2, 'P20222644', 'Satrio 644', '56419974644', '3276022304010010644', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243644', 'Malang. 644', 'Islam', 8, 5, '150000.00', 4, 'Belum', '2022-12-23 01:14:37', NULL, NULL, NULL),
(645, 2, 'P20222645', 'Satrio 645', '56419974645', '3276022304010010645', 'Depok', '2001-12-14', 'Perempuan', '08810243645', 'Malang. 645', 'Islam', 11, 1, '150000.00', 4, 'Sudah', '2022-12-23 01:14:37', NULL, NULL, NULL),
(646, 2, 'P20222646', 'Satrio 646', '56419974646', '3276022304010010646', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243646', 'Malang. 646', 'Islam', 1, 12, '150000.00', 3, 'Sudah', '2022-12-23 01:14:37', NULL, NULL, NULL),
(647, 2, 'P20222647', 'Satrio 647', '56419974647', '3276022304010010647', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243647', 'Malang. 647', 'Islam', 7, 10, '150000.00', 1, 'Sudah', '2022-12-23 01:14:37', NULL, NULL, NULL),
(648, 3, 'P20223648', 'Satrio 648', '56419974648', '3276022304010010648', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243648', 'Malang. 648', 'Islam', 11, 6, NULL, NULL, 'Gratis', '2022-12-23 01:14:37', NULL, NULL, NULL),
(649, 1, 'P20221649', 'Satrio 649', '56419974649', '3276022304010010649', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243649', 'Malang. 649', 'Islam', 1, 5, '150000.00', 2, 'Sudah', '2022-12-23 01:14:37', NULL, NULL, NULL),
(650, 3, 'P20223650', 'Satrio 650', '56419974650', '3276022304010010650', 'Depok', '2001-12-22', 'Perempuan', '08810243650', 'Malang. 650', 'Islam', 9, 2, NULL, NULL, 'Gratis', '2022-12-23 01:14:37', NULL, NULL, NULL),
(651, 3, 'P20223651', 'Satrio 651', '56419974651', '3276022304010010651', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243651', 'Malang. 651', 'Islam', 1, 12, NULL, NULL, 'Belum', '2022-12-23 01:14:37', NULL, NULL, NULL),
(652, 2, 'P20222652', 'Satrio 652', '56419974652', '3276022304010010652', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243652', 'Malang. 652', 'Islam', 5, 2, '150000.00', 1, 'Sudah', '2022-12-23 01:14:37', NULL, NULL, NULL),
(653, 2, 'P20222653', 'Satrio 653', '56419974653', '3276022304010010653', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243653', 'Malang. 653', 'Islam', 13, 10, '150000.00', 4, 'Sudah', '2022-12-23 01:14:37', NULL, NULL, NULL),
(654, 1, 'P20221654', 'Satrio 654', '56419974654', '3276022304010010654', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243654', 'Malang. 654', 'Islam', 9, 5, '150000.00', 4, 'Sudah', '2022-12-23 01:14:37', NULL, NULL, NULL),
(655, 1, 'P20221655', 'Satrio 655', '56419974655', '3276022304010010655', 'Depok', '2001-12-18', 'Perempuan', '08810243655', 'Malang. 655', 'Islam', 9, 5, '150000.00', 3, 'Sudah', '2022-12-23 01:14:37', NULL, NULL, NULL),
(656, 1, 'P20221656', 'Satrio 656', '56419974656', '3276022304010010656', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243656', 'Malang. 656', 'Islam', 6, 3, '150000.00', 4, 'Sudah', '2022-12-23 01:14:38', NULL, NULL, NULL),
(657, 1, 'P20221657', 'Satrio 657', '56419974657', '3276022304010010657', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243657', 'Malang. 657', 'Islam', 10, 11, '150000.00', 1, 'Sudah', '2022-12-23 01:14:38', NULL, NULL, NULL),
(658, 1, 'P20221658', 'Satrio 658', '56419974658', '3276022304010010658', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243658', 'Malang. 658', 'Islam', 3, 9, '150000.00', 4, 'Belum', '2022-12-23 01:14:38', NULL, NULL, NULL),
(659, 1, 'P20221659', 'Satrio 659', '56419974659', '3276022304010010659', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243659', 'Malang. 659', 'Islam', 5, 4, '150000.00', 2, 'Sudah', '2022-12-23 01:14:38', NULL, NULL, NULL),
(660, 1, 'P20221660', 'Satrio 660', '56419974660', '3276022304010010660', 'Depok', '2001-12-02', 'Perempuan', '08810243660', 'Malang. 660', 'Islam', 1, 9, '150000.00', 2, 'Sudah', '2022-12-23 01:14:38', NULL, NULL, NULL),
(661, 2, 'P20222661', 'Satrio 661', '56419974661', '3276022304010010661', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243661', 'Malang. 661', 'Islam', 4, 9, '150000.00', 2, 'Sudah', '2022-12-23 01:14:38', NULL, NULL, NULL),
(662, 1, 'P20221662', 'Satrio 662', '56419974662', '3276022304010010662', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243662', 'Malang. 662', 'Islam', 3, 10, '150000.00', 3, 'Sudah', '2022-12-23 01:14:38', NULL, NULL, NULL),
(663, 2, 'P20222663', 'Satrio 663', '56419974663', '3276022304010010663', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243663', 'Malang. 663', 'Islam', 4, 11, '150000.00', 3, 'Sudah', '2022-12-23 01:14:38', NULL, NULL, NULL),
(664, 3, 'P20223664', 'Satrio 664', '56419974664', '3276022304010010664', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243664', 'Malang. 664', 'Islam', 9, 8, NULL, NULL, 'Gratis', '2022-12-23 01:14:38', NULL, NULL, NULL),
(665, 2, 'P20222665', 'Satrio 665', '56419974665', '3276022304010010665', 'Depok', '2001-12-18', 'Perempuan', '08810243665', 'Malang. 665', 'Islam', 12, 1, '150000.00', 4, 'Belum', '2022-12-23 01:14:38', NULL, NULL, NULL),
(666, 3, 'P20223666', 'Satrio 666', '56419974666', '3276022304010010666', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243666', 'Malang. 666', 'Islam', 1, 8, NULL, NULL, 'Gratis', '2022-12-23 01:14:38', NULL, NULL, NULL),
(667, 1, 'P20221667', 'Satrio 667', '56419974667', '3276022304010010667', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243667', 'Malang. 667', 'Islam', 4, 9, '150000.00', 2, 'Sudah', '2022-12-23 01:14:38', NULL, NULL, NULL),
(668, 1, 'P20221668', 'Satrio 668', '56419974668', '3276022304010010668', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243668', 'Malang. 668', 'Islam', 13, 13, '150000.00', 4, 'Sudah', '2022-12-23 01:14:38', NULL, NULL, NULL),
(669, 3, 'P20223669', 'Satrio 669', '56419974669', '3276022304010010669', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243669', 'Malang. 669', 'Islam', 9, 6, NULL, NULL, 'Gratis', '2022-12-23 01:14:38', NULL, NULL, NULL),
(670, 1, 'P20221670', 'Satrio 670', '56419974670', '3276022304010010670', 'Depok', '2001-12-20', 'Perempuan', '08810243670', 'Malang. 670', 'Islam', 9, 12, '150000.00', 2, 'Sudah', '2022-12-23 01:14:38', NULL, NULL, NULL),
(671, 2, 'P20222671', 'Satrio 671', '56419974671', '3276022304010010671', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243671', 'Malang. 671', 'Islam', 11, 5, '150000.00', 4, 'Sudah', '2022-12-23 01:14:38', NULL, NULL, NULL),
(672, 1, 'P20221672', 'Satrio 672', '56419974672', '3276022304010010672', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243672', 'Malang. 672', 'Islam', 4, 3, '150000.00', 1, 'Belum', '2022-12-23 01:14:38', NULL, NULL, NULL),
(673, 1, 'P20221673', 'Satrio 673', '56419974673', '3276022304010010673', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243673', 'Malang. 673', 'Islam', 1, 6, '150000.00', 4, 'Sudah', '2022-12-23 01:14:38', NULL, NULL, NULL),
(674, 1, 'P20221674', 'Satrio 674', '56419974674', '3276022304010010674', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243674', 'Malang. 674', 'Islam', 1, 7, '150000.00', 1, 'Sudah', '2022-12-23 01:14:39', NULL, NULL, NULL),
(675, 2, 'P20222675', 'Satrio 675', '56419974675', '3276022304010010675', 'Depok', '2001-12-20', 'Perempuan', '08810243675', 'Malang. 675', 'Islam', 3, 3, '150000.00', 2, 'Sudah', '2022-12-23 01:14:39', NULL, NULL, NULL),
(676, 1, 'P20221676', 'Satrio 676', '56419974676', '3276022304010010676', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243676', 'Malang. 676', 'Islam', 6, 13, '150000.00', 4, 'Sudah', '2022-12-23 01:14:39', NULL, NULL, NULL);
INSERT INTO `pendaftar` (`id_pendaftar`, `id_jalur`, `no_pendaftar`, `nama`, `nisn`, `nik`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `no_hp`, `alamat`, `agama`, `id_prodi1`, `id_prodi2`, `nominal_bayar`, `id_bank`, `status_bayar`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(677, 2, 'P20222677', 'Satrio 677', '56419974677', '3276022304010010677', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243677', 'Malang. 677', 'Islam', 3, 11, '150000.00', 2, 'Sudah', '2022-12-23 01:14:39', NULL, NULL, NULL),
(678, 2, 'P20222678', 'Satrio 678', '56419974678', '3276022304010010678', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243678', 'Malang. 678', 'Islam', 5, 4, '150000.00', 1, 'Sudah', '2022-12-23 01:14:39', NULL, NULL, NULL),
(679, 2, 'P20222679', 'Satrio 679', '56419974679', '3276022304010010679', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243679', 'Malang. 679', 'Islam', 4, 7, '150000.00', 4, 'Belum', '2022-12-23 01:14:39', NULL, NULL, NULL),
(680, 1, 'P20221680', 'Satrio 680', '56419974680', '3276022304010010680', 'Depok', '2001-12-25', 'Perempuan', '08810243680', 'Malang. 680', 'Islam', 2, 8, '150000.00', 1, 'Sudah', '2022-12-23 01:14:39', NULL, NULL, NULL),
(681, 2, 'P20222681', 'Satrio 681', '56419974681', '3276022304010010681', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243681', 'Malang. 681', 'Islam', 2, 1, '150000.00', 2, 'Sudah', '2022-12-23 01:14:39', NULL, NULL, NULL),
(682, 2, 'P20222682', 'Satrio 682', '56419974682', '3276022304010010682', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243682', 'Malang. 682', 'Islam', 12, 11, '150000.00', 1, 'Sudah', '2022-12-23 01:14:39', NULL, NULL, NULL),
(683, 3, 'P20223683', 'Satrio 683', '56419974683', '3276022304010010683', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243683', 'Malang. 683', 'Islam', 5, 9, NULL, NULL, 'Gratis', '2022-12-23 01:14:39', NULL, NULL, NULL),
(684, 2, 'P20222684', 'Satrio 684', '56419974684', '3276022304010010684', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243684', 'Malang. 684', 'Islam', 10, 12, '150000.00', 2, 'Sudah', '2022-12-23 01:14:39', NULL, NULL, NULL),
(685, 1, 'P20221685', 'Satrio 685', '56419974685', '3276022304010010685', 'Depok', '2001-12-14', 'Perempuan', '08810243685', 'Malang. 685', 'Islam', 2, 4, '150000.00', 1, 'Sudah', '2022-12-23 01:14:39', NULL, NULL, NULL),
(686, 3, 'P20223686', 'Satrio 686', '56419974686', '3276022304010010686', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243686', 'Malang. 686', 'Islam', 3, 7, NULL, NULL, 'Belum', '2022-12-23 01:14:39', NULL, NULL, NULL),
(687, 3, 'P20223687', 'Satrio 687', '56419974687', '3276022304010010687', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243687', 'Malang. 687', 'Islam', 10, 4, NULL, NULL, 'Gratis', '2022-12-23 01:14:39', NULL, NULL, NULL),
(688, 3, 'P20223688', 'Satrio 688', '56419974688', '3276022304010010688', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243688', 'Malang. 688', 'Islam', 8, 4, NULL, NULL, 'Gratis', '2022-12-23 01:14:39', NULL, NULL, NULL),
(689, 2, 'P20222689', 'Satrio 689', '56419974689', '3276022304010010689', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243689', 'Malang. 689', 'Islam', 9, 2, '150000.00', 3, 'Sudah', '2022-12-23 01:14:40', NULL, NULL, NULL),
(690, 3, 'P20223690', 'Satrio 690', '56419974690', '3276022304010010690', 'Depok', '2001-12-09', 'Perempuan', '08810243690', 'Malang. 690', 'Islam', 13, 2, NULL, NULL, 'Gratis', '2022-12-23 01:14:40', NULL, NULL, NULL),
(691, 3, 'P20223691', 'Satrio 691', '56419974691', '3276022304010010691', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243691', 'Malang. 691', 'Islam', 13, 6, NULL, NULL, 'Gratis', '2022-12-23 01:14:40', NULL, NULL, NULL),
(692, 1, 'P20221692', 'Satrio 692', '56419974692', '3276022304010010692', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243692', 'Malang. 692', 'Islam', 9, 2, '150000.00', 1, 'Sudah', '2022-12-23 01:14:40', NULL, NULL, NULL),
(693, 2, 'P20222693', 'Satrio 693', '56419974693', '3276022304010010693', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243693', 'Malang. 693', 'Islam', 13, 2, '150000.00', 1, 'Belum', '2022-12-23 01:14:40', NULL, NULL, NULL),
(694, 1, 'P20221694', 'Satrio 694', '56419974694', '3276022304010010694', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243694', 'Malang. 694', 'Islam', 6, 2, '150000.00', 4, 'Sudah', '2022-12-23 01:14:40', NULL, NULL, NULL),
(695, 1, 'P20221695', 'Satrio 695', '56419974695', '3276022304010010695', 'Depok', '2001-12-26', 'Perempuan', '08810243695', 'Malang. 695', 'Islam', 7, 1, '150000.00', 3, 'Sudah', '2022-12-23 01:14:40', NULL, NULL, NULL),
(696, 3, 'P20223696', 'Satrio 696', '56419974696', '3276022304010010696', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243696', 'Malang. 696', 'Islam', 7, 11, NULL, NULL, 'Gratis', '2022-12-23 01:14:40', NULL, NULL, NULL),
(697, 2, 'P20222697', 'Satrio 697', '56419974697', '3276022304010010697', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243697', 'Malang. 697', 'Islam', 12, 7, '150000.00', 2, 'Sudah', '2022-12-23 01:14:40', NULL, NULL, NULL),
(698, 1, 'P20221698', 'Satrio 698', '56419974698', '3276022304010010698', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243698', 'Malang. 698', 'Islam', 6, 5, '150000.00', 4, 'Sudah', '2022-12-23 01:14:41', NULL, NULL, NULL),
(699, 3, 'P20223699', 'Satrio 699', '56419974699', '3276022304010010699', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243699', 'Malang. 699', 'Islam', 1, 3, NULL, NULL, 'Gratis', '2022-12-23 01:14:41', NULL, NULL, NULL),
(700, 3, 'P20223700', 'Satrio 700', '56419974700', '3276022304010010700', 'Depok', '2001-12-13', 'Perempuan', '08810243700', 'Malang. 700', 'Islam', 5, 12, NULL, NULL, 'Belum', '2022-12-23 01:14:41', NULL, NULL, NULL),
(701, 1, 'P20221701', 'Satrio 701', '56419974701', '3276022304010010701', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243701', 'Malang. 701', 'Islam', 1, 6, '150000.00', 2, 'Sudah', '2022-12-23 01:14:41', NULL, NULL, NULL),
(702, 1, 'P20221702', 'Satrio 702', '56419974702', '3276022304010010702', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243702', 'Malang. 702', 'Islam', 12, 6, '150000.00', 3, 'Sudah', '2022-12-23 01:14:41', NULL, NULL, NULL),
(703, 1, 'P20221703', 'Satrio 703', '56419974703', '3276022304010010703', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243703', 'Malang. 703', 'Islam', 2, 10, '150000.00', 4, 'Sudah', '2022-12-23 01:14:41', NULL, NULL, NULL),
(704, 1, 'P20221704', 'Satrio 704', '56419974704', '3276022304010010704', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243704', 'Malang. 704', 'Islam', 10, 2, '150000.00', 2, 'Sudah', '2022-12-23 01:14:41', NULL, NULL, NULL),
(705, 3, 'P20223705', 'Satrio 705', '56419974705', '3276022304010010705', 'Depok', '2001-12-06', 'Perempuan', '08810243705', 'Malang. 705', 'Islam', 10, 12, NULL, NULL, 'Gratis', '2022-12-23 01:14:41', NULL, NULL, NULL),
(706, 2, 'P20222706', 'Satrio 706', '56419974706', '3276022304010010706', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243706', 'Malang. 706', 'Islam', 1, 6, '150000.00', 1, 'Sudah', '2022-12-23 01:14:41', NULL, NULL, NULL),
(707, 1, 'P20221707', 'Satrio 707', '56419974707', '3276022304010010707', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243707', 'Malang. 707', 'Islam', 10, 9, '150000.00', 3, 'Belum', '2022-12-23 01:14:41', NULL, NULL, NULL),
(708, 3, 'P20223708', 'Satrio 708', '56419974708', '3276022304010010708', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243708', 'Malang. 708', 'Islam', 11, 10, NULL, NULL, 'Gratis', '2022-12-23 01:14:42', NULL, NULL, NULL),
(709, 3, 'P20223709', 'Satrio 709', '56419974709', '3276022304010010709', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243709', 'Malang. 709', 'Islam', 8, 11, NULL, NULL, 'Gratis', '2022-12-23 01:14:42', NULL, NULL, NULL),
(710, 2, 'P20222710', 'Satrio 710', '56419974710', '3276022304010010710', 'Depok', '2001-12-17', 'Perempuan', '08810243710', 'Malang. 710', 'Islam', 2, 3, '150000.00', 4, 'Sudah', '2022-12-23 01:14:42', NULL, NULL, NULL),
(711, 1, 'P20221711', 'Satrio 711', '56419974711', '3276022304010010711', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243711', 'Malang. 711', 'Islam', 1, 2, '150000.00', 2, 'Sudah', '2022-12-23 01:14:42', NULL, NULL, NULL),
(712, 3, 'P20223712', 'Satrio 712', '56419974712', '3276022304010010712', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243712', 'Malang. 712', 'Islam', 3, 1, NULL, NULL, 'Gratis', '2022-12-23 01:14:42', NULL, NULL, NULL),
(713, 3, 'P20223713', 'Satrio 713', '56419974713', '3276022304010010713', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243713', 'Malang. 713', 'Islam', 13, 3, NULL, NULL, 'Gratis', '2022-12-23 01:14:42', NULL, NULL, NULL),
(714, 2, 'P20222714', 'Satrio 714', '56419974714', '3276022304010010714', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243714', 'Malang. 714', 'Islam', 3, 8, '150000.00', 3, 'Belum', '2022-12-23 01:14:42', NULL, NULL, NULL),
(715, 3, 'P20223715', 'Satrio 715', '56419974715', '3276022304010010715', 'Depok', '2001-12-04', 'Perempuan', '08810243715', 'Malang. 715', 'Islam', 2, 5, NULL, NULL, 'Gratis', '2022-12-23 01:14:42', NULL, NULL, NULL),
(716, 3, 'P20223716', 'Satrio 716', '56419974716', '3276022304010010716', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243716', 'Malang. 716', 'Islam', 10, 1, NULL, NULL, 'Gratis', '2022-12-23 01:14:42', NULL, NULL, NULL),
(717, 3, 'P20223717', 'Satrio 717', '56419974717', '3276022304010010717', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243717', 'Malang. 717', 'Islam', 6, 4, NULL, NULL, 'Gratis', '2022-12-23 01:14:42', NULL, NULL, NULL),
(718, 3, 'P20223718', 'Satrio 718', '56419974718', '3276022304010010718', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243718', 'Malang. 718', 'Islam', 6, 4, NULL, NULL, 'Gratis', '2022-12-23 01:14:42', NULL, NULL, NULL),
(719, 1, 'P20221719', 'Satrio 719', '56419974719', '3276022304010010719', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243719', 'Malang. 719', 'Islam', 3, 5, '150000.00', 3, 'Sudah', '2022-12-23 01:14:43', NULL, NULL, NULL),
(720, 3, 'P20223720', 'Satrio 720', '56419974720', '3276022304010010720', 'Depok', '2001-12-17', 'Perempuan', '08810243720', 'Malang. 720', 'Islam', 3, 10, NULL, NULL, 'Gratis', '2022-12-23 01:14:43', NULL, NULL, NULL),
(721, 1, 'P20221721', 'Satrio 721', '56419974721', '3276022304010010721', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243721', 'Malang. 721', 'Islam', 13, 13, '150000.00', 1, 'Belum', '2022-12-23 01:14:43', NULL, NULL, NULL),
(722, 2, 'P20222722', 'Satrio 722', '56419974722', '3276022304010010722', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243722', 'Malang. 722', 'Islam', 12, 11, '150000.00', 2, 'Sudah', '2022-12-23 01:14:43', NULL, NULL, NULL),
(723, 3, 'P20223723', 'Satrio 723', '56419974723', '3276022304010010723', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243723', 'Malang. 723', 'Islam', 6, 11, NULL, NULL, 'Gratis', '2022-12-23 01:14:43', NULL, NULL, NULL),
(724, 3, 'P20223724', 'Satrio 724', '56419974724', '3276022304010010724', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243724', 'Malang. 724', 'Islam', 3, 11, NULL, NULL, 'Gratis', '2022-12-23 01:14:43', NULL, NULL, NULL),
(725, 3, 'P20223725', 'Satrio 725', '56419974725', '3276022304010010725', 'Depok', '2001-12-10', 'Perempuan', '08810243725', 'Malang. 725', 'Islam', 4, 6, NULL, NULL, 'Gratis', '2022-12-23 01:14:43', NULL, NULL, NULL),
(726, 2, 'P20222726', 'Satrio 726', '56419974726', '3276022304010010726', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243726', 'Malang. 726', 'Islam', 8, 7, '150000.00', 4, 'Sudah', '2022-12-23 01:14:44', NULL, NULL, NULL),
(727, 2, 'P20222727', 'Satrio 727', '56419974727', '3276022304010010727', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243727', 'Malang. 727', 'Islam', 2, 12, '150000.00', 3, 'Sudah', '2022-12-23 01:14:44', NULL, NULL, NULL),
(728, 3, 'P20223728', 'Satrio 728', '56419974728', '3276022304010010728', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243728', 'Malang. 728', 'Islam', 6, 11, NULL, NULL, 'Belum', '2022-12-23 01:14:44', NULL, NULL, NULL),
(729, 2, 'P20222729', 'Satrio 729', '56419974729', '3276022304010010729', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243729', 'Malang. 729', 'Islam', 1, 4, '150000.00', 2, 'Sudah', '2022-12-23 01:14:45', NULL, NULL, NULL),
(730, 3, 'P20223730', 'Satrio 730', '56419974730', '3276022304010010730', 'Depok', '2001-12-09', 'Perempuan', '08810243730', 'Malang. 730', 'Islam', 5, 6, NULL, NULL, 'Gratis', '2022-12-23 01:14:45', NULL, NULL, NULL),
(731, 1, 'P20221731', 'Satrio 731', '56419974731', '3276022304010010731', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243731', 'Malang. 731', 'Islam', 9, 1, '150000.00', 1, 'Sudah', '2022-12-23 01:14:45', NULL, NULL, NULL),
(732, 3, 'P20223732', 'Satrio 732', '56419974732', '3276022304010010732', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243732', 'Malang. 732', 'Islam', 3, 2, NULL, NULL, 'Gratis', '2022-12-23 01:14:45', NULL, NULL, NULL),
(733, 3, 'P20223733', 'Satrio 733', '56419974733', '3276022304010010733', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243733', 'Malang. 733', 'Islam', 5, 11, NULL, NULL, 'Gratis', '2022-12-23 01:14:45', NULL, NULL, NULL),
(734, 3, 'P20223734', 'Satrio 734', '56419974734', '3276022304010010734', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243734', 'Malang. 734', 'Islam', 7, 13, NULL, NULL, 'Gratis', '2022-12-23 01:14:45', NULL, NULL, NULL),
(735, 3, 'P20223735', 'Satrio 735', '56419974735', '3276022304010010735', 'Depok', '2001-12-14', 'Perempuan', '08810243735', 'Malang. 735', 'Islam', 9, 10, NULL, NULL, 'Belum', '2022-12-23 01:14:46', NULL, NULL, NULL),
(736, 1, 'P20221736', 'Satrio 736', '56419974736', '3276022304010010736', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243736', 'Malang. 736', 'Islam', 2, 12, '150000.00', 4, 'Sudah', '2022-12-23 01:14:46', NULL, NULL, NULL),
(737, 1, 'P20221737', 'Satrio 737', '56419974737', '3276022304010010737', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243737', 'Malang. 737', 'Islam', 5, 12, '150000.00', 1, 'Sudah', '2022-12-23 01:14:46', NULL, NULL, NULL),
(738, 1, 'P20221738', 'Satrio 738', '56419974738', '3276022304010010738', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243738', 'Malang. 738', 'Islam', 3, 11, '150000.00', 4, 'Sudah', '2022-12-23 01:14:46', NULL, NULL, NULL),
(739, 2, 'P20222739', 'Satrio 739', '56419974739', '3276022304010010739', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243739', 'Malang. 739', 'Islam', 9, 4, '150000.00', 1, 'Sudah', '2022-12-23 01:14:46', NULL, NULL, NULL),
(740, 1, 'P20221740', 'Satrio 740', '56419974740', '3276022304010010740', 'Depok', '2001-12-08', 'Perempuan', '08810243740', 'Malang. 740', 'Islam', 12, 9, '150000.00', 1, 'Sudah', '2022-12-23 01:14:46', NULL, NULL, NULL),
(741, 3, 'P20223741', 'Satrio 741', '56419974741', '3276022304010010741', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243741', 'Malang. 741', 'Islam', 4, 2, NULL, NULL, 'Gratis', '2022-12-23 01:14:46', NULL, NULL, NULL),
(742, 1, 'P20221742', 'Satrio 742', '56419974742', '3276022304010010742', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243742', 'Malang. 742', 'Islam', 4, 12, '150000.00', 4, 'Belum', '2022-12-23 01:14:46', NULL, NULL, NULL),
(743, 2, 'P20222743', 'Satrio 743', '56419974743', '3276022304010010743', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243743', 'Malang. 743', 'Islam', 7, 8, '150000.00', 1, 'Sudah', '2022-12-23 01:14:46', NULL, NULL, NULL),
(744, 1, 'P20221744', 'Satrio 744', '56419974744', '3276022304010010744', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243744', 'Malang. 744', 'Islam', 8, 4, '150000.00', 2, 'Sudah', '2022-12-23 01:14:46', NULL, NULL, NULL),
(745, 2, 'P20222745', 'Satrio 745', '56419974745', '3276022304010010745', 'Depok', '2001-12-22', 'Perempuan', '08810243745', 'Malang. 745', 'Islam', 13, 3, '150000.00', 1, 'Sudah', '2022-12-23 01:14:46', NULL, NULL, NULL),
(746, 3, 'P20223746', 'Satrio 746', '56419974746', '3276022304010010746', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243746', 'Malang. 746', 'Islam', 2, 5, NULL, NULL, 'Gratis', '2022-12-23 01:14:46', NULL, NULL, NULL),
(747, 2, 'P20222747', 'Satrio 747', '56419974747', '3276022304010010747', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243747', 'Malang. 747', 'Islam', 3, 1, '150000.00', 4, 'Sudah', '2022-12-23 01:14:46', NULL, NULL, NULL),
(748, 2, 'P20222748', 'Satrio 748', '56419974748', '3276022304010010748', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243748', 'Malang. 748', 'Islam', 5, 5, '150000.00', 3, 'Sudah', '2022-12-23 01:14:46', NULL, NULL, NULL),
(749, 3, 'P20223749', 'Satrio 749', '56419974749', '3276022304010010749', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243749', 'Malang. 749', 'Islam', 9, 2, NULL, NULL, 'Belum', '2022-12-23 01:14:46', NULL, NULL, NULL),
(750, 1, 'P20221750', 'Satrio 750', '56419974750', '3276022304010010750', 'Depok', '2001-12-10', 'Perempuan', '08810243750', 'Malang. 750', 'Islam', 2, 1, '150000.00', 1, 'Sudah', '2022-12-23 01:14:47', NULL, NULL, NULL),
(751, 2, 'P20222751', 'Satrio 751', '56419974751', '3276022304010010751', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243751', 'Malang. 751', 'Islam', 1, 1, '150000.00', 3, 'Sudah', '2022-12-23 01:14:47', NULL, NULL, NULL),
(752, 1, 'P20221752', 'Satrio 752', '56419974752', '3276022304010010752', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243752', 'Malang. 752', 'Islam', 4, 5, '150000.00', 1, 'Sudah', '2022-12-23 01:14:47', NULL, NULL, NULL),
(753, 1, 'P20221753', 'Satrio 753', '56419974753', '3276022304010010753', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243753', 'Malang. 753', 'Islam', 12, 10, '150000.00', 2, 'Sudah', '2022-12-23 01:14:47', NULL, NULL, NULL),
(754, 2, 'P20222754', 'Satrio 754', '56419974754', '3276022304010010754', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243754', 'Malang. 754', 'Islam', 11, 6, '150000.00', 2, 'Sudah', '2022-12-23 01:14:47', NULL, NULL, NULL),
(755, 2, 'P20222755', 'Satrio 755', '56419974755', '3276022304010010755', 'Depok', '2001-12-05', 'Perempuan', '08810243755', 'Malang. 755', 'Islam', 9, 8, '150000.00', 2, 'Sudah', '2022-12-23 01:14:47', NULL, NULL, NULL),
(756, 3, 'P20223756', 'Satrio 756', '56419974756', '3276022304010010756', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243756', 'Malang. 756', 'Islam', 8, 12, NULL, NULL, 'Belum', '2022-12-23 01:14:47', NULL, NULL, NULL),
(757, 3, 'P20223757', 'Satrio 757', '56419974757', '3276022304010010757', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243757', 'Malang. 757', 'Islam', 13, 6, NULL, NULL, 'Gratis', '2022-12-23 01:14:47', NULL, NULL, NULL),
(758, 2, 'P20222758', 'Satrio 758', '56419974758', '3276022304010010758', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243758', 'Malang. 758', 'Islam', 11, 3, '150000.00', 2, 'Sudah', '2022-12-23 01:14:47', NULL, NULL, NULL),
(759, 1, 'P20221759', 'Satrio 759', '56419974759', '3276022304010010759', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243759', 'Malang. 759', 'Islam', 4, 6, '150000.00', 1, 'Sudah', '2022-12-23 01:14:47', NULL, NULL, NULL),
(760, 1, 'P20221760', 'Satrio 760', '56419974760', '3276022304010010760', 'Depok', '2001-12-02', 'Perempuan', '08810243760', 'Malang. 760', 'Islam', 8, 10, '150000.00', 3, 'Sudah', '2022-12-23 01:14:47', NULL, NULL, NULL),
(761, 3, 'P20223761', 'Satrio 761', '56419974761', '3276022304010010761', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243761', 'Malang. 761', 'Islam', 8, 7, NULL, NULL, 'Gratis', '2022-12-23 01:14:47', NULL, NULL, NULL),
(762, 3, 'P20223762', 'Satrio 762', '56419974762', '3276022304010010762', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243762', 'Malang. 762', 'Islam', 5, 7, NULL, NULL, 'Gratis', '2022-12-23 01:14:47', NULL, NULL, NULL),
(763, 1, 'P20221763', 'Satrio 763', '56419974763', '3276022304010010763', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243763', 'Malang. 763', 'Islam', 5, 4, '150000.00', 4, 'Belum', '2022-12-23 01:14:48', NULL, NULL, NULL),
(764, 2, 'P20222764', 'Satrio 764', '56419974764', '3276022304010010764', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243764', 'Malang. 764', 'Islam', 7, 9, '150000.00', 4, 'Sudah', '2022-12-23 01:14:48', NULL, NULL, NULL),
(765, 1, 'P20221765', 'Satrio 765', '56419974765', '3276022304010010765', 'Depok', '2001-12-17', 'Perempuan', '08810243765', 'Malang. 765', 'Islam', 13, 1, '150000.00', 1, 'Sudah', '2022-12-23 01:14:48', NULL, NULL, NULL),
(766, 3, 'P20223766', 'Satrio 766', '56419974766', '3276022304010010766', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243766', 'Malang. 766', 'Islam', 7, 6, NULL, NULL, 'Gratis', '2022-12-23 01:14:49', NULL, NULL, NULL),
(767, 3, 'P20223767', 'Satrio 767', '56419974767', '3276022304010010767', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243767', 'Malang. 767', 'Islam', 2, 8, NULL, NULL, 'Gratis', '2022-12-23 01:14:49', NULL, NULL, NULL),
(768, 2, 'P20222768', 'Satrio 768', '56419974768', '3276022304010010768', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243768', 'Malang. 768', 'Islam', 2, 1, '150000.00', 1, 'Sudah', '2022-12-23 01:14:49', NULL, NULL, NULL),
(769, 2, 'P20222769', 'Satrio 769', '56419974769', '3276022304010010769', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243769', 'Malang. 769', 'Islam', 11, 11, '150000.00', 4, 'Sudah', '2022-12-23 01:14:49', NULL, NULL, NULL),
(770, 1, 'P20221770', 'Satrio 770', '56419974770', '3276022304010010770', 'Depok', '2001-12-17', 'Perempuan', '08810243770', 'Malang. 770', 'Islam', 1, 7, '150000.00', 3, 'Belum', '2022-12-23 01:14:49', NULL, NULL, NULL),
(771, 2, 'P20222771', 'Satrio 771', '56419974771', '3276022304010010771', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243771', 'Malang. 771', 'Islam', 13, 9, '150000.00', 1, 'Sudah', '2022-12-23 01:14:50', NULL, NULL, NULL),
(772, 2, 'P20222772', 'Satrio 772', '56419974772', '3276022304010010772', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243772', 'Malang. 772', 'Islam', 8, 1, '150000.00', 3, 'Sudah', '2022-12-23 01:14:50', NULL, NULL, NULL),
(773, 1, 'P20221773', 'Satrio 773', '56419974773', '3276022304010010773', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243773', 'Malang. 773', 'Islam', 12, 12, '150000.00', 1, 'Sudah', '2022-12-23 01:14:50', NULL, NULL, NULL),
(774, 1, 'P20221774', 'Satrio 774', '56419974774', '3276022304010010774', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243774', 'Malang. 774', 'Islam', 12, 11, '150000.00', 3, 'Sudah', '2022-12-23 01:14:50', NULL, NULL, NULL),
(775, 1, 'P20221775', 'Satrio 775', '56419974775', '3276022304010010775', 'Depok', '2001-12-17', 'Perempuan', '08810243775', 'Malang. 775', 'Islam', 4, 5, '150000.00', 1, 'Sudah', '2022-12-23 01:14:50', NULL, NULL, NULL),
(776, 1, 'P20221776', 'Satrio 776', '56419974776', '3276022304010010776', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243776', 'Malang. 776', 'Islam', 13, 8, '150000.00', 3, 'Sudah', '2022-12-23 01:14:51', NULL, NULL, NULL),
(777, 3, 'P20223777', 'Satrio 777', '56419974777', '3276022304010010777', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243777', 'Malang. 777', 'Islam', 4, 7, NULL, NULL, 'Belum', '2022-12-23 01:14:51', NULL, NULL, NULL),
(778, 2, 'P20222778', 'Satrio 778', '56419974778', '3276022304010010778', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243778', 'Malang. 778', 'Islam', 10, 7, '150000.00', 1, 'Sudah', '2022-12-23 01:14:51', NULL, NULL, NULL),
(779, 1, 'P20221779', 'Satrio 779', '56419974779', '3276022304010010779', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243779', 'Malang. 779', 'Islam', 13, 6, '150000.00', 3, 'Sudah', '2022-12-23 01:14:51', NULL, NULL, NULL),
(780, 2, 'P20222780', 'Satrio 780', '56419974780', '3276022304010010780', 'Depok', '2001-12-17', 'Perempuan', '08810243780', 'Malang. 780', 'Islam', 4, 11, '150000.00', 4, 'Sudah', '2022-12-23 01:14:51', NULL, NULL, NULL),
(781, 2, 'P20222781', 'Satrio 781', '56419974781', '3276022304010010781', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243781', 'Malang. 781', 'Islam', 13, 6, '150000.00', 2, 'Sudah', '2022-12-23 01:14:51', NULL, NULL, NULL),
(782, 3, 'P20223782', 'Satrio 782', '56419974782', '3276022304010010782', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243782', 'Malang. 782', 'Islam', 7, 12, NULL, NULL, 'Gratis', '2022-12-23 01:14:51', NULL, NULL, NULL),
(783, 1, 'P20221783', 'Satrio 783', '56419974783', '3276022304010010783', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243783', 'Malang. 783', 'Islam', 6, 6, '150000.00', 1, 'Sudah', '2022-12-23 01:14:51', NULL, NULL, NULL),
(784, 3, 'P20223784', 'Satrio 784', '56419974784', '3276022304010010784', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243784', 'Malang. 784', 'Islam', 12, 11, NULL, NULL, 'Belum', '2022-12-23 01:14:51', NULL, NULL, NULL),
(785, 3, 'P20223785', 'Satrio 785', '56419974785', '3276022304010010785', 'Depok', '2001-12-31', 'Perempuan', '08810243785', 'Malang. 785', 'Islam', 2, 7, NULL, NULL, 'Gratis', '2022-12-23 01:14:51', NULL, NULL, NULL),
(786, 3, 'P20223786', 'Satrio 786', '56419974786', '3276022304010010786', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243786', 'Malang. 786', 'Islam', 8, 6, NULL, NULL, 'Gratis', '2022-12-23 01:14:52', NULL, NULL, NULL),
(787, 1, 'P20221787', 'Satrio 787', '56419974787', '3276022304010010787', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243787', 'Malang. 787', 'Islam', 11, 4, '150000.00', 4, 'Sudah', '2022-12-23 01:14:52', NULL, NULL, NULL),
(788, 1, 'P20221788', 'Satrio 788', '56419974788', '3276022304010010788', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243788', 'Malang. 788', 'Islam', 12, 10, '150000.00', 4, 'Sudah', '2022-12-23 01:14:52', NULL, NULL, NULL),
(789, 3, 'P20223789', 'Satrio 789', '56419974789', '3276022304010010789', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243789', 'Malang. 789', 'Islam', 11, 10, NULL, NULL, 'Gratis', '2022-12-23 01:14:52', NULL, NULL, NULL),
(790, 1, 'P20221790', 'Satrio 790', '56419974790', '3276022304010010790', 'Depok', '2001-12-23', 'Perempuan', '08810243790', 'Malang. 790', 'Islam', 10, 4, '150000.00', 3, 'Sudah', '2022-12-23 01:14:52', NULL, NULL, NULL),
(791, 3, 'P20223791', 'Satrio 791', '56419974791', '3276022304010010791', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243791', 'Malang. 791', 'Islam', 9, 3, NULL, NULL, 'Belum', '2022-12-23 01:14:52', NULL, NULL, NULL),
(792, 3, 'P20223792', 'Satrio 792', '56419974792', '3276022304010010792', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243792', 'Malang. 792', 'Islam', 4, 8, NULL, NULL, 'Gratis', '2022-12-23 01:14:52', NULL, NULL, NULL),
(793, 3, 'P20223793', 'Satrio 793', '56419974793', '3276022304010010793', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243793', 'Malang. 793', 'Islam', 1, 13, NULL, NULL, 'Gratis', '2022-12-23 01:14:52', NULL, NULL, NULL),
(794, 3, 'P20223794', 'Satrio 794', '56419974794', '3276022304010010794', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243794', 'Malang. 794', 'Islam', 7, 4, NULL, NULL, 'Gratis', '2022-12-23 01:14:52', NULL, NULL, NULL),
(795, 3, 'P20223795', 'Satrio 795', '56419974795', '3276022304010010795', 'Depok', '2001-12-24', 'Perempuan', '08810243795', 'Malang. 795', 'Islam', 6, 7, NULL, NULL, 'Gratis', '2022-12-23 01:14:53', NULL, NULL, NULL),
(796, 3, 'P20223796', 'Satrio 796', '56419974796', '3276022304010010796', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243796', 'Malang. 796', 'Islam', 12, 4, NULL, NULL, 'Gratis', '2022-12-23 01:14:53', NULL, NULL, NULL),
(797, 2, 'P20222797', 'Satrio 797', '56419974797', '3276022304010010797', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243797', 'Malang. 797', 'Islam', 11, 1, '150000.00', 4, 'Sudah', '2022-12-23 01:14:53', NULL, NULL, NULL),
(798, 1, 'P20221798', 'Satrio 798', '56419974798', '3276022304010010798', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243798', 'Malang. 798', 'Islam', 9, 9, '150000.00', 2, 'Belum', '2022-12-23 01:14:53', NULL, NULL, NULL),
(799, 2, 'P20222799', 'Satrio 799', '56419974799', '3276022304010010799', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243799', 'Malang. 799', 'Islam', 2, 11, '150000.00', 1, 'Sudah', '2022-12-23 01:14:53', NULL, NULL, NULL),
(800, 3, 'P20223800', 'Satrio 800', '56419974800', '3276022304010010800', 'Depok', '2001-12-05', 'Perempuan', '08810243800', 'Malang. 800', 'Islam', 6, 10, NULL, NULL, 'Gratis', '2022-12-23 01:14:53', NULL, NULL, NULL),
(801, 3, 'P20223801', 'Satrio 801', '56419974801', '3276022304010010801', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243801', 'Malang. 801', 'Islam', 1, 6, NULL, NULL, 'Gratis', '2022-12-23 01:14:53', NULL, NULL, NULL),
(802, 1, 'P20221802', 'Satrio 802', '56419974802', '3276022304010010802', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243802', 'Malang. 802', 'Islam', 6, 8, '150000.00', 1, 'Sudah', '2022-12-23 01:14:53', NULL, NULL, NULL),
(803, 1, 'P20221803', 'Satrio 803', '56419974803', '3276022304010010803', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243803', 'Malang. 803', 'Islam', 13, 3, '150000.00', 3, 'Sudah', '2022-12-23 01:14:54', NULL, NULL, NULL),
(804, 1, 'P20221804', 'Satrio 804', '56419974804', '3276022304010010804', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243804', 'Malang. 804', 'Islam', 1, 1, '150000.00', 2, 'Sudah', '2022-12-23 01:14:54', NULL, NULL, NULL),
(805, 3, 'P20223805', 'Satrio 805', '56419974805', '3276022304010010805', 'Depok', '2001-12-23', 'Perempuan', '08810243805', 'Malang. 805', 'Islam', 4, 10, NULL, NULL, 'Belum', '2022-12-23 01:14:54', NULL, NULL, NULL),
(806, 3, 'P20223806', 'Satrio 806', '56419974806', '3276022304010010806', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243806', 'Malang. 806', 'Islam', 3, 4, NULL, NULL, 'Gratis', '2022-12-23 01:14:54', NULL, NULL, NULL),
(807, 3, 'P20223807', 'Satrio 807', '56419974807', '3276022304010010807', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243807', 'Malang. 807', 'Islam', 11, 1, NULL, NULL, 'Gratis', '2022-12-23 01:14:54', NULL, NULL, NULL),
(808, 1, 'P20221808', 'Satrio 808', '56419974808', '3276022304010010808', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243808', 'Malang. 808', 'Islam', 7, 3, '150000.00', 4, 'Sudah', '2022-12-23 01:14:54', NULL, NULL, NULL),
(809, 2, 'P20222809', 'Satrio 809', '56419974809', '3276022304010010809', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243809', 'Malang. 809', 'Islam', 4, 7, '150000.00', 4, 'Sudah', '2022-12-23 01:14:54', NULL, NULL, NULL),
(810, 3, 'P20223810', 'Satrio 810', '56419974810', '3276022304010010810', 'Depok', '2001-12-18', 'Perempuan', '08810243810', 'Malang. 810', 'Islam', 11, 10, NULL, NULL, 'Gratis', '2022-12-23 01:14:55', NULL, NULL, NULL),
(811, 1, 'P20221811', 'Satrio 811', '56419974811', '3276022304010010811', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243811', 'Malang. 811', 'Islam', 13, 13, '150000.00', 2, 'Sudah', '2022-12-23 01:14:55', NULL, NULL, NULL),
(812, 1, 'P20221812', 'Satrio 812', '56419974812', '3276022304010010812', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243812', 'Malang. 812', 'Islam', 11, 1, '150000.00', 1, 'Belum', '2022-12-23 01:14:55', NULL, NULL, NULL),
(813, 3, 'P20223813', 'Satrio 813', '56419974813', '3276022304010010813', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243813', 'Malang. 813', 'Islam', 13, 7, NULL, NULL, 'Gratis', '2022-12-23 01:14:55', NULL, NULL, NULL),
(814, 2, 'P20222814', 'Satrio 814', '56419974814', '3276022304010010814', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243814', 'Malang. 814', 'Islam', 4, 10, '150000.00', 4, 'Sudah', '2022-12-23 01:14:55', NULL, NULL, NULL),
(815, 2, 'P20222815', 'Satrio 815', '56419974815', '3276022304010010815', 'Depok', '2001-12-30', 'Perempuan', '08810243815', 'Malang. 815', 'Islam', 10, 10, '150000.00', 2, 'Sudah', '2022-12-23 01:14:55', NULL, NULL, NULL),
(816, 3, 'P20223816', 'Satrio 816', '56419974816', '3276022304010010816', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243816', 'Malang. 816', 'Islam', 4, 4, NULL, NULL, 'Gratis', '2022-12-23 01:14:55', NULL, NULL, NULL),
(817, 2, 'P20222817', 'Satrio 817', '56419974817', '3276022304010010817', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243817', 'Malang. 817', 'Islam', 10, 7, '150000.00', 3, 'Sudah', '2022-12-23 01:14:55', NULL, NULL, NULL),
(818, 3, 'P20223818', 'Satrio 818', '56419974818', '3276022304010010818', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243818', 'Malang. 818', 'Islam', 8, 1, NULL, NULL, 'Gratis', '2022-12-23 01:14:55', NULL, NULL, NULL),
(819, 2, 'P20222819', 'Satrio 819', '56419974819', '3276022304010010819', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243819', 'Malang. 819', 'Islam', 2, 9, '150000.00', 1, 'Belum', '2022-12-23 01:14:55', NULL, NULL, NULL),
(820, 3, 'P20223820', 'Satrio 820', '56419974820', '3276022304010010820', 'Depok', '2001-12-19', 'Perempuan', '08810243820', 'Malang. 820', 'Islam', 2, 5, NULL, NULL, 'Gratis', '2022-12-23 01:14:55', NULL, NULL, NULL),
(821, 1, 'P20221821', 'Satrio 821', '56419974821', '3276022304010010821', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243821', 'Malang. 821', 'Islam', 7, 1, '150000.00', 2, 'Sudah', '2022-12-23 01:14:55', NULL, NULL, NULL),
(822, 3, 'P20223822', 'Satrio 822', '56419974822', '3276022304010010822', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243822', 'Malang. 822', 'Islam', 3, 4, NULL, NULL, 'Gratis', '2022-12-23 01:14:55', NULL, NULL, NULL),
(823, 1, 'P20221823', 'Satrio 823', '56419974823', '3276022304010010823', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243823', 'Malang. 823', 'Islam', 9, 9, '150000.00', 1, 'Sudah', '2022-12-23 01:14:56', NULL, NULL, NULL),
(824, 1, 'P20221824', 'Satrio 824', '56419974824', '3276022304010010824', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243824', 'Malang. 824', 'Islam', 2, 11, '150000.00', 1, 'Sudah', '2022-12-23 01:14:56', NULL, NULL, NULL),
(825, 3, 'P20223825', 'Satrio 825', '56419974825', '3276022304010010825', 'Depok', '2001-12-27', 'Perempuan', '08810243825', 'Malang. 825', 'Islam', 12, 10, NULL, NULL, 'Gratis', '2022-12-23 01:14:56', NULL, NULL, NULL),
(826, 1, 'P20221826', 'Satrio 826', '56419974826', '3276022304010010826', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243826', 'Malang. 826', 'Islam', 7, 8, '150000.00', 3, 'Belum', '2022-12-23 01:14:56', NULL, NULL, NULL),
(827, 3, 'P20223827', 'Satrio 827', '56419974827', '3276022304010010827', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243827', 'Malang. 827', 'Islam', 1, 10, NULL, NULL, 'Gratis', '2022-12-23 01:14:56', NULL, NULL, NULL),
(828, 1, 'P20221828', 'Satrio 828', '56419974828', '3276022304010010828', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243828', 'Malang. 828', 'Islam', 8, 10, '150000.00', 3, 'Sudah', '2022-12-23 01:14:56', NULL, NULL, NULL),
(829, 1, 'P20221829', 'Satrio 829', '56419974829', '3276022304010010829', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243829', 'Malang. 829', 'Islam', 4, 5, '150000.00', 2, 'Sudah', '2022-12-23 01:14:56', NULL, NULL, NULL),
(830, 1, 'P20221830', 'Satrio 830', '56419974830', '3276022304010010830', 'Depok', '2001-12-27', 'Perempuan', '08810243830', 'Malang. 830', 'Islam', 8, 2, '150000.00', 1, 'Sudah', '2022-12-23 01:14:56', NULL, NULL, NULL),
(831, 1, 'P20221831', 'Satrio 831', '56419974831', '3276022304010010831', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243831', 'Malang. 831', 'Islam', 3, 7, '150000.00', 1, 'Sudah', '2022-12-23 01:14:56', NULL, NULL, NULL),
(832, 3, 'P20223832', 'Satrio 832', '56419974832', '3276022304010010832', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243832', 'Malang. 832', 'Islam', 6, 7, NULL, NULL, 'Gratis', '2022-12-23 01:14:56', NULL, NULL, NULL),
(833, 1, 'P20221833', 'Satrio 833', '56419974833', '3276022304010010833', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243833', 'Malang. 833', 'Islam', 6, 6, '150000.00', 1, 'Belum', '2022-12-23 01:14:56', NULL, NULL, NULL),
(834, 3, 'P20223834', 'Satrio 834', '56419974834', '3276022304010010834', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243834', 'Malang. 834', 'Islam', 8, 5, NULL, NULL, 'Gratis', '2022-12-23 01:14:56', NULL, NULL, NULL),
(835, 3, 'P20223835', 'Satrio 835', '56419974835', '3276022304010010835', 'Depok', '2001-12-08', 'Perempuan', '08810243835', 'Malang. 835', 'Islam', 8, 10, NULL, NULL, 'Gratis', '2022-12-23 01:14:56', NULL, NULL, NULL),
(836, 1, 'P20221836', 'Satrio 836', '56419974836', '3276022304010010836', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243836', 'Malang. 836', 'Islam', 13, 7, '150000.00', 2, 'Sudah', '2022-12-23 01:14:56', NULL, NULL, NULL),
(837, 3, 'P20223837', 'Satrio 837', '56419974837', '3276022304010010837', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243837', 'Malang. 837', 'Islam', 1, 11, NULL, NULL, 'Gratis', '2022-12-23 01:14:57', NULL, NULL, NULL),
(838, 2, 'P20222838', 'Satrio 838', '56419974838', '3276022304010010838', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243838', 'Malang. 838', 'Islam', 10, 2, '150000.00', 2, 'Sudah', '2022-12-23 01:14:57', NULL, NULL, NULL),
(839, 3, 'P20223839', 'Satrio 839', '56419974839', '3276022304010010839', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243839', 'Malang. 839', 'Islam', 11, 4, NULL, NULL, 'Gratis', '2022-12-23 01:14:57', NULL, NULL, NULL),
(840, 3, 'P20223840', 'Satrio 840', '56419974840', '3276022304010010840', 'Depok', '2001-12-11', 'Perempuan', '08810243840', 'Malang. 840', 'Islam', 1, 10, NULL, NULL, 'Belum', '2022-12-23 01:14:57', NULL, NULL, NULL),
(841, 2, 'P20222841', 'Satrio 841', '56419974841', '3276022304010010841', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243841', 'Malang. 841', 'Islam', 5, 13, '150000.00', 3, 'Sudah', '2022-12-23 01:14:57', NULL, NULL, NULL),
(842, 2, 'P20222842', 'Satrio 842', '56419974842', '3276022304010010842', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243842', 'Malang. 842', 'Islam', 10, 10, '150000.00', 1, 'Sudah', '2022-12-23 01:14:57', NULL, NULL, NULL),
(843, 3, 'P20223843', 'Satrio 843', '56419974843', '3276022304010010843', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243843', 'Malang. 843', 'Islam', 1, 13, NULL, NULL, 'Gratis', '2022-12-23 01:14:57', NULL, NULL, NULL),
(844, 1, 'P20221844', 'Satrio 844', '56419974844', '3276022304010010844', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243844', 'Malang. 844', 'Islam', 5, 7, '150000.00', 4, 'Sudah', '2022-12-23 01:14:57', NULL, NULL, NULL),
(845, 2, 'P20222845', 'Satrio 845', '56419974845', '3276022304010010845', 'Depok', '2001-12-21', 'Perempuan', '08810243845', 'Malang. 845', 'Islam', 7, 1, '150000.00', 2, 'Sudah', '2022-12-23 01:14:57', NULL, NULL, NULL),
(846, 2, 'P20222846', 'Satrio 846', '56419974846', '3276022304010010846', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243846', 'Malang. 846', 'Islam', 4, 8, '150000.00', 1, 'Sudah', '2022-12-23 01:14:57', NULL, NULL, NULL),
(847, 2, 'P20222847', 'Satrio 847', '56419974847', '3276022304010010847', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243847', 'Malang. 847', 'Islam', 13, 2, '150000.00', 3, 'Belum', '2022-12-23 01:14:57', NULL, NULL, NULL),
(848, 3, 'P20223848', 'Satrio 848', '56419974848', '3276022304010010848', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243848', 'Malang. 848', 'Islam', 10, 10, NULL, NULL, 'Gratis', '2022-12-23 01:14:57', NULL, NULL, NULL),
(849, 2, 'P20222849', 'Satrio 849', '56419974849', '3276022304010010849', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243849', 'Malang. 849', 'Islam', 8, 12, '150000.00', 2, 'Sudah', '2022-12-23 01:14:58', NULL, NULL, NULL),
(850, 1, 'P20221850', 'Satrio 850', '56419974850', '3276022304010010850', 'Depok', '2001-12-06', 'Perempuan', '08810243850', 'Malang. 850', 'Islam', 1, 13, '150000.00', 4, 'Sudah', '2022-12-23 01:14:58', NULL, NULL, NULL),
(851, 1, 'P20221851', 'Satrio 851', '56419974851', '3276022304010010851', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243851', 'Malang. 851', 'Islam', 2, 2, '150000.00', 2, 'Sudah', '2022-12-23 01:14:58', NULL, NULL, NULL),
(852, 3, 'P20223852', 'Satrio 852', '56419974852', '3276022304010010852', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243852', 'Malang. 852', 'Islam', 9, 12, NULL, NULL, 'Gratis', '2022-12-23 01:14:58', NULL, NULL, NULL),
(853, 1, 'P20221853', 'Satrio 853', '56419974853', '3276022304010010853', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243853', 'Malang. 853', 'Islam', 13, 10, '150000.00', 1, 'Sudah', '2022-12-23 01:14:58', NULL, NULL, NULL),
(854, 2, 'P20222854', 'Satrio 854', '56419974854', '3276022304010010854', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243854', 'Malang. 854', 'Islam', 13, 13, '150000.00', 1, 'Belum', '2022-12-23 01:14:58', NULL, NULL, NULL),
(855, 2, 'P20222855', 'Satrio 855', '56419974855', '3276022304010010855', 'Depok', '2001-12-02', 'Perempuan', '08810243855', 'Malang. 855', 'Islam', 6, 12, '150000.00', 3, 'Sudah', '2022-12-23 01:14:58', NULL, NULL, NULL),
(856, 3, 'P20223856', 'Satrio 856', '56419974856', '3276022304010010856', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243856', 'Malang. 856', 'Islam', 10, 2, NULL, NULL, 'Gratis', '2022-12-23 01:14:58', NULL, NULL, NULL),
(857, 2, 'P20222857', 'Satrio 857', '56419974857', '3276022304010010857', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243857', 'Malang. 857', 'Islam', 3, 3, '150000.00', 1, 'Sudah', '2022-12-23 01:14:58', NULL, NULL, NULL),
(858, 1, 'P20221858', 'Satrio 858', '56419974858', '3276022304010010858', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243858', 'Malang. 858', 'Islam', 10, 13, '150000.00', 4, 'Sudah', '2022-12-23 01:14:58', NULL, NULL, NULL),
(859, 2, 'P20222859', 'Satrio 859', '56419974859', '3276022304010010859', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243859', 'Malang. 859', 'Islam', 6, 7, '150000.00', 1, 'Sudah', '2022-12-23 01:14:58', NULL, NULL, NULL),
(860, 3, 'P20223860', 'Satrio 860', '56419974860', '3276022304010010860', 'Depok', '2001-12-30', 'Perempuan', '08810243860', 'Malang. 860', 'Islam', 13, 10, NULL, NULL, 'Gratis', '2022-12-23 01:14:58', NULL, NULL, NULL),
(861, 3, 'P20223861', 'Satrio 861', '56419974861', '3276022304010010861', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243861', 'Malang. 861', 'Islam', 3, 4, NULL, NULL, 'Belum', '2022-12-23 01:14:58', NULL, NULL, NULL),
(862, 3, 'P20223862', 'Satrio 862', '56419974862', '3276022304010010862', 'Jakarta', '2001-12-18', 'Laki-Laki', '08810243862', 'Malang. 862', 'Islam', 13, 6, NULL, NULL, 'Gratis', '2022-12-23 01:14:59', NULL, NULL, NULL),
(863, 1, 'P20221863', 'Satrio 863', '56419974863', '3276022304010010863', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243863', 'Malang. 863', 'Islam', 5, 1, '150000.00', 3, 'Sudah', '2022-12-23 01:14:59', NULL, NULL, NULL),
(864, 2, 'P20222864', 'Satrio 864', '56419974864', '3276022304010010864', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243864', 'Malang. 864', 'Islam', 10, 12, '150000.00', 3, 'Sudah', '2022-12-23 01:14:59', NULL, NULL, NULL),
(865, 1, 'P20221865', 'Satrio 865', '56419974865', '3276022304010010865', 'Depok', '2001-12-22', 'Perempuan', '08810243865', 'Malang. 865', 'Islam', 7, 10, '150000.00', 2, 'Sudah', '2022-12-23 01:14:59', NULL, NULL, NULL),
(866, 1, 'P20221866', 'Satrio 866', '56419974866', '3276022304010010866', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243866', 'Malang. 866', 'Islam', 5, 6, '150000.00', 1, 'Sudah', '2022-12-23 01:14:59', NULL, NULL, NULL),
(867, 3, 'P20223867', 'Satrio 867', '56419974867', '3276022304010010867', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243867', 'Malang. 867', 'Islam', 8, 3, NULL, NULL, 'Gratis', '2022-12-23 01:14:59', NULL, NULL, NULL),
(868, 3, 'P20223868', 'Satrio 868', '56419974868', '3276022304010010868', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243868', 'Malang. 868', 'Islam', 2, 9, NULL, NULL, 'Belum', '2022-12-23 01:14:59', NULL, NULL, NULL),
(869, 3, 'P20223869', 'Satrio 869', '56419974869', '3276022304010010869', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243869', 'Malang. 869', 'Islam', 12, 6, NULL, NULL, 'Gratis', '2022-12-23 01:14:59', NULL, NULL, NULL),
(870, 1, 'P20221870', 'Satrio 870', '56419974870', '3276022304010010870', 'Depok', '2001-12-04', 'Perempuan', '08810243870', 'Malang. 870', 'Islam', 4, 9, '150000.00', 1, 'Sudah', '2022-12-23 01:14:59', NULL, NULL, NULL),
(871, 3, 'P20223871', 'Satrio 871', '56419974871', '3276022304010010871', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243871', 'Malang. 871', 'Islam', 9, 9, NULL, NULL, 'Gratis', '2022-12-23 01:14:59', NULL, NULL, NULL),
(872, 2, 'P20222872', 'Satrio 872', '56419974872', '3276022304010010872', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243872', 'Malang. 872', 'Islam', 8, 7, '150000.00', 4, 'Sudah', '2022-12-23 01:14:59', NULL, NULL, NULL),
(873, 3, 'P20223873', 'Satrio 873', '56419974873', '3276022304010010873', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243873', 'Malang. 873', 'Islam', 12, 12, NULL, NULL, 'Gratis', '2022-12-23 01:15:00', NULL, NULL, NULL),
(874, 3, 'P20223874', 'Satrio 874', '56419974874', '3276022304010010874', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243874', 'Malang. 874', 'Islam', 6, 4, NULL, NULL, 'Gratis', '2022-12-23 01:15:00', NULL, NULL, NULL),
(875, 2, 'P20222875', 'Satrio 875', '56419974875', '3276022304010010875', 'Depok', '2001-12-06', 'Perempuan', '08810243875', 'Malang. 875', 'Islam', 9, 9, '150000.00', 4, 'Belum', '2022-12-23 01:15:00', NULL, NULL, NULL),
(876, 3, 'P20223876', 'Satrio 876', '56419974876', '3276022304010010876', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243876', 'Malang. 876', 'Islam', 4, 12, NULL, NULL, 'Gratis', '2022-12-23 01:15:00', NULL, NULL, NULL),
(877, 3, 'P20223877', 'Satrio 877', '56419974877', '3276022304010010877', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243877', 'Malang. 877', 'Islam', 10, 2, NULL, NULL, 'Gratis', '2022-12-23 01:15:00', NULL, NULL, NULL),
(878, 2, 'P20222878', 'Satrio 878', '56419974878', '3276022304010010878', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243878', 'Malang. 878', 'Islam', 2, 10, '150000.00', 1, 'Sudah', '2022-12-23 01:15:00', NULL, NULL, NULL),
(879, 1, 'P20221879', 'Satrio 879', '56419974879', '3276022304010010879', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243879', 'Malang. 879', 'Islam', 4, 3, '150000.00', 2, 'Sudah', '2022-12-23 01:15:00', NULL, NULL, NULL),
(880, 1, 'P20221880', 'Satrio 880', '56419974880', '3276022304010010880', 'Depok', '2001-12-13', 'Perempuan', '08810243880', 'Malang. 880', 'Islam', 6, 10, '150000.00', 3, 'Sudah', '2022-12-23 01:15:00', NULL, NULL, NULL),
(881, 2, 'P20222881', 'Satrio 881', '56419974881', '3276022304010010881', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243881', 'Malang. 881', 'Islam', 13, 8, '150000.00', 4, 'Sudah', '2022-12-23 01:15:00', NULL, NULL, NULL),
(882, 3, 'P20223882', 'Satrio 882', '56419974882', '3276022304010010882', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243882', 'Malang. 882', 'Islam', 2, 9, NULL, NULL, 'Belum', '2022-12-23 01:15:00', NULL, NULL, NULL),
(883, 3, 'P20223883', 'Satrio 883', '56419974883', '3276022304010010883', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243883', 'Malang. 883', 'Islam', 8, 6, NULL, NULL, 'Gratis', '2022-12-23 01:15:00', NULL, NULL, NULL),
(884, 2, 'P20222884', 'Satrio 884', '56419974884', '3276022304010010884', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243884', 'Malang. 884', 'Islam', 12, 4, '150000.00', 3, 'Sudah', '2022-12-23 01:15:00', NULL, NULL, NULL),
(885, 1, 'P20221885', 'Satrio 885', '56419974885', '3276022304010010885', 'Depok', '2001-12-15', 'Perempuan', '08810243885', 'Malang. 885', 'Islam', 8, 6, '150000.00', 1, 'Sudah', '2022-12-23 01:15:01', NULL, NULL, NULL),
(886, 3, 'P20223886', 'Satrio 886', '56419974886', '3276022304010010886', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243886', 'Malang. 886', 'Islam', 4, 8, NULL, NULL, 'Gratis', '2022-12-23 01:15:01', NULL, NULL, NULL),
(887, 1, 'P20221887', 'Satrio 887', '56419974887', '3276022304010010887', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243887', 'Malang. 887', 'Islam', 8, 5, '150000.00', 3, 'Sudah', '2022-12-23 01:15:01', NULL, NULL, NULL),
(888, 3, 'P20223888', 'Satrio 888', '56419974888', '3276022304010010888', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243888', 'Malang. 888', 'Islam', 13, 4, NULL, NULL, 'Gratis', '2022-12-23 01:15:01', NULL, NULL, NULL),
(889, 2, 'P20222889', 'Satrio 889', '56419974889', '3276022304010010889', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243889', 'Malang. 889', 'Islam', 8, 7, '150000.00', 4, 'Belum', '2022-12-23 01:15:01', NULL, NULL, NULL),
(890, 2, 'P20222890', 'Satrio 890', '56419974890', '3276022304010010890', 'Depok', '2001-12-14', 'Perempuan', '08810243890', 'Malang. 890', 'Islam', 9, 2, '150000.00', 3, 'Sudah', '2022-12-23 01:15:01', NULL, NULL, NULL),
(891, 1, 'P20221891', 'Satrio 891', '56419974891', '3276022304010010891', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243891', 'Malang. 891', 'Islam', 9, 3, '150000.00', 2, 'Sudah', '2022-12-23 01:15:02', NULL, NULL, NULL),
(892, 1, 'P20221892', 'Satrio 892', '56419974892', '3276022304010010892', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243892', 'Malang. 892', 'Islam', 8, 5, '150000.00', 4, 'Sudah', '2022-12-23 01:15:02', NULL, NULL, NULL),
(893, 3, 'P20223893', 'Satrio 893', '56419974893', '3276022304010010893', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243893', 'Malang. 893', 'Islam', 10, 9, NULL, NULL, 'Gratis', '2022-12-23 01:15:02', NULL, NULL, NULL),
(894, 2, 'P20222894', 'Satrio 894', '56419974894', '3276022304010010894', 'Jakarta', '2001-12-28', 'Laki-Laki', '08810243894', 'Malang. 894', 'Islam', 10, 6, '150000.00', 2, 'Sudah', '2022-12-23 01:15:02', NULL, NULL, NULL),
(895, 1, 'P20221895', 'Satrio 895', '56419974895', '3276022304010010895', 'Depok', '2001-12-26', 'Perempuan', '08810243895', 'Malang. 895', 'Islam', 12, 4, '150000.00', 3, 'Sudah', '2022-12-23 01:15:02', NULL, NULL, NULL),
(896, 1, 'P20221896', 'Satrio 896', '56419974896', '3276022304010010896', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243896', 'Malang. 896', 'Islam', 2, 12, '150000.00', 2, 'Belum', '2022-12-23 01:15:02', NULL, NULL, NULL),
(897, 3, 'P20223897', 'Satrio 897', '56419974897', '3276022304010010897', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243897', 'Malang. 897', 'Islam', 2, 5, NULL, NULL, 'Gratis', '2022-12-23 01:15:02', NULL, NULL, NULL),
(898, 1, 'P20221898', 'Satrio 898', '56419974898', '3276022304010010898', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243898', 'Malang. 898', 'Islam', 9, 10, '150000.00', 4, 'Sudah', '2022-12-23 01:15:02', NULL, NULL, NULL),
(899, 3, 'P20223899', 'Satrio 899', '56419974899', '3276022304010010899', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243899', 'Malang. 899', 'Islam', 3, 3, NULL, NULL, 'Gratis', '2022-12-23 01:15:02', NULL, NULL, NULL),
(900, 2, 'P20222900', 'Satrio 900', '56419974900', '3276022304010010900', 'Depok', '2001-12-07', 'Perempuan', '08810243900', 'Malang. 900', 'Islam', 3, 6, '150000.00', 3, 'Sudah', '2022-12-23 01:15:02', NULL, NULL, NULL);
INSERT INTO `pendaftar` (`id_pendaftar`, `id_jalur`, `no_pendaftar`, `nama`, `nisn`, `nik`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `no_hp`, `alamat`, `agama`, `id_prodi1`, `id_prodi2`, `nominal_bayar`, `id_bank`, `status_bayar`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(901, 3, 'P20223901', 'Satrio 901', '56419974901', '3276022304010010901', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243901', 'Malang. 901', 'Islam', 8, 3, NULL, NULL, 'Gratis', '2022-12-23 01:15:02', NULL, NULL, NULL),
(902, 2, 'P20222902', 'Satrio 902', '56419974902', '3276022304010010902', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243902', 'Malang. 902', 'Islam', 7, 7, '150000.00', 4, 'Sudah', '2022-12-23 01:15:03', NULL, NULL, NULL),
(903, 3, 'P20223903', 'Satrio 903', '56419974903', '3276022304010010903', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243903', 'Malang. 903', 'Islam', 5, 8, NULL, NULL, 'Belum', '2022-12-23 01:15:03', NULL, NULL, NULL),
(904, 2, 'P20222904', 'Satrio 904', '56419974904', '3276022304010010904', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243904', 'Malang. 904', 'Islam', 11, 1, '150000.00', 2, 'Sudah', '2022-12-23 01:15:03', NULL, NULL, NULL),
(905, 1, 'P20221905', 'Satrio 905', '56419974905', '3276022304010010905', 'Depok', '2001-12-02', 'Perempuan', '08810243905', 'Malang. 905', 'Islam', 5, 11, '150000.00', 4, 'Sudah', '2022-12-23 01:15:03', NULL, NULL, NULL),
(906, 2, 'P20222906', 'Satrio 906', '56419974906', '3276022304010010906', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243906', 'Malang. 906', 'Islam', 10, 10, '150000.00', 2, 'Sudah', '2022-12-23 01:15:03', NULL, NULL, NULL),
(907, 1, 'P20221907', 'Satrio 907', '56419974907', '3276022304010010907', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243907', 'Malang. 907', 'Islam', 1, 11, '150000.00', 4, 'Sudah', '2022-12-23 01:15:03', NULL, NULL, NULL),
(908, 2, 'P20222908', 'Satrio 908', '56419974908', '3276022304010010908', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243908', 'Malang. 908', 'Islam', 4, 9, '150000.00', 3, 'Sudah', '2022-12-23 01:15:03', NULL, NULL, NULL),
(909, 1, 'P20221909', 'Satrio 909', '56419974909', '3276022304010010909', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243909', 'Malang. 909', 'Islam', 3, 5, '150000.00', 2, 'Sudah', '2022-12-23 01:15:03', NULL, NULL, NULL),
(910, 3, 'P20223910', 'Satrio 910', '56419974910', '3276022304010010910', 'Depok', '2001-12-22', 'Perempuan', '08810243910', 'Malang. 910', 'Islam', 5, 8, NULL, NULL, 'Belum', '2022-12-23 01:15:03', NULL, NULL, NULL),
(911, 1, 'P20221911', 'Satrio 911', '56419974911', '3276022304010010911', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243911', 'Malang. 911', 'Islam', 12, 9, '150000.00', 2, 'Sudah', '2022-12-23 01:15:04', NULL, NULL, NULL),
(912, 2, 'P20222912', 'Satrio 912', '56419974912', '3276022304010010912', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243912', 'Malang. 912', 'Islam', 4, 8, '150000.00', 1, 'Sudah', '2022-12-23 01:15:04', NULL, NULL, NULL),
(913, 3, 'P20223913', 'Satrio 913', '56419974913', '3276022304010010913', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243913', 'Malang. 913', 'Islam', 1, 3, NULL, NULL, 'Gratis', '2022-12-23 01:15:04', NULL, NULL, NULL),
(914, 1, 'P20221914', 'Satrio 914', '56419974914', '3276022304010010914', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243914', 'Malang. 914', 'Islam', 5, 12, '150000.00', 4, 'Sudah', '2022-12-23 01:15:04', NULL, NULL, NULL),
(915, 1, 'P20221915', 'Satrio 915', '56419974915', '3276022304010010915', 'Depok', '2001-12-27', 'Perempuan', '08810243915', 'Malang. 915', 'Islam', 3, 6, '150000.00', 3, 'Sudah', '2022-12-23 01:15:04', NULL, NULL, NULL),
(916, 3, 'P20223916', 'Satrio 916', '56419974916', '3276022304010010916', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243916', 'Malang. 916', 'Islam', 7, 1, NULL, NULL, 'Gratis', '2022-12-23 01:15:04', NULL, NULL, NULL),
(917, 1, 'P20221917', 'Satrio 917', '56419974917', '3276022304010010917', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243917', 'Malang. 917', 'Islam', 3, 3, '150000.00', 3, 'Belum', '2022-12-23 01:15:04', NULL, NULL, NULL),
(918, 2, 'P20222918', 'Satrio 918', '56419974918', '3276022304010010918', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243918', 'Malang. 918', 'Islam', 8, 9, '150000.00', 3, 'Sudah', '2022-12-23 01:15:04', NULL, NULL, NULL),
(919, 3, 'P20223919', 'Satrio 919', '56419974919', '3276022304010010919', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243919', 'Malang. 919', 'Islam', 6, 3, NULL, NULL, 'Gratis', '2022-12-23 01:15:04', NULL, NULL, NULL),
(920, 3, 'P20223920', 'Satrio 920', '56419974920', '3276022304010010920', 'Depok', '2001-12-08', 'Perempuan', '08810243920', 'Malang. 920', 'Islam', 7, 6, NULL, NULL, 'Gratis', '2022-12-23 01:15:04', NULL, NULL, NULL),
(921, 3, 'P20223921', 'Satrio 921', '56419974921', '3276022304010010921', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243921', 'Malang. 921', 'Islam', 1, 6, NULL, NULL, 'Gratis', '2022-12-23 01:15:04', NULL, NULL, NULL),
(922, 3, 'P20223922', 'Satrio 922', '56419974922', '3276022304010010922', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243922', 'Malang. 922', 'Islam', 13, 6, NULL, NULL, 'Gratis', '2022-12-23 01:15:04', NULL, NULL, NULL),
(923, 1, 'P20221923', 'Satrio 923', '56419974923', '3276022304010010923', 'Jakarta', '2001-12-03', 'Laki-Laki', '08810243923', 'Malang. 923', 'Islam', 10, 1, '150000.00', 3, 'Sudah', '2022-12-23 01:15:05', NULL, NULL, NULL),
(924, 1, 'P20221924', 'Satrio 924', '56419974924', '3276022304010010924', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243924', 'Malang. 924', 'Islam', 4, 8, '150000.00', 2, 'Belum', '2022-12-23 01:15:05', NULL, NULL, NULL),
(925, 1, 'P20221925', 'Satrio 925', '56419974925', '3276022304010010925', 'Depok', '2001-12-11', 'Perempuan', '08810243925', 'Malang. 925', 'Islam', 11, 13, '150000.00', 3, 'Sudah', '2022-12-23 01:15:05', NULL, NULL, NULL),
(926, 1, 'P20221926', 'Satrio 926', '56419974926', '3276022304010010926', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243926', 'Malang. 926', 'Islam', 12, 4, '150000.00', 3, 'Sudah', '2022-12-23 01:15:05', NULL, NULL, NULL),
(927, 2, 'P20222927', 'Satrio 927', '56419974927', '3276022304010010927', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243927', 'Malang. 927', 'Islam', 6, 4, '150000.00', 4, 'Sudah', '2022-12-23 01:15:05', NULL, NULL, NULL),
(928, 2, 'P20222928', 'Satrio 928', '56419974928', '3276022304010010928', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243928', 'Malang. 928', 'Islam', 4, 4, '150000.00', 3, 'Sudah', '2022-12-23 01:15:05', NULL, NULL, NULL),
(929, 2, 'P20222929', 'Satrio 929', '56419974929', '3276022304010010929', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243929', 'Malang. 929', 'Islam', 4, 9, '150000.00', 3, 'Sudah', '2022-12-23 01:15:05', NULL, NULL, NULL),
(930, 3, 'P20223930', 'Satrio 930', '56419974930', '3276022304010010930', 'Depok', '2001-12-18', 'Perempuan', '08810243930', 'Malang. 930', 'Islam', 4, 3, NULL, NULL, 'Gratis', '2022-12-23 01:15:05', NULL, NULL, NULL),
(931, 3, 'P20223931', 'Satrio 931', '56419974931', '3276022304010010931', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243931', 'Malang. 931', 'Islam', 4, 13, NULL, NULL, 'Belum', '2022-12-23 01:15:05', NULL, NULL, NULL),
(932, 3, 'P20223932', 'Satrio 932', '56419974932', '3276022304010010932', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243932', 'Malang. 932', 'Islam', 3, 8, NULL, NULL, 'Gratis', '2022-12-23 01:15:05', NULL, NULL, NULL),
(933, 3, 'P20223933', 'Satrio 933', '56419974933', '3276022304010010933', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243933', 'Malang. 933', 'Islam', 10, 5, NULL, NULL, 'Gratis', '2022-12-23 01:15:05', NULL, NULL, NULL),
(934, 3, 'P20223934', 'Satrio 934', '56419974934', '3276022304010010934', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243934', 'Malang. 934', 'Islam', 1, 8, NULL, NULL, 'Gratis', '2022-12-23 01:15:05', NULL, NULL, NULL),
(935, 3, 'P20223935', 'Satrio 935', '56419974935', '3276022304010010935', 'Depok', '2001-12-31', 'Perempuan', '08810243935', 'Malang. 935', 'Islam', 1, 2, NULL, NULL, 'Gratis', '2022-12-23 01:15:05', NULL, NULL, NULL),
(936, 3, 'P20223936', 'Satrio 936', '56419974936', '3276022304010010936', 'Jakarta', '2001-12-19', 'Laki-Laki', '08810243936', 'Malang. 936', 'Islam', 13, 7, NULL, NULL, 'Gratis', '2022-12-23 01:15:06', NULL, NULL, NULL),
(937, 1, 'P20221937', 'Satrio 937', '56419974937', '3276022304010010937', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243937', 'Malang. 937', 'Islam', 7, 6, '150000.00', 3, 'Sudah', '2022-12-23 01:15:06', NULL, NULL, NULL),
(938, 1, 'P20221938', 'Satrio 938', '56419974938', '3276022304010010938', 'Jakarta', '2001-12-08', 'Laki-Laki', '08810243938', 'Malang. 938', 'Islam', 5, 12, '150000.00', 2, 'Belum', '2022-12-23 01:15:06', NULL, NULL, NULL),
(939, 2, 'P20222939', 'Satrio 939', '56419974939', '3276022304010010939', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243939', 'Malang. 939', 'Islam', 12, 8, '150000.00', 1, 'Sudah', '2022-12-23 01:15:06', NULL, NULL, NULL),
(940, 3, 'P20223940', 'Satrio 940', '56419974940', '3276022304010010940', 'Depok', '2001-12-02', 'Perempuan', '08810243940', 'Malang. 940', 'Islam', 8, 5, NULL, NULL, 'Gratis', '2022-12-23 01:15:06', NULL, NULL, NULL),
(941, 3, 'P20223941', 'Satrio 941', '56419974941', '3276022304010010941', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243941', 'Malang. 941', 'Islam', 4, 6, NULL, NULL, 'Gratis', '2022-12-23 01:15:07', NULL, NULL, NULL),
(942, 1, 'P20221942', 'Satrio 942', '56419974942', '3276022304010010942', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243942', 'Malang. 942', 'Islam', 5, 9, '150000.00', 4, 'Sudah', '2022-12-23 01:15:07', NULL, NULL, NULL),
(943, 1, 'P20221943', 'Satrio 943', '56419974943', '3276022304010010943', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243943', 'Malang. 943', 'Islam', 10, 1, '150000.00', 4, 'Sudah', '2022-12-23 01:15:08', NULL, NULL, NULL),
(944, 2, 'P20222944', 'Satrio 944', '56419974944', '3276022304010010944', 'Jakarta', '2001-12-22', 'Laki-Laki', '08810243944', 'Malang. 944', 'Islam', 11, 13, '150000.00', 3, 'Sudah', '2022-12-23 01:15:08', NULL, NULL, NULL),
(945, 2, 'P20222945', 'Satrio 945', '56419974945', '3276022304010010945', 'Depok', '2001-12-22', 'Perempuan', '08810243945', 'Malang. 945', 'Islam', 10, 1, '150000.00', 1, 'Belum', '2022-12-23 01:15:08', NULL, NULL, NULL),
(946, 2, 'P20222946', 'Satrio 946', '56419974946', '3276022304010010946', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243946', 'Malang. 946', 'Islam', 12, 10, '150000.00', 2, 'Sudah', '2022-12-23 01:15:08', NULL, NULL, NULL),
(947, 2, 'P20222947', 'Satrio 947', '56419974947', '3276022304010010947', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243947', 'Malang. 947', 'Islam', 13, 6, '150000.00', 3, 'Sudah', '2022-12-23 01:15:08', NULL, NULL, NULL),
(948, 2, 'P20222948', 'Satrio 948', '56419974948', '3276022304010010948', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243948', 'Malang. 948', 'Islam', 12, 5, '150000.00', 3, 'Sudah', '2022-12-23 01:15:08', NULL, NULL, NULL),
(949, 1, 'P20221949', 'Satrio 949', '56419974949', '3276022304010010949', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243949', 'Malang. 949', 'Islam', 6, 4, '150000.00', 4, 'Sudah', '2022-12-23 01:15:08', NULL, NULL, NULL),
(950, 3, 'P20223950', 'Satrio 950', '56419974950', '3276022304010010950', 'Depok', '2001-12-19', 'Perempuan', '08810243950', 'Malang. 950', 'Islam', 8, 8, NULL, NULL, 'Gratis', '2022-12-23 01:15:08', NULL, NULL, NULL),
(951, 3, 'P20223951', 'Satrio 951', '56419974951', '3276022304010010951', 'Jakarta', '2001-12-21', 'Laki-Laki', '08810243951', 'Malang. 951', 'Islam', 3, 8, NULL, NULL, 'Gratis', '2022-12-23 01:15:09', NULL, NULL, NULL),
(952, 2, 'P20222952', 'Satrio 952', '56419974952', '3276022304010010952', 'Jakarta', '2001-12-04', 'Laki-Laki', '08810243952', 'Malang. 952', 'Islam', 2, 9, '150000.00', 3, 'Belum', '2022-12-23 01:15:09', NULL, NULL, NULL),
(953, 2, 'P20222953', 'Satrio 953', '56419974953', '3276022304010010953', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243953', 'Malang. 953', 'Islam', 3, 13, '150000.00', 1, 'Sudah', '2022-12-23 01:15:09', NULL, NULL, NULL),
(954, 2, 'P20222954', 'Satrio 954', '56419974954', '3276022304010010954', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243954', 'Malang. 954', 'Islam', 11, 1, '150000.00', 1, 'Sudah', '2022-12-23 01:15:09', NULL, NULL, NULL),
(955, 1, 'P20221955', 'Satrio 955', '56419974955', '3276022304010010955', 'Depok', '2001-12-18', 'Perempuan', '08810243955', 'Malang. 955', 'Islam', 7, 1, '150000.00', 3, 'Sudah', '2022-12-23 01:15:09', NULL, NULL, NULL),
(956, 1, 'P20221956', 'Satrio 956', '56419974956', '3276022304010010956', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243956', 'Malang. 956', 'Islam', 7, 6, '150000.00', 3, 'Sudah', '2022-12-23 01:15:09', NULL, NULL, NULL),
(957, 2, 'P20222957', 'Satrio 957', '56419974957', '3276022304010010957', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243957', 'Malang. 957', 'Islam', 13, 5, '150000.00', 1, 'Sudah', '2022-12-23 01:15:09', NULL, NULL, NULL),
(958, 2, 'P20222958', 'Satrio 958', '56419974958', '3276022304010010958', 'Jakarta', '2001-12-20', 'Laki-Laki', '08810243958', 'Malang. 958', 'Islam', 13, 9, '150000.00', 4, 'Sudah', '2022-12-23 01:15:09', NULL, NULL, NULL),
(959, 1, 'P20221959', 'Satrio 959', '56419974959', '3276022304010010959', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243959', 'Malang. 959', 'Islam', 10, 3, '150000.00', 2, 'Belum', '2022-12-23 01:15:10', NULL, NULL, NULL),
(960, 3, 'P20223960', 'Satrio 960', '56419974960', '3276022304010010960', 'Depok', '2001-12-12', 'Perempuan', '08810243960', 'Malang. 960', 'Islam', 7, 2, NULL, NULL, 'Gratis', '2022-12-23 01:15:10', NULL, NULL, NULL),
(961, 2, 'P20222961', 'Satrio 961', '56419974961', '3276022304010010961', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243961', 'Malang. 961', 'Islam', 7, 5, '150000.00', 2, 'Sudah', '2022-12-23 01:15:10', NULL, NULL, NULL),
(962, 2, 'P20222962', 'Satrio 962', '56419974962', '3276022304010010962', 'Jakarta', '2001-12-06', 'Laki-Laki', '08810243962', 'Malang. 962', 'Islam', 12, 1, '150000.00', 4, 'Sudah', '2022-12-23 01:15:10', NULL, NULL, NULL),
(963, 3, 'P20223963', 'Satrio 963', '56419974963', '3276022304010010963', 'Jakarta', '2001-12-16', 'Laki-Laki', '08810243963', 'Malang. 963', 'Islam', 13, 9, NULL, NULL, 'Gratis', '2022-12-23 01:15:10', NULL, NULL, NULL),
(964, 3, 'P20223964', 'Satrio 964', '56419974964', '3276022304010010964', 'Jakarta', '2001-12-30', 'Laki-Laki', '08810243964', 'Malang. 964', 'Islam', 11, 13, NULL, NULL, 'Gratis', '2022-12-23 01:15:10', NULL, NULL, NULL),
(965, 2, 'P20222965', 'Satrio 965', '56419974965', '3276022304010010965', 'Depok', '2001-12-14', 'Perempuan', '08810243965', 'Malang. 965', 'Islam', 1, 12, '150000.00', 3, 'Sudah', '2022-12-23 01:15:10', NULL, NULL, NULL),
(966, 1, 'P20221966', 'Satrio 966', '56419974966', '3276022304010010966', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243966', 'Malang. 966', 'Islam', 2, 8, '150000.00', 4, 'Belum', '2022-12-23 01:15:10', NULL, NULL, NULL),
(967, 3, 'P20223967', 'Satrio 967', '56419974967', '3276022304010010967', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243967', 'Malang. 967', 'Islam', 2, 11, NULL, NULL, 'Gratis', '2022-12-23 01:15:10', NULL, NULL, NULL),
(968, 2, 'P20222968', 'Satrio 968', '56419974968', '3276022304010010968', 'Jakarta', '2001-12-23', 'Laki-Laki', '08810243968', 'Malang. 968', 'Islam', 4, 13, '150000.00', 4, 'Sudah', '2022-12-23 01:15:11', NULL, NULL, NULL),
(969, 2, 'P20222969', 'Satrio 969', '56419974969', '3276022304010010969', 'Jakarta', '2001-12-26', 'Laki-Laki', '08810243969', 'Malang. 969', 'Islam', 9, 7, '150000.00', 3, 'Sudah', '2022-12-23 01:15:12', NULL, NULL, NULL),
(970, 3, 'P20223970', 'Satrio 970', '56419974970', '3276022304010010970', 'Depok', '2001-12-24', 'Perempuan', '08810243970', 'Malang. 970', 'Islam', 2, 5, NULL, NULL, 'Gratis', '2022-12-23 01:15:12', NULL, NULL, NULL),
(971, 2, 'P20222971', 'Satrio 971', '56419974971', '3276022304010010971', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243971', 'Malang. 971', 'Islam', 1, 5, '150000.00', 1, 'Sudah', '2022-12-23 01:15:13', NULL, NULL, NULL),
(972, 1, 'P20221972', 'Satrio 972', '56419974972', '3276022304010010972', 'Jakarta', '2001-12-25', 'Laki-Laki', '08810243972', 'Malang. 972', 'Islam', 6, 3, '150000.00', 2, 'Sudah', '2022-12-23 01:15:13', NULL, NULL, NULL),
(973, 1, 'P20221973', 'Satrio 973', '56419974973', '3276022304010010973', 'Jakarta', '2001-12-29', 'Laki-Laki', '08810243973', 'Malang. 973', 'Islam', 11, 12, '150000.00', 1, 'Belum', '2022-12-23 01:15:13', NULL, NULL, NULL),
(974, 1, 'P20221974', 'Satrio 974', '56419974974', '3276022304010010974', 'Jakarta', '2001-12-17', 'Laki-Laki', '08810243974', 'Malang. 974', 'Islam', 9, 12, '150000.00', 4, 'Sudah', '2022-12-23 01:15:13', NULL, NULL, NULL),
(975, 3, 'P20223975', 'Satrio 975', '56419974975', '3276022304010010975', 'Depok', '2001-12-12', 'Perempuan', '08810243975', 'Malang. 975', 'Islam', 9, 7, NULL, NULL, 'Gratis', '2022-12-23 01:15:14', NULL, NULL, NULL),
(976, 3, 'P20223976', 'Satrio 976', '56419974976', '3276022304010010976', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243976', 'Malang. 976', 'Islam', 2, 11, NULL, NULL, 'Gratis', '2022-12-23 01:15:14', NULL, NULL, NULL),
(977, 2, 'P20222977', 'Satrio 977', '56419974977', '3276022304010010977', 'Jakarta', '2001-12-24', 'Laki-Laki', '08810243977', 'Malang. 977', 'Islam', 12, 13, '150000.00', 4, 'Sudah', '2022-12-23 01:15:15', NULL, NULL, NULL),
(978, 1, 'P20221978', 'Satrio 978', '56419974978', '3276022304010010978', 'Jakarta', '2001-12-10', 'Laki-Laki', '08810243978', 'Malang. 978', 'Islam', 2, 2, '150000.00', 1, 'Sudah', '2022-12-23 01:15:15', NULL, NULL, NULL),
(979, 1, 'P20221979', 'Satrio 979', '56419974979', '3276022304010010979', 'Jakarta', '2001-12-27', 'Laki-Laki', '08810243979', 'Malang. 979', 'Islam', 10, 7, '150000.00', 2, 'Sudah', '2022-12-23 01:15:15', NULL, NULL, NULL),
(980, 1, 'P20221980', 'Satrio 980', '56419974980', '3276022304010010980', 'Depok', '2001-12-30', 'Perempuan', '08810243980', 'Malang. 980', 'Islam', 13, 2, '150000.00', 3, 'Belum', '2022-12-23 01:15:15', NULL, NULL, NULL),
(981, 2, 'P20222981', 'Satrio 981', '56419974981', '3276022304010010981', 'Jakarta', '2001-12-31', 'Laki-Laki', '08810243981', 'Malang. 981', 'Islam', 8, 3, '150000.00', 2, 'Sudah', '2022-12-23 01:15:15', NULL, NULL, NULL),
(982, 3, 'P20223982', 'Satrio 982', '56419974982', '3276022304010010982', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243982', 'Malang. 982', 'Islam', 7, 4, NULL, NULL, 'Gratis', '2022-12-23 01:15:15', NULL, NULL, NULL),
(983, 2, 'P20222983', 'Satrio 983', '56419974983', '3276022304010010983', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243983', 'Malang. 983', 'Islam', 8, 4, '150000.00', 1, 'Sudah', '2022-12-23 01:15:15', NULL, NULL, NULL),
(984, 1, 'P20221984', 'Satrio 984', '56419974984', '3276022304010010984', 'Jakarta', '2001-12-05', 'Laki-Laki', '08810243984', 'Malang. 984', 'Islam', 11, 9, '150000.00', 1, 'Sudah', '2022-12-23 01:15:15', NULL, NULL, NULL),
(985, 3, 'P20223985', 'Satrio 985', '56419974985', '3276022304010010985', 'Depok', '2001-12-22', 'Perempuan', '08810243985', 'Malang. 985', 'Islam', 6, 2, NULL, NULL, 'Gratis', '2022-12-23 01:15:15', NULL, NULL, NULL),
(986, 3, 'P20223986', 'Satrio 986', '56419974986', '3276022304010010986', 'Jakarta', '2001-12-14', 'Laki-Laki', '08810243986', 'Malang. 986', 'Islam', 2, 8, NULL, NULL, 'Gratis', '2022-12-23 01:15:16', NULL, NULL, NULL),
(987, 2, 'P20222987', 'Satrio 987', '56419974987', '3276022304010010987', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243987', 'Malang. 987', 'Islam', 7, 11, '150000.00', 4, 'Belum', '2022-12-23 01:15:16', NULL, NULL, NULL),
(988, 1, 'P20221988', 'Satrio 988', '56419974988', '3276022304010010988', 'Jakarta', '2001-12-09', 'Laki-Laki', '08810243988', 'Malang. 988', 'Islam', 4, 1, '150000.00', 2, 'Sudah', '2022-12-23 01:15:16', NULL, NULL, NULL),
(989, 1, 'P20221989', 'Satrio 989', '56419974989', '3276022304010010989', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243989', 'Malang. 989', 'Islam', 12, 12, '150000.00', 2, 'Sudah', '2022-12-23 01:15:16', NULL, NULL, NULL),
(990, 3, 'P20223990', 'Satrio 990', '56419974990', '3276022304010010990', 'Depok', '2001-12-31', 'Perempuan', '08810243990', 'Malang. 990', 'Islam', 2, 8, NULL, NULL, 'Gratis', '2022-12-23 01:15:16', NULL, NULL, NULL),
(991, 2, 'P20222991', 'Satrio 991', '56419974991', '3276022304010010991', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243991', 'Malang. 991', 'Islam', 7, 12, '150000.00', 2, 'Sudah', '2022-12-23 01:15:17', NULL, NULL, NULL),
(992, 3, 'P20223992', 'Satrio 992', '56419974992', '3276022304010010992', 'Jakarta', '2001-12-15', 'Laki-Laki', '08810243992', 'Malang. 992', 'Islam', 11, 11, NULL, NULL, 'Gratis', '2022-12-23 01:15:17', NULL, NULL, NULL),
(993, 3, 'P20223993', 'Satrio 993', '56419974993', '3276022304010010993', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243993', 'Malang. 993', 'Islam', 3, 3, NULL, NULL, 'Gratis', '2022-12-23 01:15:17', NULL, NULL, NULL),
(994, 3, 'P20223994', 'Satrio 994', '56419974994', '3276022304010010994', 'Jakarta', '2001-12-13', 'Laki-Laki', '08810243994', 'Malang. 994', 'Islam', 8, 5, NULL, NULL, 'Belum', '2022-12-23 01:15:17', NULL, NULL, NULL),
(995, 3, 'P20223995', 'Satrio 995', '56419974995', '3276022304010010995', 'Depok', '2001-12-18', 'Perempuan', '08810243995', 'Malang. 995', 'Islam', 10, 9, NULL, NULL, 'Gratis', '2022-12-23 01:15:17', NULL, NULL, NULL),
(996, 2, 'P20222996', 'Satrio 996', '56419974996', '3276022304010010996', 'Jakarta', '2001-12-02', 'Laki-Laki', '08810243996', 'Malang. 996', 'Islam', 12, 2, '150000.00', 3, 'Sudah', '2022-12-23 01:15:17', NULL, NULL, NULL),
(997, 1, 'P20221997', 'Satrio 997', '56419974997', '3276022304010010997', 'Jakarta', '2001-12-07', 'Laki-Laki', '08810243997', 'Malang. 997', 'Islam', 6, 11, '150000.00', 4, 'Sudah', '2022-12-23 01:15:18', NULL, NULL, NULL),
(998, 1, 'P20221998', 'Satrio 998', '56419974998', '3276022304010010998', 'Jakarta', '2001-12-12', 'Laki-Laki', '08810243998', 'Malang. 998', 'Islam', 2, 5, '150000.00', 2, 'Sudah', '2022-12-23 01:15:18', NULL, NULL, NULL),
(999, 2, 'P20222999', 'Satrio 999', '56419974999', '3276022304010010999', 'Jakarta', '2001-12-11', 'Laki-Laki', '08810243999', 'Malang. 999', 'Islam', 9, 13, '150000.00', 1, 'Sudah', '2022-12-23 01:15:18', NULL, NULL, NULL),
(1000, 2, 'P202221000', 'Satrio 1000', '564199741000', '32760223040100101000', 'Depok', '2001-12-22', 'Perempuan', '088102431000', 'Malang. 1000', 'Islam', 2, 10, '150000.00', 3, 'Sudah', '2022-12-23 01:15:18', NULL, NULL, NULL);

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
(1, 6, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 6', 2022, 'public/uploads/prestasi/6', '2022-12-23 01:13:44', NULL, NULL, NULL),
(2, 7, 'NASIONAL', 'Prestasi NASIONAL Satrio 7', 2022, 'public/uploads/prestasi/7', '2022-12-23 01:13:44', NULL, NULL, NULL),
(3, 8, 'NASIONAL', 'Prestasi NASIONAL Satrio 8', 2022, 'public/uploads/prestasi/8', '2022-12-23 01:13:44', NULL, NULL, NULL),
(4, 10, 'NASIONAL', 'Prestasi NASIONAL Satrio 10', 2022, 'public/uploads/prestasi/10', '2022-12-23 01:13:44', NULL, NULL, NULL),
(5, 13, 'NASIONAL', 'Prestasi NASIONAL Satrio 13', 2022, 'public/uploads/prestasi/13', '2022-12-23 01:13:45', NULL, NULL, NULL),
(6, 14, 'NASIONAL', 'Prestasi NASIONAL Satrio 14', 2022, 'public/uploads/prestasi/14', '2022-12-23 01:13:45', NULL, NULL, NULL),
(7, 16, 'NASIONAL', 'Prestasi NASIONAL Satrio 16', 2022, 'public/uploads/prestasi/16', '2022-12-23 01:13:45', NULL, NULL, NULL),
(8, 18, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 18', 2022, 'public/uploads/prestasi/18', '2022-12-23 01:13:45', NULL, NULL, NULL),
(9, 19, 'NASIONAL', 'Prestasi NASIONAL Satrio 19', 2022, 'public/uploads/prestasi/19', '2022-12-23 01:13:45', NULL, NULL, NULL),
(10, 22, 'NASIONAL', 'Prestasi NASIONAL Satrio 22', 2022, 'public/uploads/prestasi/22', '2022-12-23 01:13:45', NULL, NULL, NULL),
(11, 26, 'NASIONAL', 'Prestasi NASIONAL Satrio 26', 2022, 'public/uploads/prestasi/26', '2022-12-23 01:13:46', NULL, NULL, NULL),
(12, 30, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 30', 2022, 'public/uploads/prestasi/30', '2022-12-23 01:13:46', NULL, NULL, NULL),
(13, 37, 'NASIONAL', 'Prestasi NASIONAL Satrio 37', 2022, 'public/uploads/prestasi/37', '2022-12-23 01:13:46', NULL, NULL, NULL),
(14, 38, 'NASIONAL', 'Prestasi NASIONAL Satrio 38', 2022, 'public/uploads/prestasi/38', '2022-12-23 01:13:46', NULL, NULL, NULL),
(15, 39, 'NASIONAL', 'Prestasi NASIONAL Satrio 39', 2022, 'public/uploads/prestasi/39', '2022-12-23 01:13:46', NULL, NULL, NULL),
(16, 43, 'NASIONAL', 'Prestasi NASIONAL Satrio 43', 2022, 'public/uploads/prestasi/43', '2022-12-23 01:13:47', NULL, NULL, NULL),
(17, 45, 'NASIONAL', 'Prestasi NASIONAL Satrio 45', 2022, 'public/uploads/prestasi/45', '2022-12-23 01:13:47', NULL, NULL, NULL),
(18, 46, 'NASIONAL', 'Prestasi NASIONAL Satrio 46', 2022, 'public/uploads/prestasi/46', '2022-12-23 01:13:47', NULL, NULL, NULL),
(19, 48, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 48', 2022, 'public/uploads/prestasi/48', '2022-12-23 01:13:47', NULL, NULL, NULL),
(20, 50, 'NASIONAL', 'Prestasi NASIONAL Satrio 50', 2022, 'public/uploads/prestasi/50', '2022-12-23 01:13:47', NULL, NULL, NULL),
(21, 54, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 54', 2022, 'public/uploads/prestasi/54', '2022-12-23 01:13:47', NULL, NULL, NULL),
(22, 56, 'NASIONAL', 'Prestasi NASIONAL Satrio 56', 2022, 'public/uploads/prestasi/56', '2022-12-23 01:13:47', NULL, NULL, NULL),
(23, 57, 'NASIONAL', 'Prestasi NASIONAL Satrio 57', 2022, 'public/uploads/prestasi/57', '2022-12-23 01:13:47', NULL, NULL, NULL),
(24, 58, 'NASIONAL', 'Prestasi NASIONAL Satrio 58', 2022, 'public/uploads/prestasi/58', '2022-12-23 01:13:48', NULL, NULL, NULL),
(25, 59, 'NASIONAL', 'Prestasi NASIONAL Satrio 59', 2022, 'public/uploads/prestasi/59', '2022-12-23 01:13:48', NULL, NULL, NULL),
(26, 66, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 66', 2022, 'public/uploads/prestasi/66', '2022-12-23 01:13:48', NULL, NULL, NULL),
(27, 68, 'NASIONAL', 'Prestasi NASIONAL Satrio 68', 2022, 'public/uploads/prestasi/68', '2022-12-23 01:13:48', NULL, NULL, NULL),
(28, 69, 'NASIONAL', 'Prestasi NASIONAL Satrio 69', 2022, 'public/uploads/prestasi/69', '2022-12-23 01:13:48', NULL, NULL, NULL),
(29, 72, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 72', 2022, 'public/uploads/prestasi/72', '2022-12-23 01:13:48', NULL, NULL, NULL),
(30, 80, 'NASIONAL', 'Prestasi NASIONAL Satrio 80', 2022, 'public/uploads/prestasi/80', '2022-12-23 01:13:49', NULL, NULL, NULL),
(31, 85, 'NASIONAL', 'Prestasi NASIONAL Satrio 85', 2022, 'public/uploads/prestasi/85', '2022-12-23 01:13:50', NULL, NULL, NULL),
(32, 87, 'NASIONAL', 'Prestasi NASIONAL Satrio 87', 2022, 'public/uploads/prestasi/87', '2022-12-23 01:13:50', NULL, NULL, NULL),
(33, 90, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 90', 2022, 'public/uploads/prestasi/90', '2022-12-23 01:13:50', NULL, NULL, NULL),
(34, 93, 'NASIONAL', 'Prestasi NASIONAL Satrio 93', 2022, 'public/uploads/prestasi/93', '2022-12-23 01:13:50', NULL, NULL, NULL),
(35, 94, 'NASIONAL', 'Prestasi NASIONAL Satrio 94', 2022, 'public/uploads/prestasi/94', '2022-12-23 01:13:50', NULL, NULL, NULL),
(36, 96, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 96', 2022, 'public/uploads/prestasi/96', '2022-12-23 01:13:51', NULL, NULL, NULL),
(37, 98, 'NASIONAL', 'Prestasi NASIONAL Satrio 98', 2022, 'public/uploads/prestasi/98', '2022-12-23 01:13:51', NULL, NULL, NULL),
(38, 101, 'NASIONAL', 'Prestasi NASIONAL Satrio 101', 2022, 'public/uploads/prestasi/101', '2022-12-23 01:13:51', NULL, NULL, NULL),
(39, 102, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 102', 2022, 'public/uploads/prestasi/102', '2022-12-23 01:13:51', NULL, NULL, NULL),
(40, 103, 'NASIONAL', 'Prestasi NASIONAL Satrio 103', 2022, 'public/uploads/prestasi/103', '2022-12-23 01:13:52', NULL, NULL, NULL),
(41, 104, 'NASIONAL', 'Prestasi NASIONAL Satrio 104', 2022, 'public/uploads/prestasi/104', '2022-12-23 01:13:52', NULL, NULL, NULL),
(42, 109, 'NASIONAL', 'Prestasi NASIONAL Satrio 109', 2022, 'public/uploads/prestasi/109', '2022-12-23 01:13:52', NULL, NULL, NULL),
(43, 112, 'NASIONAL', 'Prestasi NASIONAL Satrio 112', 2022, 'public/uploads/prestasi/112', '2022-12-23 01:13:53', NULL, NULL, NULL),
(44, 116, 'NASIONAL', 'Prestasi NASIONAL Satrio 116', 2022, 'public/uploads/prestasi/116', '2022-12-23 01:13:53', NULL, NULL, NULL),
(45, 117, 'NASIONAL', 'Prestasi NASIONAL Satrio 117', 2022, 'public/uploads/prestasi/117', '2022-12-23 01:13:53', NULL, NULL, NULL),
(46, 119, 'NASIONAL', 'Prestasi NASIONAL Satrio 119', 2022, 'public/uploads/prestasi/119', '2022-12-23 01:13:53', NULL, NULL, NULL),
(47, 131, 'NASIONAL', 'Prestasi NASIONAL Satrio 131', 2022, 'public/uploads/prestasi/131', '2022-12-23 01:13:54', NULL, NULL, NULL),
(48, 133, 'NASIONAL', 'Prestasi NASIONAL Satrio 133', 2022, 'public/uploads/prestasi/133', '2022-12-23 01:13:54', NULL, NULL, NULL),
(49, 134, 'NASIONAL', 'Prestasi NASIONAL Satrio 134', 2022, 'public/uploads/prestasi/134', '2022-12-23 01:13:54', NULL, NULL, NULL),
(50, 136, 'NASIONAL', 'Prestasi NASIONAL Satrio 136', 2022, 'public/uploads/prestasi/136', '2022-12-23 01:13:54', NULL, NULL, NULL),
(51, 137, 'NASIONAL', 'Prestasi NASIONAL Satrio 137', 2022, 'public/uploads/prestasi/137', '2022-12-23 01:13:55', NULL, NULL, NULL),
(52, 139, 'NASIONAL', 'Prestasi NASIONAL Satrio 139', 2022, 'public/uploads/prestasi/139', '2022-12-23 01:13:55', NULL, NULL, NULL),
(53, 140, 'NASIONAL', 'Prestasi NASIONAL Satrio 140', 2022, 'public/uploads/prestasi/140', '2022-12-23 01:13:55', NULL, NULL, NULL),
(54, 142, 'NASIONAL', 'Prestasi NASIONAL Satrio 142', 2022, 'public/uploads/prestasi/142', '2022-12-23 01:13:55', NULL, NULL, NULL),
(55, 143, 'NASIONAL', 'Prestasi NASIONAL Satrio 143', 2022, 'public/uploads/prestasi/143', '2022-12-23 01:13:55', NULL, NULL, NULL),
(56, 145, 'NASIONAL', 'Prestasi NASIONAL Satrio 145', 2022, 'public/uploads/prestasi/145', '2022-12-23 01:13:55', NULL, NULL, NULL),
(57, 148, 'NASIONAL', 'Prestasi NASIONAL Satrio 148', 2022, 'public/uploads/prestasi/148', '2022-12-23 01:13:56', NULL, NULL, NULL),
(58, 152, 'NASIONAL', 'Prestasi NASIONAL Satrio 152', 2022, 'public/uploads/prestasi/152', '2022-12-23 01:13:56', NULL, NULL, NULL),
(59, 155, 'NASIONAL', 'Prestasi NASIONAL Satrio 155', 2022, 'public/uploads/prestasi/155', '2022-12-23 01:13:57', NULL, NULL, NULL),
(60, 156, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 156', 2022, 'public/uploads/prestasi/156', '2022-12-23 01:13:57', NULL, NULL, NULL),
(61, 159, 'NASIONAL', 'Prestasi NASIONAL Satrio 159', 2022, 'public/uploads/prestasi/159', '2022-12-23 01:13:57', NULL, NULL, NULL),
(62, 160, 'NASIONAL', 'Prestasi NASIONAL Satrio 160', 2022, 'public/uploads/prestasi/160', '2022-12-23 01:13:58', NULL, NULL, NULL),
(63, 164, 'NASIONAL', 'Prestasi NASIONAL Satrio 164', 2022, 'public/uploads/prestasi/164', '2022-12-23 01:13:58', NULL, NULL, NULL),
(64, 166, 'NASIONAL', 'Prestasi NASIONAL Satrio 166', 2022, 'public/uploads/prestasi/166', '2022-12-23 01:13:59', NULL, NULL, NULL),
(65, 168, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 168', 2022, 'public/uploads/prestasi/168', '2022-12-23 01:13:59', NULL, NULL, NULL),
(66, 171, 'NASIONAL', 'Prestasi NASIONAL Satrio 171', 2022, 'public/uploads/prestasi/171', '2022-12-23 01:14:00', NULL, NULL, NULL),
(67, 173, 'NASIONAL', 'Prestasi NASIONAL Satrio 173', 2022, 'public/uploads/prestasi/173', '2022-12-23 01:14:00', NULL, NULL, NULL),
(68, 174, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 174', 2022, 'public/uploads/prestasi/174', '2022-12-23 01:14:00', NULL, NULL, NULL),
(69, 175, 'NASIONAL', 'Prestasi NASIONAL Satrio 175', 2022, 'public/uploads/prestasi/175', '2022-12-23 01:14:00', NULL, NULL, NULL),
(70, 176, 'NASIONAL', 'Prestasi NASIONAL Satrio 176', 2022, 'public/uploads/prestasi/176', '2022-12-23 01:14:00', NULL, NULL, NULL),
(71, 179, 'NASIONAL', 'Prestasi NASIONAL Satrio 179', 2022, 'public/uploads/prestasi/179', '2022-12-23 01:14:01', NULL, NULL, NULL),
(72, 182, 'NASIONAL', 'Prestasi NASIONAL Satrio 182', 2022, 'public/uploads/prestasi/182', '2022-12-23 01:14:01', NULL, NULL, NULL),
(73, 183, 'NASIONAL', 'Prestasi NASIONAL Satrio 183', 2022, 'public/uploads/prestasi/183', '2022-12-23 01:14:01', NULL, NULL, NULL),
(74, 184, 'NASIONAL', 'Prestasi NASIONAL Satrio 184', 2022, 'public/uploads/prestasi/184', '2022-12-23 01:14:01', NULL, NULL, NULL),
(75, 188, 'NASIONAL', 'Prestasi NASIONAL Satrio 188', 2022, 'public/uploads/prestasi/188', '2022-12-23 01:14:02', NULL, NULL, NULL),
(76, 190, 'NASIONAL', 'Prestasi NASIONAL Satrio 190', 2022, 'public/uploads/prestasi/190', '2022-12-23 01:14:02', NULL, NULL, NULL),
(77, 192, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 192', 2022, 'public/uploads/prestasi/192', '2022-12-23 01:14:02', NULL, NULL, NULL),
(78, 194, 'NASIONAL', 'Prestasi NASIONAL Satrio 194', 2022, 'public/uploads/prestasi/194', '2022-12-23 01:14:02', NULL, NULL, NULL),
(79, 197, 'NASIONAL', 'Prestasi NASIONAL Satrio 197', 2022, 'public/uploads/prestasi/197', '2022-12-23 01:14:02', NULL, NULL, NULL),
(80, 200, 'NASIONAL', 'Prestasi NASIONAL Satrio 200', 2022, 'public/uploads/prestasi/200', '2022-12-23 01:14:02', NULL, NULL, NULL),
(81, 205, 'NASIONAL', 'Prestasi NASIONAL Satrio 205', 2022, 'public/uploads/prestasi/205', '2022-12-23 01:14:03', NULL, NULL, NULL),
(82, 206, 'NASIONAL', 'Prestasi NASIONAL Satrio 206', 2022, 'public/uploads/prestasi/206', '2022-12-23 01:14:03', NULL, NULL, NULL),
(83, 209, 'NASIONAL', 'Prestasi NASIONAL Satrio 209', 2022, 'public/uploads/prestasi/209', '2022-12-23 01:14:03', NULL, NULL, NULL),
(84, 211, 'NASIONAL', 'Prestasi NASIONAL Satrio 211', 2022, 'public/uploads/prestasi/211', '2022-12-23 01:14:03', NULL, NULL, NULL),
(85, 212, 'NASIONAL', 'Prestasi NASIONAL Satrio 212', 2022, 'public/uploads/prestasi/212', '2022-12-23 01:14:03', NULL, NULL, NULL),
(86, 216, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 216', 2022, 'public/uploads/prestasi/216', '2022-12-23 01:14:03', NULL, NULL, NULL),
(87, 217, 'NASIONAL', 'Prestasi NASIONAL Satrio 217', 2022, 'public/uploads/prestasi/217', '2022-12-23 01:14:03', NULL, NULL, NULL),
(88, 226, 'NASIONAL', 'Prestasi NASIONAL Satrio 226', 2022, 'public/uploads/prestasi/226', '2022-12-23 01:14:04', NULL, NULL, NULL),
(89, 227, 'NASIONAL', 'Prestasi NASIONAL Satrio 227', 2022, 'public/uploads/prestasi/227', '2022-12-23 01:14:04', NULL, NULL, NULL),
(90, 229, 'NASIONAL', 'Prestasi NASIONAL Satrio 229', 2022, 'public/uploads/prestasi/229', '2022-12-23 01:14:04', NULL, NULL, NULL),
(91, 230, 'NASIONAL', 'Prestasi NASIONAL Satrio 230', 2022, 'public/uploads/prestasi/230', '2022-12-23 01:14:04', NULL, NULL, NULL),
(92, 233, 'NASIONAL', 'Prestasi NASIONAL Satrio 233', 2022, 'public/uploads/prestasi/233', '2022-12-23 01:14:05', NULL, NULL, NULL),
(93, 236, 'NASIONAL', 'Prestasi NASIONAL Satrio 236', 2022, 'public/uploads/prestasi/236', '2022-12-23 01:14:05', NULL, NULL, NULL),
(94, 252, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 252', 2022, 'public/uploads/prestasi/252', '2022-12-23 01:14:06', NULL, NULL, NULL),
(95, 255, 'NASIONAL', 'Prestasi NASIONAL Satrio 255', 2022, 'public/uploads/prestasi/255', '2022-12-23 01:14:06', NULL, NULL, NULL),
(96, 257, 'NASIONAL', 'Prestasi NASIONAL Satrio 257', 2022, 'public/uploads/prestasi/257', '2022-12-23 01:14:06', NULL, NULL, NULL),
(97, 264, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 264', 2022, 'public/uploads/prestasi/264', '2022-12-23 01:14:07', NULL, NULL, NULL),
(98, 274, 'NASIONAL', 'Prestasi NASIONAL Satrio 274', 2022, 'public/uploads/prestasi/274', '2022-12-23 01:14:07', NULL, NULL, NULL),
(99, 277, 'NASIONAL', 'Prestasi NASIONAL Satrio 277', 2022, 'public/uploads/prestasi/277', '2022-12-23 01:14:08', NULL, NULL, NULL),
(100, 281, 'NASIONAL', 'Prestasi NASIONAL Satrio 281', 2022, 'public/uploads/prestasi/281', '2022-12-23 01:14:08', NULL, NULL, NULL),
(101, 283, 'NASIONAL', 'Prestasi NASIONAL Satrio 283', 2022, 'public/uploads/prestasi/283', '2022-12-23 01:14:08', NULL, NULL, NULL),
(102, 285, 'NASIONAL', 'Prestasi NASIONAL Satrio 285', 2022, 'public/uploads/prestasi/285', '2022-12-23 01:14:08', NULL, NULL, NULL),
(103, 288, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 288', 2022, 'public/uploads/prestasi/288', '2022-12-23 01:14:08', NULL, NULL, NULL),
(104, 290, 'NASIONAL', 'Prestasi NASIONAL Satrio 290', 2022, 'public/uploads/prestasi/290', '2022-12-23 01:14:08', NULL, NULL, NULL),
(105, 302, 'NASIONAL', 'Prestasi NASIONAL Satrio 302', 2022, 'public/uploads/prestasi/302', '2022-12-23 01:14:09', NULL, NULL, NULL),
(106, 303, 'NASIONAL', 'Prestasi NASIONAL Satrio 303', 2022, 'public/uploads/prestasi/303', '2022-12-23 01:14:09', NULL, NULL, NULL),
(107, 306, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 306', 2022, 'public/uploads/prestasi/306', '2022-12-23 01:14:09', NULL, NULL, NULL),
(108, 307, 'NASIONAL', 'Prestasi NASIONAL Satrio 307', 2022, 'public/uploads/prestasi/307', '2022-12-23 01:14:09', NULL, NULL, NULL),
(109, 312, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 312', 2022, 'public/uploads/prestasi/312', '2022-12-23 01:14:10', NULL, NULL, NULL),
(110, 313, 'NASIONAL', 'Prestasi NASIONAL Satrio 313', 2022, 'public/uploads/prestasi/313', '2022-12-23 01:14:10', NULL, NULL, NULL),
(111, 315, 'NASIONAL', 'Prestasi NASIONAL Satrio 315', 2022, 'public/uploads/prestasi/315', '2022-12-23 01:14:10', NULL, NULL, NULL),
(112, 317, 'NASIONAL', 'Prestasi NASIONAL Satrio 317', 2022, 'public/uploads/prestasi/317', '2022-12-23 01:14:10', NULL, NULL, NULL),
(113, 319, 'NASIONAL', 'Prestasi NASIONAL Satrio 319', 2022, 'public/uploads/prestasi/319', '2022-12-23 01:14:11', NULL, NULL, NULL),
(114, 320, 'NASIONAL', 'Prestasi NASIONAL Satrio 320', 2022, 'public/uploads/prestasi/320', '2022-12-23 01:14:11', NULL, NULL, NULL),
(115, 321, 'NASIONAL', 'Prestasi NASIONAL Satrio 321', 2022, 'public/uploads/prestasi/321', '2022-12-23 01:14:11', NULL, NULL, NULL),
(116, 326, 'NASIONAL', 'Prestasi NASIONAL Satrio 326', 2022, 'public/uploads/prestasi/326', '2022-12-23 01:14:11', NULL, NULL, NULL),
(117, 327, 'NASIONAL', 'Prestasi NASIONAL Satrio 327', 2022, 'public/uploads/prestasi/327', '2022-12-23 01:14:12', NULL, NULL, NULL),
(118, 331, 'NASIONAL', 'Prestasi NASIONAL Satrio 331', 2022, 'public/uploads/prestasi/331', '2022-12-23 01:14:13', NULL, NULL, NULL),
(119, 334, 'NASIONAL', 'Prestasi NASIONAL Satrio 334', 2022, 'public/uploads/prestasi/334', '2022-12-23 01:14:14', NULL, NULL, NULL),
(120, 341, 'NASIONAL', 'Prestasi NASIONAL Satrio 341', 2022, 'public/uploads/prestasi/341', '2022-12-23 01:14:15', NULL, NULL, NULL),
(121, 343, 'NASIONAL', 'Prestasi NASIONAL Satrio 343', 2022, 'public/uploads/prestasi/343', '2022-12-23 01:14:15', NULL, NULL, NULL),
(122, 345, 'NASIONAL', 'Prestasi NASIONAL Satrio 345', 2022, 'public/uploads/prestasi/345', '2022-12-23 01:14:15', NULL, NULL, NULL),
(123, 357, 'NASIONAL', 'Prestasi NASIONAL Satrio 357', 2022, 'public/uploads/prestasi/357', '2022-12-23 01:14:15', NULL, NULL, NULL),
(124, 359, 'NASIONAL', 'Prestasi NASIONAL Satrio 359', 2022, 'public/uploads/prestasi/359', '2022-12-23 01:14:16', NULL, NULL, NULL),
(125, 360, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 360', 2022, 'public/uploads/prestasi/360', '2022-12-23 01:14:16', NULL, NULL, NULL),
(126, 361, 'NASIONAL', 'Prestasi NASIONAL Satrio 361', 2022, 'public/uploads/prestasi/361', '2022-12-23 01:14:16', NULL, NULL, NULL),
(127, 362, 'NASIONAL', 'Prestasi NASIONAL Satrio 362', 2022, 'public/uploads/prestasi/362', '2022-12-23 01:14:16', NULL, NULL, NULL),
(128, 369, 'NASIONAL', 'Prestasi NASIONAL Satrio 369', 2022, 'public/uploads/prestasi/369', '2022-12-23 01:14:16', NULL, NULL, NULL),
(129, 370, 'NASIONAL', 'Prestasi NASIONAL Satrio 370', 2022, 'public/uploads/prestasi/370', '2022-12-23 01:14:16', NULL, NULL, NULL),
(130, 371, 'NASIONAL', 'Prestasi NASIONAL Satrio 371', 2022, 'public/uploads/prestasi/371', '2022-12-23 01:14:16', NULL, NULL, NULL),
(131, 374, 'NASIONAL', 'Prestasi NASIONAL Satrio 374', 2022, 'public/uploads/prestasi/374', '2022-12-23 01:14:17', NULL, NULL, NULL),
(132, 378, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 378', 2022, 'public/uploads/prestasi/378', '2022-12-23 01:14:17', NULL, NULL, NULL),
(133, 385, 'NASIONAL', 'Prestasi NASIONAL Satrio 385', 2022, 'public/uploads/prestasi/385', '2022-12-23 01:14:17', NULL, NULL, NULL),
(134, 390, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 390', 2022, 'public/uploads/prestasi/390', '2022-12-23 01:14:18', NULL, NULL, NULL),
(135, 391, 'NASIONAL', 'Prestasi NASIONAL Satrio 391', 2022, 'public/uploads/prestasi/391', '2022-12-23 01:14:18', NULL, NULL, NULL),
(136, 394, 'NASIONAL', 'Prestasi NASIONAL Satrio 394', 2022, 'public/uploads/prestasi/394', '2022-12-23 01:14:18', NULL, NULL, NULL),
(137, 395, 'NASIONAL', 'Prestasi NASIONAL Satrio 395', 2022, 'public/uploads/prestasi/395', '2022-12-23 01:14:18', NULL, NULL, NULL),
(138, 396, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 396', 2022, 'public/uploads/prestasi/396', '2022-12-23 01:14:18', NULL, NULL, NULL),
(139, 401, 'NASIONAL', 'Prestasi NASIONAL Satrio 401', 2022, 'public/uploads/prestasi/401', '2022-12-23 01:14:19', NULL, NULL, NULL),
(140, 402, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 402', 2022, 'public/uploads/prestasi/402', '2022-12-23 01:14:19', NULL, NULL, NULL),
(141, 404, 'NASIONAL', 'Prestasi NASIONAL Satrio 404', 2022, 'public/uploads/prestasi/404', '2022-12-23 01:14:19', NULL, NULL, NULL),
(142, 409, 'NASIONAL', 'Prestasi NASIONAL Satrio 409', 2022, 'public/uploads/prestasi/409', '2022-12-23 01:14:19', NULL, NULL, NULL),
(143, 412, 'NASIONAL', 'Prestasi NASIONAL Satrio 412', 2022, 'public/uploads/prestasi/412', '2022-12-23 01:14:20', NULL, NULL, NULL),
(144, 415, 'NASIONAL', 'Prestasi NASIONAL Satrio 415', 2022, 'public/uploads/prestasi/415', '2022-12-23 01:14:20', NULL, NULL, NULL),
(145, 420, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 420', 2022, 'public/uploads/prestasi/420', '2022-12-23 01:14:20', NULL, NULL, NULL),
(146, 423, 'NASIONAL', 'Prestasi NASIONAL Satrio 423', 2022, 'public/uploads/prestasi/423', '2022-12-23 01:14:21', NULL, NULL, NULL),
(147, 429, 'NASIONAL', 'Prestasi NASIONAL Satrio 429', 2022, 'public/uploads/prestasi/429', '2022-12-23 01:14:21', NULL, NULL, NULL),
(148, 431, 'NASIONAL', 'Prestasi NASIONAL Satrio 431', 2022, 'public/uploads/prestasi/431', '2022-12-23 01:14:21', NULL, NULL, NULL),
(149, 444, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 444', 2022, 'public/uploads/prestasi/444', '2022-12-23 01:14:22', NULL, NULL, NULL),
(150, 445, 'NASIONAL', 'Prestasi NASIONAL Satrio 445', 2022, 'public/uploads/prestasi/445', '2022-12-23 01:14:22', NULL, NULL, NULL),
(151, 446, 'NASIONAL', 'Prestasi NASIONAL Satrio 446', 2022, 'public/uploads/prestasi/446', '2022-12-23 01:14:22', NULL, NULL, NULL),
(152, 449, 'NASIONAL', 'Prestasi NASIONAL Satrio 449', 2022, 'public/uploads/prestasi/449', '2022-12-23 01:14:22', NULL, NULL, NULL),
(153, 456, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 456', 2022, 'public/uploads/prestasi/456', '2022-12-23 01:14:22', NULL, NULL, NULL),
(154, 458, 'NASIONAL', 'Prestasi NASIONAL Satrio 458', 2022, 'public/uploads/prestasi/458', '2022-12-23 01:14:23', NULL, NULL, NULL),
(155, 466, 'NASIONAL', 'Prestasi NASIONAL Satrio 466', 2022, 'public/uploads/prestasi/466', '2022-12-23 01:14:23', NULL, NULL, NULL),
(156, 470, 'NASIONAL', 'Prestasi NASIONAL Satrio 470', 2022, 'public/uploads/prestasi/470', '2022-12-23 01:14:23', NULL, NULL, NULL),
(157, 471, 'NASIONAL', 'Prestasi NASIONAL Satrio 471', 2022, 'public/uploads/prestasi/471', '2022-12-23 01:14:23', NULL, NULL, NULL),
(158, 472, 'NASIONAL', 'Prestasi NASIONAL Satrio 472', 2022, 'public/uploads/prestasi/472', '2022-12-23 01:14:23', NULL, NULL, NULL),
(159, 473, 'NASIONAL', 'Prestasi NASIONAL Satrio 473', 2022, 'public/uploads/prestasi/473', '2022-12-23 01:14:23', NULL, NULL, NULL),
(160, 475, 'NASIONAL', 'Prestasi NASIONAL Satrio 475', 2022, 'public/uploads/prestasi/475', '2022-12-23 01:14:24', NULL, NULL, NULL),
(161, 477, 'NASIONAL', 'Prestasi NASIONAL Satrio 477', 2022, 'public/uploads/prestasi/477', '2022-12-23 01:14:24', NULL, NULL, NULL),
(162, 479, 'NASIONAL', 'Prestasi NASIONAL Satrio 479', 2022, 'public/uploads/prestasi/479', '2022-12-23 01:14:24', NULL, NULL, NULL),
(163, 482, 'NASIONAL', 'Prestasi NASIONAL Satrio 482', 2022, 'public/uploads/prestasi/482', '2022-12-23 01:14:24', NULL, NULL, NULL),
(164, 495, 'NASIONAL', 'Prestasi NASIONAL Satrio 495', 2022, 'public/uploads/prestasi/495', '2022-12-23 01:14:25', NULL, NULL, NULL),
(165, 498, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 498', 2022, 'public/uploads/prestasi/498', '2022-12-23 01:14:25', NULL, NULL, NULL),
(166, 505, 'NASIONAL', 'Prestasi NASIONAL Satrio 505', 2022, 'public/uploads/prestasi/505', '2022-12-23 01:14:26', NULL, NULL, NULL),
(167, 506, 'NASIONAL', 'Prestasi NASIONAL Satrio 506', 2022, 'public/uploads/prestasi/506', '2022-12-23 01:14:26', NULL, NULL, NULL),
(168, 507, 'NASIONAL', 'Prestasi NASIONAL Satrio 507', 2022, 'public/uploads/prestasi/507', '2022-12-23 01:14:26', NULL, NULL, NULL),
(169, 509, 'NASIONAL', 'Prestasi NASIONAL Satrio 509', 2022, 'public/uploads/prestasi/509', '2022-12-23 01:14:26', NULL, NULL, NULL),
(170, 512, 'NASIONAL', 'Prestasi NASIONAL Satrio 512', 2022, 'public/uploads/prestasi/512', '2022-12-23 01:14:26', NULL, NULL, NULL),
(171, 515, 'NASIONAL', 'Prestasi NASIONAL Satrio 515', 2022, 'public/uploads/prestasi/515', '2022-12-23 01:14:26', NULL, NULL, NULL),
(172, 517, 'NASIONAL', 'Prestasi NASIONAL Satrio 517', 2022, 'public/uploads/prestasi/517', '2022-12-23 01:14:27', NULL, NULL, NULL),
(173, 523, 'NASIONAL', 'Prestasi NASIONAL Satrio 523', 2022, 'public/uploads/prestasi/523', '2022-12-23 01:14:28', NULL, NULL, NULL),
(174, 525, 'NASIONAL', 'Prestasi NASIONAL Satrio 525', 2022, 'public/uploads/prestasi/525', '2022-12-23 01:14:28', NULL, NULL, NULL),
(175, 526, 'NASIONAL', 'Prestasi NASIONAL Satrio 526', 2022, 'public/uploads/prestasi/526', '2022-12-23 01:14:28', NULL, NULL, NULL),
(176, 528, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 528', 2022, 'public/uploads/prestasi/528', '2022-12-23 01:14:28', NULL, NULL, NULL),
(177, 534, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 534', 2022, 'public/uploads/prestasi/534', '2022-12-23 01:14:28', NULL, NULL, NULL),
(178, 535, 'NASIONAL', 'Prestasi NASIONAL Satrio 535', 2022, 'public/uploads/prestasi/535', '2022-12-23 01:14:29', NULL, NULL, NULL),
(179, 537, 'NASIONAL', 'Prestasi NASIONAL Satrio 537', 2022, 'public/uploads/prestasi/537', '2022-12-23 01:14:29', NULL, NULL, NULL),
(180, 540, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 540', 2022, 'public/uploads/prestasi/540', '2022-12-23 01:14:29', NULL, NULL, NULL),
(181, 541, 'NASIONAL', 'Prestasi NASIONAL Satrio 541', 2022, 'public/uploads/prestasi/541', '2022-12-23 01:14:29', NULL, NULL, NULL),
(182, 545, 'NASIONAL', 'Prestasi NASIONAL Satrio 545', 2022, 'public/uploads/prestasi/545', '2022-12-23 01:14:29', NULL, NULL, NULL),
(183, 553, 'NASIONAL', 'Prestasi NASIONAL Satrio 553', 2022, 'public/uploads/prestasi/553', '2022-12-23 01:14:30', NULL, NULL, NULL),
(184, 558, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 558', 2022, 'public/uploads/prestasi/558', '2022-12-23 01:14:30', NULL, NULL, NULL),
(185, 559, 'NASIONAL', 'Prestasi NASIONAL Satrio 559', 2022, 'public/uploads/prestasi/559', '2022-12-23 01:14:30', NULL, NULL, NULL),
(186, 560, 'NASIONAL', 'Prestasi NASIONAL Satrio 560', 2022, 'public/uploads/prestasi/560', '2022-12-23 01:14:30', NULL, NULL, NULL),
(187, 561, 'NASIONAL', 'Prestasi NASIONAL Satrio 561', 2022, 'public/uploads/prestasi/561', '2022-12-23 01:14:30', NULL, NULL, NULL),
(188, 564, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 564', 2022, 'public/uploads/prestasi/564', '2022-12-23 01:14:30', NULL, NULL, NULL),
(189, 565, 'NASIONAL', 'Prestasi NASIONAL Satrio 565', 2022, 'public/uploads/prestasi/565', '2022-12-23 01:14:31', NULL, NULL, NULL),
(190, 568, 'NASIONAL', 'Prestasi NASIONAL Satrio 568', 2022, 'public/uploads/prestasi/568', '2022-12-23 01:14:31', NULL, NULL, NULL),
(191, 570, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 570', 2022, 'public/uploads/prestasi/570', '2022-12-23 01:14:31', NULL, NULL, NULL),
(192, 577, 'NASIONAL', 'Prestasi NASIONAL Satrio 577', 2022, 'public/uploads/prestasi/577', '2022-12-23 01:14:31', NULL, NULL, NULL),
(193, 578, 'NASIONAL', 'Prestasi NASIONAL Satrio 578', 2022, 'public/uploads/prestasi/578', '2022-12-23 01:14:32', NULL, NULL, NULL),
(194, 580, 'NASIONAL', 'Prestasi NASIONAL Satrio 580', 2022, 'public/uploads/prestasi/580', '2022-12-23 01:14:32', NULL, NULL, NULL),
(195, 585, 'NASIONAL', 'Prestasi NASIONAL Satrio 585', 2022, 'public/uploads/prestasi/585', '2022-12-23 01:14:32', NULL, NULL, NULL),
(196, 587, 'NASIONAL', 'Prestasi NASIONAL Satrio 587', 2022, 'public/uploads/prestasi/587', '2022-12-23 01:14:32', NULL, NULL, NULL),
(197, 588, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 588', 2022, 'public/uploads/prestasi/588', '2022-12-23 01:14:32', NULL, NULL, NULL),
(198, 597, 'NASIONAL', 'Prestasi NASIONAL Satrio 597', 2022, 'public/uploads/prestasi/597', '2022-12-23 01:14:33', NULL, NULL, NULL),
(199, 598, 'NASIONAL', 'Prestasi NASIONAL Satrio 598', 2022, 'public/uploads/prestasi/598', '2022-12-23 01:14:33', NULL, NULL, NULL),
(200, 600, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 600', 2022, 'public/uploads/prestasi/600', '2022-12-23 01:14:33', NULL, NULL, NULL),
(201, 604, 'NASIONAL', 'Prestasi NASIONAL Satrio 604', 2022, 'public/uploads/prestasi/604', '2022-12-23 01:14:34', NULL, NULL, NULL),
(202, 605, 'NASIONAL', 'Prestasi NASIONAL Satrio 605', 2022, 'public/uploads/prestasi/605', '2022-12-23 01:14:34', NULL, NULL, NULL),
(203, 606, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 606', 2022, 'public/uploads/prestasi/606', '2022-12-23 01:14:34', NULL, NULL, NULL),
(204, 610, 'NASIONAL', 'Prestasi NASIONAL Satrio 610', 2022, 'public/uploads/prestasi/610', '2022-12-23 01:14:34', NULL, NULL, NULL),
(205, 611, 'NASIONAL', 'Prestasi NASIONAL Satrio 611', 2022, 'public/uploads/prestasi/611', '2022-12-23 01:14:34', NULL, NULL, NULL),
(206, 622, 'NASIONAL', 'Prestasi NASIONAL Satrio 622', 2022, 'public/uploads/prestasi/622', '2022-12-23 01:14:35', NULL, NULL, NULL),
(207, 626, 'NASIONAL', 'Prestasi NASIONAL Satrio 626', 2022, 'public/uploads/prestasi/626', '2022-12-23 01:14:35', NULL, NULL, NULL),
(208, 628, 'NASIONAL', 'Prestasi NASIONAL Satrio 628', 2022, 'public/uploads/prestasi/628', '2022-12-23 01:14:36', NULL, NULL, NULL),
(209, 630, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 630', 2022, 'public/uploads/prestasi/630', '2022-12-23 01:14:36', NULL, NULL, NULL),
(210, 631, 'NASIONAL', 'Prestasi NASIONAL Satrio 631', 2022, 'public/uploads/prestasi/631', '2022-12-23 01:14:36', NULL, NULL, NULL),
(211, 632, 'NASIONAL', 'Prestasi NASIONAL Satrio 632', 2022, 'public/uploads/prestasi/632', '2022-12-23 01:14:36', NULL, NULL, NULL),
(212, 634, 'NASIONAL', 'Prestasi NASIONAL Satrio 634', 2022, 'public/uploads/prestasi/634', '2022-12-23 01:14:36', NULL, NULL, NULL),
(213, 640, 'NASIONAL', 'Prestasi NASIONAL Satrio 640', 2022, 'public/uploads/prestasi/640', '2022-12-23 01:14:36', NULL, NULL, NULL),
(214, 643, 'NASIONAL', 'Prestasi NASIONAL Satrio 643', 2022, 'public/uploads/prestasi/643', '2022-12-23 01:14:37', NULL, NULL, NULL),
(215, 648, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 648', 2022, 'public/uploads/prestasi/648', '2022-12-23 01:14:37', NULL, NULL, NULL),
(216, 650, 'NASIONAL', 'Prestasi NASIONAL Satrio 650', 2022, 'public/uploads/prestasi/650', '2022-12-23 01:14:37', NULL, NULL, NULL),
(217, 651, 'NASIONAL', 'Prestasi NASIONAL Satrio 651', 2022, 'public/uploads/prestasi/651', '2022-12-23 01:14:37', NULL, NULL, NULL),
(218, 664, 'NASIONAL', 'Prestasi NASIONAL Satrio 664', 2022, 'public/uploads/prestasi/664', '2022-12-23 01:14:38', NULL, NULL, NULL),
(219, 666, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 666', 2022, 'public/uploads/prestasi/666', '2022-12-23 01:14:38', NULL, NULL, NULL),
(220, 669, 'NASIONAL', 'Prestasi NASIONAL Satrio 669', 2022, 'public/uploads/prestasi/669', '2022-12-23 01:14:38', NULL, NULL, NULL),
(221, 683, 'NASIONAL', 'Prestasi NASIONAL Satrio 683', 2022, 'public/uploads/prestasi/683', '2022-12-23 01:14:39', NULL, NULL, NULL),
(222, 686, 'NASIONAL', 'Prestasi NASIONAL Satrio 686', 2022, 'public/uploads/prestasi/686', '2022-12-23 01:14:39', NULL, NULL, NULL),
(223, 687, 'NASIONAL', 'Prestasi NASIONAL Satrio 687', 2022, 'public/uploads/prestasi/687', '2022-12-23 01:14:39', NULL, NULL, NULL),
(224, 688, 'NASIONAL', 'Prestasi NASIONAL Satrio 688', 2022, 'public/uploads/prestasi/688', '2022-12-23 01:14:39', NULL, NULL, NULL),
(225, 690, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 690', 2022, 'public/uploads/prestasi/690', '2022-12-23 01:14:40', NULL, NULL, NULL),
(226, 691, 'NASIONAL', 'Prestasi NASIONAL Satrio 691', 2022, 'public/uploads/prestasi/691', '2022-12-23 01:14:40', NULL, NULL, NULL),
(227, 696, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 696', 2022, 'public/uploads/prestasi/696', '2022-12-23 01:14:40', NULL, NULL, NULL),
(228, 699, 'NASIONAL', 'Prestasi NASIONAL Satrio 699', 2022, 'public/uploads/prestasi/699', '2022-12-23 01:14:41', NULL, NULL, NULL),
(229, 700, 'NASIONAL', 'Prestasi NASIONAL Satrio 700', 2022, 'public/uploads/prestasi/700', '2022-12-23 01:14:41', NULL, NULL, NULL),
(230, 705, 'NASIONAL', 'Prestasi NASIONAL Satrio 705', 2022, 'public/uploads/prestasi/705', '2022-12-23 01:14:41', NULL, NULL, NULL),
(231, 708, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 708', 2022, 'public/uploads/prestasi/708', '2022-12-23 01:14:42', NULL, NULL, NULL),
(232, 709, 'NASIONAL', 'Prestasi NASIONAL Satrio 709', 2022, 'public/uploads/prestasi/709', '2022-12-23 01:14:42', NULL, NULL, NULL),
(233, 712, 'NASIONAL', 'Prestasi NASIONAL Satrio 712', 2022, 'public/uploads/prestasi/712', '2022-12-23 01:14:42', NULL, NULL, NULL),
(234, 713, 'NASIONAL', 'Prestasi NASIONAL Satrio 713', 2022, 'public/uploads/prestasi/713', '2022-12-23 01:14:42', NULL, NULL, NULL),
(235, 715, 'NASIONAL', 'Prestasi NASIONAL Satrio 715', 2022, 'public/uploads/prestasi/715', '2022-12-23 01:14:42', NULL, NULL, NULL),
(236, 716, 'NASIONAL', 'Prestasi NASIONAL Satrio 716', 2022, 'public/uploads/prestasi/716', '2022-12-23 01:14:42', NULL, NULL, NULL),
(237, 717, 'NASIONAL', 'Prestasi NASIONAL Satrio 717', 2022, 'public/uploads/prestasi/717', '2022-12-23 01:14:42', NULL, NULL, NULL),
(238, 718, 'NASIONAL', 'Prestasi NASIONAL Satrio 718', 2022, 'public/uploads/prestasi/718', '2022-12-23 01:14:42', NULL, NULL, NULL),
(239, 720, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 720', 2022, 'public/uploads/prestasi/720', '2022-12-23 01:14:43', NULL, NULL, NULL),
(240, 723, 'NASIONAL', 'Prestasi NASIONAL Satrio 723', 2022, 'public/uploads/prestasi/723', '2022-12-23 01:14:43', NULL, NULL, NULL),
(241, 724, 'NASIONAL', 'Prestasi NASIONAL Satrio 724', 2022, 'public/uploads/prestasi/724', '2022-12-23 01:14:43', NULL, NULL, NULL),
(242, 725, 'NASIONAL', 'Prestasi NASIONAL Satrio 725', 2022, 'public/uploads/prestasi/725', '2022-12-23 01:14:44', NULL, NULL, NULL),
(243, 728, 'NASIONAL', 'Prestasi NASIONAL Satrio 728', 2022, 'public/uploads/prestasi/728', '2022-12-23 01:14:44', NULL, NULL, NULL),
(244, 730, 'NASIONAL', 'Prestasi NASIONAL Satrio 730', 2022, 'public/uploads/prestasi/730', '2022-12-23 01:14:45', NULL, NULL, NULL),
(245, 732, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 732', 2022, 'public/uploads/prestasi/732', '2022-12-23 01:14:45', NULL, NULL, NULL),
(246, 733, 'NASIONAL', 'Prestasi NASIONAL Satrio 733', 2022, 'public/uploads/prestasi/733', '2022-12-23 01:14:45', NULL, NULL, NULL),
(247, 734, 'NASIONAL', 'Prestasi NASIONAL Satrio 734', 2022, 'public/uploads/prestasi/734', '2022-12-23 01:14:45', NULL, NULL, NULL),
(248, 735, 'NASIONAL', 'Prestasi NASIONAL Satrio 735', 2022, 'public/uploads/prestasi/735', '2022-12-23 01:14:46', NULL, NULL, NULL),
(249, 741, 'NASIONAL', 'Prestasi NASIONAL Satrio 741', 2022, 'public/uploads/prestasi/741', '2022-12-23 01:14:46', NULL, NULL, NULL),
(250, 746, 'NASIONAL', 'Prestasi NASIONAL Satrio 746', 2022, 'public/uploads/prestasi/746', '2022-12-23 01:14:46', NULL, NULL, NULL),
(251, 749, 'NASIONAL', 'Prestasi NASIONAL Satrio 749', 2022, 'public/uploads/prestasi/749', '2022-12-23 01:14:46', NULL, NULL, NULL),
(252, 756, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 756', 2022, 'public/uploads/prestasi/756', '2022-12-23 01:14:47', NULL, NULL, NULL),
(253, 757, 'NASIONAL', 'Prestasi NASIONAL Satrio 757', 2022, 'public/uploads/prestasi/757', '2022-12-23 01:14:47', NULL, NULL, NULL),
(254, 761, 'NASIONAL', 'Prestasi NASIONAL Satrio 761', 2022, 'public/uploads/prestasi/761', '2022-12-23 01:14:47', NULL, NULL, NULL),
(255, 762, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 762', 2022, 'public/uploads/prestasi/762', '2022-12-23 01:14:48', NULL, NULL, NULL),
(256, 766, 'NASIONAL', 'Prestasi NASIONAL Satrio 766', 2022, 'public/uploads/prestasi/766', '2022-12-23 01:14:49', NULL, NULL, NULL),
(257, 767, 'NASIONAL', 'Prestasi NASIONAL Satrio 767', 2022, 'public/uploads/prestasi/767', '2022-12-23 01:14:49', NULL, NULL, NULL),
(258, 777, 'NASIONAL', 'Prestasi NASIONAL Satrio 777', 2022, 'public/uploads/prestasi/777', '2022-12-23 01:14:51', NULL, NULL, NULL),
(259, 782, 'NASIONAL', 'Prestasi NASIONAL Satrio 782', 2022, 'public/uploads/prestasi/782', '2022-12-23 01:14:51', NULL, NULL, NULL),
(260, 784, 'NASIONAL', 'Prestasi NASIONAL Satrio 784', 2022, 'public/uploads/prestasi/784', '2022-12-23 01:14:51', NULL, NULL, NULL),
(261, 785, 'NASIONAL', 'Prestasi NASIONAL Satrio 785', 2022, 'public/uploads/prestasi/785', '2022-12-23 01:14:52', NULL, NULL, NULL),
(262, 786, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 786', 2022, 'public/uploads/prestasi/786', '2022-12-23 01:14:52', NULL, NULL, NULL),
(263, 789, 'NASIONAL', 'Prestasi NASIONAL Satrio 789', 2022, 'public/uploads/prestasi/789', '2022-12-23 01:14:52', NULL, NULL, NULL),
(264, 791, 'NASIONAL', 'Prestasi NASIONAL Satrio 791', 2022, 'public/uploads/prestasi/791', '2022-12-23 01:14:52', NULL, NULL, NULL),
(265, 792, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 792', 2022, 'public/uploads/prestasi/792', '2022-12-23 01:14:52', NULL, NULL, NULL),
(266, 793, 'NASIONAL', 'Prestasi NASIONAL Satrio 793', 2022, 'public/uploads/prestasi/793', '2022-12-23 01:14:52', NULL, NULL, NULL),
(267, 794, 'NASIONAL', 'Prestasi NASIONAL Satrio 794', 2022, 'public/uploads/prestasi/794', '2022-12-23 01:14:53', NULL, NULL, NULL),
(268, 795, 'NASIONAL', 'Prestasi NASIONAL Satrio 795', 2022, 'public/uploads/prestasi/795', '2022-12-23 01:14:53', NULL, NULL, NULL),
(269, 796, 'NASIONAL', 'Prestasi NASIONAL Satrio 796', 2022, 'public/uploads/prestasi/796', '2022-12-23 01:14:53', NULL, NULL, NULL),
(270, 800, 'NASIONAL', 'Prestasi NASIONAL Satrio 800', 2022, 'public/uploads/prestasi/800', '2022-12-23 01:14:53', NULL, NULL, NULL),
(271, 801, 'NASIONAL', 'Prestasi NASIONAL Satrio 801', 2022, 'public/uploads/prestasi/801', '2022-12-23 01:14:53', NULL, NULL, NULL),
(272, 805, 'NASIONAL', 'Prestasi NASIONAL Satrio 805', 2022, 'public/uploads/prestasi/805', '2022-12-23 01:14:54', NULL, NULL, NULL),
(273, 806, 'NASIONAL', 'Prestasi NASIONAL Satrio 806', 2022, 'public/uploads/prestasi/806', '2022-12-23 01:14:54', NULL, NULL, NULL),
(274, 807, 'NASIONAL', 'Prestasi NASIONAL Satrio 807', 2022, 'public/uploads/prestasi/807', '2022-12-23 01:14:54', NULL, NULL, NULL),
(275, 810, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 810', 2022, 'public/uploads/prestasi/810', '2022-12-23 01:14:55', NULL, NULL, NULL),
(276, 813, 'NASIONAL', 'Prestasi NASIONAL Satrio 813', 2022, 'public/uploads/prestasi/813', '2022-12-23 01:14:55', NULL, NULL, NULL),
(277, 816, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 816', 2022, 'public/uploads/prestasi/816', '2022-12-23 01:14:55', NULL, NULL, NULL),
(278, 818, 'NASIONAL', 'Prestasi NASIONAL Satrio 818', 2022, 'public/uploads/prestasi/818', '2022-12-23 01:14:55', NULL, NULL, NULL),
(279, 820, 'NASIONAL', 'Prestasi NASIONAL Satrio 820', 2022, 'public/uploads/prestasi/820', '2022-12-23 01:14:55', NULL, NULL, NULL),
(280, 822, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 822', 2022, 'public/uploads/prestasi/822', '2022-12-23 01:14:55', NULL, NULL, NULL),
(281, 825, 'NASIONAL', 'Prestasi NASIONAL Satrio 825', 2022, 'public/uploads/prestasi/825', '2022-12-23 01:14:56', NULL, NULL, NULL),
(282, 827, 'NASIONAL', 'Prestasi NASIONAL Satrio 827', 2022, 'public/uploads/prestasi/827', '2022-12-23 01:14:56', NULL, NULL, NULL),
(283, 832, 'NASIONAL', 'Prestasi NASIONAL Satrio 832', 2022, 'public/uploads/prestasi/832', '2022-12-23 01:14:56', NULL, NULL, NULL),
(284, 834, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 834', 2022, 'public/uploads/prestasi/834', '2022-12-23 01:14:56', NULL, NULL, NULL),
(285, 835, 'NASIONAL', 'Prestasi NASIONAL Satrio 835', 2022, 'public/uploads/prestasi/835', '2022-12-23 01:14:56', NULL, NULL, NULL),
(286, 837, 'NASIONAL', 'Prestasi NASIONAL Satrio 837', 2022, 'public/uploads/prestasi/837', '2022-12-23 01:14:57', NULL, NULL, NULL),
(287, 839, 'NASIONAL', 'Prestasi NASIONAL Satrio 839', 2022, 'public/uploads/prestasi/839', '2022-12-23 01:14:57', NULL, NULL, NULL),
(288, 840, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 840', 2022, 'public/uploads/prestasi/840', '2022-12-23 01:14:57', NULL, NULL, NULL),
(289, 843, 'NASIONAL', 'Prestasi NASIONAL Satrio 843', 2022, 'public/uploads/prestasi/843', '2022-12-23 01:14:57', NULL, NULL, NULL),
(290, 848, 'NASIONAL', 'Prestasi NASIONAL Satrio 848', 2022, 'public/uploads/prestasi/848', '2022-12-23 01:14:57', NULL, NULL, NULL),
(291, 852, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 852', 2022, 'public/uploads/prestasi/852', '2022-12-23 01:14:58', NULL, NULL, NULL),
(292, 856, 'NASIONAL', 'Prestasi NASIONAL Satrio 856', 2022, 'public/uploads/prestasi/856', '2022-12-23 01:14:58', NULL, NULL, NULL),
(293, 860, 'NASIONAL', 'Prestasi NASIONAL Satrio 860', 2022, 'public/uploads/prestasi/860', '2022-12-23 01:14:58', NULL, NULL, NULL),
(294, 861, 'NASIONAL', 'Prestasi NASIONAL Satrio 861', 2022, 'public/uploads/prestasi/861', '2022-12-23 01:14:59', NULL, NULL, NULL),
(295, 862, 'NASIONAL', 'Prestasi NASIONAL Satrio 862', 2022, 'public/uploads/prestasi/862', '2022-12-23 01:14:59', NULL, NULL, NULL),
(296, 867, 'NASIONAL', 'Prestasi NASIONAL Satrio 867', 2022, 'public/uploads/prestasi/867', '2022-12-23 01:14:59', NULL, NULL, NULL),
(297, 868, 'NASIONAL', 'Prestasi NASIONAL Satrio 868', 2022, 'public/uploads/prestasi/868', '2022-12-23 01:14:59', NULL, NULL, NULL),
(298, 869, 'NASIONAL', 'Prestasi NASIONAL Satrio 869', 2022, 'public/uploads/prestasi/869', '2022-12-23 01:14:59', NULL, NULL, NULL),
(299, 871, 'NASIONAL', 'Prestasi NASIONAL Satrio 871', 2022, 'public/uploads/prestasi/871', '2022-12-23 01:14:59', NULL, NULL, NULL),
(300, 873, 'NASIONAL', 'Prestasi NASIONAL Satrio 873', 2022, 'public/uploads/prestasi/873', '2022-12-23 01:15:00', NULL, NULL, NULL),
(301, 874, 'NASIONAL', 'Prestasi NASIONAL Satrio 874', 2022, 'public/uploads/prestasi/874', '2022-12-23 01:15:00', NULL, NULL, NULL),
(302, 876, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 876', 2022, 'public/uploads/prestasi/876', '2022-12-23 01:15:00', NULL, NULL, NULL),
(303, 877, 'NASIONAL', 'Prestasi NASIONAL Satrio 877', 2022, 'public/uploads/prestasi/877', '2022-12-23 01:15:00', NULL, NULL, NULL),
(304, 882, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 882', 2022, 'public/uploads/prestasi/882', '2022-12-23 01:15:00', NULL, NULL, NULL),
(305, 883, 'NASIONAL', 'Prestasi NASIONAL Satrio 883', 2022, 'public/uploads/prestasi/883', '2022-12-23 01:15:00', NULL, NULL, NULL),
(306, 886, 'NASIONAL', 'Prestasi NASIONAL Satrio 886', 2022, 'public/uploads/prestasi/886', '2022-12-23 01:15:01', NULL, NULL, NULL),
(307, 888, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 888', 2022, 'public/uploads/prestasi/888', '2022-12-23 01:15:01', NULL, NULL, NULL),
(308, 893, 'NASIONAL', 'Prestasi NASIONAL Satrio 893', 2022, 'public/uploads/prestasi/893', '2022-12-23 01:15:02', NULL, NULL, NULL),
(309, 897, 'NASIONAL', 'Prestasi NASIONAL Satrio 897', 2022, 'public/uploads/prestasi/897', '2022-12-23 01:15:02', NULL, NULL, NULL),
(310, 899, 'NASIONAL', 'Prestasi NASIONAL Satrio 899', 2022, 'public/uploads/prestasi/899', '2022-12-23 01:15:02', NULL, NULL, NULL),
(311, 901, 'NASIONAL', 'Prestasi NASIONAL Satrio 901', 2022, 'public/uploads/prestasi/901', '2022-12-23 01:15:02', NULL, NULL, NULL),
(312, 903, 'NASIONAL', 'Prestasi NASIONAL Satrio 903', 2022, 'public/uploads/prestasi/903', '2022-12-23 01:15:03', NULL, NULL, NULL),
(313, 910, 'NASIONAL', 'Prestasi NASIONAL Satrio 910', 2022, 'public/uploads/prestasi/910', '2022-12-23 01:15:03', NULL, NULL, NULL),
(314, 913, 'NASIONAL', 'Prestasi NASIONAL Satrio 913', 2022, 'public/uploads/prestasi/913', '2022-12-23 01:15:04', NULL, NULL, NULL),
(315, 916, 'NASIONAL', 'Prestasi NASIONAL Satrio 916', 2022, 'public/uploads/prestasi/916', '2022-12-23 01:15:04', NULL, NULL, NULL),
(316, 919, 'NASIONAL', 'Prestasi NASIONAL Satrio 919', 2022, 'public/uploads/prestasi/919', '2022-12-23 01:15:04', NULL, NULL, NULL),
(317, 920, 'NASIONAL', 'Prestasi NASIONAL Satrio 920', 2022, 'public/uploads/prestasi/920', '2022-12-23 01:15:04', NULL, NULL, NULL),
(318, 921, 'NASIONAL', 'Prestasi NASIONAL Satrio 921', 2022, 'public/uploads/prestasi/921', '2022-12-23 01:15:04', NULL, NULL, NULL),
(319, 922, 'NASIONAL', 'Prestasi NASIONAL Satrio 922', 2022, 'public/uploads/prestasi/922', '2022-12-23 01:15:04', NULL, NULL, NULL),
(320, 930, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 930', 2022, 'public/uploads/prestasi/930', '2022-12-23 01:15:05', NULL, NULL, NULL),
(321, 931, 'NASIONAL', 'Prestasi NASIONAL Satrio 931', 2022, 'public/uploads/prestasi/931', '2022-12-23 01:15:05', NULL, NULL, NULL),
(322, 932, 'NASIONAL', 'Prestasi NASIONAL Satrio 932', 2022, 'public/uploads/prestasi/932', '2022-12-23 01:15:05', NULL, NULL, NULL),
(323, 933, 'NASIONAL', 'Prestasi NASIONAL Satrio 933', 2022, 'public/uploads/prestasi/933', '2022-12-23 01:15:05', NULL, NULL, NULL),
(324, 934, 'NASIONAL', 'Prestasi NASIONAL Satrio 934', 2022, 'public/uploads/prestasi/934', '2022-12-23 01:15:05', NULL, NULL, NULL),
(325, 935, 'NASIONAL', 'Prestasi NASIONAL Satrio 935', 2022, 'public/uploads/prestasi/935', '2022-12-23 01:15:05', NULL, NULL, NULL),
(326, 936, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 936', 2022, 'public/uploads/prestasi/936', '2022-12-23 01:15:06', NULL, NULL, NULL),
(327, 940, 'NASIONAL', 'Prestasi NASIONAL Satrio 940', 2022, 'public/uploads/prestasi/940', '2022-12-23 01:15:07', NULL, NULL, NULL),
(328, 941, 'NASIONAL', 'Prestasi NASIONAL Satrio 941', 2022, 'public/uploads/prestasi/941', '2022-12-23 01:15:07', NULL, NULL, NULL),
(329, 950, 'NASIONAL', 'Prestasi NASIONAL Satrio 950', 2022, 'public/uploads/prestasi/950', '2022-12-23 01:15:09', NULL, NULL, NULL),
(330, 951, 'NASIONAL', 'Prestasi NASIONAL Satrio 951', 2022, 'public/uploads/prestasi/951', '2022-12-23 01:15:09', NULL, NULL, NULL),
(331, 960, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 960', 2022, 'public/uploads/prestasi/960', '2022-12-23 01:15:10', NULL, NULL, NULL),
(332, 963, 'NASIONAL', 'Prestasi NASIONAL Satrio 963', 2022, 'public/uploads/prestasi/963', '2022-12-23 01:15:10', NULL, NULL, NULL),
(333, 964, 'NASIONAL', 'Prestasi NASIONAL Satrio 964', 2022, 'public/uploads/prestasi/964', '2022-12-23 01:15:10', NULL, NULL, NULL),
(334, 967, 'NASIONAL', 'Prestasi NASIONAL Satrio 967', 2022, 'public/uploads/prestasi/967', '2022-12-23 01:15:11', NULL, NULL, NULL),
(335, 970, 'NASIONAL', 'Prestasi NASIONAL Satrio 970', 2022, 'public/uploads/prestasi/970', '2022-12-23 01:15:12', NULL, NULL, NULL),
(336, 975, 'NASIONAL', 'Prestasi NASIONAL Satrio 975', 2022, 'public/uploads/prestasi/975', '2022-12-23 01:15:14', NULL, NULL, NULL),
(337, 976, 'NASIONAL', 'Prestasi NASIONAL Satrio 976', 2022, 'public/uploads/prestasi/976', '2022-12-23 01:15:14', NULL, NULL, NULL),
(338, 982, 'NASIONAL', 'Prestasi NASIONAL Satrio 982', 2022, 'public/uploads/prestasi/982', '2022-12-23 01:15:15', NULL, NULL, NULL),
(339, 985, 'NASIONAL', 'Prestasi NASIONAL Satrio 985', 2022, 'public/uploads/prestasi/985', '2022-12-23 01:15:15', NULL, NULL, NULL),
(340, 986, 'NASIONAL', 'Prestasi NASIONAL Satrio 986', 2022, 'public/uploads/prestasi/986', '2022-12-23 01:15:16', NULL, NULL, NULL),
(341, 990, 'INTERNASIONAL', 'Prestasi INTERNASIONAL Satrio 990', 2022, 'public/uploads/prestasi/990', '2022-12-23 01:15:17', NULL, NULL, NULL),
(342, 992, 'NASIONAL', 'Prestasi NASIONAL Satrio 992', 2022, 'public/uploads/prestasi/992', '2022-12-23 01:15:17', NULL, NULL, NULL),
(343, 993, 'NASIONAL', 'Prestasi NASIONAL Satrio 993', 2022, 'public/uploads/prestasi/993', '2022-12-23 01:15:17', NULL, NULL, NULL),
(344, 994, 'NASIONAL', 'Prestasi NASIONAL Satrio 994', 2022, 'public/uploads/prestasi/994', '2022-12-23 01:15:17', NULL, NULL, NULL),
(345, 995, 'NASIONAL', 'Prestasi NASIONAL Satrio 995', 2022, 'public/uploads/prestasi/995', '2022-12-23 01:15:17', NULL, NULL, NULL);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=346;

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
