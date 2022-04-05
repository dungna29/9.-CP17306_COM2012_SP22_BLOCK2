/* T-SQL - Structured Query Language: Ngôn ngữ truy vấn có cấu trúc SQL cho phép Tạo CSDL, Thao tác trên dữ liệu
		(Lưu trữ dữ liệu, Sửa dữ liệu, Xóa dữ liệu) Đa số các RDBMS hiện nay sử dụng SQL (MS SQL Server – T- SQL, 
		Microsoft Access, Oracle – PL/SQL, DB2, MySQL…) [DungNA29]
Có thể chia thành 4 nhóm lệnh SQL:
	+ Nhóm truy vấn dữ liệu (DQL): gồm các lệnh truy vấn lựa chọn
	(Select) để lấy thông tin nhưng không làm thay đổi dữ liệu trong các bảng
	+ Nhóm định nghĩa dữ liệu (DDL): Gồm các lệnh tạo, thay đổi các bảng dữ liệu(Create, Drop, Alter, …)
	+ Nhóm thao tác dữ liệu (DML): Gồm các lệnh làm thay đổi dữ liệu (Insert, Delete, Update,…) lưu trong các bảng
	+ Nhóm điều khiển dữ liệu (DCL): Gồm các lệnh quản lý quyền truy nhập vào dữ liệu và các bảng (Grant, Revoke, …)
SQL KHÔNG PHÂN BIỆT CHỮA HOA CHỮ THƯỜNG. [DungNA29]
NGUYÊN TẮC KHI ĐẶT TÊN
	+ Kí tự đầu tiên của một định danh phải là một kí tự chữ cái theo chuẩn Unicode 2.0, hoặc dấu (_),
	hoặc dấu @ (tên biến), hoặc # (bảng tạm).
    + Không trùng với các từ khoá và từ dành riêng của ngôn ngữ T-SQL
    + Không chứa các kí tự đặt biệt +, -, *, /, !, ~, | ....
    + Ví dụ tên hợp lệ: Nhan_vien, _PhongBan
    + Tên không hợp lệ: [%], SELECT
    [DungNA29]
	Ctrl + E = Exxcute câu lệnh khi bôi đen vùng lệnh.
	*/

-- Câu lệnh 1.1: COMMENT TRONG SQL --	
-- (2 dấu gạch liên tiếp): Comment trên một dòng và chỉ có tác dụng trên 1 dòng DungNA29
/*..Comment trên một khối.. */ 
        

/*
	CÂU LỆNH 1.2: CREATE DATABASE
	ĐỊNH NGHĨA: DÙNG ĐỂ TẠO 1 DATABASE TRONG CSDL
	CÔNG THỨC: 
	CREATE DATABASE database_name;
*/
CREATE DATABASE CP17306_SP2022_BL2
USE CP17306_SP2022_BL2 -- Chỉ định DB mà mình muốn làm việc

/*
	CÂU LỆNH 1.3: DROP DATABASE
	ĐỊNH NGHĨA: XÓA DATABASE TRONG CSDL
	CÔNG THỨC: 
	DROP DATABASE database_name;
*/
DROP DATABASE CP17306_SP2022_BL2

/*
	CÂU LỆNH 1.4: CREATE TABLE
	ĐỊNH NGHĨA: TẠO BẢNG TRONG CSDL
	CÔNG THỨC: 
	CREATE TABLE table_name (
    column1 datatype,
    column2 datatype,
    column3 datatype,
   ....
	);
*/
-- Cách 1 tạo bảng kèm khóa chính
CREATE TABLE ChucVu(
Id INT PRIMARY KEY IDENTITY,
Ma VARCHAR(20) UNIQUE,
Ten NVARCHAR(50) DEFAULT NULL
)
-- Cách 2 tạo bảng kèm khóa chính
CREATE TABLE ChucVu(
Id INT,
Ma VARCHAR(20) UNIQUE,
Ten NVARCHAR(50) DEFAULT NULL,
PRIMARY KEY(Id)
)
-- Cách 3 tạo bảng kèm khóa chính
CREATE TABLE ChucVu(
Id INT PRIMARY KEY,
Ma VARCHAR(20) UNIQUE,
Ten NVARCHAR(50) DEFAULT NULL
)
-- Cách 4 tạo bảng kèm khóa chính với Constraint
CREATE TABLE ChucVu(
Id INT,
Ma VARCHAR(20) UNIQUE,
Ten NVARCHAR(50) DEFAULT NULL
CONSTRAINT PK_ChucVu PRIMARY KEY (Id,Ma) -- Constraint dùng để chỉ ra quy tắc của dữ liệu phải tuân theo.
)
-- Trong ví ụ trên chi có 1 khóa chính PK_ChucVu. Tuy nhiên, Giá trị của khóa chính được tạo nên từ 2 cột(Id,Ma)

