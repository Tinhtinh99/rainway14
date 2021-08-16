DROP DATABASE IF EXISTS 	ThucTap;
CREATE DATABASE 			ThucTap;
USE							ThucTap;

DROP TABLE IF EXISTS GIANG_VIEN;
CREATE TABLE GIANG_VIEN(
MaGv			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
HoTen			VARCHAR(50) NOT NULL,
Luong			MEDIUMINT UNSIGNED);

DROP TABLE IF EXISTS SINH_VIEN;
CREATE TABLE SINH_VIEN(
MaSv			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
HoTen			VARCHAR(50) NOT NULL,
NamSinh			INT NOT NULL,
QueQuan			VARCHAR(100));

DROP TABLE IF EXISTS DE_TAI;
CREATE TABLE DE_TAI(
MaDt			TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
TenDt			VARCHAR(50) NOT NULL,
Kinhphi			MEDIUMINT UNSIGNED NOT NULL,
NoiThucTap		VARCHAR(100));

DROP TABLE IF EXISTS Huong_Dan;
CREATE TABLE Huong_Dan(
ID				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
MaSv			TINYINT UNSIGNED,  
CONSTRAINT fk_masv FOREIGN KEY(MaSv)  REFERENCES SINH_VIEN(MaSv) ON DELETE CASCADE ON UPDATE CASCADE,
MaDt			TINYINT UNSIGNED, 
CONSTRAINT fk_madt FOREIGN KEY(MaDt)  REFERENCES DE_TAI(MaDt) ON DELETE CASCADE ON UPDATE CASCADE,
MaGv			TINYINT UNSIGNED,  
CONSTRAINT fk_magv FOREIGN KEY(MaGv)  REFERENCES GIANG_VIEN(MaGv) ON DELETE CASCADE ON UPDATE CASCADE,
Ketqua			VARCHAR(100)
);

-- ==========================================================================INSERT DATA ================================================================================
-- INSERT BẢNG GIAO VIEN 
DELETE FROM GIANG_VIEN;
INSERT INTO `thuctap`.`giang_vien` (`MaGv`, `HoTen`, `Luong`) VALUES ('1', 'Nguyễn VIệt ANh ', '5000000');
INSERT INTO `thuctap`.`giang_vien` (`MaGv`, `HoTen`, `Luong`) VALUES ('2', 'Nguyễn Tiến Ngọc', '3000000');
INSERT INTO `thuctap`.`giang_vien` (`MaGv`, `HoTen`, `Luong`) VALUES ('3', 'Nguyễn Xuân Tùng', '4000000');
-- INSERT BẢNG sinh vien 
DELETE FROM SINH_VIEN;
INSERT INTO `thuctap`.`sinh_vien` (`MaSv`, `HoTen`, `NamSinh`, `QueQuan`) VALUES ('1', 'Nguyễn mạnh', '2000', 'nghệ an ');
INSERT INTO `thuctap`.`sinh_vien` (`MaSv`, `HoTen`, `NamSinh`, `QueQuan`) VALUES ('2', 'Nguyễn Tùng', '1999', 'hà nội');
INSERT INTO `thuctap`.`sinh_vien` (`MaSv`, `HoTen`, `NamSinh`, `QueQuan`) VALUES ('3', 'Nguyễn Cường', '2001', 'TP.HCM');
INSERT INTO `thuctap`.`sinh_vien` (`MaSv`, `HoTen`, `NamSinh`, `QueQuan`) VALUES ('4', 'nguyễn Xuân', '2000', 'HUế');
INSERT INTO `thuctap`.`sinh_vien` (`MaSv`, `HoTen`, `NamSinh`, `QueQuan`) VALUES ('5', 'Nguyễn Quân ', '2000', 'lào cai');
INSERT INTO `thuctap`.`sinh_vien` (`MaSv`, `HoTen`, `NamSinh`, `QueQuan`) VALUES ('6', 'Nguyễn Xuyến', '1995', 'huế');

-- INSERT DE tai 
DELETE FROM DE_TAI;
INSERT INTO `thuctap`.`de_tai` (`MaDt`, `TenDt`, `Kinhphi`, `NoiThucTap`) VALUES ('1', 'Cối xoay gió', '1000000', 'Cầu giấy');
INSERT INTO `thuctap`.`de_tai` (`MaDt`, `TenDt`, `Kinhphi`, `NoiThucTap`) VALUES ('2', 'Pin mặt trời', '1500000', 'Cầu giấy');
INSERT INTO `thuctap`.`de_tai` (`MaDt`, `TenDt`, `Kinhphi`, `NoiThucTap`) VALUES ('3', 'CONG NGHE SINH HOC', '900000', 'Cầu giấy');
INSERT INTO `thuctap`.`de_tai` (`MaDt`, `TenDt`, `Kinhphi`, `NoiThucTap`) VALUES ('4', 'Thủy Điện ', '5000000', 'Hòa Bình ');

