--2159001
--1. Nhận vào mã phiếu mượn, trả ra số cmnd, họ tên, địa chỉ, ngày sinh của độc giả mượn phiếu đó
create proc sp_thongTinDocGiaMuon 
	@mapm char(10)
as
begin
	if not exists (select mapm from PhieuMuon where mapm=@mapm)
	begin 
		raiserror ('Khong ton tai ma phieu muon da chon',15,1)
		return
	end 
	else
	begin
		select distinct dg.socmnd, dg.hoten,dg.diachi,dg.ngsinh
		from DocGia dg join PhieuMuon pm on dg.madg=pm.madg
		where pm.mapm=@mapm
	end
end
go
exec sp_thongTinDocGiaMuon 'PM004     '
select * from PhieuMuon


--2. Nhận vào một năm, xuất ra thông tin các độc giả sinh năm đó.
create proc sp_thongTinDocGiaNam
	@namsinh char(4)
as
begin
	if @namsinh is NULL or @namsinh ='' 
	begin 
		raiserror ('Nam sinh khong duoc phep rong',15,1)
		return
	end 
	else
	begin
		if not exists (select ngsinh
						from DocGia
						where year(ngsinh) = @namsinh)
			begin
				raiserror('Khong co doc gia sinh trong nam nay',15,1)
				return
			end
		else
		begin
			select distinct dg.socmnd,dg.hoten,dg.ngsinh,dg.diachi
			from  DocGia dg 
			where year(ngsinh)=@namsinh
		end
	end
end
go
exec sp_thongTinDocGia 'PM004     '
select * from PhieuMuon
--3/ Xuất ra thông tin độc giả trẻ tuổi nhất.
select *
from DocGia dg
where year(dg.ngsinh)>=all(select year(ngsinh)
                           from DocGia)

--4/ Nhận vào một mã phiếu mượn, trả ra số cmnd, họ tên độc giả mượn và tổng số cuốn sách được mượn trong lần đó.
create proc sp_CheckMuonSach
		@mapm char(10)
as
begin 
	if not exists (select mapm
					from PhieuMuon
					where mapm=@mapm)
		begin
			raiserror('Khong ton tai ma phieu muon da chon',15,1)
			return
		end
	else
		begin
			select dg.socmnd,dg.hoten,count(ctpm.mapm) as SoSachDuocMuon
            from  DocGia dg join PhieuMuon pm on dg.madg=pm.madg
                            join CT_PhieuMuon ctpm on ctpm.mapm=pm.mapm
			where pm.mapm=@mapm
			group by dg.socmnd, dg.hoten
		end
end
go 
exec sp_CheckMuonSach 'PM004     '


--9/ Nhận vào mã phiếu trả, cập nhật ngày trả theo các bước sau:
-- Kiểm tra mã phiếu trả có tồn tại không  nếu không trả về mã lỗi là 1
-- Cập nhật ngày trả của phiếu trả
-- Cập nhật tiền phạt của các chi tiết phiếu trả tương ứng theo công thức:
--tiền phạt = mucgiaphat * (ngày trả mới – ngày mượn – số ngày quy định)
create proc sp_Cau9 
		@mapt char(10)
as
begin
if not exists(select @mapt
			  from PhieuTra
			  where mapt=@mapt )
			  return 1
	update PhieuTra
	set ngaytra=getdate()
	where mapt=@mapt

	update CT_PhieuTra
	set tienphat = mucgiaphat*(select distinct datediff(day,pm.ngaymuon,pt.ngaytra)-ctpm.songayquydinh
							   from PhieuTra pt join PhieuMuon pm on pt.mapm=pm.mapm 
							                    join CT_PhieuMuon ctpm on pm.mapm=ctpm.mapm)
	where mapt=@mapt
end
go
exec sp_Cau9 'PT001     '
exec sp_Cau9 'PT011     '
select * from PhieuTra

--10. Nhận vào thông tin một phiếu mượn (mã phiếu mượn, mã độc giả), thêm phiếu mượn vào
--CSDL theo các bước sau:
-- Kiểm tra mã phiếu mượn đã tồn tại chưa  nếu đã tồn tại trả về mã lỗi là 1
-- Kiểm tra mã độc giả phải khác null và phải tồn tại trong bảng độc giả  nếu không trả
--về mã lỗi 2
-- Thêm phiếu mượn vào CSDL, biết rằng ngày mượn luôn là ngày hiện tại của hệ thống.
--Trả về 0 báo hiệu thêm thành công.
create proc sp_Cau10
		@mapm char(10), @madg char(10)
as
begin
	if exists(select @mapm
			  from PhieuMuon 
			  where mapm=@mapm )
			  return 1			  
	if (@madg is null) or not exists (select @madg
				     from DocGia
				     where madg=@madg)
				     return 2
	insert into PhieuMuon(mapm, madg, ngaymuon, SoLanTra)
	values (@mapm,@madg,getdate(), null)
	return 0
end
go
declare @tt int
exec @tt = sp_Cau10 'PM004     ','DG05      '
exec @tt = sp_Cau10 'PM011     ','DG05      '
exec @tt = sp_Cau10 'PM004     ','DG19      '
select * from PhieuMuon
