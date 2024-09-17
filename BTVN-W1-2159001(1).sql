--1. Nhận vào hai số a, b và trả về tổng a, b.
IF OBJECT_ID('Tongab') is not null 
	drop proc Tongab 
	go
CREATE proc Tongab @a int, @b int
AS
DECLARE @tong int
SET @tong = @a+@b
PRINT @tong 
GO
EXEC Tongab 4,5 


CREATE proc sumab @a int, @b int, @sum int output
AS 
SET @sum = @a + @b
GO
DECLARE @sum int
exec sumab 3,4,@sum output
print @sum


--2. Nhận vào hai số a, b và trả về hiệu a, b.
create proc Hieuab @a int, @b int
as
declare @hieu int
set @hieu = @a - @b
print @hieu
go
exec Hieuab 9,5


if object_id ('Hieuab') is not null
drop proc Hieuab
go
create proc Hieuab @a int, @b int, @hieu int output
as
set @hieu=@a-@b
go 
declare @hieu int
exec Hieuab 10,4, @hieu output
print @hieu

--3. Nhận vào hai số a, b và trả về tích a, b.
create proc Tichab @a int, @b int
as 
declare @tich int
set @tich=@a*@b
print @tich
go 
exec Tichab 2,4


if object_id ('Tichab') is not null
drop proc Tichab
go
create proc Tichab @a int, @b int, @tich int out
as
set @tich=@a*@b
go
declare @tich int
exec Tichab 20,2, @tich output
print @tich

--4. Nhận vào hai số a, b và trả về thương a, b.
create proc Thuongab @a int, @b int
as 
declare @thuong float
set @thuong=@a*1.0/@b*1.0
print @thuong
go 
exec Thuongab 10,3
--------------
if object_id ('Thuongab') is not null
drop proc Thuongab
go
create proc Thuongab @a int, @b int, @thuong float out
as 
set @thuong = @a*1.0/@b*1.0
go
declare @thuong float
exec Thuongab 8,3,@thuong output
print @thuong

--5. Nhận vào hai số a, b và trả về số dư của phép chia a cho b.
create proc Soduab @a int, @b int
as 
declare @sodu int
set @sodu=@a%@b
print @sodu
go
exec Soduab 3,5
-----------------
if object_id('Soduab') is not null
drop proc Soduab
go
create proc Soduab @a int, @b int, @sodu int out
as 
set @sodu=@a%@b
go
declare @sodu int
exec Soduab 2,6,@sodu output
print @sodu

--6. Nhận vào hai số a, b và i.
-- Nếu i là 1 trả về tổng a, b
--Nếu i là 2 trả về hiệu a, b
-- Nếu i là 3 trả về tích a, b
--Nếu i là 4 trả về thương a, b
-- Nếu i là 5 trả về số dư phép chia a cho b
create proc Nhapi @i int, @a int, @b int
as
begin 
	if @i < 1 or @i > 5 
		begin
			print 'loi input'
			return
		end
	if @i=1	
		exec Tongab @a, @b
	else if @i=2
		exec Hieuab @a,@b
	else if @i=3
		exec Tichab @a,@b
	else if @i=4
		exec Thuongab @a,@b
	else
		exec Soduab @a, @b
end
go
exec Nhapi 5,3,4
drop proc Nhapi

--7. Nhận vào n, m và trả về tổng các giá trị nằm trong đoạn n, m (dùng tham số output).
--create proc nhapmn @n int, @m int, @ketqua int output
as
begin
if @n>@m
		begin
			print 'loi input'
			return
		end
set @ketqua=0
while(@n<=@m)
	begin
		set @ketqua=@ketqua+@n
		set @n=@n+1
	end
end
go
declare @k int 
exec nhapmn 7,5,@k output
print @k

drop proc nhapmn

