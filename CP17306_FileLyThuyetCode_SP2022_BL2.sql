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

/*
	CÂU LỆNH 2.1: SELECT   
	Câu lệnh SELECT được sử dụng để chọn dữ liệu từ cơ sở dữ liệu.
	Dữ liệu trả về được lưu trữ trong một bảng kết quả, được gọi là tập kết quả.
	-- Cú pháp: Ở đây, column1, column2, ... là tên trường của bảng mà bạn muốn chọn dữ liệu
	SELECT column1, column2, ...
	FROM table_name;
	SELECT * FROM table_name;
*/
SELECT * FROM SanPham
SELECT Ma,Ten FROM SanPham
/*
	CÂU LỆNH 2.2: Aliases   
	Bí danh SQL được sử dụng để đặt tên tạm thời cho một bảng hoặc một cột trong bảng.
	Bí danh thường được sử dụng để làm cho tên cột dễ đọc hơn.
	Bí danh chỉ tồn tại trong thời gian truy vấn.
	-- Cú pháp cột bí danh:
	SELECT column_name AS alias_name
	FROM table_name;
	-- Cú pháp bảng bí danh:
	SELECT column_name(s)
	FROM table_name AS alias_name;
*/
SELECT Ma AS N'Mã Nhân Viên',Ten AS N'Tên NV' FROM NhanVien

/*
	CÂU LỆNH 2.2: SELECT DISTINCT   
	Câu lệnh SELECT DISTINCT chỉ được sử dụng để trả về các giá trị riêng biệt (khác nhau).
	tên trong một bảng, một cột thường chứa nhiều giá trị trùng lặp; và đôi khi bạn chỉ muốn liệt kê các giá trị khác nhau (riêng biệt).
	
	-- Cú pháp cột bí danh:
	SELECT DISTINCT column1, column2, ...
	FROM table_name;
*/
SELECT DISTINCT Ten FROM NHANVIEN

/*
	CÂU LỆNH 2.3: SELECT TOP Clause  
	Mệnh đề SELECT TOP được sử dụng để chỉ định số lượng bản ghi trả về.
	Mệnh đề SELECT TOP hữu ích trên các bảng lớn với hàng nghìn bản ghi. Trả lại một số lượng lớn bản ghi có thể ảnh hưởng đến hiệu suất.
	
	-- Cú pháp: 
	SELECT TOP number|percent column_name(s)
	FROM table_name
	WHERE condition;
*/
SELECT TOP 2 * FROM NhanVien
SELECT TOP 50 PERCENT * FROM NhanVien
/* 
	CÂU LỆNH 2.4:WHERE 
	- Được sử dụng để lọc các bản ghi. 
	- Mệnh đề WHERE được sử dụng để chỉ trích xuất những bản ghi đáp ứng một điều kiện cụ thể. [DungNA29]
	-- Cú pháp:
	SELECT column1, column2, ...
	FROM table_name
	WHERE condition;
	=	Equal - So sánh	
	>	Greater than - Lớn hơn	
	<	Less than - Nhỏ hơn 	
	>=	Greater than or equal - Lớn hơn hoặc bằng	
	<=	Less than or equal - Nhỏ hơn hoặc bằng	
	<>	Not equal. Note: In some versions of SQL this operator may be written as !=	 -  Khác
	BETWEEN	Between a certain range	 - Trong Khoảng  - Sẽ Giải thích trong phần riêng
	LIKE	Search for a pattern	-  Tìm kiếm theo mẫu - Sẽ Giải thích trong phần riêng
	IN	To specify multiple possible values for a column - Sẽ Giải thích trong phần riêng [DungNA29]
	Lưu ý: Mệnh đề WHERE không chỉ được sử dụng trong câu lệnh 
	SELECT, nó còn được sử dụng trong CẬP NHẬT, câu lệnh XÓA, v.v.! [DungNA29]
*/
--In ra danh sách các nhân viên nữ ở cửa hàng
SELECT * FROM NHANVIEN
WHERE GioiTinh = N'Nữ'
-- In danh sách những người họ Lê ở cửa hàng
SELECT * FROM NHANVIEN
WHERE Ho = N'Lê' AND GioiTinh = N'Nữ'

