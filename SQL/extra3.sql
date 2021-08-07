DROP DATABASE IF EXISTS Fresher_Training_Management;
CREATE DATABASE Fresher_Training_Management;
USE 			Fresher_Training_Management;



DROP TABLE IF EXISTS Trainee;
CREATE TABLE 			Trainee(  
TraineeID 				MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Fullname				VARCHAR(50) NOT NULL,
Birth_Date 				DATE NOT NULL,
Gender					ENUM('Male','Female','Unknown'),
IQ_Test 				TINYINT UNSIGNED NOT NULL CHECK(IQ_Test >=0 AND IQ_Test <= 20),
Gmath_Test 				TINYINT UNSIGNED NOT NULL CHECK(Gmath_Test >=0 AND IQ_Test <= 20),
English_Test			TINYINT UNSIGNED NOT NULL CHECK(English_Test >=0 AND IQ_Test <= 50),
Training_Class			CHAR(10) NOT NULL,
Evaluation_Note 		VARCHAR(500)
);

ALTER TABLE Trainee ADD VTI_Account VARCHAR(50)  UNIQUE KEY;

DROP TABLE IF EXISTS EX2;
CREATE TABLE EX2(
ID 						MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
`NAME`					VARCHAR(50),
`Code`					CHAR(5) CHECK (length(`code`)=5),
ModifiedDate 			DATETIME NOT NULL   
);

DROP TABLE IF EXISTS EX3;
CREATE TABLE 		EX3(
ID 						MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
`NAME`					VARCHAR(50),
Birthdate				DATE,
Gender					TINYINT UNSIGNED CHECK (Gender=0 Or gender=1),
IsDeletedFlag			ENUM('0','1')
);


-- --------------------------------------------------------------------------
-- Question 1: Thêm ít nhất 10 bản ghi vào table 
TRUNCATE trainee;
DELETE FROM Trainee ;
INSERT INTO `trainee` (`Fullname`, `Birth_Date`, `Gender`, `IQ_Test`,`Gmath_Test`,`English_Test`, `Training_Class`)
VALUES
						('Nguyễn Tiến Ngọc', '2000-01-01', 'male', '12', '12', '20', '1'),
						('Nguyễn Văn Việt Anh', '2000-03-02', 'male', '15', '15', '40', '1'),
						('Nguyễn Xuân Tùng', '2000-06-03', 'male', '14', '13', '33', '1'),
						('Nguyễn Văn Tuyến', '2000-03-04', 'male', '16', '15', '45', '1'),
						('Đào Bá Lộc', '2000-07-05', 'female', '18', '17', '39', '1'),
						('Nguyễn Viết Thắng', '2000-08-06', 'male', '20', '19', '27', '2'),
						('Nguyễn Quang Hải', '2000-08-08', 'male', '9', '7', '37', '2'),
						('Nguyễn Công Phượng', '2000-03-09', 'male', '5', '6', '46', '2'),
						('Nguyễn Công Vinh', '2000-01-10', 'male', '4', '8', '29', '2');
-- Question 2: Viết lệnh để lấy ra tất cả các thực tập sinh đã vượt qua bài test đầu vào, nhóm chúng thành các tháng sinh khác nhau

SELECT * FROM 			Trainee 
WHERE 					`IQ_Test` >=05 
AND 					`Gmath_Test`>=05 
AND 					`English_Test`>=15
GROUP BY 				Birth_Date;

-- Question 3: Viết lệnh để lấy ra thực tập sinh có tên dài nhất, lấy ra các thông tin sau:
-- tên, tuổi, các thông tin cơ bản (như đã được định nghĩa trong table)

SELECT 					Trainee.*,
						character_length(Fullname)  
FROM 					Trainee
WHERE 					character_length(Fullname)=(SELECT Max(character_length(Fullname)) FROM Trainee);

-- Question 4: Viết lệnh để lấy ra tất cả các thực tập sinh là ET, 1 ET thực tập sinh là
-- những người đã vượt qua bài test đầu vào và thỏa mãn số điểm như sau:
--  ET_IQ + ET_Gmath>=20
--  ET_IQ>=8
--  ET_Gmath>=8
--  ET_English>=18

SELECT 			Trainee.* FROM Trainee 
WHERE 			IQ_Test + Gmath_Test >=20 
	AND 		IQ_Test >=8 
    AND 		Gmath_Test >=8
    AND			English_Test >=18;
    
-- Question 5: xóa thực tập sinh có TraineeID = 3 

DELETE FROM 		Trainee 
WHERE 				TraineeID =3;
 
-- Question 6: Thực tập sinh có TraineeID = 5 được chuyển sang lớp "2". Hãy cập nhật
-- thông tin vào database
UPDATE 				Trainee 
SET 				Training_Class=2
WHERE 				TraineeID=5;















