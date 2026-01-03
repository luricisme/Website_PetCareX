CREATE TABLE HangThanhVien
(
    IdHang          INT IDENTITY PRIMARY KEY,
    MaHang          VARCHAR(20) UNIQUE NOT NULL,
    TenHang         NVARCHAR(255),
    HanMucThangHang DECIMAL(15, 2),
    HanMucGiuHang   DECIMAL(15, 2),
    UuDaiGiamGia    DECIMAL(5, 2)
);

CREATE TABLE KhachHang
(
    IdKhachHang       INT IDENTITY PRIMARY KEY,
    MaKhachHang       VARCHAR(20) UNIQUE NOT NULL,
    CCCD              VARCHAR(12),
    HoTen             NVARCHAR(255),
    SoDienThoai       VARCHAR(15),
    TongChiTieuNamNay DECIMAL(15, 2),
    GioiTinh          NVARCHAR(10) CHECK (GioiTinh IN (N'Nam', N'Nữ', N'Khác')),
    NgaySinh          DATE,
    DiemLoyalty       INT,
    IdHang            INT,
    IdAccount         INT
);

CREATE TABLE ThuCung
(
    IdThuCung        INT IDENTITY PRIMARY KEY,
    MaThuCung        VARCHAR(20) UNIQUE NOT NULL,
    Ten              NVARCHAR(255),
    Loai             NVARCHAR(255),
    Giong            NVARCHAR(255),
    GioiTinh         NVARCHAR(10) CHECK (GioiTinh IN (N'Nam', N'Nữ', N'Khác')),
    NgaySinh         DATE,
    TinhTrangSucKhoe NVARCHAR(MAX),
    Chu              INT
);