/*
	CÂU LỆNH 2.5: DELETE  
	Câu lệnh DELETE được sử dụng để xóa các bản ghi hiện có trong bảng.
	-- Cú pháp: 
	DELETE FROM table_name WHERE condition;
	-- Lưu ý: Hãy cẩn thận khi xóa các bản ghi trong bảng! Lưu ý mệnh đề WHERE trong câu lệnh DELETE. 
	Mệnh đề WHERE chỉ định (các) bản ghi nào nên được xóa. Nếu bạn bỏ qua mệnh đề WHERE, 
	tất cả các bản ghi trong bảng sẽ bị xóa!
*/
DELETE FROM NhanVienz -- Xóa tất cả data bên trong bảng
DELETE FROM NhanVien WHERE Ma = 'Manv'

/*
	CÂU LỆNH 2.5: UPDATE   
	Câu lệnh UPDATE được sử dụng để sửa đổi các bản ghi hiện có trong bảng.
	-- Cú pháp: 
	UPDATE table_name
	SET column1 = value1, column2 = value2, ...
	WHERE condition;
	-- Lưu ý: Hãy cẩn thận khi cập nhật các bản ghi trong bảng! Lưu ý mệnh đề WHERE trong câu lệnh UPDATE. 
	Mệnh đề WHERE chỉ định (các) bản ghi sẽ được cập nhật. Nếu bạn bỏ qua mệnh đề WHERE, 
	tất cả các bản ghi trong bảng sẽ được cập nhật!
*/
UPDATE NHANVIEN
SET Ho = N'Nguyễn',TenDem = N'Như'
WHERE Ma = 'NV16'
SELECT * FROM NHANVIEN WHERE Ma = 'NV16'

/*
	CÂU LỆNH 2.6: TOÁN TỬ LIKE   
	Toán tử LIKE được sử dụng trong mệnh đề WHERE để tìm kiếm một mẫu cụ thể trong một cột.
	Có hai ký tự đại diện thường được sử dụng cùng với toán tử LIKE:
	% - Dấu phần trăm đại diện cho không, một hoặc nhiều ký tự
	_ - Dấu gạch dưới thể hiện một ký tự
		LIKE Operator					Description
	WHERE CustomerName LIKE 'a%'	Finds any values that start with "a" - Tìm bất kỳ giá trị nào bắt đầu bằng "a"
	WHERE CustomerName LIKE '%a'	Finds any values that end with "a" - Tìm bất kỳ giá trị nào kết thúc bằng "a"
	WHERE CustomerName LIKE '%or%'	Finds any values that have "or" in any position - Tìm bất kỳ giá trị nào có "or" ở bất kỳ vị trí nào
	WHERE CustomerName LIKE '_r%'	Finds any values that have "r" in the second position - Tìm bất kỳ giá trị nào có "r" ở vị trí thứ hai
	WHERE CustomerName LIKE 'a_%'	Finds any values that start with "a" and are at least 2 characters in length - Tìm bất kỳ giá trị nào bắt đầu bằng "a" và có ít nhất 2 ký tự
	WHERE CustomerName LIKE 'a__%'	Finds any values that start with "a" and are at least 3 characters in length - Tìm bất kỳ giá trị nào bắt đầu bằng "a" và có ít nhất 3 ký tự
	WHERE ContactName LIKE 'a%o'	Finds any values that start with "a" and ends with "o" - Tìm bất kỳ giá trị nào bắt đầu bằng "a" và kết thúc bằng "o"
	
	-- Cú pháp: 
	SELECT column1, column2, ...
	FROM table_name
	WHERE columnN LIKE pattern;	
*/
SELECT * FROM NHANVIEN WHERE Ten LIKE '%n%'
-- Truy vấn những người sử dụng số điện thoại mạng Việt Teo
-- Truy vấn những người sử dụng số điện thoại có đuôi 37

/*
	CÂU LỆNH 2.7: TOÁN TỬ IN  
	Toán tử IN cho phép bạn chỉ định nhiều giá trị trong mệnh đề WHERE.
	Toán tử IN là cách viết tắt của nhiều điều kiện OR.
	-- Cú pháp:
	SELECT column_name(s)
	FROM table_name
	WHERE column_name IN (value1, value2, ...);
	HOẶC
	SELECT column_name(s)
	FROM table_name
	WHERE column_name IN (SELECT STATEMENT);
*/
SELECT * FROM NHANVIEN
WHERE Ten = N'Tiến' OR Ten = N'Tồn'

