USE [QLBanHang]
GO
INSERT [dbo].[KHACH_HANG] ([makh], [hoten], [gioitinh], [dthoai], [diachi]) VALUES (1, N'Vo Quang Dung       ', N'nam       ', 94122288, N'371 te thien dai thanh                            ')
INSERT [dbo].[KHACH_HANG] ([makh], [hoten], [gioitinh], [dthoai], [diachi]) VALUES (2, N'Nguyen Huy Hoang    ', N'be de     ', 128884123, N'so 69 duong csgo                                  ')
INSERT [dbo].[KHACH_HANG] ([makh], [hoten], [gioitinh], [dthoai], [diachi]) VALUES (3, N'Chau Gia Bao        ', N'nam       ', 223454812, N'882 ly thai to                                    ')
INSERT [dbo].[KHACH_HANG] ([makh], [hoten], [gioitinh], [dthoai], [diachi]) VALUES (4, N'Phu Sieu kho        ', N'nam       ', 111111111, N'ko nha                                            ')
INSERT [dbo].[KHACH_HANG] ([makh], [hoten], [gioitinh], [dthoai], [diachi]) VALUES (5, N'Chau Gia Tien       ', N'nam       ', 222222222, N'khong ro                                          ')
GO
INSERT [dbo].[HOA_DON] ([mahd], [ngaylap], [makh]) VALUES (201, CAST(N'2022-09-27' AS Date), 2)
INSERT [dbo].[HOA_DON] ([mahd], [ngaylap], [makh]) VALUES (202, CAST(N'2022-09-27' AS Date), 4)
INSERT [dbo].[HOA_DON] ([mahd], [ngaylap], [makh]) VALUES (203, CAST(N'2022-09-27' AS Date), 1)
INSERT [dbo].[HOA_DON] ([mahd], [ngaylap], [makh]) VALUES (204, CAST(N'2022-09-27' AS Date), 3)
INSERT [dbo].[HOA_DON] ([mahd], [ngaylap], [makh]) VALUES (205, CAST(N'2022-09-27' AS Date), 5)
GO
INSERT [dbo].[SAN_PHAM] ([masp], [tensp], [ngaysx], [dongia]) VALUES (101, N'chuot Logitech                ', CAST(N'2019-05-15' AS Date), 100000.0000)
INSERT [dbo].[SAN_PHAM] ([masp], [tensp], [ngaysx], [dongia]) VALUES (102, N'ban phim co                   ', CAST(N'2022-01-29' AS Date), 4000000.0000)
INSERT [dbo].[SAN_PHAM] ([masp], [tensp], [ngaysx], [dongia]) VALUES (103, N'man hinh                      ', CAST(N'2021-11-27' AS Date), 10000000.0000)
INSERT [dbo].[SAN_PHAM] ([masp], [tensp], [ngaysx], [dongia]) VALUES (104, N'pab chuot navi                ', CAST(N'2022-01-09' AS Date), 200000.0000)
INSERT [dbo].[SAN_PHAM] ([masp], [tensp], [ngaysx], [dongia]) VALUES (105, N'Tay cam                       ', CAST(N'2017-12-25' AS Date), 1200000.0000)
GO
INSERT [dbo].[CT_HOA_DON] ([mahd], [masp], [soluong], [dongia]) VALUES (201, 102, 1, 4000000.0000)
INSERT [dbo].[CT_HOA_DON] ([mahd], [masp], [soluong], [dongia]) VALUES (202, 104, 1, 200000.0000)
INSERT [dbo].[CT_HOA_DON] ([mahd], [masp], [soluong], [dongia]) VALUES (203, 101, 1, 100000.0000)
INSERT [dbo].[CT_HOA_DON] ([mahd], [masp], [soluong], [dongia]) VALUES (204, 105, 1, 1200000.0000)
INSERT [dbo].[CT_HOA_DON] ([mahd], [masp], [soluong], [dongia]) VALUES (205, 103, 1, 10000000.0000)
GO
