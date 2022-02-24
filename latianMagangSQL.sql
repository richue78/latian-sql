/*
CREATE DATABASE Musica
go
USE Musica

/*DROP DATABASE Musica*/

/*
DROP TABLE DetailTransaction
DROP TABLE HeaderTransaction
DROP TABLE MsMusicIns
DROP TABLE MsMusicInsType
DROP TABLE MsEmployee
DROP TABLE MsBranch
*/

CREATE TABLE MsBranch
(
	BranchID VARCHAR(6) PRIMARY KEY,
	BranchName VARCHAR(50) NOT NULL,
	Address VARCHAR(100) NOT NULL,
	Phone VARCHAR(50),
	CONSTRAINT CheckBran1 CHECK (LEN(BranchID)=5),
	CONSTRAINT CheckBran2 CHECK (BranchID LIKE 'BR[0-9][0-9][0-9]')
)

CREATE TABLE MsEmployee
(
	EmployeeID VARCHAR(6) PRIMARY KEY,
	EmployeeName VARCHAR(50) NOT NULL,
	Address VARCHAR(100) NOT NULL,
	Phone VARCHAR(50),
	Gender CHAR(3) NOT NULL,
	DateOfBirth DATETIME,
	Salary NUMERIC,
	BranchID VARCHAR(6) REFERENCES MsBranch ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT CheckEmpl1 CHECK (LEN(EmployeeID)=5),
	CONSTRAINT CheckEmpl2 CHECK (EmployeeID LIKE 'EM[0-9][0-9][0-9]'),
	CONSTRAINT CheckEmpl3 CHECK (Gender IN ('M','F'))
)

CREATE TABLE MsMusicInsType
(
	MusicInsTypeID VARCHAR(6) PRIMARY KEY,
	MusicInsType VARCHAR(50) NOT NULL,	 
	CONSTRAINT CheckMsct1 CHECK (LEN(MusicInsTypeID)=5),
	CONSTRAINT CheckMsct2 CHECK (MusicInsTypeID LIKE 'MT[0-9][0-9][0-9]')
)

CREATE TABLE MsMusicIns
(
	MusicInsID VARCHAR(6) PRIMARY KEY,
	MusicIns VARCHAR(50) NOT NULL,
	Price NUMERIC NOT NULL,
	Stock INT NOT NULL,
	MusicInsTypeID VARCHAR(6) REFERENCES MsMusicInsType ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT CheckMsci1 CHECK (LEN(MusicInsID)=5),
	CONSTRAINT CheckMsci2 CHECK (MusicInsID LIKE 'MI[0-9][0-9][0-9]'),
	CONSTRAINT CheckMsci3 CHECK (Stock >= 0)
)

CREATE TABLE HeaderTransaction
(
	TransactionID VARCHAR(6) PRIMARY KEY,
	TransactionDate DATETIME NOT NULL,
	EmployeeID VARCHAR(6) REFERENCES MsEmployee ON UPDATE CASCADE ON DELETE SET NULL,
	CustomerName VARCHAR(50),
	CONSTRAINT CheckHead1 CHECK (LEN(TransactionID)=5),
	CONSTRAINT CheckHead2 CHECK (TransactionID LIKE 'TR[0-9][0-9][0-9]')
)

CREATE TABLE DetailTransaction
(
	TransactionID VARCHAR(6) REFERENCES HeaderTransaction ON UPDATE CASCADE ON DELETE CASCADE,
	MusicInsID VARCHAR(6) REFERENCES MsMusicIns ON UPDATE CASCADE ON DELETE CASCADE,
	Qty INT NOT NULL,
	PRIMARY KEY(TransactionID, MusicInsID)
)

insert into MsBranch values ('BR001','Cabang Merdeka','Jl. Gang Merdeka No. 17','021-7771234')
insert into MsBranch values ('BR002','Cabang Sejahtera','Jl. Sejahtera Sehat Selalu No. 88','022-2008972')
insert into MsBranch values ('BR003','Cabang Adil','Jl. Adil No. 33','021-8983234')
insert into MsBranch values ('BR004','Cabang Makmur','Jl. Gang Makmur No. 12','021-6526321')
insert into MsBranch values ('BR005','Cabang Damai','Jl. Damai Aman Sentosa No. 45','044-8989898')

insert into MsEmployee values ('EM001','Kikis Sabrina Mona','Jl. Putar-Putar No. 8','022-1239995','F','1989-03-21','3500000','BR003')
insert into MsEmployee values ('EM002','Marlene Martani','Jl. Gajebo No. 32','022-5675542','F','1988-06-14','4250000','BR002')
insert into MsEmployee values ('EM003','Rakhmat Suryahadi','Gang Gansing No. 19','021-3451232','M','1988-01-30','3670000','BR002')
insert into MsEmployee values ('EM004','Suhandi','Jl. Pintu Lima No. 5','022-4519377','M','1985-02-10','5600000','BR001')
insert into MsEmployee values ('EM005','Lisye Mareta Cahya','Jl. Gang Medan Merdeka No. 25','021-9798123','F','1986-12-12','5400000','BR001')
insert into MsEmployee values ('EM006','Sofian Chandra','Jl. Putar-Putar No. 12','021-8763445','M','1987-12-11','5500000','BR005')
insert into MsEmployee values ('EM007','William Salim','Jl. Pusing-Pusing No. 76','022-4859345','M','1987-08-14','5490000','BR005')
insert into MsEmployee values ('EM008','William Wijaya','Jl. Gichung No. 10','022-7859123','M','1989-11-04','5590000','BR003')

