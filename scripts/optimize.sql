USE PETCARX
GO


-- ================= INDEX ====================
-- Tạo Index tối ưu cho bảng LichHen (Phiên bản Surrogate Key)
CREATE NONCLUSTERED INDEX [IDX_LichHen_NhanVien_ThoiGian]
ON [dbo].[LichHen] ([IdNhanVien], [ThoiGianHen])
INCLUDE ([TrangThai], [IdThuCung], [IdKhachHang]) -- Include các cột cần select
GO

-- 1. Tạo Partition Function
-- Chia mốc thời gian: Trước 2024, 2024, 2025, 2026, Sau 2026
CREATE PARTITION FUNCTION [PF_LichHen_ByYear](DATETIME)
AS RANGE RIGHT FOR VALUES 
('2024-01-01', '2025-01-01', '2026-01-01');
GO

-- 2. Tạo Partition Scheme
CREATE PARTITION SCHEME [PS_LichHen_ByYear]
AS PARTITION [PF_LichHen_ByYear]
ALL TO ([PRIMARY]); -- Trong thực tế, mỗi partition nên ở 1 ổ cứng riêng
GO

-- 3. Xóa bảng cũ để tạo lại bảng có Partition
IF OBJECT_ID('dbo.LichHen', 'U') IS NOT NULL 
    DROP TABLE [dbo].[LichHen];
GO

CREATE TABLE [LichHen] (
  [IdLichHen] INT IDENTITY(1,1),
  [IdNhanVien] INT NOT NULL,  
  [IdThuCung] INT NOT NULL,
  [IdKhachHang] INT NOT NULL,
  [IdChiNhanh] INT NOT NULL,
  [ThoiGianHen] datetime,
  [TrangThai] nvarchar(255)

  -- Tạo PK Composite (Id + Thời Gian) và đặt nó lên Partition Scheme
  CONSTRAINT [PK_LichHen_Partition] PRIMARY KEY CLUSTERED ([IdLichHen], [ThoiGianHen])
  ON [PS_LichHen_ByYear]([ThoiGianHen]) 
)
GO

ALTER TABLE [LichHen] ADD FOREIGN KEY ([IdNhanVien]) REFERENCES [NhanVien] ([IdNhanVien])
GO

ALTER TABLE [LichHen] ADD FOREIGN KEY ([IdThuCung]) REFERENCES [ThuCung] ([IdThuCung])
GO

ALTER TABLE [LichHen] ADD FOREIGN KEY ([IdKhachHang]) REFERENCES [KhachHang] ([IdKhachHang])
GO

ALTER TABLE [LichHen] ADD FOREIGN KEY ([IdChiNhanh]) REFERENCES [ChiNhanh] ([IdChiNhanh])
GO

-- 4. Tạo lại Index tối ưu (Cũng phải Partition theo luôn)
CREATE NONCLUSTERED INDEX [IDX_LichHen_NhanVien_ThoiGian]
ON [dbo].[LichHen] ([IdNhanVien], [ThoiGianHen])
INCLUDE ([TrangThai], [IdThuCung], [IdKhachHang])
ON [PS_LichHen_ByYear]([ThoiGianHen]); -- Index này cũng được chia nhỏ theo năm
GO


-- Tạo composite index để tối ưu truy vấn theo ChiNhanh + NgayLap
CREATE NONCLUSTERED INDEX IX_HoaDon_ChiNhanh_NgayLap
ON dbo.HoaDon (IdChiNhanh, NgayLap)
INCLUDE (TienThanhToan, IdHoaDon, TrangThai);
GO

﻿-- Tạo composite non-clustered index
CREATE NONCLUSTERED INDEX IX_LichSuTiem_MaThuCung_NgayTiem
ON LichSuTiem(IdThuCung, NgayTiem DESC)
INCLUDE (MaLichSuTiem, MuiSo, LieuLuong, MaVacXin, MaNhanVien);


CREATE NONCLUSTERED INDEX IDX_ThuCung_Id_Ten
ON ThuCung (IdThuCung)
INCLUDE (Ten, Loai, Giong);
GO

CREATE NONCLUSTERED INDEX [IDX_SanPham_LoaiThuoc_Covering]
ON [dbo].[SanPham] ([LoaiSanPham])
INCLUDE ([TenSanPham], [GiaBan]);
GO

CREATE NONCLUSTERED INDEX [IDX_TonKho_MaSanPham_GiaoDienBacSi]
ON [dbo].[TonKho] ([MaSanPham])
INCLUDE ([IdChiNhanh], [SoLuong]);
GO

CREATE NONCLUSTERED INDEX [IDX_TonKho_DoctorLookup]
ON [dbo].[TonKho] ([IdChiNhanh], [LoaiSanPham], [TenSanPham])
INCLUDE ([MaSanPham], [SoLuong]);
GO

-- Indexing for getting appointments
CREATE NONCLUSTERED INDEX IDX_ThuCung_Id_Ten
ON ThuCung (IdThuCung)
INCLUDE (Ten, Loai, Giong);
GO


CREATE NONCLUSTERED INDEX IDX_KhachHang_Id_HoTen
ON KhachHang (IdKhachHang)
INCLUDE (HoTen, SoDienThoai, TongChiTieuNamNay);
GO


-- Partitioning for HoSoKhamBenh
-- 1. Tạo Partition Function
CREATE PARTITION FUNCTION [PF_HoSoKham_ByYear](DATETIME)
AS RANGE RIGHT FOR VALUES
('2024-01-01', '2025-01-01', '2026-01-01');
GO

