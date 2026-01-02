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

-- SỬA: Bỏ MaThuCung và MaVacXin vì không tồn tại trong bảng LichSuTiem
CREATE NONCLUSTERED INDEX IX_LichSuTiem_ThuCung_NgayTiem
ON LichSuTiem(IdThuCung, NgayTiem DESC)
INCLUDE (IdLichSuTiem, MuiSo, LieuLuong, IdVacXin, IdBacSi);
GO

CREATE NONCLUSTERED INDEX IDX_ThuCung_Id_Ten
ON ThuCung (IdThuCung)
INCLUDE (Ten, Loai, Giong);
GO

CREATE NONCLUSTERED INDEX [IDX_SanPham_LoaiThuoc_Covering]
ON [dbo].[SanPham] ([LoaiSanPham])
INCLUDE ([TenSanPham], [GiaBan]);
GO

-- SỬA: Bỏ MaSanPham vì TonKho dùng IdSanPham
CREATE NONCLUSTERED INDEX [IDX_TonKho_SanPham_GiaoDienBacSi]
ON [dbo].[TonKho] ([IdSanPham])
INCLUDE ([IdChiNhanh], [SoLuong]);
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

-- 3. Xóa các bảng có FK references đến HoSoKhamBenh trước
-- Drop Toa_SanPham trước (nó reference Toa)
IF OBJECT_ID('dbo.Toa_SanPham', 'U') IS NOT NULL
    DROP TABLE [dbo].[Toa_SanPham];
GO

-- Drop Toa (nó reference HoSoKhamBenh)
IF OBJECT_ID('dbo.Toa', 'U') IS NOT NULL
    DROP TABLE [dbo].[Toa];
GO

-- Drop HoaDon_Kham (nó reference HoSoKhamBenh)
IF OBJECT_ID('dbo.HoaDon_Kham', 'U') IS NOT NULL
    DROP TABLE [dbo].[HoaDon_Kham];
GO

-- Bây giờ mới drop HoSoKhamBenh
IF OBJECT_ID('dbo.HoSoKhamBenh', 'U') IS NOT NULL
    DROP TABLE [dbo].[HoSoKhamBenh];
GO

-- SỬA: Thêm cột IdBacSi bị thiếu
CREATE TABLE [dbo].[HoSoKhamBenh] (
    [IdHoSo] INT IDENTITY(1,1) NOT NULL,
    [IdThuCung] INT NOT NULL,
    [ThoiGianKham] DATETIME NOT NULL,
    [TrieuChung] NVARCHAR(MAX),
    [ChuanDoan] NVARCHAR(MAX),
    [NgayTaiKham] DATE,
    [IdBacSi] INT,

    CONSTRAINT [PK_HoSoKhamBenh_Partition] PRIMARY KEY CLUSTERED ([IdHoSo], [ThoiGianKham])
) ON [PS_HoSoKham_ByYear]([ThoiGianKham]);
GO

ALTER TABLE [HoSoKhamBenh] ADD FOREIGN KEY ([IdThuCung]) REFERENCES [ThuCung] ([IdThuCung])
GO

ALTER TABLE [HoSoKhamBenh] ADD FOREIGN KEY ([IdBacSi]) REFERENCES [NhanVien] ([IdNhanVien])
GO

-- Optimize for getting product on storage
IF OBJECT_ID('dbo.TonKho', 'U') IS NOT NULL
    DROP TABLE [dbo].[TonKho];
GO

-- SỬA: Thêm IdSanPham để giữ FK với SanPham
CREATE TABLE [TonKho] (
  [IdChiNhanh] INT,
  [IdSanPham] INT,
  [MaSanPham] nvarchar(255),
  [SoLuong] int,
  [LoaiSanPham] nvarchar(255),
  [TenSanPham] nvarchar(255),
  [SoLuongDaBan] INT,
  PRIMARY KEY ([IdChiNhanh], [IdSanPham]),
  FOREIGN KEY ([IdChiNhanh]) REFERENCES [ChiNhanh] ([IdChiNhanh]),
  FOREIGN KEY ([IdSanPham]) REFERENCES [SanPham] ([IdSanPham])
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
        INNER JOIN inserted i ON tk.IdSanPham = i.IdSanPham;
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

-- SỬA: Đổi IdToa thành INT và thêm cột IdToa
CREATE TABLE [dbo].[Toa] (
    [IdToa] INT IDENTITY(1,1),
    [MaToa] NVARCHAR(255) NOT NULL,
    [IdHoSo] INT NOT NULL,
    [IdThuCung] INT NOT NULL,
    [ThoiGianKham] DATETIME NOT NULL,
    CONSTRAINT [PK_Toa] PRIMARY KEY CLUSTERED ([IdToa], [ThoiGianKham]),
    CONSTRAINT [FK_Toa_HoSo] FOREIGN KEY ([IdHoSo], [ThoiGianKham])
        REFERENCES [HoSoKhamBenh] ([IdHoSo], [ThoiGianKham])
) ON [PS_PetCare_ByYear]([ThoiGianKham]);
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
        REFERENCES [Toa] ([IdToa], [ThoiGianKham]),
    CONSTRAINT [FK_ToaSP_SanPham] FOREIGN KEY ([IdSanPham])
        REFERENCES [SanPham] ([IdSanPham])
) ON [PS_PetCare_ByYear]([ThoiGianKham]);
GO