insert into MsMusicInsType values ('MT001','Guitar')
insert into MsMusicInsType values ('MT002','Violin')
insert into MsMusicInsType values ('MT003','Piano')
insert into MsMusicInsType values ('MT004','Drum')
insert into MsMusicInsType values ('MT005','Keyboard')

insert into MsMusicIns values ('MI001','Yamaha CX-40','1150000','23','MT001')
insert into MsMusicIns values ('MI002','Yamaha KX-5000','5950000','12','MT005')
insert into MsMusicIns values ('MI003','Yamaha C-390','1250000','10','MT001')
insert into MsMusicIns values ('MI004','Excellent P-77','25700000','17','MT003')
insert into MsMusicIns values ('MI005','Board B-123','5650000','30','MT005')
insert into MsMusicIns values ('MI006','Pearl Q-300','9570000','26','MT004')
insert into MsMusicIns values ('MI007','Supernova X-23','4510000','56','MT002')
insert into MsMusicIns values ('MI008','Yamaha Grand X-1','49750000','12','MT003')

insert into HeaderTransaction values ('TR001','2010-10-02 15:30:00.000','EM003','Veronica')
insert into HeaderTransaction values ('TR002','2010-10-15 09:50:00.000','EM008','Richard Parker')
insert into HeaderTransaction values ('TR003','2010-10-16 13:26:00.000','EM005','Steven Michael')
insert into HeaderTransaction values ('TR004','2010-11-22 10:55:00.000','EM004','Anabelle Setiawan Wati')
insert into HeaderTransaction values ('TR005','2010-11-25 15:30:00.000','EM003','Michelle Regina')
insert into HeaderTransaction values ('TR006','2010-12-13 08:23:00.000','EM001','Dian Sastro')
insert into HeaderTransaction values ('TR007','2010-12-13 18:19:00.000','EM001','Cathy')
insert into HeaderTransaction values ('TR008','2010-12-27 15:21:00.000','EM006','Stephanie Meyer')
insert into HeaderTransaction values ('TR009','2010-01-02 10:28:00.000','EM007','Michael J.')
insert into HeaderTransaction values ('TR010','2010-01-03 12:39:00.000','EM002','Arnold Swasana Segar')

insert into DetailTransaction values ('TR001','MI001','1')
insert into DetailTransaction values ('TR001','MI004','2')
insert into DetailTransaction values ('TR002','MI003','1')
insert into DetailTransaction values ('TR002','MI005','2')
insert into DetailTransaction values ('TR002','MI008','5')
insert into DetailTransaction values ('TR003','MI007','4')
insert into DetailTransaction values ('TR004','MI004','3')
insert into DetailTransaction values ('TR004','MI006','3')
insert into DetailTransaction values ('TR005','MI002','1')
insert into DetailTransaction values ('TR006','MI001','2')
insert into DetailTransaction values ('TR007','MI003','3')
insert into DetailTransaction values ('TR007','MI006','5')
insert into DetailTransaction values ('TR008','MI002','3')
insert into DetailTransaction values ('TR008','MI004','2')
insert into DetailTransaction values ('TR008','MI008','1')
insert into DetailTransaction values ('TR009','MI002','2')
insert into DetailTransaction values ('TR009','MI005','4')
insert into DetailTransaction values ('TR010','MI001','2')
insert into DetailTransaction values ('TR010','MI003','2')
insert into DetailTransaction values ('TR010','MI004','2')
*/

--1

select top 2 EmployeeID,EmployeeName,Gender from MsEmployee 
where Gender like 'F'

--2
select * from MsEmployee 
where right(Phone,1)%5=0 and Salary > 4000000

--3

create view [views_1] as
select * from MsMusicIns where MusicIns like 'Yamaha%' and Price between 5000000 and 10000000;


--4
select REPLACE(EmployeeName,SUBSTRING(EmployeeName,(CHARINDEX(' ',EmployeeName)-DATALENGTH(EmployeeName)),DATALENGTH(EmployeeName)),EmployeeID) as BranchEmployee
from MsEmployee where EmployeeName like '% % %'

--5
select SUBSTRING(MusicIns,(CHARINDEX(' ',MusicIns)-DATALENGTH(MusicIns)),DATALENGTH(MusicIns)) as Brand ,'Rp. ' + cast(Price as varchar) as price ,mmi.Stock,mit.MusicInsType from MsMusicIns as mmi
join MsMusicInsType as mit on mmi.MusicInsTypeID= mit.MusicInsTypeID

