--5. Nhận vào số isbn một đầu sách, xuất ra danh sách độc giả (số cmnd, họ tên, ngsinh, địa chỉ) của
--các độc giả từng mượn đầu sách đó.
create proc sp_tungMuonSach
		@isbn nchar(12)
as
begin
	if not exists (select isbn from CuonSach where isbn=@isbn)
	begin
		raiserror ('Khong Ton Tai Ma Sach Da Chon',15,1)
		return
	end
	else
	begin
		select distinct dg.socmnd,dg.hoten,dg.ngsinh,dg.diachi
		from DocGia dg join PhieuMuon pm on dg.madg=pm.madg
				join CT_PhieuMuon ctpm on ctpm.mapm=pm.mapm
				join CuonSach cs on cs.isbn=ctpm.isbn
		where cs.isbn=@isbn
	end
end
go
exec sp_tungMuonSach '116525441' 


--6. Nhận vào số cmnd một độc giả, xuất ra thông tin các cuốn sách (mã isbn, mã sách) mà độc giả
--đã từng mượn.
create proc sp_CuonSachDaMuon
			@socmnd varchar(10)
as
begin
	if not exists (select socmnd from DocGia where socmnd=@socmnd)
	begin
		raiserror ('Khong Ton Tai so cmnd',15,1)
		return
	end 
	else
	begin
		select distinct cs.isbn, cs.masach
		from DocGia dg join PhieuMuon pm on dg.madg=pm.madg
						join CT_PhieuMuon ctpm on ctpm.mapm=pm.mapm
						join CuonSach cs on cs.isbn=ctpm.isbn
		where dg.socmnd=@socmnd
	end
end
go
exec sp_CuonSachDaMuon '2157836254'
select * from DocGia
drop proc sp_CuonSachDaMuon
--7. Nhận vào một mã phiếu mượn trả ra số lượng phiếu trả cho phiếu mượn đó.
create proc sp_DemPhieuTra
			@mapm char(10)
as
begin
	if not exists (select mapm from PhieuMuon where mapm=@mapm)
	begin
		raiserror ('Khong Ton Tai Ma Phieu Muon',15,1)
		return
	end 
	else
	begin
		select count(ctpt.mapt) as So_Luong_Phieu_Tra 
		from PhieuMuon pm join PhieuTra pt on pm.mapm=pt.mapm
			join CT_PhieuTra ctpt on ctpt.mapt=pt.mapt
		where pm.mapm=@mapm
	end
end
go
exec sp_DemPhieuTra 'PM001     '
select * from PhieuTra
--8
create proc sp_XoaDauSach
	@isbn nchar(12)
as
begin
	if not exists (select isbn from DauSach where isbn=@isbn)
	begin
		return 1
	end 
	else
	begin
		if (select soluong from DauSach where isbn=@isbn)=0
			begin
				delete from DauSach where isbn=@isbn
				return 0
			end
		else
			begin
				if not exists (select * from CT_PhieuMuon ctpm join DauSach ds on ctpm.isbn=ds.isbn 						
								where ds.isbn=@isbn)
					begin
						delete from DauSach where isbn=@isbn
						return 0
					end
				else
					begin
						return 2
					end

			end

	end
end
go
exec sp_XoaDauSach '369874112   '
select * from DauSach