SELECT * FROM NHANVIEN
WHERE Ten IN (N'Tiến',N'Tồn')

-- Lấy dữ liệu những đang làm tại các cauwr hàng Hà Nội
SELECT * FROM NHANVIEN
WHERE IdCH IN (SELECT ID FROM CUAHANG WHERE ThanhPho=N'Hà Nội')
/*
	CÂU LỆNH 2.9: TOÁN TỬ SQL AND, OR và NOT Operators(Toán tử)  và Toán tử BETWEEN
	Mệnh đề WHERE có thể được kết hợp với các toán tử AND, OR và NOT.
	Toán tử AND và OR được sử dụng để lọc các bản ghi dựa trên nhiều hơn một điều kiện:
	Toán tử AND hiển thị một bản ghi nếu tất cả các điều kiện được phân tách bằng AND đều ĐÚNG.
	Toán tử OR hiển thị một bản ghi nếu bất kỳ điều kiện nào được phân tách bởi OR là TRUE.
	Toán tử NOT hiển thị một bản ghi nếu (các) điều kiện KHÔNG ĐÚNG.
	-- Cú pháp:
	AND Syntax
		SELECT column1, column2, ...
		FROM table_name
		WHERE condition1 AND condition2 AND condition3 ...;
	
	OR Syntax
		SELECT column1, column2, ...
		FROM table_name
		WHERE condition1 OR condition2 OR condition3 ...;
	
	NOT Syntax
		SELECT column1, column2, ...
		FROM table_name
		WHERE NOT condition;
		
		Toán tử GIỮA chọn các giá trị trong một phạm vi nhất định. Các giá trị có thể là số, văn bản hoặc ngày tháng.
		Toán tử BETWEEN được bao gồm: giá trị bắt đầu và kết thúc được bao gồm. 
	BETWEEN Syntax
		SELECT column_name(s)
		FROM table_name
		WHERE column_name BETWEEN value1 AND value2;
*/
-- Lấy ra các nhân viên giới tính là Nữ và Họ Nguyễn
SELECT * FROM NhanVien
WHERE GioiTinh = N'Nữ' AND Ho = N'Nguyễn'
-- Lấy các sản phẩm có năm bảo hành từ 2 đến 3 năm ở bảng Chi Tiết SP
SELECT * FROM ChiTietSP
WHERE NamBH >= 2 AND NamBH <=3

SELECT * FROM ChiTietSP
WHERE NamBH BETWEEN 2 AND 3

/*
	CÂU LỆNH 3.0: TOÁN TỬ IN  COUNT(), AVG() and SUM(),MIN() and MAX() Functions	
	
	Hàm COUNT () trả về số hàng phù hợp với tiêu chí được chỉ định.
	Hàm AVG () trả về giá trị trung bình của một cột số.
	Hàm SUM () trả về tổng tổng của một cột số.
	Hàm MIN () trả về giá trị nhỏ nhất của cột đã chọn.
	Hàm MAX () trả về giá trị lớn nhất của cột đã chọn.
	-- Cú pháp:
	Cú pháp COUNT ()
		SELECT COUNT(column_name)
		FROM table_name
		WHERE condition;
	Cú pháp AVG ()
		SELECT AVG(column_name)
		FROM table_name
		WHERE condition;
	Cú pháp SUM ()
		SELECT SUM(column_name)
		FROM table_name
		WHERE condition;
	Cú pháp MIN ()
		SELECT MIN(column_name)
		FROM table_name
		WHERE condition;
	Cú pháp MAX ()
		SELECT MAX(column_name)
		FROM table_name
		WHERE condition;
*/
-- Lấy ra số lượng nhân viên Nữ ở cửa hàng FPT SHOP
SELECT COUNT(GioiTinh) FROM NhanVien
WHERE GioiTinh = N'Nữ'
-- Lấy ra số lượng nhân viên nữ làm ở cửa hàng có CH01
SELECT COUNT(GioiTinh) AS N'Số lượng nhân viên nữ' FROM NhanVien
WHERE GioiTinh = N'Nữ'AND IdCH = (SELECT Id FROM CuaHang WHERE Ma = 'CH1')
-- AVG() Tính trung bình giá nhập Laptop tại cửa hàng?
SELECT AVG(GiaNhap) FROM ChiTietSP
WHERE IdSP = (SELECT Id FROM SanPham WHERE Ten = 'LapTop')

