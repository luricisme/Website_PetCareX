
USE master;
GO

-- =============================================
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'PETCARX')
BEGIN
    CREATE DATABASE PETCARX;
    PRINT 'Database PETCARX created successfully';
END
ELSE
BEGIN
    PRINT 'Database PETCARX already exists';
END
GO

USE PETCARX
GO

DROP TABLE IF EXISTS Account;
GO
CREATE TABLE [Account] (
    [IdAccount] INT IDENTITY(1,1) PRIMARY KEY,
    [Username] VARCHAR(50) UNIQUE NOT NULL,
    [Password] VARCHAR(255) NOT NULL,
    [CreatedAt] DATETIME DEFAULT GETDATE()
);

DROP TABLE IF EXISTS Role;
GO
CREATE TABLE [Role] (
    [IdRole] INT IDENTITY(1,1) PRIMARY KEY,
    [RoleName] VARCHAR(50) UNIQUE NOT NULL,
    Description NVARCHAR(255)
);
GO

DROP TABLE IF EXISTS [Permission];
GO
CREATE TABLE Permission (
    [IdPermission] INT IDENTITY(1,1) PRIMARY KEY,
    [PermissionName] VARCHAR(100) UNIQUE NOT NULL,
);
GO

DROP TABLE IF EXISTS Account_Role;
GO
CREATE TABLE Account_Role(
    IdAccount INT NOT NULL,
    IdRole INT NOT NULL,
    PRIMARY KEY (IdAccount, IdRole),
    FOREIGN KEY (IdAccount) REFERENCES Account(IdAccount),
    FOREIGN KEY (IdRole) REFERENCES Role(IdRole)
);
GO

DROP TABLE IF EXISTS Role_Permission;
GO
CREATE TABLE Role_Permission(
    IdRole INT NOT NULL,
    IdPermission INT NOT NULL,
    PRIMARY KEY (IdRole, IdPermission),
    FOREIGN KEY (IdRole) REFERENCES Role(IdRole) ON DELETE CASCADE,
    FOREIGN KEY (IdPermission) REFERENCES Permission(IdPermission)
);
GO

-- TẠO BẢNG KHÁC HÀNG
DROP TABLE IF EXISTS KhachHang;
GO
CREATE TABLE [KhachHang](
    [IdKhachHang] INT IDENTITY (1,1) PRIMARY KEY,
    [MaKhachHang] VARCHAR(20) NOT NULL UNIQUE,
    [CCCD] VARCHAR(12),  -- CCCD chuyển thành VARCHAR(12)
    [HoTen] NVARCHAR(255),
    [SoDienThoai] VARCHAR(15), -- SĐT thoại đổi thành VARCHAR(11)
    [TongChiTieuNamNay] DECIMAL(15,2), -- đổi thành DICIMAL(15,2)
    [GioiTinh] NVARCHAR(10) CHECK (GioiTinh IN (N'Nam', N'Nữ', N'Khác')),
    [NgaySinh] DATE, -- NgaySinh đổi từ DATETIME sang DATE (không có thời gian, chỉ có ngày)
    [DiemLoyalty] INT,
    [IdHang] INT,
    [IdAccount] INT,
    FOREIGN KEY (IdAccount) REFERENCES Account(IdAccount)
);
GO
-- =================================================== --

-- HẠNG THÀNH VIÊN
DROP TABLE IF EXISTS HangThanhVien;
GO
CREATE TABLE [HangThanhVien] (
  [IdHang] INT IDENTITY(1,1) PRIMARY KEY,
  [MaHang] VARCHAR(20) NOT NULL UNIQUE,
  [TenHang] NVARCHAR(255),
  [HanMucThangHang] DECIMAL(15,2),
  [HanMucGiuHang] DECIMAL(15,2),
  [UuDaiGiamGia] DECIMAL(5,2)
);
GO
-- =================================================== --

