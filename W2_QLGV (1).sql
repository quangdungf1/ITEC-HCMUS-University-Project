create database QLHS

go 
use QLHS
go


create table GIAOVIEN
(
	MAGV varchar(3) ,
	HOTEN nvarchar(30),
	LUONG FLOAT,
	PHAI NVARCHAR(7),
	NGSINH DATE,
	DIACHI NVARCHAR(50),
	GVQLCM VARCHAR(3),
	MABM NVARCHAR(5),	
	primary key (MAGV)
)


create table KHOA

(
	MAKHOA VARCHAR(5),
	TENKHOA NVARCHAR(20),
	NAMTL int ,
	PHONG NVARCHAR(3),
	DIENTHOAI VARCHAR(15),
	TRUONGKHOA VARCHAR(3),
	NGAYNHANCHUC DATE,
	primary key (MAKHOA)
)

create table BOMON
(
	MABM Nvarchar(5),
	TENBM nvarchar(30),
	PHONG NVARCHAR(3),
	DIENTHOAI VARCHAR(15),
	TRUONGBM VARCHAR(3),
	MAKHOA VARCHAR(5),
	NGAYNHANCHUC DATE,
	primary key (MABM)
)
create table GV_DT
(
	MAGV varchar(3),
	DIENTHOAI VARCHAR(15),
	primary key (MAGV,DIENTHOAI)
)
create table NGUOITHAN
(
	MAGV varchar(3),
	TEN NVARCHAR(30),
	NGSINH DATE,
	PHAI CHAR(7),
	 primary key (MAGV,TEN)
)
create table THAMGIADT
(
	MAGV varchar(3),
	MADT VARCHAR(3),
	STT INT,
	PHUCAP FLOAT,
	KETQUA NVARCHAR(10),
	primary key (MAGV,MADT,STT)
)
create table CONGVIEC
(
	MADT VARCHAR(3),
	SOTT INT,
	TENCV NVARCHAR(50),
	NGAYBD DATE,
	NGAYKT DATE,
	primary key (MADT,SOTT)
)

create table DETAI
(
	MADT VARCHAR(3),
	TENDT nvarchar(50),
	CAPQL NVARCHAR(10),
	KINHPHI FLOAT,
	NGAYBD DATE,
	NGAYKT DATE,
	MACD VARCHAR(4),
	GVCNDT VARCHAR(3),
	primary key (MADT)
)
create table CHUDE
(	
	MACD VARCHAR(4),
	TENCD NVARCHAR(50),
	primary key (MACD)
)

go
alter table THAMGIADT ADD
CONSTRAINT FK_THAMGIADT_CONGVIEC FOREIGN KEY (MADT,STT) REFERENCES CONGVIEC(MADT,SOTT),
CONSTRAINT FK_THAMGIADT_GIAOVIEN FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV)
	

alter table KHOA ADD
CONSTRAINT FK_KHOA_GIAOVIEN FOREIGN KEY (TRUONGKHOA) REFERENCES GIAOVIEN(MAGV)

alter table BOMON ADD
CONSTRAINT FK_BOMON_KHOA FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA),
CONSTRAINT FK_BOMON_GIAOVIEN FOREIGN KEY (TRUONGBM) REFERENCES GIAOVIEN(MAGV)

alter table CONGVIEC ADD
CONSTRAINT FK_CONGVIEC_DETAI FOREIGN KEY (MADT) REFERENCES DETAI(MADT)
	

alter table GIAOVIEN ADD
CONSTRAINT FK_GIAOVIEN_GIAOVIEN FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV),
CONSTRAINT FK_GIAOVIEN_BOMON FOREIGN KEY (MABM) REFERENCES BOMON(MABM)
	

alter table GV_DT ADD
CONSTRAINT FK_GV_DT_GIAOVIEN FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV)
	
alter table DETAI ADD
CONSTRAINT FK_DETAI_GIAOVIEN FOREIGN KEY (GVCNDT) REFERENCES GIAOVIEN(MAGV),
CONSTRAINT FK_DETAI_CHUDE FOREIGN KEY (MACD) REFERENCES CHUDE(MACD)