--6
select EmployeeName, Case when Gender = 'M' then 'Male' when Gender = 'F' then 'Female' else 'Other' end as gender,CONVERT(varchar,TransactionDate,106) as transactiondate,CustomerName from MsEmployee as mse
join HeaderTransaction as ht on mse.EmployeeID=ht.EmployeeID
where EmployeeName like '% %' and Gender = 'M'
order by EmployeeName

--7
select mse.EmployeeID,EmployeeName,CONVERT(varchar,DateOfBirth,106)as DateOfBirth,CustomerName,CONVERT(varchar,TransactionDate,106)as TransactionDate from MsEmployee as mse
join HeaderTransaction as ht on mse.EmployeeID=ht.EmployeeID
where MONTH(DateOfBirth)=12 and DAY(TransactionDate)=16

--8
select BranchName,EmployeeName from MsBranch as mb
join MsEmployee as me on mb.BranchID = me.BranchID
join HeaderTransaction as ht on me.EmployeeID = ht.EmployeeID
join DetailTransaction as dt on ht.TransactionID = dt.TransactionID
where MONTH(TransactionDate)=10 and Qty >=5

--9

create proc search @namacari varchar(250)
as
begin
		select EmployeeName,[Address],Phone,Gender from MsEmployee
		where EmployeeName like '%'+@namacari+'%' or [Address] like '%'+@namacari+'%' or Phone like '%'+@namacari+'%' or Gender like '%'+@namacari+'%'
end

exec search 'f'

--10
create proc Check_Transaction @TransactionID varchar(225)
as
begin
		select CustomerName,EmployeeName,BranchName,MusicIns,Price from MsBranch as mb
			join MsEmployee as me on mb.BranchID = me.BranchID
			join HeaderTransaction as ht on me.EmployeeID = ht.EmployeeID
			join DetailTransaction as dt on ht.TransactionID = dt.TransactionID
			join MsMusicIns as mmi on dt.MusicInsID = mmi.MusicInsID
			where ht.TransactionID like @TransactionID
end


exec Check_Transaction 'Tr001'

--11
select COUNT(TransactionDate)as jumlahTransaksi,EmployeeName from MsEmployee as mse
join HeaderTransaction as ht on mse.EmployeeID = ht.EmployeeID
join DetailTransaction as dt on ht.TransactionID = dt.TransactionID
group by EmployeeName

--12
alter proc Add_Stock_MusicIns @musicname varchar(255),@stok int
as
	begin
	if @stok=0
		print'Imput stock harus lebih dari 0'
	else
		
		begin
			update MsMusicIns
			set 
			Stock = Stock+@stok
			where MusicInsID = @musicname
		end
	end

exec Add_Stock_MusicIns 'MI001','0'

select MusicInsID,Stock from MsMusicIns

--13
create proc Check_Music_Code  @dataid varchar(255)
as
	begin
	if exists(select * from MsMusicIns where MusicInsID = @dataid)
		begin
		select * from MsMusicIns where MusicInsID = @dataid
		end
	else if exists(select * from MsMusicInsType where MusicInsTypeID = @dataid)
		
		begin
			
		select * from MsMusicInsType where MusicInsTypeID = @dataid
		
		end
	else
		print'Data tidak ditemukan / Kode yang dimasukan salah'
	end

exec Check_Music_Code 'MT100'




--14
create proc Check_Sale @namabulan varchar(255)
as
begin 
	select MusicInsType,Qty from HeaderTransaction as ht 
	join DetailTransaction as dt on ht.TransactionID = dt.TransactionID
	join MsMusicIns as mmi on dt.MusicInsID = mmi.MusicInsID
	join MsMusicInsType as mmt on mmi.MusicInsTypeID =mmt.MusicInsTypeID
	where MONTH(ht.TransactionDate)= MONTH(@namabulan+'1 2021')
	order by mmt.MusicInsType
end

exec Check_Sale 'October'

--15
create proc Check_Employee @employeeid varchar(255)=null
as
begin
	if @employeeid is null or @employeeid = ''
		begin
		select EmployeeName,me.[Address],me.Phone,CONVERT(varchar,me.DateOfBirth,106),BranchName from  MsBranch as mb
			join MsEmployee as me on mb.BranchID = me.BranchID
			join HeaderTransaction as ht on me.EmployeeID = ht.EmployeeID
		end
	else if exists(select * from MsBranch as mb
			join MsEmployee as me on mb.BranchID = me.BranchID
			join HeaderTransaction as ht on me.EmployeeID = ht.EmployeeID 
			where ht.TransactionID=@employeeid)
			begin
			select EmployeeName,me.[Address],me.Phone,CONVERT(varchar,me.DateOfBirth,106)as DateOfBrith,BranchName from  MsBranch as mb
			join MsEmployee as me on mb.BranchID = me.BranchID
			join HeaderTransaction as ht on me.EmployeeID = ht.EmployeeID
			where ht.TransactionID=@employeeid
			end
	
end

exec Check_Employee 