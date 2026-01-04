-- =========================================
-- 1. Accounts (20)
-- =========================================
INSERT INTO Account (Username, Password)
VALUES ('khachhang1', 'password123'),
       ('khachhang2', 'password123'),
       ('khachhang3', 'password123'),
       ('khachhang4', 'password123'),
       ('khachhang5', 'password123'),
       ('khachhang6', 'password123'),
       ('khachhang7', 'password123'),
       ('khachhang8', 'password123'),
       ('khachhang9', 'password123'),
       ('khachhang10', 'password123'),
       ('khachhang11', 'password123'),
       ('khachhang12', 'password123'),
       ('khachhang13', 'password123'),
       ('khachhang14', 'password123'),
       ('khachhang15', 'password123'),
       ('khachhang16', 'password123'),
       ('khachhang17', 'password123'),
       ('khachhang18', 'password123'),
       ('khachhang19', 'password123'),
       ('khachhang20', 'password123');

-- =========================================
-- 2. HangThanhVien
-- =========================================
INSERT INTO HangThanhVien (MaHang, TenHang, HanMucThangHang, HanMucGiuHang, UuDaiGiamGia)
VALUES ('VIP', N'VIP', 5000000, 10000000, 10),
       ('Silver', N'Silver', 2000000, 5000000, 5),
       ('Gold', N'Gold', 3000000, 7000000, 7);

-- =========================================
-- 3. KhachHang (20)
-- =========================================
INSERT INTO KhachHang (MaKhachHang, CCCD, HoTen, SoDienThoai, TongChiTieuNamNay, GioiTinh, NgaySinh, DiemLoyalty,
                       IdHang, IdAccount)
VALUES ('KH001', '123456789001', N'Nguyen Van A', '0912340001', 1000000.00, N'Nam', '1990-01-01', 100, 1, 1),
       ('KH002', '123456789002', N'Tran Thi B', '0912340002', 1200000.00, N'Nữ', '1991-02-02', 110, 2, 2),
       ('KH003', '123456789003', N'Le Van C', '0912340003', 1300000.00, N'Nam', '1992-03-03', 120, 3, 3),
       ('KH004', '123456789004', N'Pham Thi D', '0912340004', 1400000.00, N'Nữ', '1993-04-04', 130, 1, 4),
       ('KH005', '123456789005', N'Hoang Van E', '0912340005', 1500000.00, N'Nam', '1994-05-05', 140, 2, 5),
       ('KH006', '123456789006', N'Dang Thi F', '0912340006', 1600000.00, N'Nữ', '1995-06-06', 150, 3, 6),
       ('KH007', '123456789007', N'Nguyen Van G', '0912340007', 1700000.00, N'Nam', '1996-07-07', 160, 1, 7),
       ('KH008', '123456789008', N'Tran Thi H', '0912340008', 1800000.00, N'Nữ', '1997-08-08', 170, 2, 8),
       ('KH009', '123456789009', N'Le Van I', '0912340009', 1900000.00, N'Nam', '1998-09-09', 180, 3, 9),
       ('KH010', '123456789010', N'Pham Thi J', '0912340010', 2000000.00, N'Nữ', '1999-10-10', 190, 1, 10),
       ('KH011', '123456789011', N'Hoang Van K', '0912340011', 2100000.00, N'Nam', '1985-01-11', 200, 2, 11),
       ('KH012', '123456789012', N'Dang Thi L', '0912340012', 2200000.00, N'Nữ', '1986-02-12', 210, 3, 12),
       ('KH013', '123456789013', N'Nguyen Van M', '0912340013', 2300000.00, N'Nam', '1987-03-13', 220, 1, 13),
       ('KH014', '123456789014', N'Tran Thi N', '0912340014', 2400000.00, N'Nữ', '1988-04-14', 230, 2, 14),
       ('KH015', '123456789015', N'Le Van O', '0912340015', 2500000.00, N'Nam', '1989-05-15', 240, 3, 15),
       ('KH016', '123456789016', N'Pham Thi P', '0912340016', 2600000.00, N'Nữ', '1990-06-16', 250, 1, 16),
       ('KH017', '123456789017', N'Hoang Van Q', '0912340017', 2700000.00, N'Nam', '1991-07-17', 260, 2, 17),
       ('KH018', '123456789018', N'Dang Thi R', '0912340018', 2800000.00, N'Nữ', '1992-08-18', 270, 3, 18),
       ('KH019', '123456789019', N'Nguyen Van S', '0912340019', 2900000.00, N'Nam', '1993-09-19', 280, 1, 19),
       ('KH020', '123456789020', N'Tran Thi T', '0912340020', 3000000.00, N'Nữ', '1994-10-20', 290, 2, 20);

