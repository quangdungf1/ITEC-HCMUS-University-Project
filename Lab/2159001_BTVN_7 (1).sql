

--Q35 Cho	biết	mức	lương	cao	nhất	của	các	giảng	viên.
SELECT DISTINCT gv.LUONG
FROM GIAOVIEN gv
WHERE gv.LUONG>=all(SELECT gv2.LUONG FROM GIAOVIEN gv2)

--Q36 Cho	biết	những	giáo	viên	có	lương	lớn	nhất
SELECT gv.*
FROM GIAOVIEN gv
WHERE gv.LUONG>=all(SELECT gv2.LUONG FROM GIAOVIEN gv2)

--Q37 Cho	biết	lương	cao	nhất	trong	bộ môn	“HTTT”
SELECT DISTINCT gv.LUONG
FROM GIAOVIEN gv
WHERE gv.MABM='MMT' and gv.LUONG>=all(SELECT gv2.LUONG FROM GIAOVIEN gv2 WHERE gv2.MABM='MMT')

--Q38 Cho	biết	tên	giáo	viên	lớn	tuổi	nhất	của	bộ môn	Hệ thống	thông	tin.
SELECT gv.HOTEN
FROM GIAOVIEN gv join BOMON bm on bm.MABM=gv.MABM
WHERE bm.TENBM=N'Hệ thống thông tin' 
and gv.NGSINH<=all(SELECT gv2.NGSINH FROM GIAOVIEN gv2 join BOMON bm2 ON bm2.MABM=gv2.MABM WHERE bm2.TENBM=N'Hệ thống thông tin')

--Q39 . Cho	biết	tên	giáo	viên	nhỏ tuổi	nhất	khoa	Công	nghệ thông	tin.
SELECT GV.HOTEN
FROM GIAOVIEN gv join BOMON bm ON gv.MABM=bm.MABM join KHOA k ON k.MAKHOA=bm.MAKHOA
WHERE k.TENKHOA=N'Công nghệ thông tin'
and year(gv.NGSINH)>=all(SELECT year(gv2.NGSINH) FROM GIAOVIEN gv2 join BOMON bm2 ON gv2.MABM=bm2.MABM join KHOA k2 ON k2.MAKHOA=bm2.MAKHOA
WHERE k2.TENKHOA=N'Công nghệ thông tin')
 
--Q40 Cho	biết	tên	giáo	viên	và	tên	khoa	của	giáo	viên	có	lương	cao	nhất
SELECT GV.HOTEN, k.TENKHOA
FROM GIAOVIEN gv join BOMON bm ON gv.MABM=bm.MABM join KHOA k ON k.MAKHOA=bm.MAKHOA
WHERE gv.LUONG>=all(SELECT gv2.LUONG FROM GIAOVIEN gv2)

--Q41 Cho	biết	những	giáo	viên	có	lương	lớn	nhất	trong	bộ môn	của	họ.
SELECT gv.HOTEN
FROM GIAOVIEN gv 
GROUP BY gv.MABM, gv.HOTEN, gv.LUONG
having gv.LUONG>=all(SELECT gv2.LUONG FROM GIAOVIEN gv2 group by gv2.MABM, gv2.LUONG having gv2.MABM=gv.MABM)

--Q42 Cho	biết	tên	những	đề tài	mà	giáo	viên	Nguyễn	Hoài	An	chưa	tham	gia.
SELECT dt.TENDT
FROM DETAI dt
WHERE dt.MADT not in (SELECT tg.MADT FROM GIAOVIEN gv join THAMGIADT tg ON tg.MAGV=GV.MAGV WHERE gv.HOTEN=N'Nguyễn Hoài An')

--Q43 Cho	biết	những	đề tài	mà	giáo	viên	Nguyễn	Hoài	An	chưa	tham	gia.	Xuất	ra	tên	đề tài,	
--tên	người	chủ nhiệm	đề tài.
SELECT dt.TENDT,gv2.HOTEN
FROM DETAI dt join GIAOVIEN gv2 ON dt.GVCNDT=gv2.MAGV
WHERE dt.MADT not in (SELECT tg.MADT FROM GIAOVIEN gv join THAMGIADT tg ON tg.MAGV=GV.MAGV WHERE gv.HOTEN=N'Nguyễn Hoài An')

