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
