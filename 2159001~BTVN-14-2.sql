

--1
Alter table PhieuMuon
	add SoCuonMuon int;
declare cur cursor for(select mapm,count(*)
						from CT_PhieuMuon
						group by mapm
						)
open cur

declare @mapm char(10),@socuonmuon int
fetch next from cur into @mapm, @socuonmuon
while (@@fetch_status=0)
begin
        update PhieuMuon
        set SoCuonMuon = @socuonmuon 
        where mapm=@mapm
    fetch next from cur into @mapm, @socuonmuon
end
close cur
deallocate cur
--2
go
create
proc sp_DanhSachDS
			@isbn nchar(12)
as 
	--KHAI BÁO CURSOR
	DECLARE CUR CURSOR FOR (SELECT ct.isbn, tensach,count(distinct ct.masach) as SoSachMuon
							FROM DauSach  join CuonSach 
							ON DauSach.isbn=CuonSach.isbn join CT_PhieuMuon  ct
							ON  ct.masach= CuonSach.masach and ct.isbn=CuonSach.isbn
							WHERE DauSach.isbn=@isbn
							GROUP BY ct.isbn, tensach
							)
	--MỞ CURSOR
	OPEN CUR
	--NẠP DỮ LIỆU LẦN 1 VÀO CUR
	DECLARE @MADAUSACH nvarchar(12),@TENDAUSACH nvarchar(25), @SOSACHMUON int ,@SOSACHCONLAI int
	FETCH NEXT FROM CUR INTO @MADAUSACH , @TENDAUSACH  ,@SOSACHMUON
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
			select @SOSACHCONLAI=( select count(cs.masach) as SOMASACH from CuonSach cs join CT_PhieuMuon ct on cs.isbn=ct.isbn and cs.masach=ct.masach
			where  cs.isbn=@isbn and cs.masach 
			not in (select distinct masach from CT_PhieuMuon ))
			PRINT N' DANH SÁCH SÁCH MƯỢN'
			PRINT N'--------------------------------------------------------------------------------'
			PRINT N'MÃ ĐẦU SÁCH' + SPACE(8) + N'TÊN ĐẦU SÁCH' +SPACE(10) +N'TỔNG SỐ SÁCH HIỆN CÒN'+SPACE(4)+N'TỔNG SỐ SÁCH ĐANG MƯỢN'
			PRINT cast(@MADAUSACH as nvarchar(12))+ space(8) +@TENDAUSACH+space(30-len(@TENDAUSACH)) +cast(@SOSACHMUON  as varchar(2)) +space(16) + cast(@SOSACHCONLAI as nvarchar(2))
			PRINT N'--------------------------------------------------------------------------------'
			fetch next from cur into @MADAUSACH,@TENDAUSACH,@SOSACHMUON 
	END
	CLOSE CUR
	--HỦY VÙNG NHỚ
	DEALLOCATE CUR
	exec sp_DanhSachDS '116525441   '
	DROP PROC sp_DanhSachDS
--3
go
create
proc sp_ThongKetg9
			@thang int , @nam int