--Q44 Cho	biết	tên	những	giáo	viên	khoa	Công	nghệ thông	tin	mà	chưa	tham	gia	đề tài	nào
SELECT gv.HOTEN
FROM GIAOVIEN gv join BOMON bm ON bm.MABM=gv.MABM join KHOA k ON k.MAKHOA=bm.MAKHOA
WHERE k.TENKHOA=N'Công nghệ thông tin'
and gv.MAGV not in (SELECT tg.MAGV FROM THAMGIADT tg)

--Q45 Tìm	những	giáo	viên	không	tham	gia	bất	kỳ đề tài	nào
SELECT gv.HOTEN
FROM GIAOVIEN gv
WHERE gv.MAGV not in (SELECT tg.MAGV FROM THAMGIADT tg)

--Q46 Cho	biết	giáo	viên	có	lương	lớn	hơn	lương	của	giáo	viên	“Nguyễn	Hoài	An”
SELECT gv.*
FROM GIAOVIEN gv
WHERE gv.LUONG>(SELECT gv2.LUONG FROM GIAOVIEN gv2 WHERE gv2.HOTEN=N'Nguyễn Hoài An')

--Q47 Tìm	những trưởng	bộ môn	tham	gia	tối	thiểu	1	đề tài
SELECT gv.*
FROM BOMON bm join GIAOVIEN gv ON bm.TRUONGBM=gv.MAGV
WHERE gv.MAGV in (SELECT tg.MAGV FROM THAMGIADT tg)

--Q48 Tìm	giáo	viên	trùng	tên	và	cùng	giới	tính	với	giáo	viên	khác	trong	cùng	bộ môn
SELECT gv.*
FROM GIAOVIEN gv
WHERE exists (SELECT * FROM GIAOVIEN gv2 WHERE gv2.HOTEN=gv.HOTEN and gv2.PHAI=gv.PHAI and gv2.MABM=gv.MABM and gv2.MAGV!=gv.MAGV)

--Q49 Tìm	những	giáo	viên	có	lương	lớn	hơn	lương	của	ít	nhất	một	giáo	viên	bộ môn	“Công	
--nghệ phần	mềm”
SELECT gv.*
FROM GIAOVIEN gv 
WHERE gv.LUONG>any(SELECT gv2.LUONG FROM GIAOVIEN gv2 join BOMON bm2 ON bm2.MABM=gv2.MABM WHERE bm2.TENBM=N'Công nghệ phần mềm')

--Q50 Tìm	những	giáo	viên	có	lương	lớn	hơn	lương	của	tất	cả giáo	viên	thuộc	bộ môn	“Hệ thống	thông	tin”
SELECT gv.*
FROM GIAOVIEN gv 
WHERE gv.LUONG>all(SELECT gv2.LUONG FROM GIAOVIEN gv2 join BOMON bm2 ON bm2.MABM=gv2.MABM WHERE bm2.TENBM=N'Hệ thống thông tin')

--Q51 Cho	biết	tên	khoa	có	đông	giáo	viên	nhất
SELECT k.TENKHOA
FROM GIAOVIEN gv join BOMON bm ON bm.MABM=gv.MABM join KHOA k ON k.MAKHOA=bm.MAKHOA
GROUP BY k.MAKHOA,k.TENKHOA
HAVING COUNT(gv.MAGV)>=all(SELECT COUNT(gv2.MAGV)
FROM GIAOVIEN gv2 join BOMON bm2 ON bm2.MABM=gv2.MABM join KHOA k2 ON k2.MAKHOA=bm2.MAKHOA GROUP BY k2.MAKHOA)

--Q52 Cho	biết	họ tên	giáo	viên	chủ nhiệm	nhiều	đề tài	nhất
SELECT gv.HOTEN
FROM GIAOVIEN gv join DETAI dt ON dt.GVCNDT=gv.MAGV
GROUP BY dt.GVCNDT,gv.HOTEN
HAVING COUNT(dt.MADT)>=all(SELECT COUNT(dt2.MADT) FROM DETAI dt2 GROUP BY dt2.GVCNDT)

--Q53 Cho	biết	mã	bộ môn	có	nhiều	giáo	viên	nhất
SELECT BM.MABM
FROM BOMON bm join GIAOVIEN gv ON gv.MABM=bm.MABM
GROUP BY bm.MABM
HAVING COUNT(gv.MAGV)>=all(SELECT COUNT(gv2.MAGV) FROM BOMON bm2 join GIAOVIEN gv2 ON gv2.MABM=bm2.MABM GROUP BY bm2.MABM)


