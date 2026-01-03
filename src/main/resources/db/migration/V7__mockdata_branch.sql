INSERT INTO ChiNhanh(MaChiNhanh, TenChiNhanh, DiaChi, SoDienThoai, GioMoCua, GioDongCua)
VALUES ('CN01', N'Chi nhánh Hà Nội', N'123 Đường A', '02412340001', '08:00', '20:00'),
       ('CN02', N'Chi nhánh TP.HCM', N'456 Đường B', '02812340002', '08:00', '20:00'),
       ('CN03', N'Chi nhánh Đà Nẵng', N'789 Đường C', '02361234003', '08:00', '20:00'),
       ('CN04', N'Chi nhánh Hải Phòng', N'12 Đường D', '02251234004', '08:00', '20:00'),
       ('CN05', N'Chi nhánh Cần Thơ', N'34 Đường E', '02921234005', '08:00', '20:00'),
       ('CN06', N'Chi nhánh Nha Trang', N'56 Đường F', '02581234006', '08:00', '20:00'),
       ('CN07', N'Chi nhánh Vũng Tàu', N'78 Đường G', '02541234007', '08:00', '20:00'),
       ('CN08', N'Chi nhánh Huế', N'90 Đường H', '02343234008', '08:00', '20:00'),
       ('CN09', N'Chi nhánh Quảng Ninh', N'11 Đường I', '02031234009', '08:00', '20:00'),
       ('CN10', N'Chi nhánh Bình Dương', N'22 Đường J', '02741234010', '08:00', '20:00'),
       ('CN11', N'Chi nhánh Long An', N'33 Đường K', '02711234011', '08:00', '20:00'),
       ('CN12', N'Chi nhánh Đồng Nai', N'44 Đường L', '02511234012', '08:00', '20:00'),
       ('CN13', N'Chi nhánh Thanh Hóa', N'55 Đường M', '02371234013', '08:00', '20:00'),
       ('CN14', N'Chi nhánh Nghệ An', N'66 Đường N', '02381234014', '08:00', '20:00'),
       ('CN15', N'Chi nhánh Quảng Bình', N'77 Đường O', '02323234015', '08:00', '20:00'),
       ('CN16', N'Chi nhánh Thái Bình', N'88 Đường P', '02283234016', '08:00', '20:00'),
       ('CN17', N'Chi nhánh Phú Yên', N'99 Đường Q', '02563234017', '08:00', '20:00'),
       ('CN18', N'Chi nhánh Bình Thuận', N'10 Đường R', '02501234018', '08:00', '20:00'),
       ('CN19', N'Chi nhánh Lâm Đồng', N'21 Đường S', '02603234019', '08:00', '20:00'),
       ('CN20', N'Chi nhánh Kon Tum', N'32 Đường T', '02613234020', '08:00', '20:00');

INSERT INTO DichVu(MaDichVu, TenDichVu, MoTa, GiaDichVu)
VALUES ('DV01', N'Khám bệnh', N'Khám tổng quát cho thú cưng', 200000),
       ('DV02', N'Tiêm phòng', N'Tiêm vacxin định kỳ', 150000),
       ('DV03', N'Bán hàng', N'Bán các sản phẩm dành cho thú cưng', 0);

-- CN01-CN10
INSERT INTO ChiNhanh_DichVu(IdDichVu, IdChiNhanh)
VALUES (1, 1),
       (2, 1),
       (1, 2),
       (2, 2),
       (1, 3),
       (2, 3),
       (1, 4),
       (2, 4),
       (1, 5),
       (2, 5),
       (1, 6),
       (2, 6),
       (1, 7),
       (2, 7),
       (1, 8),
       (2, 8),
       (1, 9),
       (2, 9),
       (1, 10),
       (2, 10);

-- CN11-CN15
INSERT INTO ChiNhanh_DichVu(IdDichVu, IdChiNhanh)
VALUES (1, 11),
       (3, 11),
       (1, 12),
       (3, 12),
       (1, 13),
       (3, 13),
       (1, 14),
       (3, 14),
       (1, 15),
       (3, 15);

-- CN16-CN20
INSERT INTO ChiNhanh_DichVu(IdDichVu, IdChiNhanh)
VALUES (2, 16),
       (3, 16),
       (2, 17),
       (3, 17),
       (2, 18),
       (3, 18),
       (2, 19),
       (3, 19),
       (2, 20),
       (3, 20);

