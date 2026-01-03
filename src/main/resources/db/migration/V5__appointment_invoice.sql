CREATE TABLE LichHen
(
    IdLichHen   INT IDENTITY PRIMARY KEY,
    IdNhanVien  INT,
    IdThuCung   INT,
    IdKhachHang INT,
    IdChiNhanh  INT,
    ThoiGianHen DATETIME,
    TrangThai   NVARCHAR(255)
);

CREATE TABLE GoiTiem
(
    IdGoiTiem     INT IDENTITY PRIMARY KEY,
    MaGoi         VARCHAR(255),
    TenGoi        NVARCHAR(255),
    ThoiHanThang  INT,
    PhanTramUuDai DECIMAL(5, 2)
);

CREATE TABLE DangKyGoi
(
    IdDangKyGoi INT IDENTITY PRIMARY KEY,
    MaDangKyGoi VARCHAR(255),
    NgayDangKy  DATE,
    NgayHetHan  DATE,
    GiaSauGiam  DECIMAL(15, 2),
    IdGoiTiem   INT,
    IdThuCung   INT
);

CREATE TABLE HoaDon
(
    IdHoaDon          INT IDENTITY PRIMARY KEY,
    MaHoaDon          VARCHAR(255),
    NgayLap           DATETIME,
    TongTien          DECIMAL(15, 2),
    KhuyenMai         DECIMAL(15, 2),
    TienThanhToan     DECIMAL(15, 2),
    HinhThucThanhToan NVARCHAR(255),
    TrangThai         NVARCHAR(255),
    IdNhanVien        INT,
    IdChiNhanh        INT,
    IdKhachHang       INT
);

CREATE TABLE HoaDon_MuaHang
(
    MaHoaDonMuaHang VARCHAR(255) PRIMARY KEY,
    IdSanPham       INT,
    IdDichVu        INT,
    SoLuong         INT,
    ThanhTien       DECIMAL(15, 2),
    IdHoaDon        INT
);

CREATE TABLE HoaDon_Kham
(
    MaHoaDonKham VARCHAR(255) PRIMARY KEY,
    IdHoSo       INT,
    ThoiGianKham DATETIME,
    ThanhTien    DECIMAL(15, 2),
    IdHoaDon     INT,
    IdDichVu     INT
);

CREATE TABLE HoaDon_Tiem
(
    MaHoaDonTiem VARCHAR(255) PRIMARY KEY,
    IdLichSuTiem INT,
    ThanhTien    DECIMAL(15, 2),
    IdHoaDon     INT,
    IdDichVu     INT
);

CREATE TABLE HoaDon_GoiTiem
(
    MaHoaDonGoiTiem VARCHAR(255) PRIMARY KEY,
    IdDangKyGoi     INT,
    ThanhTien       DECIMAL(15, 2),
    IdHoaDon        INT,
    IdDichVu        INT
);

CREATE TABLE DanhGia
(
    MaDanhGia           VARCHAR(255) PRIMARY KEY,
    DiemChatLuongDichVu INT,
    DiemThaiDoNhanVien  INT,
    DiemHaiLongTongThe  INT,
    BinhLuan            TEXT,
    NgayDanhGia         DATETIME,
    IdHoaDon            INT
);
