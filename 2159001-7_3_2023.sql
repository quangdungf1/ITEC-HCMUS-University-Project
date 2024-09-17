--1. Viết hàm đếm số độc giả
IF OBJECT_ID('UF_CAU1') IS NOT NULL
    DROP FUNCTION UF_CAU1
GO
CREATE FUNCTION UF_CAU1()
RETURNS INT
BEGIN
	
	DECLARE @SODOCGIA INT

    SELECT  @SODOCGIA = COUNT(DG.MADG)
    FROM DocGia DG
    RETURN @SODOCGIA 
END
---GỌI HÀM LOẠI 1: TRẢ VỀ KIỂU CƠ SỞ
SELECT dbo.UF_CAU1() SODOCGIA




--2. Viết hàm truyền vào isbn lấy mức giá phạt của đầu sách 
IF OBJECT_ID('UF_CAU2') IS NOT NULL
    DROP FUNCTION UF_CAU2
GO
CREATE FUNCTION UF_CAU2(@ISBN nchar(12))
RETURNS FLOAT
BEGIN
	if not exists (select *
                   from DauSach
                   where isbn=@isbn)
        return -1;--trả lỗi 

	DECLARE @MUCGIAPHAT float
	SELECT @MUCGIAPHAT =MUCGIAPHAT
	FROM DauSach
	WHERE ISBN=@ISBN
	RETURN @MUCGIAPHAT
END
---GỌI HÀM LOẠI 1: TRẢ VỀ KIỂU CƠ SỞ
SELECT dbo.UF_CAU2('116525441') MUCGIAPHAT

--3. Viết hàm truyền vào MaPM, ISBN, MaSach lấy số ngày qui định
IF OBJECT_ID('UF_CAU3') IS NOT NULL
    DROP FUNCTION UF_CAU3
GO
CREATE FUNCTION UF_CAU3(@mapm varchar(20), @isbn varchar(20), @masach varchar(20))
RETURNS int
BEGIN
	if not exists (select *
                   from CT_PhieuMuon
                   where mapm=@mapm and isbn=@isbn and masach=@masach)
        return -1;--trả lỗi

	DECLARE  @songayquidinh int
	SELECT @songayquidinh= ctpm.songayquydinh
	FROM CT_PhieuMuon ctpm inner join PhieuMuon pm on ctpm.mapm=pm.mapm
	WHERE ctpm.mapm=@mapm and ctpm.isbn=@isbn and ctpm.masach=@masach
	RETURN @songayquidinh
END
---GỌI HÀM LOẠI 1: TRẢ VỀ KIỂU CƠ SỞ
SELECT dbo.UF_CAU3('PM002','116525441','S001') SONGAYQUYDINH


--4. Viết hàm truyền vào MaPM lấy ngày mượn
IF OBJECT_ID('UF_CAU4') IS NOT NULL
    DROP FUNCTION UF_CAU4
GO
CREATE FUNCTION UF_CAU4(@mapm varchar(20))
RETURNS DATE
BEGIN
	if not exists (select *
                   from PhieuMuon
                   where mapm=@mapm)
        return getdate();--trả lỗi

	DECLARE  @ngaymuon date
	SELECT @ngaymuon=ngaymuon
	FROM PhieuMuon
	WHERE mapm=@mapm
	RETURN @ngaymuon
END
---GỌI HÀM LOẠI 1: TRẢ VỀ KIỂU CƠ SỞ
SELECT dbo.UF_CAU4('PM002') NGAYMUON


--5. Viết hàm truyền vào MaPT lấy ngày trả 
IF OBJECT_ID('UF_CAU5') IS NOT NULL
    DROP FUNCTION UF_CAU5
GO
CREATE FUNCTION UF_CAU5(@mapt varchar(30))
RETURNS DATE
BEGIN
	if not exists (select *
					   from PhieuTra
					   where mapt=@mapt)
			return getdate();--trả lỗi

	DECLARE  @ngaytra date
	SELECT @ngaytra=ngaytra
	FROM PhieuTra
	WHERE mapt=@mapt
	RETURN @ngaytra
