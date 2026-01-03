CREATE TABLE SanPham
(
    IdSanPham   INT IDENTITY PRIMARY KEY,
    MaSanPham   VARCHAR(255),
    TenSanPham  NVARCHAR(255),
    LoaiSanPham NVARCHAR(255),
    GiaBan      DECIMAL(15, 2),
    NhaSanXuat  NVARCHAR(255),
    HanSuDung   DATE,
    HinhAnh     VARCHAR(MAX
)
    );

CREATE TABLE VacXin
(
    IdVacXin   INT PRIMARY KEY,
    MaVacXin   VARCHAR(255),
    LoaiVacXin NVARCHAR(255)
);

CREATE TABLE TonKho
(
    IdChiNhanh   INT,
    IdSanPham    INT,
    SoLuong      INT,
    SoLuongDaBan INT,
    PRIMARY KEY (IdChiNhanh, IdSanPham)
);

CREATE TABLE HoSoKhamBenh
(
    IdHoSo       INT IDENTITY NOT NULL,
    IdThuCung    INT      NOT NULL,
    ThoiGianKham DATETIME NOT NULL,
    TrieuChung   NVARCHAR(MAX),
    ChuanDoan    NVARCHAR(MAX),
    NgayTaiKham  DATE,
    IdBacSi      INT,
    PRIMARY KEY (IdHoSo, ThoiGianKham)
);

CREATE TABLE Toa
(
    IdToa        INT IDENTITY,
    MaToa        VARCHAR(255) NOT NULL,
    IdHoSo       INT          NOT NULL,
    IdThuCung    INT          NOT NULL,
    ThoiGianKham DATETIME     NOT NULL,
    PRIMARY KEY (IdToa, ThoiGianKham)
);

CREATE TABLE Toa_SanPham
(
    IdToa        INT,
    IdSanPham    INT,
    SoLuong      INT,
    ThoiGianKham DATETIME,
    TenSanPham   NVARCHAR(255),
    DonGia       DECIMAL(18, 2),
    ThanhTien AS (CAST(SoLuong * DonGia AS DECIMAL(18,2))) PERSISTED,
    PRIMARY KEY (IdToa, IdSanPham, ThoiGianKham)
);

CREATE TABLE LichSuTiem
(
    IdLichSuTiem INT IDENTITY PRIMARY KEY,
    MaLichSuTiem VARCHAR(255),
    IdThuCung    INT,
    MaVacXin     VARCHAR(255),
    IdBacSi      INT,
    NgayTiem     DATE,
    LieuLuong    NVARCHAR(255),
    MuiSo        NVARCHAR(255)
);