/*
	CÂU LỆNH 1.5: DROP TABLE
	ĐỊNH NGHĨA: XÓA BẢNG TRONG CSDL
	CÔNG THỨC: 
	DROP TABLE table_name;
*/
DROP TABLE ChucVu

/*
	CÂU LỆNH 1.6: ALTER TABLE
	ĐỊNH NGHĨA:
		- Câu lệnh ALTER TABLE được sử dụng để thêm, xóa hoặc sửa đổi các cột trong bảng hiện có.
		- Câu lệnh ALTER TABLE cũng được sử dụng để thêm và bỏ các ràng buộc khác nhau trên một bảng hiện có.
	CÔNG THỨC: 
		- Thêm cột:
		ALTER TABLE table_name
		ADD column_name datatype;
		- Xóa cột:
		ALTER TABLE table_name
		DROP COLUMN column_name;
		- ALTER/MODIFY COLUMN: Để thay đổi kiểu dữ liệu của một cột trong bảng
		ALTER TABLE table_name
		ALTER COLUMN column_name datatype;
*/
ALTER TABLE ChucVu ADD ColTest INT -- Thêm cột và có thể thêm nhiều cột thông qua dấu ,

ALTER TABLE ChucVu DROP COLUMN ColTest -- Xóa cột

ALTER TABLE ChucVu ALTER COLUMN ColTest VARCHAR(MAX)-- Sửa kiểu dữ liệu của cột

