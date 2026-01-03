ALTER TABLE KhachHang
    ADD FOREIGN KEY (IdHang) REFERENCES HangThanhVien (IdHang);
ALTER TABLE KhachHang
    ADD FOREIGN KEY (IdAccount) REFERENCES Account (IdAccount);

ALTER TABLE ThuCung
    ADD FOREIGN KEY (Chu) REFERENCES KhachHang (IdKhachHang);

ALTER TABLE NhanVien
    ADD FOREIGN KEY (ChucVu) REFERENCES ChucVu (IdChucVu);
ALTER TABLE NhanVien
    ADD FOREIGN KEY (ChiNhanh) REFERENCES ChiNhanh (IdChiNhanh);
ALTER TABLE NhanVien
    ADD FOREIGN KEY (IdAccount) REFERENCES Account (IdAccount);

ALTER TABLE LichSuDieuDong
    ADD FOREIGN KEY (IdChiNhanhDen) REFERENCES ChiNhanh (IdChiNhanh);
ALTER TABLE LichSuDieuDong
    ADD FOREIGN KEY (IdChiNhanhDi) REFERENCES ChiNhanh (IdChiNhanh);
ALTER TABLE LichSuDieuDong
    ADD FOREIGN KEY (IdNhanVien) REFERENCES NhanVien (IdNhanVien);

ALTER TABLE ChiNhanh_DichVu
    ADD FOREIGN KEY (IdDichVu) REFERENCES DichVu (IdDichVu);
ALTER TABLE ChiNhanh_DichVu
    ADD FOREIGN KEY (IdChiNhanh) REFERENCES ChiNhanh (IdChiNhanh);

ALTER TABLE VacXin
    ADD FOREIGN KEY (IdVacXin) REFERENCES SanPham (IdSanPham);

ALTER TABLE TonKho
    ADD FOREIGN KEY (IdChiNhanh) REFERENCES ChiNhanh (IdChiNhanh);
ALTER TABLE TonKho
    ADD FOREIGN KEY (IdSanPham) REFERENCES SanPham (IdSanPham);

ALTER TABLE HoSoKhamBenh
    ADD FOREIGN KEY (IdThuCung) REFERENCES ThuCung (IdThuCung);
ALTER TABLE HoSoKhamBenh
    ADD FOREIGN KEY (IdBacSi) REFERENCES NhanVien (IdNhanVien);

ALTER TABLE Toa
    ADD FOREIGN KEY (IdHoSo, ThoiGianKham)
        REFERENCES HoSoKhamBenh (IdHoSo, ThoiGianKham);

ALTER TABLE Toa_SanPham
    ADD FOREIGN KEY (IdToa, ThoiGianKham)
        REFERENCES Toa (IdToa, ThoiGianKham);

ALTER TABLE Toa_SanPham
    ADD FOREIGN KEY (IdSanPham) REFERENCES SanPham (IdSanPham);

ALTER TABLE LichSuTiem
    ADD FOREIGN KEY (IdThuCung) REFERENCES ThuCung (IdThuCung);
ALTER TABLE LichSuTiem
    ADD FOREIGN KEY (IdBacSi) REFERENCES NhanVien (IdNhanVien);

ALTER TABLE LichHen
    ADD FOREIGN KEY (IdNhanVien) REFERENCES NhanVien (IdNhanVien);
ALTER TABLE LichHen
    ADD FOREIGN KEY (IdThuCung) REFERENCES ThuCung (IdThuCung);
ALTER TABLE LichHen
    ADD FOREIGN KEY (IdKhachHang) REFERENCES KhachHang (IdKhachHang);
ALTER TABLE LichHen
    ADD FOREIGN KEY (IdChiNhanh) REFERENCES ChiNhanh (IdChiNhanh);

ALTER TABLE DangKyGoi
    ADD FOREIGN KEY (IdGoiTiem) REFERENCES GoiTiem (IdGoiTiem);
ALTER TABLE DangKyGoi
    ADD FOREIGN KEY (IdThuCung) REFERENCES ThuCung (IdThuCung);

ALTER TABLE HoaDon
    ADD FOREIGN KEY (IdNhanVien) REFERENCES NhanVien (IdNhanVien);
ALTER TABLE HoaDon
    ADD FOREIGN KEY (IdChiNhanh) REFERENCES ChiNhanh (IdChiNhanh);
ALTER TABLE HoaDon
    ADD FOREIGN KEY (IdKhachHang) REFERENCES KhachHang (IdKhachHang);

ALTER TABLE HoaDon_MuaHang
    ADD FOREIGN KEY (IdSanPham) REFERENCES SanPham (IdSanPham);
ALTER TABLE HoaDon_MuaHang
    ADD FOREIGN KEY (IdDichVu) REFERENCES DichVu (IdDichVu);
ALTER TABLE HoaDon_MuaHang
    ADD FOREIGN KEY (IdHoaDon) REFERENCES HoaDon (IdHoaDon);

ALTER TABLE HoaDon_Kham
    ADD FOREIGN KEY (IdHoaDon) REFERENCES HoaDon (IdHoaDon);
ALTER TABLE HoaDon_Kham
    ADD FOREIGN KEY (IdDichVu) REFERENCES DichVu (IdDichVu);
ALTER TABLE HoaDon_Kham
    ADD FOREIGN KEY (IdHoSo, ThoiGianKham)
        REFERENCES HoSoKhamBenh (IdHoSo, ThoiGianKham);

ALTER TABLE HoaDon_Tiem
    ADD FOREIGN KEY (IdLichSuTiem) REFERENCES LichSuTiem (IdLichSuTiem);
ALTER TABLE HoaDon_Tiem
    ADD FOREIGN KEY (IdHoaDon) REFERENCES HoaDon (IdHoaDon);
ALTER TABLE HoaDon_Tiem
    ADD FOREIGN KEY (IdDichVu) REFERENCES DichVu (IdDichVu);

ALTER TABLE HoaDon_GoiTiem
    ADD FOREIGN KEY (IdDangKyGoi) REFERENCES DangKyGoi (IdDangKyGoi);
ALTER TABLE HoaDon_GoiTiem
    ADD FOREIGN KEY (IdHoaDon) REFERENCES HoaDon (IdHoaDon);
ALTER TABLE HoaDon_GoiTiem
    ADD FOREIGN KEY (IdDichVu) REFERENCES DichVu (IdDichVu);

ALTER TABLE DanhGia
    ADD FOREIGN KEY (IdHoaDon) REFERENCES HoaDon (IdHoaDon);