-- THÚ CƯNG
DROP TABLE IF EXISTS ThuCung;
GO
CREATE TABLE [ThuCung] (
  [IdThuCung] INT IDENTITY(1,1) PRIMARY KEY,
  [MaThuCung] VARCHAR(20) NOT NULL UNIQUE,
  [Ten] NVARCHAR(255),
  [Loai] NVARCHAR(255),
  [Giong] NVARCHAR(255),
  [GioiTinh] NVARCHAR(10) CHECK (GioiTinh IN (N'Nam', N'Nữ', N'Khác')), -- thêm check value
  [NgaySinh] DATE, -- đổi thành DATE
  [TinhTrangSucKhoe] NVARCHAR(MAX),
  [Chu] INT -- Tham chiếu đến id khách hàng
);
GO
-- =================================================== --

-- CHI NHÁNH
DROP TABLE IF EXISTS ChiNhanh;
GO
CREATE TABLE [ChiNhanh] (
  [IdChiNhanh] INT IDENTITY(1,1) PRIMARY KEY, -- SK
  [MaChiNhanh] VARCHAR(20) NOT NULL UNIQUE, -- 
  [TenChiNhanh] NVARCHAR(255),
  [DiaChi] NVARCHAR(255),
  [SoDienThoai] VARCHAR(15),
  [GioMoCua] TIME,
  [GioDongCua] TIME
);
GO
-- =================================================== --

DROP TABLE IF EXISTS DichVu;
GO
CREATE TABLE [DichVu] (
  [IdDichVu] INT IDENTITY (1,1) PRIMARY KEY,
  [MaDichVu] VARCHAR(255),
  [TenDichVu] NVARCHAR(255),
  [MoTa] NVARCHAR(MAX),
  [GiaDichVu] DECIMAL(15,2)
);
GO
-- =================================================== --

DROP TABLE IF EXISTS ChiNhanh_DichVu;
GO
CREATE TABLE [ChiNhanh_DichVu] (
  [IdDichVu] INT, 
  [IdChiNhanh] INT,
  PRIMARY KEY ([IdDichVu], [IdChiNhanh])
);
GO
-- =================================================== --

DROP TABLE IF EXISTS ChucVu;
GO
CREATE TABLE [ChucVu] (
  [IdChucVu] INT IDENTITY(1,1) PRIMARY KEY,
  [MaChucVu] VARCHAR(20) NOT NULL UNIQUE, -- business key
  [TenChucVu] NVARCHAR(255),
  [LuongCoBan] DECIMAL(15,2)
);
GO
-- =================================================== --

DROP TABLE IF EXISTS NhanVien;
GO
CREATE TABLE [NhanVien] (
  [IdNhanVien] INT IDENTITY(1,1) PRIMARY KEY,
  [MaNhanVien] VARCHAR(20) NOT NULL UNIQUE,
  [HoTen] NVARCHAR(255),
  [GioiTinh] NVARCHAR(10) CHECK (GioiTinh IN (N'Nam', N'Nữ', N'Khác')), -- thêm check value
  [NgaySinh] DATE, -- ĐỔI THÀNH DATE
  [NgayVaoLam] DATE, -- ĐỎI THÀNH DATE
  [ChucVu] INT, -- THAM CHIẾU IdChucVu
  [ChiNhanh] INT, -- THAM CHIẾU IdChiNhanh
  [IdAccount] INT,
  FOREIGN KEY (IdAccount) REFERENCES Account(IdAccount)
);
GO
-- =================================================== --

DROP TABLE IF EXISTS LichSuDieuDong;
GO
CREATE TABLE [LichSuDieuDong] (
  [IdChiNhanhDen] INT,
  [IdChiNhanhDi] INT,
  [NgayChuyen] DATE, -- ĐỔI THÀNH DATE
  [IdNhanVien] INT,
  PRIMARY KEY ([IdChiNhanhDen], [IdChiNhanhDi], [NgayChuyen], [IdNhanVien])
);
GO
-- =================================================== --