alter table NGUOITHAN ADD
CONSTRAINT FK_NGUOITHAN_GIAOVIEN FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV)
GO	
insert into GIAOVIEN values	('001',N'Nguyễn Hoài An',2000,N'Nam','2/15/1973',N'25/3 Lạc Long Quân, Q.10, TP HCM',NULL,NULL)
insert into GIAOVIEN values	('002',N'Trần Trà Hương',2500,N'Nữ','6/20/1960',N'125 Trần Hưng Đạo, Q.1, TP HCM',NULL,NULL)
insert into GIAOVIEN values	('003',N'Nguyễn Ngọc Ánh',2200,N'Nữ','5/11/1975',N'12/21 Võ Văn Ngân Thủ Đức, TP HCM',NULL,NULL)
insert into GIAOVIEN values	('004',N'Trương Nam Sơn',2300,N'Nam','6/20/1959',N'215 Lý Thường Kiệt, TP Biên Hòa',NULL,NULL)
insert into GIAOVIEN values	('005',N'Lý Hoàng Hà',2500,N'Nam','10/23/1954',N'22/5 Nguyễn Xí, Q.Bình Thạnh, TP HCM',NULL,NULL)
insert into GIAOVIEN values	('006',N'Trần Bạch Tuyết',1500,N'Nữ','5/20/1980',N'127 Hùng Vương, TP Mỹ Tho',NULL,NULL)
insert into GIAOVIEN values	('007',N'Nguyễn An Trung',2100,N'Nam','6/5/1967',N'234 3/2, TP Biên Hòa',NULL,NULL)
insert into GIAOVIEN values	('008',N'Trần Trung Hiếu',1800,N'Nam','8/6/1977',N'22/11 Lý Thường Kiệt, TP Mỹ Tho',NULL,NULL)
insert into GIAOVIEN values	('009',N'Trần Hoàng Nam',2000,N'Nam','11/22/1975',N'234 Trấn Não, An Phú, TP HCM',NULL,NULL)
insert into GIAOVIEN values	('010',N'Phạm Nam Thanh',1500,N'Nam','12/12/1980',N'221 Hùng Vương, Q.5, TP HCM',NULL,NULL)

GO

insert into CHUDE values(N'NCPT',N'Nghiên cứu phát triển')
insert into CHUDE values(N'QLGD',N'Quản lý giáo dục')
insert into CHUDE values(N'ƯDCN',N'Ứng dụng công nghệ')
GO

insert into GV_DT values('001','0838912112')
insert into GV_DT values('001','0903123123')
insert into GV_DT values('002','0913454545')
insert into GV_DT values('003','0838121212')
insert into GV_DT values('003','0903656565')
insert into GV_DT values('003','0937125125')
insert into GV_DT values('006','0937888888')
insert into GV_DT values('008','0653717171')
insert into GV_DT values('008','0913232323')

GO
insert into NGUOITHAN values ('001',  'Hùng', '1990-01-14', 'Nam' )
insert into NGUOITHAN values ('001',  'Thủy', '1994-12-08', 'Nữ' )
insert into NGUOITHAN values ('001',  'Hà', '1998-09-03', 'Nữ')
insert into NGUOITHAN values ('001',  'Thu', '1998-09-03', 'Nữ' )
insert into NGUOITHAN values ('001',  'Mai', '2003-03-26', 'Nữ')
insert into NGUOITHAN values ('001',  'Vy', '2000-02-14', 'Nữ' )
insert into NGUOITHAN values ('001',  'Nam', '1991-05-06', 'Nam' )
insert into NGUOITHAN values ('001',  'An', '1996-08-19', 'Nam' )
insert into NGUOITHAN values ('001',  'Nguyệt','2006-01-14', 'Nữ')	
GO
insert into KHOA values ('CNTT',  N'Công nghệ thông tin', '1995', 'B11','0838123456','002','2005-02-20' )
insert into KHOA values ('HH',  N'Hóa học', 1980, 'B41','0838456456','007','2001-10-15' )
insert into KHOA values ('SH',  N'Sinh học', 1980, 'B31','0838454545','004','2000-10-11' )
insert into KHOA values ('VL',  N'Vật lý', 1976, 'B21','0838223223','005','2003-09-18' )	
GO


