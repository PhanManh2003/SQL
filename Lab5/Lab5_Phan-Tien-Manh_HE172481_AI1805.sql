create database Lab5
use Lab5 
go

create table NhanVien(
	HoNV Nvarchar(10),
	TenLOT Nvarchar(10),
	Ten Nvarchar(10),
	MaNV varchar(10),
	NgSinh date,
	Dchi Nvarchar(30),
	Phai varchar(3) check (Phai='Nam' or Phai='Nu'),
	Luong int,
	Ma_NQL varchar(10),
	MaPHG varchar(1),
	PRIMARY KEY (MaNV),
	foreign key(MaPHG) references PhongBan(MaPHG),
	);

create table PhongBan(
	TenPHG varchar(30),
	MaPHG varchar(1),
	TrPHG varchar(10),
	Ng_nhamchuc date,
	PRIMARY KEY(MaPHG),

	);

create table Diadiem_PHG(
	MaPHG varchar(1),
	Diadiem Nvarchar(30),
	PRIMARY KEY(Diadiem, MaPHG),
	foreign key(MaPHG) references PhongBan(MaPHG),
	);

create table ThanNhan(
	MaNV varchar(10),
	TenTN Nvarchar(10),
	Phai varchar(3) check (Phai='Nam' or Phai='Nu'),
	NgSinh date,
	Quanhe varchar(30),
	PRIMARY KEY(MaNV, TenTN),
	foreign key(MaNV) references NhanVien(MaNV),
	);

create table DeAn(
	TenDA varchar(30),
	MaDA varchar(10),
	DDiem_DA varchar(30),
	MaPHG varchar(1),
	PRIMARY KEY(MaDA),
	foreign key(MaPHG) references PhongBan(MaPHG),
	);

create table PhanCong(
	MaNV varchar(10),
	MaDA varchar(10),
	Thoigian float,
	PRIMARY KEY (MaNV, MaDA),
	foreign key(MaDA) references DeAn(MaDA),
	);
go

insert into NhanVien
values ('Dinh', 'Ba', 'Tien', '123456789', '1955-01-09', '731 Tran Hung Dao, Q1, TPHCM', 'Nam', 30000, '333445555', '5'),
('Nguyen', 'Thanh', 'Tung', '333445555', '1945-12-08', '638 Nguyen Van Cu, Q5, TPHCM', 'Nam', 40000, '888665555', '5'),
('Bui', 'Thuy', 'Vu', '999887777', '1958-07-19', '332 Nguyen Thai Hoc, Q1, TPHCM', 'Nam', 25000, '987654321', '4'),
('Le', 'Thi', 'Nhan', '987654321', '1931-06-20', '291 Ho Van Hue, QPN, TPHCM', 'Nu', 43000, '888665555', '4'),
('Nguyen', 'Manh', 'Hung', '666884444', '1952-09-15', '975 Ba Ria, Vung Tau', 'Nam', 38000, '333445555', '5'),
('Tran', 'Thanh', 'Tam', '453453453', '1962-07-31', '543 Mai Thi Luu, Q1, TPHCM', 'Nam', 25000, '333445555', '5'),
('Tran', 'Hong', 'Quan', '987987987', '1959-03-29', '980 Le Hong Phong, Q10, TPHCM', 'Nam', 25000, '987654321', '4'),
('Vuong', 'Ngoc', 'Quyen', '888665555', '1927-10-10', '450 Trung Vuong, HaNoi', 'Nu', 55000, NULL, '1');


insert into PhongBan
values ('Nghien cuu', '5', '333445555', '1978-05-22'),
('Dieu hanh', '4', '987654321', '1985-01-01'),
('Quan ly', '1', '888665555', '1971-06-19');

insert into Diadiem_PHG
values ('1', 'TP HCM'),
('4', 'Ha Noi'),
('5', 'Vung Tau'),
('5', 'Nha Trang'),
('5', 'TP HCM');

insert into ThanNhan
values ('333445555', 'Quang', 'Nu', '1976-04-05', 'Con gai'),
('333445555', 'Khang', 'Nam', '1973-10-25', 'Con trai'),
('333445555', 'Duong', 'Nu', '1948-05-03', 'Vo chong'),
('987654321', 'Dang', 'Nam', '1932-02-29', 'Vo chong'),
('123456789', 'Duy', 'Nam', '1978-01-01', 'Con trai'),
('123456789', 'Chau', 'Nu', '1978-12-31', 'Con gai');

insert into DeAn
values ('San pham X', '1', 'Vung Tau', '5'),
('San pham Y', '2', 'Nha Trang', '5'),
('San pham Z', '3', 'TP HCM', '5'),
('Tin hoc hoa', '10', 'Ha Noi', '4'),
('Cap quang', '20', 'TP HCM', '1'),
('Dao tao', '30', 'Ha Noi', '4');