DROP TABLE IF EXISTS SanPham;
GO
CREATE TABLE [SanPham] (
  [IdSanPham] INT IDENTITY(1,1) PRIMARY KEY,
  [MaSanPham] VARCHAR(255), -- đổi thành VARCHAR
  [TenSanPham] NVARCHAR(255),
  [LoaiSanPham] NVARCHAR(255),
  [GiaBan] DECIMAL(15,2),
  [NhaSanXuat] NVARCHAR(255),
  [HanSuDung] DATE,
  [HinhAnh] VARCHAR(MAX)
);
GO
-- =================================================== --

DROP TABLE IF EXISTS VacXin;
GO
CREATE TABLE [VacXin] (
  [IdVacXin] INT PRIMARY KEY, -- Tham chiếu đến IdSanPham
  [MaVacXin] VARCHAR(255),
  [LoaiVacXin] NVARCHAR(255)
);
GO
-- =================================================== --

DROP TABLE IF EXISTS TonKho;
GO
CREATE TABLE [TonKho] (
  [IdChiNhanh] INT NOT NULL,
  [IdSanPham] INT NOT NULL,
  [SoLuong] INT,
  [SoLuongDaBan] INT,
  PRIMARY KEY ([IdChiNhanh], [IdSanPham])
);
GO
-- =================================================== --

DROP TABLE IF EXISTS HoSoKhamBenh;
GO

CREATE TABLE [HoSoKhamBenh] (
    [IdHoSo] INT IDENTITY(1,1) NOT NULL,
    [IdThuCung] INT NOT NULL,
    [ThoiGianKham] DATETIME NOT NULL,
    [TrieuChung] NVARCHAR(MAX),
    [ChuanDoan] NVARCHAR(MAX),
    [NgayTaiKham] DATE, -- ngày tái khám đổi thành DATE
    [IdBacSi] INT, -- Tham chiếu tới nhân viên

    CONSTRAINT [PK_HoSoKhamBenh_Partition] PRIMARY KEY CLUSTERED ([IdHoSo], [ThoiGianKham])
);
GO
-- =================================================== --

DROP TABLE IF EXISTS Toa;
GO
CREATE TABLE [Toa] (
    [IdToa] INT IDENTITY(1,1),
    [MaToa] VARCHAR(255) NOT NULL,
    [IdHoSo] INT NOT NULL,
    [IdThuCung] INT NOT NULL,
    [ThoiGianKham] DATETIME NOT NULL,
    CONSTRAINT [PK_Toa] PRIMARY KEY CLUSTERED ([IdToa], [ThoiGianKham]),
    CONSTRAINT [FK_Toa_HoSo] FOREIGN KEY ([IdHoSo], [ThoiGianKham]) 
        REFERENCES [HoSoKhamBenh] ([IdHoSo], [ThoiGianKham])
);
GO
-- =================================================== --


DROP TABLE IF EXISTS Toa_SanPham;
GO
CREATE TABLE [Toa_SanPham] (
    [IdToa] INT NOT NULL,
    [IdSanPham] INT NOT NULL,
    [SoLuong] INT NOT NULL,
    [ThoiGianKham] DATETIME NOT NULL, 
    [TenSanPham] NVARCHAR(255),
    [DonGia] DECIMAL(18,2),
    [ThanhTien] AS (CAST(SoLuong * DonGia AS DECIMAL(18,2))) PERSISTED,
    CONSTRAINT [PK_Toa_SanPham] PRIMARY KEY CLUSTERED ([IdToa], [IdSanPham], [ThoiGianKham]),
    CONSTRAINT [FK_ToaSP_Toa] FOREIGN KEY ([IdToa], [ThoiGianKham]) 
        REFERENCES [Toa] ([IdToa], [ThoiGianKham])
);
GO
-- =================================================== --

DROP TABLE IF EXISTS LichSuTiem;
GO
CREATE TABLE [LichSuTiem] (
  [IdLichSuTiem] INT IDENTITY(1,1) PRIMARY KEY,
  [MaLichSuTiem] VARCHAR(255),
  [IdThuCung] INT,
  [MaVacXin] VARCHAR(255),
  [IdBacSi] INT, -- đổi tên lại thành IdBacSi
  [NgayTiem] DATE,
  [LieuLuong] NVARCHAR(255),
  [MuiSo] NVARCHAR(255)
);
GO
-- =================================================== --