END
---GỌI HÀM LOẠI 1: TRẢ VỀ KIỂU CƠ SỞ
SELECT dbo.UF_CAU5('PT002') NGAYTRA

--9. Viết hàm truyền vào ngày mượn tính số sách được mượn trong ngày đó 
IF OBJECT_ID('UF_CAU9') IS NOT NULL
    DROP FUNCTION UF_CAU9
GO
CREATE FUNCTION UF_CAU9(@ngaymuon date)
RETURNS INT
BEGIN
	if not exists (select *
                   from PhieuMuon
                   where ngaymuon=@ngaymuon)
        return -1;--trả lỗi

	DECLARE  @sosach int
	SELECT distinct @sosach=count(ctpm.mapm)
	FROM PhieuMuon pm join CT_PhieuMuon ctpm on pm.mapm=ctpm.mapm
	GROUP BY pm.ngaymuon
	HAVING pm.ngaymuon=@ngaymuon
	RETURN @sosach
END
---GỌI HÀM LOẠI 1: TRẢ VỀ KIỂU CƠ SỞ
SELECT dbo.UF_CAU9('2014-02-26') SOSACHMUON

--10. Viết hàm truyền vào MaPM và MaPT tính số sách còn nợ của độc giả 
IF OBJECT_ID('UF_CAU10') IS NOT NULL
    DROP FUNCTION UF_CAU10
GO
CREATE FUNCTION UF_CAU10(@mapm char(10), @mapt char(10))
RETURNS INT
BEGIN
	if not exists (select *
                   from PhieuMuon
                   where mapm=@mapm)
        return -1;--trả lỗi
	if not exists (select *
                   from PhieuTra
                   where mapt=@mapt)
        return -1;--trả lỗi

	DECLARE  @sosachno int
	SELECT  @sosachno = count(pm.mapm)-1
	FROM PhieuMuon pm join PhieuTra pt on pm.mapm=pt.mapm
	WHERE pt.mapt=@mapt and pm.mapm=@mapm and pm.mapm in(SELECT MAPM
														FROM PhieuTra
														WHERE mapt=@mapm and mapt=@mapt)
	RETURN @sosachno
END
---GỌI HÀM LOẠI 1: TRẢ VỀ KIỂU CƠ SỞ
SELECT dbo.UF_CAU10('PM002', 'PT002') SOSACHNO


---11. Viết hàm truyền vào MaPT, ISBN, MaSach tính tiền phạt 
IF OBJECT_ID('UF_CAU11') IS NOT NULL
    DROP FUNCTION UF_CAU11
GO
CREATE FUNCTION UF_CAU11(@mapt char(10) , @isbn nchar(12) , @masach nchar(5))
RETURNS FLOAT
BEGIN
	if not exists (select *
                   from CT_PhieuTra
                   where mapt=@mapt and isbn=@isbn and masach=@masach)
        return -1;--trả lỗi

	DECLARE  @tienphat float
	SELECT @tienphat=tienphat
	FROM CT_PhieuTra
	WHERE mapt=@mapt and isbn=@isbn and masach=@masach
	RETURN @tienphat
END	
---GỌI HÀM LOẠI 1: TRẢ VỀ KIỂU CƠ SỞ
SELECT dbo.UF_CAU11('PT001','116525441','S001') TINHTIENPHAT

--12. Viết hàm truyền vào ISBN và chỉ thị:
--- Nếu chỉ thị là 1 thì trả ra danh sách sách có tình trạng =Đang được mượn
--- Nếu chỉ thị là 2 thì trả ra danh sách sách có tình trạng = Có thể mượn
IF OBJECT_ID('UF_CAU12') IS NOT NULL
    DROP FUNCTION UF_CAU12
