CREATE
--ALTER

PROC SP_001
	@MAPM CHAR(10)
AS
	--XUẤT THÔNG TIN ĐỌC GIẢ
	DECLARE @HOTEN NVARCHAR(30),@NGAYMUON DATE

	SELECT @HOTEN = HOTEN,@NGAYMUON=ngaymuon
	FROM DocGia dg join PhieuMuon pm on dg.madg=pm.madg
	WHERE  pm.mapm=@MAPM
	
	PRINT N'MÃ PM:' + @MAPM
	PRINT N'NGÀY MƯỢN:' + CAST(@NGAYMUON AS NVARCHAR(20))
	PRINT N'HỌ TÊN ĐG:' + @HOTEN

	--KHAI BÁO CURSOR
	DECLARE CUR CURSOR FOR (SELECT ds.isbn,ctpm.masach,ds.tensach
							FROM DauSach ds join CT_PhieuMuon ctpm on ctpm.isbn=ds.isbn
							WHERE ctpm.mapm = @MAPM
							)
	
	--MỞ CURSOR
	OPEN CUR
	--NẠP DỮ LIỆU LẦN 1 VÀO CUR
	DECLARE @ISBN NCHAR(12), @MASACH NCHAR(5), @TENSACH NVARCHAR(100)

	FETCH NEXT FROM CUR INTO @ISBN, @MASACH,@TENSACH
	PRINT N' DANH SÁCH SÁCH MƯỢN'
	PRINT N'--------------------------------------------------------------------------------'
	PRINT N'ISBN' + SPACE(8) + N'MaSach' +SPACE(10) + N'TenSach'	
	PRINT N'--------------------------------------------------------------------------------'
	--DUYỆT CUR
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		--XỬ LÍ THEO ĐỀ
		PRINT @ISBN + SPACE (4)+ @MASACH+ SPACE(4)+@TENSACH
		FETCH NEXT FROM CUR INTO @ISBN, @MASACH,@TENSACH
	END
	--ĐÓNG CUR
	CLOSE CUR
	--HỦY VÙNG NHỚ
	DEALLOCATE CUR
GO
EXEC SP_001 'PM003     '

GO
CREATE
--ALTER

PROC SP_002
	@MAPT CHAR(10)
AS
	--KHAI BÁO CURSOR

	DECLARE CUR CURSOR FOR (SELECT DS.isbn, CTPT.masach, DS.tensach, DATEDIFF (DAY,PM.ngaymuon,PT.ngaytra) AS TONG_NGAY_MUON
							FROM DauSach DS 
							JOIN CT_PhieuTra CTPT
							ON CTPT.isbn = DS.isbn
							JOIN PhieuTra PT
							ON PT.mapt=CTPT.mapt
							JOIN PhieuMuon PM 
							ON PM.mapm=PT.mapm
							WHERE CTPT.mapt = @MAPT)

	
	--MỞ CURSOR
	OPEN CUR
	--NẠP DỮ LIỆU LẦN 1 VÀO CUR
	DECLARE @ISBN NCHAR(12), @MASACH NCHAR(5), @TENSACH NVARCHAR(100),@SONGAYMUON INT

	FETCH NEXT FROM CUR INTO @ISBN, @MASACH,@TENSACH,@SONGAYMUON
	PRINT N' DANH SÁCH SÁCH TRẢ'
	PRINT N'--------------------------------------------------------------------------------------------------------'
	PRINT N'ISBN' + SPACE(8) + N'MaSach' +SPACE(10) + N'TenSach'+SPACE(8)+N'Số ngày mượn'
	PRINT N'--------------------------------------------------------------------------------------------------------'
	--DUYỆT CUR
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		--XỬ LÍ THEO ĐỀ
		PRINT @ISBN + SPACE (4)+ @MASACH+ SPACE(4)+@TENSACH+SPACE(10-LEN(CAST(@SONGAYMUON AS VARCHAR(5)))) + CAST(@SONGAYMUON AS VARCHAR(5)) 
		FETCH NEXT FROM CUR INTO @ISBN, @MASACH,@TENSACH,@SONGAYMUON
	END
	--ĐÓNG CUR
	CLOSE CUR
	--HỦY VÙNG NHỚ
	DEALLOCATE CUR
GO
EXEC SP_002 'PT002     '
SELECT * FROM PhieuTra
DROP PROC SP_002

--3
GO
CREATE
--ALTER

PROC SP_003
	@MAPM CHAR(10)
AS
	--KHAI BÁO CURSOR
	DECLARE CUR CURSOR FOR (SELECT ds.isbn,ctpm.masach,ds.tensach,DATEDIFF(DAY,(DATEADD(DAY,CTPM.songayquydinh,PM.ngaymuon)),PT.ngaytra) AS ttrang
							FROM DauSach ds join CT_PhieuMuon ctpm on ctpm.isbn=ds.isbn
							JOIN PhieuMuon PM ON PM.mapm=CTPM.mapm
							JOIN PhieuTra PT ON PT.mapm=PM.mapm
							WHERE ctpm.mapm = @MAPM
							)
	select * from PhieuMuon
	select * from CT_PhieuMuon
	select * from PhieuTra
	--MỞ CURSOR
	OPEN CUR
	--NẠP DỮ LIỆU LẦN 1 VÀO CUR
	DECLARE @ISBN NCHAR(12), @MASACH NCHAR(5), @TENSACH NVARCHAR(100),@TTRANG NVARCHAR(10)

	FETCH NEXT FROM CUR INTO @ISBN, @MASACH,@TENSACH,@TTRANG
	PRINT N' DANH SÁCH SÁCH ĐANG MƯỢN'
	PRINT N'-------------------------------------------------------------------------------------------------'
	PRINT N'ISBN' + SPACE(8) + N'MaSach' +SPACE(10) + N'TenSach'	+SPACE(8)+N'Tình trạng(trễ,-)'
	PRINT N'-------------------------------------------------------------------------------------------------'
	--DUYỆT CUR
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		--XỬ LÍ THEO ĐỀ
		PRINT @ISBN + SPACE (4)+ @MASACH+ SPACE(4)+@TENSACH+SPACE(5 - LEN(CAST(ISNULL(@TTRANG,0) AS VARCHAR(5)))) 
		+ CAST(ISNULL(@SOLANTRA,0) AS VARCHAR(5))
		FETCH NEXT FROM CUR INTO @ISBN, @MASACH,@TENSACH
	END
	--ĐÓNG CUR
	CLOSE CUR
	--HỦY VÙNG NHỚ
	DEALLOCATE CUR
GO
EXEC SP_001 'PM003     '