DROP TABLE IF EXISTS LichHen;
GO
CREATE TABLE [LichHen] (
  [IdLichHen] INT IDENTITY(1,1) PRIMARY KEY,
  [IdNhanVien] INT NOT NULL,  
  [IdThuCung] INT NOT NULL,
  [IdKhachHang] INT NOT NULL,
  [IdChiNhanh] INT NOT NULL,
  [ThoiGianHen] DATETIME,
  [TrangThai] NVARCHAR(255)
);
GO
-- =================================================== --

DROP TABLE IF EXISTS GoiTiem;
GO
CREATE TABLE [GoiTiem] (
  [IdGoiTiem] INT IDENTITY(1,1) PRIMARY KEY,
  [MaGoi] VARCHAR(255),
  [TenGoi] NVARCHAR(255),
  [ThoiHanThang] INT,
  [PhanTramUuDai] DECIMAL(5,2) -- Chuyển float sang decimal(5,2)
);
GO
-- =================================================== --

DROP TABLE IF EXISTS DangKyGoi;
GO
CREATE TABLE [DangKyGoi] (
  [IdDangKyGoi] INT IDENTITY(1,1) PRIMARY KEY,
  [MaDangKyGoi] VARCHAR(255), -- ĐỔI THÀNH VARCHAR
  [NgayDangKy] DATE,
  [NgayHetHan] DATE,
  [GiaSauGiam] DECIMAL(15,2),
  [IdGoiTiem] INT, -- Tham chiếu đến IdGoiTiem
  [IdThuCung] INT
);
GO
-- =================================================== --

DROP TABLE IF EXISTS HoaDon;
GO
CREATE TABLE [HoaDon] (
  [IdHoaDon] INT IDENTITY(1,1) PRIMARY KEY,
  [MaHoaDon] VARCHAR(255),
  [NgayLap] DATETIME,
  [TongTien] DECIMAL(15,2),
  [KhuyenMai] DECIMAL(15,2),
  [TienThanhToan] DECIMAL(15,2),
  [HinhThucThanhToan] nvarchar(255),
  [TrangThai] nvarchar(255),
  [IdNhanVien] INT,
  [IdChiNhanh] INT,
  [IdKhachHang] INT
);
GO


-- =================================================== --
DROP TABLE IF EXISTS HoaDon_MuaHang;
GO
CREATE TABLE [HoaDon_MuaHang] (
  [MaHoaDonMuaHang] VARCHAR(255) PRIMARY KEY, -- ĐỔI THÀNH VARCHAR
  [IdSanPham] INT,
  [IdDichVu] INT,
  [SoLuong] INT,
  [ThanhTien] DECIMAL(15,2),
  [IdHoaDon] INT, -- Tham chiếu đến Id Hóa đơn
);
GO


DROP TABLE IF EXISTS HoaDon_Kham;
GO
CREATE TABLE [HoaDon_Kham] (
  [MaHoaDonKham] VARCHAR(255) PRIMARY KEY,
  [IdHoSo] INT,
  [ThoiGianKham] DATETIME,
  [ThanhTien] DECIMAL(15,2),
  [IdHoaDon] INT,
  [IdDichVu] INT
);
GO

DROP TABLE IF EXISTS HoaDon_Tiem;
GO
CREATE TABLE [HoaDon_Tiem] (
  [MaHoaDonTiem] VARCHAR(255) PRIMARY KEY,
  [IdLichSuTiem] INT,
  [ThanhTien] DECIMAL(15,2),
  [IdHoaDon] INT,
  [IdDichVu] INT
);
GO