-- SỬA: Sửa trigger vì không có cột MaToa và MaSanPham trong Toa_SanPham
CREATE OR ALTER TRIGGER [trg_ToaSanPham_AllInOne_Sync]
ON [Toa_SanPham]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Cập nhật Tên và Giá từ SanPham
    UPDATE ts
    SET ts.TenSanPham = sp.TenSanPham,
        ts.DonGia = sp.GiaBan
    FROM Toa_SanPham ts
    INNER JOIN inserted i ON ts.IdToa = i.IdToa AND ts.IdSanPham = i.IdSanPham
    INNER JOIN SanPham sp ON i.IdSanPham = sp.IdSanPham;
END;
GO

-- SỬA: Bỏ MaToa vì không tồn tại trong Toa_SanPham mới
CREATE NONCLUSTERED INDEX [IDX_Toa_SanPham_Export]
ON [dbo].[Toa_SanPham] ([IdToa])
INCLUDE ([TenSanPham], [SoLuong], [DonGia], [ThanhTien]);
GO

-- Tạo lại bảng HoaDon_Kham
CREATE TABLE [HoaDon_Kham] (
  [MaHoaDonKham] VARCHAR(255) PRIMARY KEY,
  [IdHoSo] INT,
  [ThoiGianKham] DATETIME,
  [ThanhTien] DECIMAL(15,2),
  [IdHoaDon] INT,
  [IdDichVu] INT,
  FOREIGN KEY ([IdHoaDon]) REFERENCES [HoaDon] ([IdHoaDon]),
  FOREIGN KEY ([IdDichVu]) REFERENCES [DichVu] ([IdDichVu]),
  FOREIGN KEY ([IdHoSo], [ThoiGianKham]) REFERENCES [HoSoKhamBenh] ([IdHoSo], [ThoiGianKham])
);
GO

-- Check kết quả optimize:
-- =============================================
-- 1. XEM TẤT CẢ CÁC INDEX TRONG DATABASE
-- =============================================
SELECT
    OBJECT_NAME(i.object_id) AS TableName,
    i.name AS IndexName,
    i.type_desc AS IndexType,
    STRING_AGG(c.name, ', ') WITHIN GROUP (ORDER BY ic.key_ordinal) AS IndexedColumns
FROM sys.indexes i
INNER JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
INNER JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
WHERE OBJECT_NAME(i.object_id) NOT LIKE 'sys%'
    AND i.type_desc != 'HEAP'
GROUP BY OBJECT_NAME(i.object_id), i.name, i.type_desc, i.index_id
ORDER BY TableName, IndexName;
GO

-- =============================================
-- 3. XEM TẤT CẢ CÁC PARTITION FUNCTION
-- =============================================
SELECT
    pf.name AS PartitionFunctionName,
    pf.type_desc AS PartitionType,
    pf.fanout AS NumberOfPartitions,
    prv.value AS BoundaryValue
FROM sys.partition_functions pf
LEFT JOIN sys.partition_range_values prv ON pf.function_id = prv.function_id
ORDER BY pf.name, prv.boundary_id;
GO

-- =============================================
-- 4. XEM TẤT CẢ CÁC PARTITION SCHEME
-- =============================================
SELECT
    ps.name AS PartitionSchemeName,
    pf.name AS PartitionFunctionName,
    ds.name AS FileGroupName
FROM sys.partition_schemes ps
INNER JOIN sys.partition_functions pf ON ps.function_id = pf.function_id
INNER JOIN sys.destination_data_spaces dds ON ps.data_space_id = dds.partition_scheme_id
INNER JOIN sys.data_spaces ds ON dds.data_space_id = ds.data_space_id
ORDER BY ps.name, dds.destination_id;
GO

