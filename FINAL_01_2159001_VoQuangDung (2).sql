﻿--1
IF OBJECT_ID('UF_D1_C1') IS NOT NULL
	DROP FUNCTION UF_D1_C1
CREATE FUNCTION UF_D1_C1(@MAGV VARCHAR(10))
RETURNS INT
BEGIN
	DECLARE @KQ INT;

	SELECT @KQ=COUNT(MaDT) 
	FROM GiangVien GV JOIN DeTaiNCC DTNNC ON DTNNC.ChuNhiemDT=GV.MaGV
	WHERE @MAGV=GV.MaGV AND DTNNC.XepLoai IS NULL
	RETURN @KQ
	
END
SELECT DBO.UF_D1_C1('GV03')

--2

--					T	X	S
--DETAINCC			+	-	+(CHUNHIEMDT)

IF OBJECT_ID('UTR_D1_2') IS NOT NULL
	DROP TRIGGER UTR_D1_2

GO
CREATE TRIGGER UTR_D1_2
ON DeTaiNCC
FOR UPDATE
AS
	IF UPDATE(CHUNHIEMDT)
	BEGIN
		IF NOT EXISTS (SELECT * 
						FROM inserted I JOIN DeTaiNCC DT ON DT.ChuNhiemDT=I.ChuNhiemDT
						WHERE DBO.UF_D1_C1(I.CHUNHIEMDT)=1)
		BEGIN 
			RAISERROR(N'Mỗi giảng viên chỉ chủ nhiệm 1 đề tài đang thực hiện',15,1)
			ROLLBACK
		END
	END
GO
UPDATE DeTaiNCC
SET ChuNhiemDT='GV05' 
WHERE MaNNC='NH01'
UPDATE DeTaiNCC
SET XepLoai=NULL 
WHERE MaNNC='NH01'
--3
IF OBJECT_ID('UTR_D1_C3') IS NOT NULL
	DROP TRIGGER UTR_D1_C3

GO
CREATE TRIGGER UTR_D1_C3
ON DeTaiNCC
FOR UPDATE
AS
	IF UPDATE(CHUNHIEMDT)
	BEGIN
		IF NOT EXISTS (SELECT * 
						FROM inserted I JOIN DeTaiNCC DT ON DT.ChuNhiemDT=I.ChuNhiemDT
						WHERE DBO.UF_D1_C1(I.CHUNHIEMDT)=1)
		BEGIN 
			UPDATE DeTaiNCC
			SET ChuNhiemDT=DT.ChuNhiemDT
			FROM inserted I JOIN DeTaiNCC DT ON I.ChuNhiemDT!=DT.ChuNhiemDT
			WHERE DT.ChuNhiemDT IN(SELECT GV.MaGV
							FROM GiangVien GV JOIN DeTaiNCC DT ON GV.MaGV= DT.ChuNhiemDT
							WHERE GV.MaGV NOT IN (SELECT DeTaiNCC.ChuNhiemDT
													FROM DeTaiNCC 
													WHERE DBO.UF_D1_C1(DeTaiNCC.ChuNhiemDT)=0)
							)
			
		END
	END
GO
UPDATE DeTaiNCC
SET ChuNhiemDT='GV03' 
WHERE MaNNC='NH03'
UPDATE DeTaiNCC
SET XepLoai=NULL 
WHERE MaNNC='NH03'

SELECT * FROM GiangVien
SELECT * FROM SanPhamDT
SELECT * FROM DeTaiNCC