-- INSERT HD 
DELETE FROM   HUONG_DAN;
INSERT INTO `thuctap`.`huong_dan` (`ID`, `MaSv`, `MaDt`, `MaGv`, `Ketqua`) VALUES ('1', '1', '1', '3', 'Thành công');
INSERT INTO `thuctap`.`huong_dan` (`ID`, `MaSv`, `MaDt`, `MaGv`, `Ketqua`) VALUES ('2', '2', '2', '2', 'Thành công');
INSERT INTO `thuctap`.`huong_dan` (`ID`, `MaSv`, `MaDt`, `MaGv`, `Ketqua`) VALUES ('3', '3', '3', '1', 'Thành công');
INSERT INTO `thuctap`.`huong_dan` (`ID`, `MaSv`, `MaDt`, `MaGv`, `Ketqua`) VALUES ('4', '6', '3', '2', 'Thành công');
INSERT INTO `thuctap`.`huong_dan` (`ID`, `MaSv`, `MaDt`, `MaGv`, `Ketqua`) VALUES ('5', '2', '1', '2', 'Thành công');


-- =======================================================================LỆNH=======================================================================================
/*2. Viết lệnh để
a) Lấy tất cả các sinh viên chưa có đề tài hướng dẫn
b) Lấy ra số sinh viên làm đề tài ‘CONG NGHE SINH HOC’*/

-- a)
SELECT s.MaSv,s.HoTen  
FROM huong_dan hd
RIGHT JOIN sinh_vien s USING(MaSv)
WHERE hd.MaDt IS NULL ;
-- b)
SELECT COUNT(hd.MaSv) as `Số_lượng_sinh_viên`
FROM huong_dan hd
JOIN de_tai dt USING(MaDt)
WHERE dt.TenDt ='CONG NGHE SINH HOC'
GROUP BY MaDt;


/*3. Tạo view có tên là "SinhVienInfo" lấy các thông tin về học sinh bao gồm:
mã số, họ tên và tên đề tài
(Nếu sinh viên chưa có đề tài thì column tên đề tài sẽ in ra "Chưa có")*/
CREATE OR REPLACE VIEW 		`SINHVIENINFOR` AS 
						SELECT SV.MaSv,SV.Hoten,
						CASE 
							WHEN DT.TenDt Is Null Then 'Chưa có'
							ELSE DT.TenDt 
						END AS `Ten_De_Tai`
						FROM Huong_dan HD
						RIGHT JOIN de_tai DT  USING(MaDt)
						RIGHT JOIN Sinh_vien SV USING(MaSv);
                        
SELECT * FROM `SINHVIENINFOR`;


-- Question 4: Tạo trigger cho table SinhVien khi insert sinh viên có năm sinh <= 1900
-- thì hiện ra thông báo "năm sinh phải > 1900
DROP TRIGGER IF EXISTS trig_insert_sv;
DELIMITER $$
CREATE TRIGGER trig_insert_sv
BEFORE INSERT ON Sinh_Vien
FOR EACH ROW
BEGIN
		IF NEW.NamSinh <= '1900'
		THEN 
				SIGNAL SQLSTATE '12345'
                SET MESSAGE_TEXT='Năm sinh phải lớn hơn 1900';
			END IF;
END $$;
DELIMITER ; 
SELECT * FROM Sinh_vien;
INSERT INTO `thuctap`.`sinh_vien` (`MaSv`, `HoTen`, `NamSinh`, `QueQuan`) VALUES ('7', 'Hoàng Hoài Thương ', '1800', 'Cao bằng ');


-- QUESTION 5 : Hãy cấu hình table sao cho khi xóa 1 sinh viên nào đó thì tất cả thông
-- tin trong table HuongDan liên quan tới sinh viên đó sẽ bị xóa đi
DROP TRIGGER IF EXISTS trig_DELETE_SV;
DELIMITER $$
CREATE TRIGGER trig_DELETE_SV
AFTER DELETE ON Sinh_Vien
FOR EACH ROW
BEGIN
        DELETE FROM Huong_dan Where Huong_dan.Masv = Old.Masv;
END $$ ;
DELIMITER ; 

SELECT * FROM huong_dan;
BEGIN WORK;
DELETE FROM Sinh_vien Where MaSv=6;
ROLLbACK;












