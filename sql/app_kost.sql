CREATE DATABASE app_kost;
USE app_kost;

CREATE TABLE tb_penghuni (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    no_ktp VARCHAR(50),
    no_hp VARCHAR(15),
    tgl_masuk DATE,
    tgl_keluar DATE NULL
);

CREATE TABLE tb_kamar (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nomor VARCHAR(10),
    harga DECIMAL(10,2)
);

CREATE TABLE tb_barang (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100),
    harga DECIMAL(10,2)
);

CREATE TABLE tb_kmr_penghuni (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_kamar INT,
    id_penghuni INT,
    tgl_masuk DATE,
    tgl_keluar DATE NULL,
    FOREIGN KEY (id_kamar) REFERENCES tb_kamar(id),
    FOREIGN KEY (id_penghuni) REFERENCES tb_penghuni(id)
);

CREATE TABLE tb_brng_bawaan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_penghuni INT,
    id_barang INT,
    FOREIGN KEY (id_penghuni) REFERENCES tb_penghuni(id),
    FOREIGN KEY (id_barang) REFERENCES tb_barang(id)
);

CREATE TABLE tb_tagihan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bulan VARCHAR(20),
    id_kmr_penghuni INT,
    jml_tagihan DECIMAL(10,2),
    FOREIGN KEY (id_kmr_penghuni) REFERENCES tb_kmr_penghuni(id)
);

CREATE TABLE tb_bayar (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_tagihan INT,
    jml_bayar DECIMAL(10,2),
    status ENUM('cicil','lunas') DEFAULT 'cicil',
    FOREIGN KEY (id_tagihan) REFERENCES tb_tagihan(id)
);

-- Update Tabel tb_bayar untuk menambahkan kolom metode pembayaran
ALTER TABLE tb_bayar 
ADD COLUMN metode_pembayaran ENUM('cash','transfer','ewallet') DEFAULT 'cash' AFTER status;

-- Sample Data untuk Testing

-- Data kamar
INSERT INTO tb_kamar (nomor, harga) VALUES 
('A101', 1000000),
('A102', 1200000),
('B201', 1500000);

-- Data barang
INSERT INTO tb_barang (nama, harga) VALUES 
('AC', 300000),
('Kulkas', 500000),
('TV', 200000);

-- Data penghuni
INSERT INTO tb_penghuni (nama, no_ktp, no_hp, tgl_masuk) VALUES 
('Budi Santoso', '3276012345678901', '08123456789', '2025-07-01'),
('Siti Aminah', '3276012345678902', '08129876543', '2025-07-05');

-- Relasi penghuni menempati kamar
INSERT INTO tb_kmr_penghuni (id_kamar, id_penghuni, tgl_masuk) VALUES
(1, 1, '2025-07-01'),
(2, 2, '2025-07-05');

-- Barang bawaan penghuni
INSERT INTO tb_brng_bawaan (id_penghuni, id_barang) VALUES
(1, 1), -- Budi bawa AC
(2, 2); -- Siti bawa Kulkas

-- Tagihan awal bulan
INSERT INTO tb_tagihan (bulan, id_kmr_penghuni, jml_tagihan) VALUES
('2025-08', 1, 1300000), -- Kamar A101 + AC
('2025-08', 2, 1700000); -- Kamar A102 + Kulkas

-- Pembayaran (contoh cicilan & lunas)
INSERT INTO tb_bayar (id_tagihan, jml_bayar, status) VALUES
(1, 500000, 'cicil'),
(2, 1700000, 'lunas');