DROP TABLE IF EXISTS HoaDon_GoiTiem;
GO
CREATE TABLE [HoaDon_GoiTiem] (
  [MaHoaDonGoiTiem] VARCHAR(255) PRIMARY KEY,
  [IdDangKyGoi] INT,
  [ThanhTien] DECIMAL(15,2),
  [IdHoaDon] INT,
  [IdDichVu] INT,
);
GO


DROP TABLE IF EXISTS DanhGia;
GO
CREATE TABLE [DanhGia] (
  [MaDanhGia] VARCHAR(255) PRIMARY KEY,
  [DiemChatLuongDichVu] INT,
  [DiemThaiDoNhanVien] INT,
  [DiemHaiLongTongThe] INT,
  [BinhLuan] TEXT,
  [NgayDanhGia] DATETIME,
  [IdHoaDon] INT
);
GO

-- ===================== THÊM RÀNG BUỘC KHÓA NGOẠI ====================================== --
ALTER TABLE [KhachHang] ADD FOREIGN KEY ([IdHang]) REFERENCES [HangThanhVien] ([IdHang])
GO

ALTER TABLE [ThuCung] ADD FOREIGN KEY ([Chu]) REFERENCES [KhachHang] ([IdKhachHang])
GO

ALTER TABLE [NhanVien] ADD FOREIGN KEY ([ChucVu]) REFERENCES [ChucVu] ([IdChucVu])
GO

ALTER TABLE [NhanVien] ADD FOREIGN KEY ([ChiNhanh]) REFERENCES [ChiNhanh] ([IdChiNhanh])
GO


ALTER TABLE [LichSuDieuDong] ADD FOREIGN KEY ([IdChiNhanhDen]) REFERENCES [ChiNhanh] ([IdChiNhanh])
GO

ALTER TABLE [LichSuDieuDong] ADD FOREIGN KEY ([IdChiNhanhDi]) REFERENCES [ChiNhanh] ([IdChiNhanh])
GO

ALTER TABLE [LichSuDieuDong] ADD FOREIGN KEY ([IdNhanVien]) REFERENCES [NhanVien] ([IdNhanVien])
GO

ALTER TABLE [ChiNhanh_DichVu] ADD FOREIGN KEY ([IdDichVu]) REFERENCES [DichVu] ([IdDichVu])
GO

ALTER TABLE [ChiNhanh_DichVu] ADD FOREIGN KEY ([IdChiNhanh]) REFERENCES [ChiNhanh] ([IdChiNhanh])
GO

ALTER TABLE [VacXin] ADD FOREIGN KEY ([IdVacXin]) REFERENCES [SanPham] ([IdSanPham])
GO


ALTER TABLE [TonKho] ADD FOREIGN KEY ([IdChiNhanh]) REFERENCES [ChiNhanh] ([IdChiNhanh])
GO

ALTER TABLE [TonKho] ADD FOREIGN KEY ([IdSanPham]) REFERENCES [SanPham] ([IdSanPham])
GO


ALTER TABLE [HoSoKhamBenh] ADD FOREIGN KEY ([IdThuCung]) REFERENCES [ThuCung] ([IdThuCung])
GO

ALTER TABLE [HoSoKhamBenh] ADD FOREIGN KEY ([IdBacSi]) REFERENCES [NhanVien] ([IdNhanVien])
GO

ALTER TABLE [Toa] ADD FOREIGN KEY ([IdHoSo], [ThoiGianKham]) REFERENCES [HoSoKhamBenh] ([IdHoSo], [ThoiGianKham])
GO

ALTER TABLE [Toa_SanPham] ADD FOREIGN KEY ([IdToa]) REFERENCES [Toa] ([IdToa])
GO

ALTER TABLE [Toa_SanPham] ADD FOREIGN KEY ([IdSanPham]) REFERENCES [SanPham] ([IdSanPham])
GO

ALTER TABLE [LichSuTiem] ADD FOREIGN KEY ([IdThuCung]) REFERENCES [ThuCung] ([IdThuCung])
GO

ALTER TABLE [LichSuTiem] ADD FOREIGN KEY ([IdVacXin]) REFERENCES [VacXin] ([IdVacXin])
GO