/*
	CÂU LỆNH 1.8: CONSTRAINT
	Câu lệnh Thêm ràng buộc Constraint (Ràng buộc là các qui tắc để hạn chế các giá trị được lưu trữ vào bảng. [DungNA29]
	Các ràng buộc được sử dụng để giới hạn loại dữ liệu có thể đi vào bảng. Điều này đảm bảo tính chính xác và độ tin cậy của dữ liệu trong bảng. Nếu có bất kỳ vi phạm nào giữa ràng buộc và hành động dữ liệu, hành động đó sẽ bị hủy bỏ)
	Ràng buộc NOT NULL trong SQL: Bảo đảm một cột không thể có giá trị NULL.
	Ràng buộc DEFAULT trong SQL: Cung cấp một giá trị mặc định cho cột khi không được xác định.
	Ràng buộc UNIQUE trong SQL: Bảo đảm tất cả giá trị trong một cột là khác nhau.
	Ràng buộc PRIMARY Key trong SQL: Mỗi hàng/bản ghi được nhận diện một cách duy nhất trong một bảng.
	Ràng buộc FOREIGN Key trong SQL: Mỗi hàng/bản ghi được nhận diện một cách duy nhất trong bất kỳ bảng nào.
	Ràng buộc CHECK trong SQL: Bảo đảm tất cả giá trị trong một cột thỏa mãn các điều kiện nào đó.
	Ràng buộc INDEX trong SQL: Sử dụng để tạo và lấy dữ liệu từ Database một cách nhanh chóng. 
	CREATE TABLE table_name (
		column1 datatype constraint, Ràng buộc xuất hiện sau kiểu dữ liệu
		column2 datatype constraint,
		column3 datatype constraint,
		....
	);
*/
-- Tạo bảng cửa hàng
CREATE TABLE CuaHang(
Id INT PRIMARY KEY IDENTITY,
Ma VARCHAR(20) UNIQUE,
Ten NVARCHAR(50) DEFAULT NULL,
DiaChi NVARCHAR(100) DEFAULT NULL,
ThanhPho NVARCHAR(20) DEFAULT NULL,
QuocGia NVARCHAR(30) DEFAULT NULL,
)
/*
	CÂU LỆNH 1.9: FOREIGN KEY Constraint
	Tại quan hệ và chỉ định khóa ngoại cho bảng
	-- Cách 1
	 <Tên cột>  <kiểu dữ liệu> FOREIGN KEY REFERENCES <Tên bảng khóa chính>(<Tên khóa chính>)
	-- Cách 2
	CONSTRAINT <Tên khóa ngoại do mình đặt> FOREIGN KEY (<Tên FK trong bảng>)
*/
--Cách 1
CREATE TABLE NhanVien(
Id INT PRIMARY KEY IDENTITY,
Ma VARCHAR(20) UNIQUE,
Ten NVARCHAR(50) DEFAULT NULL,
TenDem NVARCHAR(50) DEFAULT NULL,
Ho NVARCHAR(50) DEFAULT NULL,
GioiTinh NVARCHAR(10) DEFAULT NULL,
NgaySinh DATE DEFAULT NULL,
DiaChi NVARCHAR(100) DEFAULT NULL,
Sdt VARCHAR(20) DEFAULT NULL,
IdCH INT FOREIGN KEY REFERENCES CuaHang(Id),
IdCV INT FOREIGN KEY REFERENCES ChucVu(Id),
IdGuiBaoCao INT FOREIGN KEY REFERENCES NhanVien(Id),
TrangThai INT DEFAULT 0
)
-- Cách 2
CREATE TABLE NhanVien(
Id INT PRIMARY KEY IDENTITY,
Ma VARCHAR(20) UNIQUE,
Ten NVARCHAR(50) DEFAULT NULL,
TenDem NVARCHAR(50) DEFAULT NULL,
Ho NVARCHAR(50) DEFAULT NULL,
GioiTinh NVARCHAR(10) DEFAULT NULL,
NgaySinh DATE DEFAULT NULL,
DiaChi NVARCHAR(100) DEFAULT NULL,
Sdt VARCHAR(20) DEFAULT NULL,
IdCH INT,
IdCV INT,
IdGuiBaoCao INT,
TrangThai INT DEFAULT 0
CONSTRAINT FK_CUAHANG FOREIGN KEY(IdCH) REFERENCES CuaHang(Id),
CONSTRAINT FK_CHUCVU FOREIGN KEY(IdCV) REFERENCES ChucVu(Id),
CONSTRAINT FK_GUIBAOCAO FOREIGN KEY(IdGuiBaoCao) REFERENCES NhanVien(Id)
)
-- Cách 3: Sử dụng câu lệnh ALTER để khai báo khóa phụ, khi tạo bảng thì không cần các mối quan hệ ban đầu
CREATE TABLE NhanVien(
Id INT PRIMARY KEY IDENTITY,
Ma VARCHAR(20) UNIQUE,
Ten NVARCHAR(50) DEFAULT NULL,
TenDem NVARCHAR(50) DEFAULT NULL,
Ho NVARCHAR(50) DEFAULT NULL,
GioiTinh NVARCHAR(10) DEFAULT NULL,
NgaySinh DATE DEFAULT NULL,
DiaChi NVARCHAR(100) DEFAULT NULL,
Sdt VARCHAR(20) DEFAULT NULL,
IdCH INT,
IdCV INT,
IdGuiBaoCao INT,
TrangThai INT DEFAULT 0
)
-- Mối quan hệ thông qua câu lệnh ALTER
-- NhanVien - CuaHang
ALTER TABLE NhanVien
ADD FOREIGN KEY(IdCH) REFERENCES CuaHang(Id)

-- NhanVien - ChucVu
ALTER TABLE NhanVien
ADD FOREIGN KEY(IdCV) REFERENCES ChucVu(Id)

-- NhanVien - NguoiGuiBaoCao
ALTER TABLE NhanVien
ADD FOREIGN KEY(IdGuiBaoCao) REFERENCES NhanVien(Id)

/*
	CÂU LỆNH 2.0: INSERT INTO 
	Thêm dữ liệu vào bảng và có thể viết theo 2 cách
	-- Cách 1: Chỉ định cột và giá trị sẽ được chèn
	 INSERT INTO table_name (column1, column2, column3, ...)
	 VALUES (value1, value2, value3, ...);
	-- Cách 2: đảm bảo thứ tự của các giá trị theo cùng thứ tự với các cột trong bảng
	INSERT INTO table_name
	VALUES (value1, value2, value3, ...);
*/
INSERT INTO ChucVu(Ma,Ten)
VALUES('TP',N'Trưởng Phòng'),
		('NV',N'Nhân Viên')

INSERT INTO ChucVu
VALUES('LC',N'Lao Công'),
		('BV',N'Bảo Vệ')