--Q58 Cho	biết	tên	giáo	viên	nào	mà	tham	gia	đề tài đủ tất	cả các	chủ đề.
SELECT GV.HOTEN
FROM GIAOVIEN GV JOIN THAMGIADT TG ON GV.MAGV=TG.MAGV JOIN DETAI DT ON DT.MADT=TG.MADT
WHERE NOT EXISTS (SELECT * FROM CHUDE CD 
	WHERE NOT EXISTS (SELECT * FROM THAMGIADT TG2 JOIN DETAI DT2 ON DT2.MADT=TG2.MADT 
		WHERE DT2.MACD=CD.MACD AND DT2.MADT=DT.MADT))

--Q59 Cho	biết	tên	đề tài	nào	mà	được	tất	cả các	giáo	viên	của	bộ môn	HTTT	tham	gia.
SELECT DISTINCT DT.TENDT
FROM THAMGIADT TG JOIN DETAI DT ON DT.MADT=TG.MADT
WHERE NOT EXISTS (SELECT * FROM GIAOVIEN GV WHERE GV.MABM='HTTT' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2  WHERE TG2.MADT=TG.MADT AND TG2.MAGV=GV.MAGV))

--Q60 Cho	biết	tên	đề tài	có	tất	cả giảng	viên	bộ môn	“Hệ thống	thông	tin”	tham	gia
SELECT DISTINCT DT.TENDT
FROM THAMGIADT TG JOIN DETAI DT ON DT.MADT=TG.MADT
WHERE NOT EXISTS (SELECT * FROM GIAOVIEN GV JOIN BOMON BM ON BM.MABM=GV.MABM WHERE BM.TENBM=N'Hệ thống thông tin' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2  WHERE TG2.MADT=TG.MADT AND TG2.MAGV=GV.MAGV))

--Q61 Cho	biết	giáo	viên	nào	đã	tham	gia	tất	cả các	đề tài	có	mã	chủ đề là	QLGD.
SELECT GV.HOTEN
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV
WHERE NOT EXISTS (SELECT * FROM DETAI DT WHERE DT.MACD='QLGD' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MADT=DT.MADT AND TG2.MAGV=TG.MAGV))

--Q62 Cho	biết	tên	giáo	viên	nào	tham	gia	tất	cả các	đề tài	mà	giáo	viên	Trần	Trà	Hương	đã	
--tham	gia.
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV
WHERE GV.HOTEN!=N'Trần Trà Hương' AND 
	NOT EXISTS (SELECT * FROM DETAI DT JOIN THAMGIADT TG2 ON TG2.MADT=DT.MADT JOIN GIAOVIEN GV2 ON GV2.MAGV=TG2.MAGV 
		WHERE GV2.HOTEN=N'Trần Trà Hương' AND
			NOT EXISTS (SELECT * FROM THAMGIADT TG3 WHERE TG3.MADT=DT.MADT AND TG3.MAGV=TG.MAGV))

--Q63 Cho	biết	tên	đề tài	nào	mà	được	tất	cả các	giáo	viên	của	bộ môn	Hóa	Hữu	Cơ	tham	gia.	
SELECT DISTINCT DT.TENDT
FROM THAMGIADT TG JOIN DETAI DT ON DT.MADT=TG.MADT JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV
WHERE GV.MABM='HHC' AND NOT EXISTS (SELECT * FROM GIAOVIEN GV2 WHERE GV2.MABM='HHC' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2  WHERE TG2.MADT=TG.MADT AND TG2.MAGV=GV2.MAGV))

--Q64 Cho	biết	tên	giáo	viên	nào	mà	tham	gia	tất	cả các	công	việc	của	đề tài	006.
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV 
WHERE NOT EXISTS (SELECT * FROM CONGVIEC CV WHERE CV.MADT='006' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MAGV=TG.MAGV AND TG2.MADT=CV.MADT AND TG2.STT=CV.SOTT))

--Q65 Cho	biết	giáo	viên	nào	đã	tham	gia	tất	cả các	đề tài	của	chủ đề Ứng	dụng	công	nghệ.
SELECT GV.HOTEN
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV
WHERE NOT EXISTS (SELECT * FROM DETAI DT JOIN CHUDE CD ON DT.MACD=CD.MACD WHERE CD.TENCD=N'Ứng dụng công nghệ' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MADT=DT.MADT AND TG2.MAGV=TG.MAGV))