/*
	CÂU LỆNH 3.1: ORDER BY	
	
	Từ khóa ORDER BY được sử dụng để sắp xếp tập hợp kết quả theo thứ tự tăng dần hoặc giảm dần.
	Từ khóa ORDER BY sắp xếp các bản ghi theo thứ tự tăng dần theo mặc định. Để sắp xếp các bản ghi theo thứ tự giảm dần, 
	hãy sử dụng từ khóa DESC.
	-- Cú pháp:
	SELECT column1, column2, ...
	FROM table_name
	ORDER BY column1, column2, ... ASC|DESC;
*/
SELECT * FROM NhanVien ORDER BY Ten -- Sắp xếp ASC tăng tần vì mặc định của ORDER BY là tăng dần.
SELECT * FROM NhanVien ORDER BY Ten ASC
SELECT * FROM NhanVien ORDER BY Ten DESC -- Sắp xếp giảm dần
/*
	CÂU LỆNH 3.2: GROUP BY	
	
	Câu lệnh GROUP BY nhóm các hàng có cùng giá trị thành các hàng tóm tắt, như "tìm số lượng khách hàng ở mỗi quốc gia".
	Câu lệnh GROUP BY thường được sử dụng với các hàm tổng hợp (COUNT, MAX, MIN, SUM, AVG) để nhóm tập hợp kết quả theo một hoặc nhiều cột.
	-- Cú pháp:
	SELECT column_name(s)
	FROM table_name
	WHERE condition
	GROUP BY column_name(s)
	ORDER BY column_name(s);
*/
/*
	CÂU LỆNH 3.2: GROUP BY	
	
	Câu lệnh GROUP BY nhóm các hàng có cùng giá trị thành các hàng tóm tắt, như "tìm số lượng khách hàng ở mỗi quốc gia".
	Câu lệnh GROUP BY thường được sử dụng với các hàm tổng hợp (COUNT, MAX, MIN, SUM, AVG) để nhóm tập hợp kết quả theo một hoặc nhiều cột.
	-- Cú pháp:
	SELECT column_name(s)
	FROM table_name
	WHERE condition
	GROUP BY column_name(s)
	ORDER BY column_name(s);
*/
-- Tính tổng tiền trên từng hóa đơn khách hàng mua bên bảng chi tiết
SELECT IdHoaDon,SUM(SoLuong) AS N'Tổng SP khách mua trong hóa đơn' ,SUM(SoLuong*DonGia) AS N'Tổng Tiền' FROM HoaDonChiTiet
GROUP BY IdHoaDon

/*
	CÂU LỆNH 3.3: MỆNH ĐỀ HAVING - Mệnh đề HAVING đã được thêm vào SQL vì từ khóa WHERE không thể được sử dụng với các hàm tổng hợp. 	
	
	Mệnh đề HAVING đã được thêm vào SQL vì không thể sử dụng từ khóa WHERE với các hàm tổng hợp.
	-- Cú pháp:
	SELECT column_name(s)
	FROM table_name
	WHERE condition
	GROUP BY column_name(s)
	HAVING condition
	ORDER BY column_name(s);
*/
-- In ra danh sách các cửa hàng có số lượng được mở tại TP đó >3
SELECT ThanhPho,COUNT(ThanhPho) FROM CuaHang
GROUP BY ThanhPho
HAVING COUNT(ThanhPho) > 3