insert into PhanCong
values ('123456789', '1', 32.5),
('123456789', '2', 7.5),
('666884444', '3', 40.0),
('45345345', '1', 20.0),
('45345345', '2', 20.0),
('333445555', '3', 10.0),
('333445555', '10', 10.0),
('333445555', '20', 10.0),
('999887777', '30', 30.0),
('999887777', '10', 10.0),
('987987987', '10', 35.0),
('987987987', '30', 5.0),
('987654321', '30', 20.0),
('987654321', '20', 15.0),
('888665555', '20', NULL);
go


--I.1
create procedure I1 @s date, @f date
as
select nv.MaNV, (HoNV + '' + TenLOT + '' + Ten) as 'Ho va ten', nv.Ma_NQL,
	(select (HoNV + TenLOT + Ten) 
	from NhanVien nv2
	where nv2.MaNV = nv.Ma_NQL) as Ten_NQL
from NhanVien nv
where NgSinh between @s and @f
go
 
--I.2
create procedure I2 
as
select nv.MaNV, (nv.HoNV + ' ' + nv.TenLOT + ' ' + nv.Ten) as 'Ho va ten', nv.Luong
from NhanVien nv
where nv.MaPHG in (select maPHG from 
							(select maPHG, AVG(Luong) as TB_luong
							from Nhanvien
							group by MaPHG) as avg_luong
					where Luong > TB_Luong)
go

--I.3.
create procedure I3 @N int
as
select top (@N) *
from NhanVien nv
order by nv.Luong desc
go

--I.4
create procedure I4 @A varchar(30)
as
update NhanVien 
set Luong = Luong*1.1
where DChi LIKE '%'+@A+'%'
go


--I.5
create procedure I5
as
delete from PhongBan
where MaPHG in	(select pb.MaPHG from PhongBan pb
				left join Nhanvien nv on nv.MaPHG = pb.MaPHG
				where nv.maNV is NULL)
go

--II.1
CREATE TRIGGER II1
ON NhanVien
AFTER INSERT, UPDATE, DELETE
AS
IF exists (
        select pb.MaPHG, AVG(nv.Luong) AS AVG_LUONG
        FROM NhanVien nv 
		join PhongBan pb ON nv.MaPHG = pb.MaPHG
        group by pb.MaPHG
        having AVG(nv.Luong) > 50000
    )
    begin
        RAISERROR ('Muc luong trung binh cua phong ban vuot qua 50000', 16, 1)
        ROLLBACK TRANSACTION;
	end;
go

--II.2.
CREATE TRIGGER II2
ON NhanVien
AFTER UPDATE
AS
IF EXISTS (
        SELECT * FROM Nhanvien nv 
		JOIN PhongBan pb ON nv.MaPHG = pb.MaPHG
        WHERE maNV = pb.TrPHG AND nv.Luong < ALL (
            SELECT Luong FROM NhanVien nv
			WHERE nv.MaPHG = pb.MaPHG AND MaNV <> pb.TrPHG
        )
    )
    BEGIN
        RAISERROR ('Muc luong cua truong phong nho hon muc luong cua tat ca nhan vien trong phong ban', 16, 1)
        ROLLBACK TRANSACTION;
    END;
go

--II.3.
CREATE TRIGGER II3
ON NhanVien
AFTER INSERT
AS
BEGIN
    DECLARE @HCM FLOAT;
    DECLARE @HN FLOAT;
    DECLARE @Diff FLOAT;

    SELECT @HCM = AVG(Luong)
    FROM NhanVien nv
	JOIN PhongBan pb ON nv.MaPHG = pb.MaPHG
    WHERE nv.Dchi LIKE '%TPHCM%';

    SELECT @HN = AVG(LUONG)
    FROM NhanVien nv 
	JOIN PhongBan pb ON nv.MaPHG = pb.MaPHG
    WHERE nv.Dchi LIKE '%HaNoi%';

    SET @Diff = ABS(@HCM - @HN);

    IF (@Diff > 10000)
    BEGIN
        RAISERROR ('Su khac biet giua muc luong trung binh cua nhan vien o HCM va HN lon hon 10000', 16, 1)
        ROLLBACK TRANSACTION;
    END;
END;
go

--II.5.
CREATE TRIGGER II5
ON NhanVien 
AFTER INSERT
AS
BEGIN
    DECLARE @MaleCount INT;
    DECLARE @FemaleCount INT;
    DECLARE @Diff FLOAT;

    SELECT @MaleCount = COUNT(*)
    FROM NhanVien
    WHERE Phai = 'Nam';

    SELECT @FemaleCount = COUNT(*)
    FROM NhanVien
    WHERE Phai = 'Nu';

    SET @Diff = ABS(@MaleCount - @FemaleCount) * 1.0 / NULLIF(@MaleCount + @FemaleCount, 0);

    IF (@Diff > 0.1)
    BEGIN
        RAISERROR ('Su khac biet giua so luong nhan vien nam va nu lon hon 10%%', 16, 1)
        ROLLBACK TRANSACTION;
    END;
END;
go