ALTER TABLE [LichSuTiem] ADD FOREIGN KEY ([IdBacSi]) REFERENCES [NhanVien] ([IdNhanVien])
GO

ALTER TABLE [LichHen] ADD FOREIGN KEY ([IdNhanVien]) REFERENCES [NhanVien] ([IdNhanVien])
GO

ALTER TABLE [LichHen] ADD FOREIGN KEY ([IdThuCung]) REFERENCES [ThuCung] ([IdThuCung])
GO

ALTER TABLE [LichHen] ADD FOREIGN KEY ([IdKhachHang]) REFERENCES [KhachHang] ([IdKhachHang])
GO

ALTER TABLE [LichHen] ADD FOREIGN KEY ([IdChiNhanh]) REFERENCES [ChiNhanh] ([IdChiNhanh])
GO

ALTER TABLE [DangKyGoi] ADD FOREIGN KEY ([IdGoiTiem]) REFERENCES [GoiTiem] ([IdGoiTiem])
GO

ALTER TABLE [DangKyGoi] ADD FOREIGN KEY ([IdThuCung]) REFERENCES [ThuCung] ([IdThuCung])
GO

ALTER TABLE [HoaDon] ADD FOREIGN KEY ([IdNhanVien]) REFERENCES [NhanVien] ([IdNhanVien])
GO

ALTER TABLE [HoaDon] ADD FOREIGN KEY ([IdChiNhanh]) REFERENCES [ChiNhanh] ([IdChiNhanh])
GO

ALTER TABLE [HoaDon] ADD FOREIGN KEY ([IdKhachHang]) REFERENCES [KhachHang] ([IdKhachHang])
GO

ALTER TABLE [HoaDon_MuaHang] ADD FOREIGN KEY ([IdSanPham]) REFERENCES [SanPham] ([IdSanPham])
GO

ALTER TABLE [HoaDon_MuaHang] ADD FOREIGN KEY ([IdDichVu]) REFERENCES [DichVu] ([IdDichVu])
GO

ALTER TABLE [HoaDon_MuaHang] ADD FOREIGN KEY ([IdHoaDon]) REFERENCES [HoaDon] ([IdHoaDon])
GO

ALTER TABLE [HoaDon_Kham] ADD FOREIGN KEY ([IdHoaDon]) REFERENCES [HoaDon] ([IdHoaDon])
GO

ALTER TABLE [HoaDon_Kham] ADD FOREIGN KEY ([IdDichVu]) REFERENCES [DichVu] ([IdDichVu])
GO

ALTER TABLE [HoaDon_Kham] ADD FOREIGN KEY ([IdHoSo], [ThoiGianKham]) REFERENCES [HoSoKhamBenh] ([IdHoSo], [ThoiGianKham])
GO

ALTER TABLE [HoaDon_Tiem] ADD FOREIGN KEY ([IdLichSuTiem]) REFERENCES [LichSuTiem] ([IdLichSuTiem])
GO

ALTER TABLE [HoaDon_Tiem] ADD FOREIGN KEY ([IdHoaDon]) REFERENCES [HoaDon] ([IdHoaDon])
GO

ALTER TABLE [HoaDon_Tiem] ADD FOREIGN KEY ([IdDichVu]) REFERENCES [DichVu] ([IdDichVu])
GO

ALTER TABLE [HoaDon_GoiTiem] ADD FOREIGN KEY ([IdDangKyGoi]) REFERENCES [DangKyGoi] ([IdDangKyGoi])
GO

ALTER TABLE [HoaDon_GoiTiem] ADD FOREIGN KEY ([IdHoaDon]) REFERENCES [HoaDon] ([IdHoaDon])
GO

ALTER TABLE [HoaDon_GoiTiem] ADD FOREIGN KEY ([IdDichVu]) REFERENCES [DichVu] ([IdDichVu])
GO

ALTER TABLE [DanhGia] ADD FOREIGN KEY ([IdHoaDon]) REFERENCES [HoaDon] ([IdHoaDon])
GO