-- 2. Tạo Partition Scheme
CREATE PARTITION SCHEME [PS_HoSoKham_ByYear]
AS PARTITION [PF_HoSoKham_ByYear]
ALL TO ([PRIMARY]);
GO

-- 3. Xóa bảng cũ để tạo lại bảng có Partition
IF OBJECT_ID('dbo.HoSoKhamBenh', 'U') IS NOT NULL
    DROP TABLE [dbo].[HoSoKhamBenh];
GO

CREATE TABLE [dbo].[HoSoKhamBenh] (
    [IdHoSo] INT IDENTITY(1,1) NOT NULL,
    [IdThuCung] INT NOT NULL,
    [ThoiGianKham] DATETIME NOT NULL,
    [TrieuChung] NVARCHAR(MAX),
    [ChuanDoan] NVARCHAR(MAX),
    [NgayTaiKham] DATETIME,

    CONSTRAINT [PK_HoSoKhamBenh_Partition] PRIMARY KEY CLUSTERED ([IdHoSo], [ThoiGianKham])
) ON [PS_HoSoKham_ByYear]([ThoiGianKham]);
GO

ALTER TABLE [HoSoKhamBenh] ADD FOREIGN KEY ([IdThuCung]) REFERENCES [ThuCung] ([IdThuCung])
GO

ALTER TABLE [HoSoKhamBenh] ADD FOREIGN KEY ([IdBacSi]) REFERENCES [NhanVien] ([IdNhanVien])
GO

-- Optimize for getting product on storage
CREATE NONCLUSTERED INDEX [IDX_SanPham_LoaiThuoc_Covering]
ON [dbo].[SanPham] ([LoaiSanPham])
INCLUDE ([TenSanPham], [GiaBan]);
GO

IF OBJECT_ID('dbo.TonKho', 'U') IS NOT NULL
    DROP TABLE [dbo].[TonKho];
GO

CREATE TABLE [TonKho] (
  [IdChiNhanh] INT,
  [MaSanPham] nvarchar(255),
  [SoLuong] int,
  [LoaiSanPham] nvarchar(255),
  [TenSanPham] nvarchar(255),
  [SoLuongDaBan] INT,
  PRIMARY KEY ([IdChiNhanh], [MaSanPham])
)
GO

CREATE NONCLUSTERED INDEX [IDX_TonKho_DoctorLookup]
ON [dbo].[TonKho] ([IdChiNhanh], [LoaiSanPham], [TenSanPham])
INCLUDE ([MaSanPham], [SoLuong]);
GO

CREATE OR ALTER TRIGGER [trg_SyncSanPhamToTonKho]
ON [SanPham]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF UPDATE(TenSanPham) OR UPDATE(LoaiSanPham)
    BEGIN
        UPDATE tk
        SET tk.TenSanPham = i.TenSanPham,
            tk.LoaiSanPham = i.LoaiSanPham
        FROM [TonKho] tk
        INNER JOIN inserted i ON tk.MaSanPham = i.MaSanPham;
    END
END;
GO

-- Optimize for getting prescription
CREATE PARTITION FUNCTION [PF_PetCare_ByYear](DATETIME)
AS RANGE RIGHT FOR VALUES
('2024-01-01', '2025-01-01', '2026-01-01');
GO

CREATE PARTITION SCHEME [PS_PetCare_ByYear]
AS PARTITION [PF_PetCare_ByYear]
ALL TO ([PRIMARY]);
GO

DROP TABLE IF EXISTS Toa;
GO
CREATE TABLE [dbo].[Toa] (
[MaToa] NVARCHAR(255) NOT NULL,
[IdHoSo] INT NOT NULL,
[IdThuCung] INT NOT NULL,
[ThoiGianKham] DATETIME NOT NULL,
CONSTRAINT [PK_Toa] PRIMARY KEY CLUSTERED ([MaToa], [ThoiGianKham]),
CONSTRAINT [FK_Toa_HoSo] FOREIGN KEY ([IdHoSo], [ThoiGianKham])
REFERENCES [HoSoKhamBenh] ([IdHoSo], [ThoiGianKham])
) ON [PS_PetCare_ByYear]([ThoiGianKham]);

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
) ON [PS_PetCare_ByYear]([ThoiGianKham]);
GO

CREATE OR ALTER TRIGGER [trg_ToaSanPham_AllInOne_Sync]
  ON [Toa_SanPham]
  AFTER INSERT
  AS
  BEGIN
      SET NOCOUNT ON;

      -- Cập nhật đồng thời: Thời gian khám (cho Partition), Tên và Giá
      UPDATE ts
      SET ts.ThoiGianKham = t.ThoiGianKham,
          ts.TenSanPham = sp.TenSanPham,
          ts.DonGia = sp.GiaBan
      FROM Toa_SanPham ts
      INNER JOIN inserted i ON ts.MaToa = i.MaToa AND ts.MaSanPham = i.MaSanPham
      INNER JOIN Toa t ON i.MaToa = t.MaToa
      INNER JOIN SanPham sp ON i.MaSanPham = sp.MaSanPham;
  END;
  GO

CREATE NONCLUSTERED INDEX [IDX_Toa_SanPham_Export]
ON [dbo].[Toa_SanPham] ([MaToa])
INCLUDE ([TenSanPham], [SoLuong], [DonGia], [ThanhTien]);
GO