Create database Booking
Use Booking



CREATE TABLE KHACHHANG (
    [MaKH] [int] IDENTITY(1,1) Primary Key NOT NULL,
	[Ten] [nvarchar](max) NOT NULL,
	[Email] [nvarchar](max) NOT NULL,
	[MatKhau] [nvarchar](max) NOT NULL,
	[SoDienThoai] [varchar](10) NOT NULL,
	[DiaChi] [nvarchar](255)NOT NULL,
	[NgayTao] [datetime] NOT NULL,
	[TrangThai] [bit] NOT NULL,
);

CREATE TABLE KHACHSAN (
    MaKhachSan INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    TenKhachSan NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(255) NOT NULL,
    MoTa NVARCHAR(500),
    SoSao INT,
    GiaPhong DECIMAL(18, 2),
    MaKhuyenMai INT,  -- FK to KHUYENMAI
    MaDiaDiem INT,
    MaNV Int , 
);

CREATE TABLE CHUYENBAY (
    MaChuyenBay INT IDENTITY(1,1) PRIMARY KEY  NOT NULL,
    HangHangKhong NVARCHAR(100) NOT NULL,
    DiemDi NVARCHAR(100) NOT NULL,
    DiemDen NVARCHAR(100) NOT NULL,
    NgayBay DATE NOT NULL,
    GioBay TIME NOT NULL,
    GiaVe DECIMAL(18, 2),
    MaKhuyenMai INT,  -- FK to KHUYENMAI
    MaNV Int 
);


CREATE TABLE PHUONGTIEN (
    MaPhuongTien INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    LoaiPhuongTien NVARCHAR(100) NOT NULL,
    TenPhuongTien NVARCHAR(100) NOT NULL,
    SoChoNgoi INT,
    Gia DECIMAL(18, 2),
    Anh Nvarchar(100),
    MaDiaDiem INT,
    MaKhuyenMai INT,  -- FK to KHUYENMAI
    MaNV Int 
);

CREATE TABLE CANHO (
    MaCanHo INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    TenCanHo NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(255) NOT NULL,
    SoPhongNgu INT,
    DienTich DECIMAL(18, 2),
    GiaThue DECIMAL(18, 2),
    Anh Nvarchar(100),
    MaDiaDiem INT,
    MaKhuyenMai INT,  -- FK to KHUYENMAI
    MaNV INT
);


CREATE TABLE KHUYENMAI (
    MaKhuyenMai INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    TenKhuyenMai NVARCHAR(100) NOT NULL,
    PhanTramGiam DECIMAL(5, 2),
    NgayBatDau DATE,
    NgayKetThuc DATE,
    SoLanDung Int Not Null , 
    NgayTao datetime Not Null ,
    DieuKienApDung NVARCHAR(255)
);

CREATE TABLE [dbo].[NHANVIEN](
	[MaNV] [int] IDENTITY(1,1) Primary Key NOT NULL,
	[Email] [nvarchar](max) NULL,
	[MatKhau] [nvarchar](max) NULL,
	[Quyen] [varchar](20) NULL,
	[Ten] [nvarchar](100) NULL,
	[NgayTao] [datetime] NULL,
	[TrangThai] [bit] NULL,
	)

CREATE TABLE PHONG (
    MaPhong INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    TenPhong NVARCHAR(100),
    SoNguoiToiDa INT,
    MaKhachSan INT,  -- FK to KHACHSAN
    GiaPhong DECIMAL(18, 2),
    Anh Nvarchar(100) , 
    SoLuong Int Not Null ,
    MoTa Nvarchar (Max) Null ,
    MaNV Int 
  
);

CREATE TABLE DIA_DIEM (
    MaDiaDiem INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    TenDiaDiem NVARCHAR(100) NOT NULL,
    ThanhPho NVARCHAR(100)
);

CREATE TABLE DONTHANHTOAN (
    MaDon INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    NgayThanhToan DATE NOT NULL,
    TongTien DECIMAL(18, 2) NOT NULL,
    MaKhachHang INT NOT NULL,  -- FK to NGUOIDUNG
    PhuongThucThanhToan NVARCHAR(50) NOT NULL,  -- Ví dụ: "Thẻ tín dụng", "Chuyển khoản"
    TrangThai NVARCHAR(50) NOT NULL,  -- Ví dụ: "Đã thanh toán", "Chưa thanh toán"
    MaNV INT
);