--Q66 Cho	biết	tên	giáo	viên	nào	đã	tham	gia	tất	cả các	đề tài	của	do	Trần	Trà	Hương	làm	chủ
--nhiệm
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV
WHERE NOT EXISTS (SELECT * FROM DETAI DT JOIN GIAOVIEN GV2 ON GV2.MAGV=DT.GVCNDT WHERE GV2.HOTEN=N'Trần Trà Hương' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MADT=DT.MADT AND TG2.MAGV=TG.MAGV))

--Q67 Cho	biết	tên	đề tài	nào	mà	được	tất	cả các	giáo	viên	của	khoa	CNTT	tham	gia.
SELECT DT.TENDT
FROM THAMGIADT TG JOIN DETAI DT ON DT.MADT=TG.MADT
WHERE NOT EXISTS (SELECT * FROM GIAOVIEN GV JOIN BOMON BM ON GV.MABM=BM.MABM WHERE BM.MAKHOA='CNTT' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MADT=TG.MADT AND TG2.MAGV=GV.MAGV))

--Q68 Cho	biết	tên	giáo	viên	nào	mà	tham	gia	tất	cả các	công	việc	của	đề tài	Nghiên	cứu	tế
--bào	gốc.
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV 
WHERE NOT EXISTS (SELECT * FROM CONGVIEC CV JOIN DETAI DT ON CV.MADT=DT.MADT WHERE DT.TENDT=N'Nghiên cứu tế bào gốc' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MAGV=TG.MAGV AND TG2.MADT=CV.MADT AND TG2.STT=CV.SOTT))

--Q69 Tìm	tên	các	giáo	viên	được	phân	công	làm	tất	cả các	đề tài	có	kinh	phí	trên	100	triệu?
SELECT DISTINCT GV.HOTEN
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV
WHERE NOT EXISTS (SELECT * FROM DETAI DT WHERE DT.KINHPHI>100 AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MADT=DT.MADT AND TG2.MAGV=TG.MAGV))

--Q70 Cho	biết	tên	đề tài	nào	mà	được	tất	cả các	giáo	viên	của	khoa	Sinh	Học	tham	gia.
SELECT DISTINCT DT.TENDT
FROM THAMGIADT TG JOIN DETAI DT ON TG.MADT=DT.MADT
WHERE NOT EXISTS (SELECT * FROM GIAOVIEN GV JOIN BOMON BM ON BM.MABM=GV.MABM JOIN KHOA K ON K.MAKHOA=BM.MAKHOA
	WHERE K.TENKHOA=N'Sinh học' AND NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MAGV=GV.MAGV AND TG2.MADT=TG.MADT))

--Q71 Cho	biết	mã	số,	họ tên,	ngày	sinh	của	giáo	viên	tham	gia	tất	cả các	công	việc	của	đề tài	
--“Ứng	dụng	hóa	học	xanh”.
SELECT DISTINCT GV.MAGV,GV.HOTEN,GV.NGSINH
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV JOIN DETAI DT2 ON DT2.MADT=TG.MADT
WHERE DT2.TENDT=N'Ứng dụng hóa học xanh' AND NOT EXISTS (SELECT * FROM CONGVIEC CV JOIN DETAI DT ON CV.MADT=DT.MADT WHERE DT.TENDT=N'Ứng dụng hóa học xanh' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MAGV=TG.MAGV AND TG2.MADT=CV.MADT AND TG2.STT=CV.SOTT))

--Q72 Cho	biết	mã	số,	họ tên,	tên	bộ môn	và	tên	người	quản	lý	chuyên	môn	của	giáo	viên	
--tham	gia	tất	cả các	đề tài	thuộc	chủ đề “Nghiên	cứu	phát	triển”.
SELECT GV.MAGV,GV.HOTEN, BM.TENBM, GV2.HOTEN
FROM THAMGIADT TG JOIN GIAOVIEN GV ON GV.MAGV=TG.MAGV JOIN BOMON BM ON BM.MABM=GV.MABM JOIN GIAOVIEN GV2 ON GV2.MAGV=GV.GVQLCM
WHERE NOT EXISTS (SELECT * FROM DETAI DT JOIN CHUDE CD ON DT.MACD=CD.MACD WHERE CD.TENCD=N'Nghiên cứu phát triển' AND
	NOT EXISTS (SELECT * FROM THAMGIADT TG2 WHERE TG2.MADT=DT.MADT AND TG2.MAGV=TG.MAGV))