/*
	CÂU LỆNH 3.4: JOIN dùng để kết hợp từ 2 bảng trở lên dựa trên một cột có liên quan chúng lại với nhau  	
	
	(INNER) JOIN: Trả về các bản ghi có giá trị khớp trong cả hai bảng - JOIN mặc định chính là INNER JOIN
	LEFT (OUTER) JOIN: Trả về tất cả các bản ghi từ bảng bên trái và các bản ghi khớp từ bảng bên phải
	RIGHT (OUTER) JOIN: Trả về tất cả các bản ghi từ bảng bên phải và các bản ghi khớp từ bảng bên trái
	FULL (OUTER) JOIN:  Trả về tất cả các bản ghi khi có trong bảng bên trái hoặc bên phải
	-- Cú pháp:
	INNER JOIN Syntax
		SELECT column_name(s)
		FROM table1
		INNER JOIN table2
		ON table1.column_name = table2.column_name;
	LEFT JOIN Syntax
		SELECT column_name(s)
		FROM table1
		LEFT JOIN table2
		ON table1.column_name = table2.column_name;
	RIGHT JOIN Syntax
		SELECT column_name(s)
		FROM table1
		RIGHT JOIN table2
		ON table1.column_name = table2.column_name;
	Self JOIN Syntax
		SELECT column_name(s)
		FROM table1 T1, table1 T2
		WHERE condition;
*/
SELECT SanPham.Ma,SanPham.Ten,ChiTietSP.NamBH,ChiTietSP.SoLuongTon FROM ChiTietSP
JOIN SanPham ON SanPham.Id =ChiTietSP.IdSP
-- Nếu mà các bạn để JOIN mặc định sẽ là INNER JOIN
SELECT SanPham.Ma,SanPham.Ten,ChiTietSP.NamBH,ChiTietSP.SoLuongTon FROM ChiTietSP
INNER JOIN SanPham ON SanPham.Id =ChiTietSP.IdSP

-- LEFT JOIN
SELECT Nsx.Ma,Nsx.Ten,ChiTietSP.NamBH,ChiTietSP.SoLuongTon 
FROM ChiTietSP
LEFT JOIN Nsx ON Nsx.Id =ChiTietSP.IdNsx

SELECT Nsx.Ma,Nsx.Ten,ChiTietSP.NamBH,ChiTietSP.SoLuongTon 
FROM Nsx
LEFT JOIN ChiTietSP ON Nsx.Id =ChiTietSP.IdNsx
-- Ngoài ra nghiên cứu thêm các kiểu join còn lại.
/*
	CÂU LỆNH 3.5: SQL SELECT INTO
	Câu lệnh SELECT INTO sao chép dữ liệu từ một bảng vào một bảng mới.
	-- Cú pháp:
		SELECT *
		INTO newtable [IN externaldb]
		FROM oldtable
		WHERE condition;
	Chỉ sao chép một số cột vào một bảng mới:
		SELECT column1, column2, column3, ...
		INTO newtable [IN externaldb]
		FROM oldtable
		WHERE condition;
*/

/*
	CÂU LỆNH 3.6: SQL INSERT INTO SELECT
	Câu lệnh INSERT INTO SELECT sao chép dữ liệu từ một bảng và chèn nó vào một bảng khác.
	INSERT INTO SELECT yêu cầu các kiểu dữ liệu trong bảng nguồn và bảng đích phải khớp
	Các bản ghi hiện có trong bảng đích không bị ảnh hưởng
	-- Cú pháp:
		Sao chép tất cả các cột từ bảng này sang bảng khác:
			INSERT INTO table2
			SELECT * FROM table1
			WHERE condition;
		Chỉ sao chép một số cột từ một bảng sang một bảng khác:
			INSERT INTO table2 (column1, column2, column3, ...)
			SELECT column1, column2, column3, ...
			FROM table1
			WHERE condition;
*/

/*
	CÂU LỆNH 3.7: SQL UPDATE 
	Câu lệnh UPDATE được sử dụng để sửa đổi các bản ghi hiện có trong bảng.	
	-- Cú pháp:
		UPDATE table_name
		SET column1 = value1, column2 = value2, ...
		WHERE condition;
*/
SELECT * FROM NHANVIEN
UPDATE NhanVien
SET Ten = N'Long',GioiTinh =N'Nữ'--Khi update hoặc delete nếu không có điều kiện thì nó sẽ set hết giá trị tất cả các bản ghi tại cột chỉ định.
WHERE Ma = NV13--0928147333
-- Khi đã sử dụng điều kiện tùy tình huống bài toán thì đưa điều kiện hợp lý.