CREATE TABLE CHITIETTHANHTOAN (
    MaChiTiet INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    MaDon INT NOT NULL,  -- FK to DONTHANHTOAN
    LoaiDichVu NVARCHAR(50) NOT NULL,  -- Ví dụ: "Khách sạn", "Chuyến bay", "Phương tiện", "Căn hộ"
    MaDichVu INT NOT NULL,  -- FK to dịch vụ tương ứng (KHACHSAN, CHUYENBAY, PHUONGTIEN, CANHO)
    SoLuong INT NOT NULL,  -- Số lượng phòng, vé, hoặc phương tiện
    GiaDichVu DECIMAL(18, 2) NOT NULL,  -- Giá của dịch vụ
    ThanhTien DECIMAL(18, 2) NOT NULL,  -- Tổng tiền cho dịch vụ này (GiaDichVu * SoLuong)
   
);
CREATE TABLE [dbo].[DANHGIA](
	[ID] [int] IDENTITY(1,1) Primary Key NOT NULL,
	[MaKH] [int] NOT NULL,
	[MaSanPham] [int] NOT NULL,
	/*MaKhachSan*/
	[NoiDung] [nvarchar](max) NOT NULL,
	[NgayTao] [datetime] NOT NULL,
	)


ALTER TABLE KHACHSAN
ADD CONSTRAINT FK_KHACHSAN_KHUYENMAI FOREIGN KEY (MaKhuyenMai) REFERENCES KHUYENMAI(MaKhuyenMai),
    CONSTRAINT FK_KHACHSAN_DIA_DIEM FOREIGN KEY (MaDiaDiem) REFERENCES DIA_DIEM(MaDiaDiem);

ALTER TABLE PHONG
ADD CONSTRAINT FK_PHONG_KHACHSAN FOREIGN KEY (MaKhachSan) REFERENCES KHACHSAN(MaKhachSan);

ALTER TABLE CHUYENBAY
ADD CONSTRAINT FK_CHUYENBAY_KHUYENMAI FOREIGN KEY (MaKhuyenMai) REFERENCES KHUYENMAI(MaKhuyenMai);

ALTER TABLE PHUONGTIEN
ADD CONSTRAINT FK_PHUONGTIEN_KHUYENMAI FOREIGN KEY (MaKhuyenMai) REFERENCES KHUYENMAI(MaKhuyenMai),
    CONSTRAINT FK_PHUONGTIEN_DIA_DIEM FOREIGN KEY (MaDiaDiem) REFERENCES DIA_DIEM(MaDiaDiem);


ALTER TABLE CANHO
ADD CONSTRAINT FK_CANHO_KHUYENMAI FOREIGN KEY (MaKhuyenMai) REFERENCES KHUYENMAI(MaKhuyenMai),
    CONSTRAINT FK_CANHO_DIA_DIEM FOREIGN KEY (MaDiaDiem) REFERENCES DIA_DIEM(MaDiaDiem);

ALTER TABLE DONTHANHTOAN
ADD CONSTRAINT FK_DONTHANHTOAN_KHACHHANG FOREIGN KEY (MaKhachHang) REFERENCES KHACHHANG(MaKH);

ALTER TABLE CHITIETTHANHTOAN
ADD CONSTRAINT FK_CHITIETTHANHTOAN_DONTHANHTOAN FOREIGN KEY (MaDon) REFERENCES DONTHANHTOAN(MaDon);


-- Liên kết với KHACHSAN
ALTER TABLE CHITIETTHANHTOAN
ADD CONSTRAINT FK_CHITIETTHANHTOAN_KHACHSAN FOREIGN KEY (MaDichVu) REFERENCES KHACHSAN(MaKhachSan);

-- Liên kết với CHUYENBAY
ALTER TABLE CHITIETTHANHTOAN
ADD CONSTRAINT FK_CHITIETTHANHTOAN_CHUYENBAY FOREIGN KEY (MaDichVu) REFERENCES CHUYENBAY(MaChuyenBay);

