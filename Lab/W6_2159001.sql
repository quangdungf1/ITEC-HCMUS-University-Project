--Q27. Cho	biết	số lượng	giáo	viên	viên	và	tổng	lương	của	họ.
SELECT COUNT(GV.MAGV) AS SLGV, SUM(GV.LUONG) AS TONGL
FROM GIAOVIEN GV

--Q28. Cho	biết	số lượng	giáo	viên	và	lương	trung	bình	của	từng	bộ môn.
SELECT GV.MABM, count(gv.MAGV),AVG(gv.LUONG)
FROM GIAOVIEN GV
GROUP BY GV.MABM

--Q29. Cho	biết	tên	chủ đề và	số lượng	đề tài	thuộc	về chủ đề đó.
SELECT cd.TENCD, count(dt.MADT)
FROM DETAI dt join CHUDE cd on dt.MACD=cd.MACD
GROUP BY dt.MACD, cd.TENCD

--Q30. Cho	biết	tên	giáo	viên	và	số lượng	đề tài	mà	giáo	viên	đó	tham	gia
SELECT gv.HOTEN,count(distinct tg.MADT)
FROM THAMGIADT tg join GIAOVIEN gv on tg.MAGV=gv.MAGV
GROUP BY tg.MAGV, gv.HOTEN

--Q31. Cho	biết tên	giáo	viên	và	số lượng	đề tài	mà	giáo	viên	đó	làm	chủ nhiệm
SELECT GV.HOTEN,COUNT(DT.MADT)
FROM DETAI dt join GIAOVIEN gv on dt.GVCNDT=GV.MAGV
GROUP BY dt.GVCNDT,gv.HOTEN

--Q32. Với	mỗi	giáo	viên	cho	tên	giáo	viên	và	số người	thân	của	giáo	viên	đó.thân	của	giáo	viên	đó.
SELECT gv.HOTEN,COUNT(distinct NT.TEN)
FROM NGUOITHAN nt join GIAOVIEN gv on nt.MAGV=gv.MAGV
GROUP BY nt.MAGV,gv.HOTEN

--Q33. Cho	biết	tên	những	giáo	viên	đã	tham	gia	từ 3	đề tài	trở lên
SELECT gv.HOTEN
FROM GIAOVIEN gv join THAMGIADT tg on gv.MAGV=tg.MAGV
GROUP BY gv.MAGV,gv.HOTEN
HAVING count(distinct tg.MADT)>=3

--Q34. Cho	biết	số lượng	giáo	viên	đã	tham	gia	vào	đề tài	Ứng	dụng	hóa	học	xanh
SELECT count(distinct tg.MAGV)
FROM THAMGIADT tg join DETAI dt on tg.MADT=dt.MADT
WHERE dt.TENDT=N'Ứng dụng hóa học xanh'
GROUP BY tg.MADT