GO
CREATE FUNCTION UF_CAU12(@isbn varchar(20),@status int)
RETURNS @bookList table(isbn varchar(20),masach varchar(10))
BEGIN
	if (@status=1)
	begin
		insert into @bookList(isbn,masach)
		select isbn,masach
		from CT_PhieuMuon
		where isbn=@isbn
	end
	else if (@status=2)
	begin
		insert into @bookList(isbn,masach)
		select isbn,masach
		from CuonSach
		where tinhtrang=N'có thể mượn' and isbn=@isbn
	end
	return
END	
---GỌI HÀM LOẠI 2
SELECT * FROM dbo.UF_CAU12('116525441',2) 

--13. Viết hàm truyền vào tình trạng cho biết danh sách cuốn sách trong tình trạng đó
IF OBJECT_ID('UF_CAU13') IS NOT NULL
    DROP FUNCTION UF_CAU13
GO
CREATE FUNCTION UF_CAU13(@tinhtrang nchar(50))
RETURNS table
AS
RETURN (select isbn, masach, tinhtrang
		from CuonSach
		where tinhtrang=@tinhtrang)
---GỌI HÀM LOẠI 2
SELECT * FROM dbo.UF_CAU13(N'có thể mượn')

--14. Viết hàm truyền vào thể loại xuất danh sách sách (ISBN, TenSach, TacGia, SoLuong, MucGiaPhat) thuộc thể loại đó 
IF OBJECT_ID('UF_CAU14') IS NOT NULL
    DROP FUNCTION UF_CAU14
GO
CREATE FUNCTION UF_CAU14(@theloai nvarchar(70))
RETURNS table
AS
RETURN (select isbn,tensach, tacgia,soluong,mucgiaphat,theloai
		from DauSach
		where theloai=@theloai)
---GỌI HÀM LOẠI 2
SELECT * FROM dbo.UF_CAU14(N'ngoại ngữ')

--18. Viết hàm truyền vào ISBN và MaSach cho biết danh sách sách (ISBN, MASACH, Số sách có, số sách đang được mượn) 
IF OBJECT_ID('UF_CAU18') IS NOT NULL
    DROP FUNCTION UF_CAU18
GO
CREATE FUNCTION UF_CAU18(@theloai nvarchar(70))
RETURNS table
AS
RETURN (select DauSach.isbn, masach , count(mapm) as sosachdangmuom,soluong as sosachcon
        from CT_PhieuMuon join DauSach on CT_PhieuMuon.isbn=DauSach.isbn
		group by DauSach.isbn,masach,soluong
		having DauSach.isbn=@isbn and masach=@masach)
---GỌI HÀM LOẠI 2
SELECT * FROM dbo.cau18('116525441','S002')

--19. Viết hàm truyền vào MaDG xuất danh sách phiếu mượn của độc gia (MaPM, NgayMuon, số sách mượn) 
IF OBJECT_ID('UF_CAU19') IS NOT NULL
    DROP FUNCTION UF_CAU19
GO
CREATE	
FUNCTION UF_CAU19(@madg nchar(10))
RETURNS table
AS
RETURN(select pm.mapm,pm.ngaymuon,count(*)as SoSachMuon
       from PhieuMuon pm join CT_PhieuMuon ctpm on pm.mapm=ctpm.mapm
       where pm.madg=@madg
       group by pm.mapm,pm.ngaymuon)
---GỌI HÀM LOẠI 2
SELECT * FROM dbo.UF_CAU19('DG01')

--20. Viết hàm truyền vào Ngày mượn xuất danh sách sách mượn (MaPM, ISBN, MaSach, SoNgayQuyDinh) trong ngày đó
IF OBJECT_ID('UF_CAU20') IS NOT NULL
    DROP FUNCTION UF_CAU20
GO
CREATE	
FUNCTION UF_CAU20(@ngaymuon date)
RETURNS table
AS
RETURN(select ctpm.mapm,ctpm.isbn,ctpm.masach,ctpm.songayquydinh
        from CT_PhieuMuon ctpm join PhieuMuon pm on ctpm.mapm=pm.mapm
        where pm.ngaymuon=@ngaymuon)
---GỌI HÀM LOẠI 2
SELECT * FROM dbo.UF_CAU20('2014-12-20')