-- Liên kết với PHUONGTIEN
ALTER TABLE CHITIETTHANHTOAN
ADD CONSTRAINT FK_CHITIETTHANHTOAN_PHUONGTIEN FOREIGN KEY (MaDichVu) REFERENCES PHUONGTIEN(MaPhuongTien);

-- Liên kết với CANHO
ALTER TABLE CHITIETTHANHTOAN
ADD CONSTRAINT FK_CHITIETTHANHTOAN_CANHO FOREIGN KEY (MaDichVu) REFERENCES CANHO(MaCanHo);

-- Liên kết với KHACHHANG
ALTER TABLE DANHGIA
ADD CONSTRAINT FK_DANHGIA_KHACHHANG FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH);

-- Liên kết với dịch vụ (ví dụ KHACHSAN, bạn có thể thêm FK cho các dịch vụ khác tương tự)
ALTER TABLE DANHGIA
ADD CONSTRAINT FK_DANHGIA_KHACHSAN FOREIGN KEY (MaSanPham) REFERENCES KHACHSAN(MaKhachSan);


-- Thêm khóa ngoại liên kết với NHANVIEN
ALTER TABLE PHONG
ADD CONSTRAINT FK_PHONG_NHANVIEN FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV);

ALTER TABLE PHUONGTIEN
ADD CONSTRAINT FK_PHUONGTIEN_NHANVIEN FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV);

ALTER TABLE CHUYENBAY
ADD CONSTRAINT FK_CHUYENBAY_NHANVIEN FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV);

ALTER TABLE KHACHSAN
ADD CONSTRAINT FK_KHACHSAN_NHANVIEN FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV);

ALTER TABLE CANHO
ADD CONSTRAINT FK_CANHO_NHANVIEN FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV);

ALTER TABLE DONTHANHTOAN
ADD CONSTRAINT FK_DONTHANHTOAN_NHANVIEN FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV);

--------Tạo dữ liệu ----------------------------


INSERT INTO KHACHSAN (TenKhachSan, DiaChi, MoTa, SoSao, GiaPhong, MaKhuyenMai, MaDiaDiem, MaNV)
VALUES 
('Khách sạn Hòa Bình', '01 Đường Trần Hưng Đạo, Hà Nội', 'Khách sạn đạt chuẩn 5 sao quốc tế', 5, 2000000.00, 15, 11, 1),
('Khách sạn Sài Gòn', '45 Đường Nguyễn Huệ, TP.HCM', 'Khách sạn trung tâm thành phố', 4, 1500000.00, 16, 12, 2);


INSERT INTO CHUYENBAY (HangHangKhong, DiemDi, DiemDen, NgayBay, GioBay, GiaVe, MaKhuyenMai, MaNV)
VALUES 
('Vietnam Airlines', 'Hà Nội', 'TP.HCM', '2024-10-15', '08:00:00', 1500000.00, 1, 201),
('Bamboo Airways', 'Đà Nẵng', 'Nha Trang', '2024-11-05', '15:30:00', 1200000.00, 2, 202);

INSERT INTO PHUONGTIEN (LoaiPhuongTien, TenPhuongTien, SoChoNgoi, Gia, Anh, MaDiaDiem, MaKhuyenMai, MaNV)
VALUES 
('Xe hơi', 'Toyota Camry', 5, 500000.00, 'toyota.jpg', 101, 1, 201),
('Xe máy', 'Honda Airblade', 2, 150000.00, 'honda.jpg', 102, 2, 202);

INSERT INTO CANHO (TenCanHo, DiaChi, SoPhongNgu, DienTich, GiaThue, Anh, MaDiaDiem, MaKhuyenMai, MaNV)
VALUES 
('Căn hộ Green Bay', '123 Đường Lê Duẩn, Đà Nẵng', 3, 120.00, 15000000.00, 'greenbay.jpg', 103, 1, 201),
('Căn hộ Sunshine', '456 Đường Hoàng Văn Thụ, Hà Nội', 2, 85.00, 10000000.00, 'sunshine.jpg', 104, 2, 202);