as 
	--KHAI BÁO CURSOR
	DECLARE CUR CURSOR FOR (SELECT count (distinct madg) as N'Số Đôc Giả',(SELECT isbn FROM 
																					(SELECT isbn, count(mapm) AS Soluon FROM CT_PhieuMuon
																					   GROUP BY isbn) AS A WHERE Soluon >= 
																					   all (SELECT count(mapm) AS Soluon FROM CT_PhieuMuon
																					   GROUP BY isbn)) AS N'Đầu Sách mượn nhiều nhất', sum(tienphat) 
																					   AS N'Tổng tiền phạt'
							FROM PhieuMuon left join CT_PhieuMuon ON PhieuMuon.mapm= CT_PhieuMuon.mapm 
							 left join PhieuTra ON PhieuMuon.mapm =PhieuTra.mapm 
							 join CT_PhieuTra ON PhieuTra.mapt = CT_PhieuTra.mapt
							 WHERE month(ngaytra) <= @thang and year(ngaytra)<=@nam)
							
	--MỞ CURSOR
	OPEN CUR
	--NẠP DỮ LIỆU LẦN 1 VÀO CUR
	DECLARE @SODOCGIA CHAR(2),@DAUSACH CHAR(10), @TIENPHAT float
	FETCH NEXT FROM CUR INTO @SODOCGIA , @DAUSACH  ,@TIENPHAT
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
			PRINT N'THỐNG KÊ'
		   PRINT N'THỜI GIAN'+space(2) + '0'+cast(@thang as char(2)) +'/' + cast(@nam as char(4))
		   print N'SỐ ĐỘC GIẢ'+space(2) +@SODOCGIA
		   PRINT N'ĐẦU SÁCH ĐƯỢC MƯỢN NHIỀU NHẤT'+space(2) +@DAUSACH
		   PRINT N'TỔNG TIỀN PHẠT'+space(2)+cast(isnull(@TIENPHAT,'-')as char(10))
		  FETCH NEXT FROM CUR INTO @SODOCGIA , @DAUSACH, @TIENPHAT
	END
	CLOSE CUR
	--HỦY VÙNG NHỚ
	DEALLOCATE CUR
	exec sp_ThongKetg9 '3' ,'2024'
	DROP PROC sp_ThongKetg9

--4

go
create
proc sp_MuonTraSach
as 
	--KHAI BÁO CURSOR
	
	DECLARE CUR CURSOR FOR (SELECT PM.MAPM
							FROM PhieuMuon PM  
							)
	--MỞ CURSOR
	OPEN CUR
	--NẠP DỮ LIỆU LẦN 1 VÀO CUR
	DECLARE @MAPM char(10), @TINHTRANG nvarchar(15),@ISBN nchar(12),@MADAUSACH nchar(5),@TENDAUSACH nvarchar(20)
	FETCH NEXT FROM CUR INTO @MAPM
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
			PRINT N'MÃ PHIẾU MƯỢN: '+@MAPM
			IF NOT EXISTS (SELECT MAPM FROM PhieuTra WHERE MAPM =@MAPM)
				SET @TINHTRANG =N'CHƯA TRẢ XONG'
			ELSE
				SET @TINHTRANG=N'ĐÃ TRẢ XONG'
			PRINT N'TÌNH TRẠNG: '+@TINHTRANG
			IF @TINHTRANG = N'CHƯA TRẢ XONG'
				BEGIN
					PRINT N'--------------------------------------------------------------------------------'
					PRINT N'DANH SÁCH CHƯA TRẢ SÁCH '
					PRINT N'--------------------------------------------------------------------------------'
					PRINT N'MÃ ĐẦU SÁCH'+SPACE(8)+ N'MÃ SÁCH'+SPACE(8)+ N'TÊN SÁCH'
					DECLARE CUR_1 CURSOR FOR(SELECT CTPM.isbn , CTPM.masach ,DS.tensach
												FROM CT_PhieuMuon CTPM JOIN CuonSach CS ON CTPM.isbn=CS.isbn
												JOIN DauSach DS ON DS.isbn=DS.isbn AND CTPM.masach=CS.masach
												WHERE CTPM.mapm=@MAPM)
					OPEN CUR_1 
					FETCH NEXT FROM CUR_1 INTO @ISBN,@MADAUSACH,@TENDAUSACH
					WHILE (@@FETCH_STATUS = 0)
						BEGIN
							PRINT RTRIM(@ISBN) +SPACE(8)+ @MADAUSACH+SPACE(8)+@TENDAUSACH
							FETCH NEXT FROM CUR_1 INTO @ISBN, @MADAUSACH, @TENDAUSACH
						END
					CLOSE CUR_1
					DEALLOCATE CUR_1
				END
			ELSE
			FETCH NEXT FROM CUR INTO @MAPM
	END
	CLOSE CUR
	--HỦY VÙNG NHỚ
	DEALLOCATE CUR

	exec sp_MuonTraSach
	DROP PROC sp_MuonTraSach