--8. Nhận vào năm n, kiểm tra xem n có phải năm nhuận không. Nếu n là năm nhuận trả về 1 còn
--không phải trả về 0 (dùng tham số output).
create proc namnhuan @n int, @kq int output
as
begin
if @n<1900
begin
print 'loi input'
return
end
if(@n%400=0) or (@n%100!=0 and @n%4=0)
	set @kq= 1
else 
	set @kq= 0
end
go
declare @k int 
exec namnhuan 1899, @k output
print @k

drop proc namnhuan

--9. Nhận vào năm n, m, đếm xem có bao nhiêu năm nhuận trong đoạn n đến m (dùng tham số
--output).
create proc demnamnhuan @n int, @m int, @kq int output
as
if (@n<1900) or (@m<1900) or (@n>@m)
begin
	print 'loi input'
	return
end
set @kq=0
declare @temp int =0
while (@n<=@m)
begin
	exec namnhuan @n,@temp output 
	if @temp=1
		set @kq = @kq +1
	set @n=@n+1
end
go
declare @k int
exec demnamnhuan 2000,2010, @k output
print @k

drop proc demnamnhuan

--10. Nhận vào n và trả ra giá trị n!, biết rằng n! = 1*2*3*...*n
create proc Nhapn @n int
as
if @n<0
	begin
		print 'loi input'
		return
	end
declare @m int = 1 
declare	@kq int = 1
while (@m<=@n)
begin
	set @kq=@kq*@m
	set @m=@m+1
end
print @kq
go
exec Nhapn 5

drop proc Nhapn

--11. Nhận vào ngày a (kiểu date hoặc datetime) cho biết tháng của ngày a có bao nhiêu ngày. Ví dụ:
--nếu ngày a là ngày 15/02/2000 thì trả về 28 là số ngày của tháng 2 trong năm 2000.


--12. Nhận vào n, kiểm tra xem n có phải số nguyên tố không. Nếu là số nguyên tố trả về 1 còn
--không trả về 0.
create proc NguyenTo @N int, @kq int output
as
begin
	if @n<2
	begin
		print 'loi input'
		return
	end
declare @m int
declare @count int = 0
declare @temp int = 1
while (@temp<=@N)
	begin
		if @N%@temp=0
		  set @count=@count+1
		set @temp = @temp+1
	end
end
if @count = 2
	set @kq= 1
else 
	set @kq= 0
go 
declare @k int
exec NguyenTo 4, @k output
print @k

drop proc NguyenTo

--13. Nhận vào n, m và trả về tích các số nguyên tố nằm trong đoạn n, m (dùng tham số output). Lưu
--ý: số nguyên tố là số có hai ước chung là 1 và chính nó, ví dụ: 13, 17, ...
create proc tichnt @n int, @m int, @kq int output
as
if (@n<2) or (@m<2)
	begin
		print 'loi input'
		return
	end
declare @k int 
set @kq =1
while (@n<=@m)
begin
	exec NguyenTo @n, @k output
	if (@k=1)
		set @kq=@kq*@n
	set @n=@n+1
end
go
declare @k int 
exec tichnt 2, 5, @k output
print @k

drop proc tichnt

--14. Nhận vào n, kiểm tra xem n có phải số chính phương không. Nếu là số chính phương trả về 1
--còn không trả về 0. Lưu ý: số chính phương là bình phương của một số khác, ví dụ: 4, 9, ...
create proc SoChinhPhuong @n int,@kq int output
as
if (@n<0)
	begin
		print 'loi input'
		return
	end
declare @temp int = 1
declare @max int
set @max = @n/2
set @kq = 0
while(@temp<@max)
	begin 
		if(@temp*@temp=@n)
			set @kq=1
			set @temp=@temp+1
	end
go
declare @k int
exec SoChinhPhuong 100,@k output
print @k


drop proc SoChinhPhuong
--15. Nhận vào n, m và trả về tổng các số chính phương nằm trong đoạn n, m (dùng tham số output).