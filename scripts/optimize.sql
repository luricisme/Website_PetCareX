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
ON dbo.HoaDon (MaChiNhanh, NgayLap)
INCLUDE (TienThanhToan, MaHoaDon, TrangThai);
GO

﻿-- Tạo composite non-clustered index
CREATE NONCLUSTERED INDEX IX_LichSuTiem_MaThuCung_NgayTiem
ON LichSuTiem(MaThuCung, NgayTiem DESC)
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