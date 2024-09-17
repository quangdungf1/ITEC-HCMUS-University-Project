--1. Ngày mượn sách phải là ngày hiện tại
--				T	X	S
--PHIEUMUON		+	-	+(NGAYMUON)
iF OBJECT_ID('TR_CAU1') IS NOT NULL
    DROP TRIGGER TR_CAU1
GO
--CREATE
ALTER
trigger TR_CAU1
on PhieuMuon
for insert,update
as
begin
	if update(ngaymuon)
	begin
		if exists(select pm.mapm
				  from inserted i join PhieuMuon pm on i.mapm=pm.mapm
				  where pm.ngaymuon=getdate())
		begin
			raiserror(N'Ngày mượn phải là ngày hiện tại',15,1)
			rollback
		end
	end	
end
go
insert into PhieuMuon(mapm,madg,ngaymuon)
values('PM303','DG03','2023-03-09')

select * from PhieuMuon


--2. Ngày trả sách phải là ngày hiện tại.
--				T	X	S
--PHIEUTRA		+	-	+(NGAYTRA)
iF OBJECT_ID('TR_CAU2') IS NOT NULL
    DROP TRIGGER TR_CAU2
GO
--CREATE
ALTER
trigger TR_CAU2

on PhieuTRA
for insert,update
as
begin
	if update(ngaytra)
	begin
		if exists(select pt.mapt
				  from inserted i join PhieuTra pt on i.mapt=pt.mapt
				  where pt.ngaytra=getdate())
		begin
			raiserror(N'Ngày trả phải là ngày hiện tại',15,1)
			rollback
		end
	end	

end
go
insert into PhieuTra(mapt,mapm,ngaytra)
values('PT004','PM005','2023-03-14')
select * from Phieutra

--3. Tình trạng sách chỉ bao gồm : “đang được mượn” hoặc “có thể cho mượn”

--             T   X   S
--CuonSach     +   -   +(tinhtrang)
iF OBJECT_ID('TR_CAU3') IS NOT NULL
    DROP TRIGGER TR_CAU3
GO
create 
--alter
trigger TR_CAU3
on CuonSach
for insert,update
as 
begin
	if update(tinhtrang)
	begin
		if not exists(select isbn
					  from inserted  
				      where tinhtrang=N'đang được mượn' or tinhtrang=N'có thể cho mượn')
		begin
			raiserror(N'tình trạng chỉ bao gồm "đang được mượn" hoặc "có thể mượn"',15,1)
			rollback
		end
	end	
end
go
insert into CuonSach(isbn,masach,tinhtrang)
values('116525441','S012',N'có thể cho mượn')

select * from CuonSach

--7. Thêm thuộc tính “NgayTraDuKien” vào bảng CT_PhieuTra. Ngày trả dự kiến = ngày mượn +
--số ngày quy định được mượn.
--					T   X   S
--CT_PhieuTra		-   -   -
--CT_PhieuMuon		+   -   +(tinhtrang)
--PHIEUMUON			+   -   +(tinhtrang)
select * from PHIEUMUON

iF OBJECT_ID('TR_CAU7') IS NOT NULL
    DROP TRIGGER TR_CAU7
GO
CREATE TRIGGER TR_CAU7
ON CT_PhieuTra
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
                SELECT *
                FROM inserted I
                WHERE I.NGAYDUKIEN != (
                                    SELECT DATEADD(DAY,CTPM.NgayTraDuKien,pm.ngaymuon)
                                    FROM CT_PhieuTra CTPT JOIN CT_PhieuMuon CTPM
                                    ON CTPT.isbn = CTPM.isbn
									JOIN PHIEUMUON PM ON PM.mapm=CTPM.mapm
                                    WHERE CTPT.mapt = I.mapt
                                    )
                )	
    BEGIN
        RAISERROR(N'SoLantra = số phiếu trả của phiếu mượn tương ứng',15,1)
        ROLLBACK
    END
END
GO
INSERT INTO CT_PhieuTra
ALTER TABLE CT_PhieuTra

add NGAYDUKIEN datetime;

--8. Tình trạng cuốn sách được tự động cập nhật “đang được mượn” khi thủ thư thực hiện cho độc
--giả mượn sách này.