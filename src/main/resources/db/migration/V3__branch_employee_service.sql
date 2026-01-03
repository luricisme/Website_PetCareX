CREATE TABLE ChiNhanh
(
    IdChiNhanh  INT IDENTITY PRIMARY KEY,
    MaChiNhanh  VARCHAR(20) UNIQUE NOT NULL,
    TenChiNhanh NVARCHAR(255),
    DiaChi      NVARCHAR(255),
    SoDienThoai VARCHAR(15),
    GioMoCua    TIME,
    GioDongCua  TIME
);

CREATE TABLE DichVu
(
    IdDichVu  INT IDENTITY PRIMARY KEY,
    MaDichVu  VARCHAR(255),
    TenDichVu NVARCHAR(255),
    MoTa      NVARCHAR(MAX),
    GiaDichVu DECIMAL(15, 2)
);

CREATE TABLE ChiNhanh_DichVu
(
    IdDichVu   INT,
    IdChiNhanh INT,
    PRIMARY KEY (IdDichVu, IdChiNhanh)
);

CREATE TABLE ChucVu
(
    IdChucVu   INT IDENTITY PRIMARY KEY,
    MaChucVu   VARCHAR(20) UNIQUE NOT NULL,
    TenChucVu  NVARCHAR(255),
    LuongCoBan DECIMAL(15, 2)
);

CREATE TABLE NhanVien
(
    IdNhanVien INT IDENTITY PRIMARY KEY,
    MaNhanVien VARCHAR(20) UNIQUE NOT NULL,
    HoTen      NVARCHAR(255),
    GioiTinh   NVARCHAR(10) CHECK (GioiTinh IN (N'Nam', N'Nữ', N'Khác')),
    NgaySinh   DATE,
    NgayVaoLam DATE,
    ChucVu     INT,
    ChiNhanh   INT,
    IdAccount  INT
);

CREATE TABLE LichSuDieuDong
(
    IdChiNhanhDen INT,
    IdChiNhanhDi  INT,
    NgayChuyen    DATE,
    IdNhanVien    INT,
    PRIMARY KEY (IdChiNhanhDen, IdChiNhanhDi, NgayChuyen, IdNhanVien)
);