insert into DETAI values('001',N'HTTT quản lý các trường ĐH',N'ĐHQG',20,'10/20/2007','10/20/2008',N'QLGD','002')
insert into DETAI values('002',N'HTTT quản lý giáo vụ cho một Khoa',N'Trường',20,'10/12/2000','10/12/2001',N'QLGD','002')
insert into DETAI values('003',N'Nghiên cứu chế tạo sợi Nanô Platin',N'ĐHQG',300,'5/15/2008','5/15/2010',N'NCPT','005')
insert into DETAI values('004',N'Tạo vật liệu sinh học bằng màng ối người',N'Nhà nước',100,'1/1/2007','12/31/2009',N'NCPT','004')
insert into DETAI values('005',N'Ứng dụng hóa học xanh',N'Trường',200,'10/10/2003','12/10/2004',N'ƯDCN','007')
insert into DETAI values('006',N'Nghiên cứu tế bào gốc',N'Nhà nước',4000,'10/20/2006','10/20/2009',N'NCPT','004')
insert into DETAI values('007',N'HTTT quản lý các thư viện ở các trường ĐH',N'Trường',20,'5/10/2009','5/10/2010',N'QLGD','001')
GO

insert into BOMON values(N'CNTT',N'Công nghệ tri thức','B15','0838126126',NULL,'CNTT',NULL)
insert into BOMON values(N'HHC',N'Hóa hữu cơ','B44','0838222222',NULL,'HH',NULL)
insert into BOMON values(N'HL',N'Hóa lý','B42','0838878787',NULL,'HH',NULL)
insert into BOMON values(N'HPT',N'Hóa phân tích','B43','0838777777','007','HH','10/15/2007')
insert into BOMON values(N'HTTT',N'Hệ thống thông tin','B13','0838125125','002','CNTT','9/20/2004')
insert into BOMON values(N'MMT',N'Mạng máy tính','B16','0838676767','001','CNTT','5/15/2005')
insert into BOMON values(N'SH',N'Sinh hóa','B33','0838898989',NULL,'SH',NULL)
insert into BOMON values(N'VLĐT',N'Vật lý điện tử','B23','0838234234',NULL,'VL',NULL)
insert into BOMON values(N'VLƯD',N'Vật lý ứng dụng','B24','0838454545','005','VL','2/18/2006')
insert into BOMON values(N'VS',N'Vi sinh','B32','08389090','004','SH','1/1/2007')
GO

insert into CONGVIEC values ('001',  1	, N'Khởi tạo và Lập kế hoạch', '2007-10-20', '2008-12-20')
insert into CONGVIEC values ('001',  2	, N'Xác định yêu cầu', '2008-12-21', '2008-03-21')
insert into CONGVIEC values ('001',  4	, N'Thiết kế hệ thống', '2008-05-23', '2008-06-23')
insert into CONGVIEC values ('001',  5	, N'Cài đặt thử nghiệm', '2008-06-24', '2008-10-20')
insert into CONGVIEC values ('002',  1	, N'Khởi tạo và Lập kế hoạch', '2009-05-10', '2008-12-20')
insert into CONGVIEC values ('002',  2	, N'Xác định yêu cầu', '2009-07-11', '2009-10-11')
insert into CONGVIEC values ('002',  3	, N'Phân tích hệ thống', '2009-10-12', '2009-12-20')
insert into CONGVIEC values ('002',  4	, N'Thiết kế hệ thống', '2009-12-21', '2010-03-22')
insert into CONGVIEC values ('002',  5	, N'Cài đặt thử nghiệm', '2010-03-23', '2010-05-10')
insert into CONGVIEC values ('006',  1	, N'Lấy mẫu', '2006-10-20', '2007-02-20')
insert into CONGVIEC values ('006',  2	, N'Nuôi cấy', '2007-02-21', '2008-08-21')

GO
insert into THAMGIADT values ('001',  '002', 1 , 0.0 , NULL )
insert into THAMGIADT values ('001',  '002', 2 , 2.0 , NULL )
insert into THAMGIADT values ('002',  '001', 4 , 2.0 , 'Đạt' )
insert into THAMGIADT values ('003',  '001', 1 , 1.0 , 'Đạt' )
insert into THAMGIADT values ('003',  '001', 2 , 0.0 ,'Đạt' )
insert into THAMGIADT values ('003',  '001', 4 , 1.0 , 'Đạt' )
insert into THAMGIADT values ('003',  '002', 2 , 0.0 , NULL )
insert into THAMGIADT values ('004',  '006', 1 , 0.0 , 'Đạt')
insert into THAMGIADT values ('004',  '006', 2 , 1.0 , 'Đạt')
insert into THAMGIADT values ('006',  '006', 2 , 1.5 , 'Đạt')
insert into THAMGIADT values ('009',  '002', 3 , 0.5 , NULL)
insert into THAMGIADT values ('009',  '002', 4 , 1.5 , NULL)









