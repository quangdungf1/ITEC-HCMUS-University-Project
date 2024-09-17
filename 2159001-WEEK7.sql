--6. Viết hàm truyền vào mà độc giả tính số phiếu mượn của độc giả
GO
CREATE
--ALTER
FUNCTION UF_SOPHIEUMUON(@MADG VARCHAR(10))
RETURNS INT
BEGIN
	--KIỂM TRA MADG
	IF NOT EXISTS(SELECT * FROM PhieuMuon WHERE madg = @MADG)
		RETURN -1 --MAPM KO HỢP LỆ
	DECLARE @SOPHIEUMUON INT

	SELECT @SOPHIEUMUON  = COUNT(PM.MAPM)
	FROM PhieuMuon PM
	WHERE maDG = @MADG 

	RETURN @SOPHIEUMUON
END
---GỌI HÀM LOẠI 1: TRẢ VỀ KIỂU CƠ SỞ
SELECT *, dbo.UF_SOPHIEUMUON(DG.MADG) TONGSOPHIEUMUON
FROM DocGia DG

---FUNCTION LOẠI 2: TRẢ KIỂU BẢNG
CREATE
--ALTER
FUNCTION UF_SOPHIEUMUON()
RETURNS TABLE --LOẠI FUNCTION TRẢ VỀ BẢNG
AS
	--CHỈ CÓ 1 CÂU TRUY VẤN DUY NHẤT
	RETURN (SELECT maDG
			FROM DocGia)
--CÁCH DÙNG
SELECT *
FROM UF_SOPHIEUMUON() A JOIN DocGia PM ON PM.maDG = A.maDG
--7. Viết hàm truyền vào MaDG và ngày mượn tính số sách độc giả mượn trong ngày đó 
GO
CREATE
--ALTER
FUNCTION UF_SOSACHMUONTRONGNGAY(@MADG VARCHAR(10),
								@NGAYMUON DATE)
RETURNS INT
BEGIN
	--KIỂM TRA MADG
	IF NOT EXISTS(SELECT * FROM PhieuMuon WHERE madg = @MADG)
		RETURN -1 --MAPM KO HỢP LỆ

	DECLARE @SOSACHMUON INT

	SELECT @SOSACHMUON  = COUNT(PM.MAPM)
	FROM PhieuMuon PM
	WHERE maDG = @MADG and ngaymuon=@NGAYMUON

	RETURN @SOSACHMUON	
END
---GỌI HÀM LOẠI 1: TRẢ VỀ KIỂU CƠ SỞ
SELECT *, dbo.UF_SOSACHMUONTRONGNGAY(DG.MADG,PM.ngaymuon) SOSACHMUONTRONGNGAY
FROM DocGia DG JOIN PhieuMuon PM ON DG.madg=PM.madg

--8. Viết hàm truyền vào ngày sinh tính tuổi của độc giả  IF OBJECT_ID('UF_TINHTUOIDG') IS NOT NULL
    DROP FUNCTION UF_TINHTUOIDGGO
CREATE FUNCTION UF_TINHTUOIDG(@NGAYSINH DATE)
RETURNS INT
BEGIN
	--KIỂM TRA MADG
	DECLARE @SOTUOI INT

    SELECT @SOTUOI = ABS(DATEDIFF(YEAR,ngsinh,GETDATE()))
    FROM DocGia DG
    WHERE DG.ngsinh = @NGAYSINH
    RETURN @SOTUOI
END
---GỌI HÀM LOẠI 1: TRẢ VỀ KIỂU CƠ SỞ
SELECT *, dbo.UF_TINHTUOIDG('1999-12-20') TUOI
FROM DocGia


--15. Viết hàm truyền vào tuổi, giới tính xuất danh sách sách mà độc giả có tuổi và giới tính
--này mượn
IF OBJECT_ID('UF_DSSACH') IS NOT NULL
    DROP FUNCTION UF_DSSACH
GO
CREATE FUNCTION UF_DSSACH(@TUOI INT, @GIOITINH NVARCHAR(10))
RETURNS TABLE
AS
    RETURN (
            SELECT CS.*
            FROM CuonSach CS, CT_PhieuMuon CTPM, DocGia DG, PhieuMuon PM
            WHERE CS.masach = CTPM.masach AND CTPM.mapm=PM.mapm AND CTPM.isbn = CS.isbn AND DG.madg = PM.madg
            AND @TUOI = DBO.UF_TINHTUOIDG(DG.ngsinh)
            AND @GIOITINH = DG.gioitinh
            )
SELECT*
FROM UF_DSSACH(33,N'Nam')


--16. Viết hàm truyền vào MAPM xuất danh sách mượn (MaPM, NGAYMUON, ISBN,
--MASACH, SONGAYQUYDINH) IF OBJECT_ID('UF_DSMUON') IS NOT NULL
    DROP FUNCTION UF_DSMUON
GO
CREATE FUNCTION UF_DSMUON(@MAPM VARCHAR(10))
RETURNS TABLE
AS
    RETURN (
            SELECT CTPM.MAPM,PM.ngaymuon,CTPM.isbn,CTPM.masach,CTPM.songayquydinh
            FROM  CT_PhieuMuon CTPM, PhieuMuon PM
            WHERE CTPM.mapm = @MAPM AND PM.mapm=@MAPM AND CTPM.mapm = PM.mapm 
            )

SELECT*
FROM UF_DSMUON('PM001')


--17. Viết hàm truyền vào MAPM xuất danh sách trả (MAPM, MAPT, NGAYTRA, ISBN,
--MASACH, MUCGIAPHAT, TIENPHAT) IF OBJECT_ID('UF_DSTRA') IS NOT NULL
    DROP FUNCTION UF_DSTRA
GO
CREATE FUNCTION UF_DSTRA(@MAPM VARCHAR(10))
RETURNS TABLE
AS
    RETURN (
            SELECT PT.MAPM,PT.ngayTRA,CTPT.isbn,CTPT.masach,CTPT.mucgiaphat,CTPT.tienphat
            FROM  CT_PhieuTra CTPT, PhieuTRA PT
            WHERE CTPT.mapT = PT.mapt AND PT.mapm=@MAPM 
            )

SELECT*
FROM UF_DSMUON('PM001')

SELECT * FROM CuonSach
SELECT * FROM DocGia
SELECT * fROM PhieuMuon
SELECT*FROM CT_PhieuTRA
SELECT*FROM PhieuTRA