INSERT INTO KHUYENMAI (TenKhuyenMai, PhanTramGiam, NgayBatDau, NgayKetThuc, SoLanDung, NgayTao, DieuKienApDung)
VALUES 
('Khuyến mãi mùa hè', 10.00, '2024-06-01', '2024-08-31', 100, GETDATE(), 'Áp dụng cho tất cả các dịch vụ'),
('Giảm giá cuối tuần', 15.00, '2024-10-01', '2024-12-31', 50, GETDATE(), 'Áp dụng vào thứ 7 và Chủ nhật');

INSERT INTO NHANVIEN (Email, MatKhau, Quyen, Ten, NgayTao, TrangThai)
VALUES 
('nhanvienA@gmail.com', 'nv123', 'Admin', 'Nguyễn Văn A', GETDATE(), 1),
('nhanvienB@gmail.com', 'nv456', 'User', 'Trần Thị B', GETDATE(), 1);

INSERT INTO DONTHANHTOAN (NgayThanhToan, TongTien, MaKhachHang, PhuongThucThanhToan, TrangThai, MaNV)
VALUES 
('2024-10-10', 3000000.00, 1, 'Thẻ tín dụng', 'Đã thanh toán', 201),
('2024-11-01', 1500000.00, 2, 'Chuyển khoản', 'Chưa thanh toán', 202);

INSERT INTO CHITIETTHANHTOAN (MaDon, LoaiDichVu, MaDichVu, SoLuong, GiaDichVu, ThanhTien)
VALUES 
(1, 'Khách sạn', 1, 2, 2000000.00, 4000000.00),
(2, 'Chuyến bay', 1, 1, 1500000.00, 1500000.00);

INSERT INTO DANHGIA (MaKH, MaSanPham, NoiDung, NgayTao)
VALUES 
(1, 1, 'Khách sạn rất tốt, dịch vụ chuyên nghiệp.', GETDATE()),
(2, 1, 'Phòng rộng rãi, thoải mái nhưng giá hơi cao.', GETDATE());

INSERT INTO DIA_DIEM (TenDiaDiem, ThanhPho)
VALUES 
('Hồ Gươm', 'Hà Nội'),
('Bến Nhà Rồng', 'TP. Hồ Chí Minh'),
('Cầu Rồng', 'Đà Nẵng'),
('Tháp Bà Ponagar', 'Nha Trang'),
('Hồ Xuân Hương', 'Đà Lạt'),
('Chùa Hương', 'Hà Nội'),
('Bãi biển Mỹ Khê', 'Đà Nẵng'),
('Chợ Bến Thành', 'TP. Hồ Chí Minh'),
('Nhà thờ Đức Bà', 'TP. Hồ Chí Minh'),
('Chợ Đầm', 'Nha Trang');

INSERT INTO PHONG (TenPhong, SoNguoiToiDa, MaKhachSan, GiaPhong, Anh, SoLuong, MoTa, MaNV)
VALUES 
(N'Phòng Tiêu Chuẩn', 1, 13, 800000.00, N'khach-san-grand-dragon-thanh-xuan-4.jpg', 10, 'Phòng nhỏ, thích hợp cho 1 người.', 2),
(N'Phòng Gia Đình', 4, 14, 2000000.00, N'khach-san-ho-chi-minh-30.jpg', 4, 'Phòng lớn cho gia đình.', 2),
(N'Phòng VIP', 3, 13, 2500000.00, N'khu-nghi-mat-va-khach-san-the-light-nha-trang-ivivu.jpg', 2, 'Phòng sang trọng với dịch vụ đặc biệt.', 1),
(N'Phòng Ngủ Nghỉ', 1, 14, 600000.00, N'VQK_2153 (1).jpg', 8, 'Phòng đơn giản, giá cả hợp lý.', 2),
(N'Phòng Deluxe', 2, 13, 1500000.00, N'Thiet-ke-phong-ngu-khach-san-sang-trong-2-2.png', 5, 'Phòng rộng rãi với view đẹp.', 1);

('Phòng Superior', 1, 14, 1200000.00, N'khach-san-ho-chi-minh-30.jpg', 3, 'Phòng tiện nghi, gần trung tâm.', 1),