-- =========================================
-- 4. ThuCung (40, 2 pets per customer)
-- =========================================
INSERT INTO ThuCung (MaThuCung, Ten, Loai, Giong, GioiTinh, NgaySinh, TinhTrangSucKhoe, Chu)
VALUES
-- KhachHang 1
('TC001', 'Milu', 'Chó', 'Golden Retriever', N'Nam', '2020-01-01', N'Tốt', 1),
('TC002', 'Mimi', 'Mèo', 'Anh Lông Dài', N'Nữ', '2020-03-03', N'Tốt', 1),
-- KhachHang 2
('TC003', 'Bingo', 'Chó', 'Beagle', N'Nam', '2019-02-02', N'Tốt', 2),
('TC004', 'Luna', 'Mèo', 'Ta', N'Nữ', '2019-04-04', N'Tốt', 2),
-- KhachHang 3
('TC005', 'Rocky', 'Chó', 'Bulldog', N'Nam', '2021-01-05', N'Tốt', 3),
('TC006', 'Bella', 'Mèo', 'Siberian', N'Nữ', '2021-03-06', N'Tốt', 3),
-- KhachHang 4
('TC007', 'Max', 'Chó', 'Husky', N'Nam', '2020-05-07', N'Tốt', 4),
('TC008', 'Lily', 'Mèo', 'Ba Tư', N'Nữ', '2020-07-08', N'Tốt', 4),
-- KhachHang 5
('TC009', 'Charlie', 'Chó', 'Poodle', N'Nam', '2019-09-09', N'Tốt', 5),
('TC010', 'Lucy', 'Mèo', 'Maine Coon', N'Nữ', '2019-11-10', N'Tốt', 5),
-- KhachHang 6
('TC011', 'Cooper', 'Chó', 'Shiba', N'Nam', '2021-01-11', N'Tốt', 6),
('TC012', 'Daisy', 'Mèo', 'Bengal', N'Nữ', '2021-03-12', N'Tốt', 6),
-- KhachHang 7
('TC013', 'Toby', 'Chó', 'Boxer', N'Nam', '2020-05-13', N'Tốt', 7),
('TC014', 'Nala', 'Mèo', 'Ragdoll', N'Nữ', '2020-07-14', N'Tốt', 7),
-- KhachHang 8
('TC015', 'Oscar', 'Chó', 'Dachshund', N'Nam', '2019-09-15', N'Tốt', 8),
('TC016', 'Sophie', 'Mèo', 'Sphynx', N'Nữ', '2019-11-16', N'Tốt', 8),
-- KhachHang 9
('TC017', 'Bear', 'Chó', 'Labrador', N'Nam', '2021-01-17', N'Tốt', 9),
('TC018', 'Chloe', 'Mèo', 'Munchkin', N'Nữ', '2021-03-18', N'Tốt', 9),
-- KhachHang 10
('TC019', 'Duke', 'Chó', 'Corgi', N'Nam', '2020-05-19', N'Tốt', 10),
('TC020', 'Molly', 'Mèo', 'Scottish Fold', N'Nữ', '2020-07-20', N'Tốt', 10),
-- KhachHang 11
('TC021', 'Zeus', 'Chó', 'Doberman', N'Nam', '2019-09-21', N'Tốt', 11),
('TC022', 'Luna2', 'Mèo', 'Persian', N'Nữ', '2019-11-22', N'Tốt', 11),
-- KhachHang 12
('TC023', 'Bruno', 'Chó', 'Golden Retriever', N'Nam', '2021-01-23', N'Tốt', 12),
('TC024', 'Kitty', 'Mèo', 'Siamese', N'Nữ', '2021-03-24', N'Tốt', 12),
-- KhachHang 13
('TC025', 'Rex', 'Chó', 'Husky', N'Nam', '2020-05-25', N'Tốt', 13),
('TC026', 'Mia', 'Mèo', 'Burmese', N'Nữ', '2020-07-26', N'Tốt', 13),
-- KhachHang 14
('TC027', 'Sam', 'Chó', 'Poodle', N'Nam', '2019-09-27', N'Tốt', 14),
('TC028', 'Coco', 'Mèo', 'Ragdoll', N'Nữ', '2019-11-28', N'Tốt', 14),
-- KhachHang 15
('TC029', 'Jack', 'Chó', 'Beagle', N'Nam', '2021-01-29', N'Tốt', 15),
('TC030', 'Lola', 'Mèo', 'Siberian', N'Nữ', '2021-03-30', N'Tốt', 15),
-- KhachHang 16
('TC031', 'Leo', 'Chó', 'Boxer', N'Nam', '2020-05-31', N'Tốt', 16),
('TC032', 'Nina', 'Mèo', 'Maine Coon', N'Nữ', '2020-07-01', N'Tốt', 16),
-- KhachHang 17
('TC033', 'Shadow', 'Chó', 'Shiba', N'Nam', '2019-09-02', N'Tốt', 17),
('TC034', 'Angel', 'Mèo', 'Bengal', N'Nữ', '2019-11-03', N'Tốt', 17),
-- KhachHang 18
('TC035', 'Rocky2', 'Chó', 'Corgi', N'Nam', '2021-01-04', N'Tốt', 18),
('TC036', 'Lily2', 'Mèo', 'Scottish Fold', N'Nữ', '2021-03-05', N'Tốt', 18),
-- KhachHang 19
('TC037', 'Hunter', 'Chó', 'Doberman', N'Nam', '2020-05-06', N'Tốt', 19),
('TC038', 'Bella2', 'Mèo', 'Persian', N'Nữ', '2020-07-07', N'Tốt', 19),
-- KhachHang 20
('TC039', 'Maverick', 'Chó', 'Golden Retriever', N'Nam', '2019-09-08', N'Tốt', 20),
('TC040', 'Chloe2', 'Mèo', 'Siamese', N'Nữ', '2019-11-09', N'Tốt', 20);
