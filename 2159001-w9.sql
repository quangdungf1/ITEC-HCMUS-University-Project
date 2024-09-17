-- ngay giao phai sau ngay dat
--					T	X	S
--PHIEUMUON			+	-	+(MAPM,MADG)78
--TAO TRIGER	

alter trigger tg_ThemPM
ON PhieuMuon
For insert
as
begin
	--xử lý kiểm tra
	--dl đã được insert vào bảng phieumuon rồi
	-- đồng thời dl được insert vào inserted
	--đếm số pmuon của mỗi đọc gia trong mỗi ngày
	--group by madg, ngaymuon
	--xuất dl của inserted
	if exists (select count(*) from inserted i join PhieuMuon pm on pm.madg = i.madg
	group by i.madg, pm.ngaymuon
	having count(*) >3
	)
	begin
		raiserror(N'ko mượn quá 3 pm 1 ngày',15,1)
		rollback
	end
end	
go
insert into PhieuMuon(mapm,madg,ngaymuon) values ('PM007','DG01','3/1/2023')
insert into PhieuMuon(mapm,madg,ngaymuon) values ('PM008','DG01','3/1/2023'),('PM009','DG02','3/1/2023')

select count(*)
from PhieuMuon
where madg='DG01'
group by madg, ngaymuon

--4.Đọc giả muốn mượn sách phải từ 18 tuổi trở lên.
--			T	X	S
--DOCGIA	+	-	+(DG.NGAYSINH)
ALTER trigger tg_DOCGIAMUON
ON DOCGIA
For insert, update
as
begin
	if update(ngsinh)
	begin
		if exists (select DG.MADG from inserted i join DocGia DG on DG.madg = i.madg
		WHERE ABS(DATEDIFF(YEAR,GETDATE(),DG.ngsinh))<=18
		)
		begin
			raiserror(N'DOC GIA MUON SACH PHAI LON HON 18 TUOI',15,1)
			rollback
		end
	end
	if exists (select DG.MADG from inserted i join DocGia DG on DG.madg = i.madg
		WHERE ABS(DATEDIFF(YEAR,GETDATE(),DG.ngsinh))<=18
		)
		begin
			raiserror(N'DOC GIA MUON SACH PHAI LON HON 18 TUOI',15,1)
			rollback
		end
end	
go
insert into DocGia(madg,hoten,ngsinh) values ('DG007','NGUYEN HUY HONAG','9/5/2013')
insert into DocGia(madg,hoten,ngsinh) values ('DG014','MINH DE','2/11/1983')
SELECT * FROM DocGia

--5.Số lượng đầu sách hiện có >=0.
--			T	X	S
--DAUSACH	+	-	+(DS.SOLUONG)
CREATE trigger tg_DAUSACHHIENCO
ON DauSach
For insert,UPDATE
as
begin
	if update(soluong)
	begin
		if exists (select * 
			from inserted i join DauSach DS on DS.isbn = i.isbn 
			WHERE DS.soluong<=0
			)                                 
		begin
			raiserror(N'Số lượng đầu sách hiện có phai lon hon 0.',15,1)
			rollback
		end
	end
	if exists (select * 
			from inserted i join DauSach DS on DS.isbn = i.isbn 
			WHERE DS.soluong<=0
			)                                 
	begin
		raiserror(N'Số lượng đầu sách hiện có phai lon hon 0.',15,1)
		rollback
	end
end	
go
insert into DauSach(isbn,tensach,soluong,tensach) values ('215637841   ','SACH BAN CS CUC BAY','0')
insert into DauSach(isbn,tensach,soluong,tensach) values ('971778922 ','SACH DAY LAM GIAU',2)

--6. Thêm thuộc tính “SoLanTra” vào bảng PhieuMuon. SoLantra = số phiếu trả của phiếu mượn
--tương ứng.
iF OBJECT_ID('TR_PHIEUMUON') IS NOT NULL
    DROP TRIGGER TR_PHIEUMUON
GO
CREATE TRIGGER TR_PHIEUMUON
ON PHIEUMUON
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
                SELECT*
                FROM inserted I
                WHERE I.SoLanTra != (
                                    SELECT COUNT(CTPT.mapt)
                                    FROM PhieuTra PT JOIN CT_PhieuTra CTPT
                                    ON PT.mapt = CTPT.mapt
                                    WHERE PT.mapm = I.mapm
                                    GROUP BY PT.mapm
                                    )
                )
    BEGIN
        RAISERROR(N'SoLantra = số phiếu trả của phiếu mượn tương ứng',15,1)
        ROLLBACK
    END
END
GO
INSERT INTO PhieuMuon