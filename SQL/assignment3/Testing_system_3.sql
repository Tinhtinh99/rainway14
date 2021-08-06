-- ===================================================================================================================================================================================================
-- ====================================================================================CREATE DATABASE================================================================================================
-- ===================================================================================================================================================================================================
DROP DATABASE IF EXISTS 			Exammanagement2;
CREATE DATABASE  					Exammanagement2;
USE 								Exammanagement2;
-- -------------------------------------TẠO BẢNG DEPARMENT ----------------------------------------
DROP TABLE IF EXISTS 				Department;
CREATE TABLE 						Department(
	DepartmentID 					SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    DepartmentName 					VARCHAR(50) UNIQUE KEY NOT NULL   
);
 -- ------------------------------------TẠO BẢNG POSITION ------------------------------------------   
DROP TABLE IF EXISTS 				`Position`;
CREATE TABLE  						`Position`(
	PositionID						SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    PositionName 					VARCHAR(50) UNIQUE KEY NOT NULL 
);
-- ---------------------------------------TẠO BẢNG ACCOUNT---------------------------------------
DROP TABLE IF EXISTS 				`Account`;
CREATE TABLE 						`Account` (
    AccountID 						MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Email 							VARCHAR(50) UNIQUE KEY NOT NULL,
    Username 						CHAR(10) UNIQUE KEY NOT NULL CHECK (LENGTH(Username) >= 6),
    Fullname 						VARCHAR(50) NOT NULL,
    DepartmentID 					SMALLINT UNSIGNED,
    PositionID 						SMALLINT UNSIGNED,
		FOREIGN KEY (PositionID) REFERENCES `Position` (PositionID) ON DELETE CASCADE,
    CreateDate 						DATE NOT NULL
);
-- ---------------------------------------TẠO BẢNG GROUP--------------------------------------------
DROP TABLE IF EXISTS 				`Group`;
CREATE TABLE  						`Group`(
	GroupID							MEDIUMINT UNSIGNED PRIMARY KEY,
    GroupName						VARCHAR(50) UNIQUE KEY NOT NULL ,
    CreatorID						MEDIUMINT UNSIGNED ,
		FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID) ON DELETE CASCADE,
    CreateDate						DATE NOT NULL
);
-- UPDATE LẠI CREATEDATE  

-- -----------------------------------------TẠO BẢNG GROUPACCOUNT-------------------------------------
DROP TABLE IF EXISTS 				GroupAccount;
CREATE TABLE  						GroupAccount(
	GroupID							MEDIUMINT UNSIGNED,
		FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID) ON DELETE CASCADE,
    AccountID						MEDIUMINT UNSIGNED, 
		FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID) ON DELETE CASCADE,
    JoinDate						DATETIME
);
-- -----------------------------------------TẠO BẢNG TYPEQUESTION-------------------------------------
DROP TABLE IF EXISTS 				TypeQuestion;
CREATE TABLE  						TypeQuestion(
	TypeID							SMALLINT UNSIGNED PRIMARY KEY ,
    TypeName						ENUM('Essay','Multiple-Choice')
);
-- ------------------------------------------TẠO BẢNG CATEGORYQUESTION------------------------------
DROP TABLE IF EXISTS 				CategoryQuestion;
CREATE TABLE  						CategoryQuestion(
	CategoryID						SMALLINT UNSIGNED PRIMARY KEY ,
    CategoryName					VARCHAR(50) UNIQUE KEY NOT NULL 
);
-- -------------------------------------------------TẠO BẢNG QUESTION--------------------------------
DROP TABLE IF EXISTS 				Question;
CREATE TABLE  						Question(
	QuestionID						SMALLINT UNSIGNED PRIMARY KEY ,
    Content							VARCHAR(100) UNIQUE KEY NOT NULL,
    CategoryID						SMALLINT UNSIGNED,
		FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID) ON DELETE CASCADE,
    TypeID							SMALLINT UNSIGNED,
		FOREIGN KEY (TypeID) REFERENCES TypeQuestion(TypeID) ON DELETE CASCADE,
    CreatorID						MEDIUMINT UNSIGNED,
		FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID) ON DELETE CASCADE,
    CreateDate						DATETIME 
);
-- --------------------------------------------------TẠO BẢNG ANSWER------------------------------------
DROP TABLE IF EXISTS 				Answer;
CREATE TABLE  						Answer(
	AnswerID						SMALLINT UNSIGNED UNIQUE KEY NOT NULL,
    Content							VARCHAR(500) UNIQUE KEY NOT NULL ,
    QuestionID						SMALLINT UNSIGNED,
		FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID) ON DELETE CASCADE,
    isCorrect						ENUM('Right','Wrong') NOT NULL
);
-- --------------------------------------------------TẠO BẢNG EXAM------------------------------------
DROP TABLE IF EXISTS 				Exam;
CREATE TABLE  						Exam(
	ExamID							SMALLINT UNSIGNED PRIMARY KEY ,
    `Code`							VARCHAR(15) UNIQUE KEY NOT NULL ,
    Title							VARCHAR(20) NOT NULL,
    CategoryID						SMALLINT UNSIGNED,
		FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID) ON DELETE CASCADE,
    Duration						TIME NOT NULL,
    CreatorID						MEDIUMINT UNSIGNED,
		FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID) ON DELETE CASCADE,
    CreateDate						DATE
);
-- -----------------------------------------------------TẠO BẢNG EXAMQUESTION-------------------------
DROP TABLE IF EXISTS 				ExamQuestion;
CREATE TABLE  						ExamQuestion(
	ExamID							SMALLINT UNSIGNED,
		 FOREIGN KEY (ExamID) REFERENCES Exam(ExamID) ON DELETE CASCADE,
    QuestionID						SMALLINT UNSIGNED,
		FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID) ON DELETE CASCADE 
);
-- ALTER TABLE examquestion
-- DROP FOREIGN KEY `examquestion_ibfk_1`;
-- ALTER TABLE examquestion 
-- DROP INDEX `ExamID` ;
-- ===================================================================================================================================================================================================
-- ====================================================================================ADD DATA FOR TESTING_SYSTEM====================================================================================
-- ===================================================================================================================================================================================================
-- ==================================ADD DATA FOR DEPARTMENT ====================================================================================
SET SQL_SAFE_UPDATES = 0;
DELETE FROM Department;
INSERT INTO  Department( DepartmentName) 
VALUES 	
			( 		N'Trưởng TT'			),
            (		N'Phó TT'				),
            ( 		N'Trưởng bộ môn'		),
            ( 		N'Phó bộ môn'			),
            (		N'Văn Thư'				),
            (		N'Kế Toán'				),
            (		N'Học sinh sinh viên'	),
            (		N'Bảo vệ '				),
            (		N'Phòng ăn'				),
            (		N'Vệ sinh'				);
SELECT * FROM  Department;
-- ======================================ADD DATA FOR Posiition======================================================================================

DELETE FROM `Position`;
INSERT INTO `Position`(PositionName)
VALUES 		
			(	N'Giám đốc'		),
            ( 	N'Phó giám đốc'	),
            ( 	N'Mentor'		),
            ( 	N'Trợ giảng'	),
            ( 	N'NV văn thư'	),
            ( 	N'NV kế toán'	),
            (	N'student'		),
            (	N'NV Bảo vệ'	),
            (	N'Đầu bếp'		),
            (	N'Lao công '	);
-- SELECT * FROM `Position`;
-- ============================================ADD DATA FOR Accountt====================================================
DELETE FROM `Account` ;
INSERT INTO `Account`(Email, Username, Fullname, DepartmentID, PositionID, CreateDate)
VALUES 			
			('nvva0907@gmail.com','nvva0907','Nguyễn văn việt anh', '1','1','2018-07-09'),
            ('tung1234@gmail.com','tung1234','Dương Do','2','2','2018-07-10'),
            ('hoang1234@gmail.com','hoang1234','Nguyễn Minh Hoàng',3,3,'2018-07-11'),
            ('ngoc1234&gmail.com','ngoc1234','Nguyễn Tiến Ngọc',4,4,'2018-07-15'),
            ('hiep1234@gmail.com','hiep1234','Hoàng Mạnh Hiệp',5,5,'2018-07-20'),
            ('quat1234@gmail.com','quat1234','Thái Duy Quát',6,6,'2018-07-12'),
            ('hieu1234@gmail.com','hieu1234','Đỗ Minh Hiếu',7,7,'2019-01-01'),
            ('dat1234@gmail.com','dat1234','Nguyễn Quang Đạt',7,7,'2019-01-01'),
            ('truong1234@gmail.com','truong1234','Phan Văn Trường',7,7,'2019-01-02'),
            ('tien1234@gmail.com','tien1234','Hoàng văn tiến','8','8','2018-07-09');
-- SELECT * FROM `Account`;
-- ====================================ADD DATA FOR TABLE GROUP============================================================
DELETE FROM `Group`;
INSERT INTO `Group`(GroupID, GroupName, CreatorID, CreateDate)
VALUES 
			(1, ' Nhóm giám hiệu ', 1, '2018-07-07'),
            (2, ' Nhóm Giáo Dục ' ,1,'2018-07-09'),
            (3, ' Nhóm thư ký ',1,'2018-07-10'),
            (4, ' Nhóm HSSV',1,'2019-01-01'),
            (5, ' Nhóm bảo vệ ','1','2019-01-01'),
            (6,'Nhóm thanh tra ','1','2019-01-01');
-- SELECT * FROM `Group`;
-- ========================================ADD DATA FOR TABLE GroupAccount==============================================
DELETE FROM GroupAccount;
INSERT INTO GroupAccount(GroupID, AccountID, JoinDate)
VALUES 
			('1','1', '2018-07-09'),
            ('1','2', '2018-07-10'),
            ('2','3', '2018-07-11'),
            ('2','4','2018-07-15'),
            ('3','5','2018-07-20'),
            ('3','6','2018-07-12'),
            ('4','7','2019-01-01'),
            ('4','8','2019-01-01'),
            ('4','9','2019-01-02');
        
-- SELECT * FROM GroupAccount;
-- =================================================ADD DATA FOR TABLE TYPEQUESTION================================================
DELETE FROM TypeQuestion;
INSERT INTO TypeQuestion (TypeID, TypeName)
VALUES  
			(1, 	'Essay'),
            (2, 'Multiple-Choice');
-- SELECT * FROM TypeQuestion;
-- =================================================Category Question========================================================
DELETE FROM CategoryQuestion;
INSERT INTO CategoryQuestion(CategoryID, CategoryName)
VALUES 		
			(1, 'Java'),
            (2, ' .NET'),
            (3, 'SQL'),
            (4, 'Postman'),
            (5,'toán'),
            (6,'lý'),
            (7,'hóa'),
            (8,'văn'),
            (9,'sử'),
            (10,'địa');
-- SELECT * FROM CategoryQuestion;
-- ============================================ADD DATA FROM Question=======================
DELETE FROM Question;
INSERT INTO Question(QuestionID, Content, CategoryID, TypeID, CreatorID, CreateDate)
VALUES 
			(1, 'Câu hỏi về Java','1','1','3','2021-07-31'),
            (2, 'Câu hỏi về .NET','2','2','4','2021-07-31'),
            (3, 'Câu hỏi về SQL','3','1','3','2021-07-31'),
            (4, 'Câu hỏi về Postman','4','2','4','2021-07-31'),
            (5,'Câu hỏi về toán','5','1','3','2021-07-31'),
            (6,'Câu hỏi về lý','6','2','4','2021-07-31'),
            (7,'Câu hỏi về hóa','7','1','3','2021-07-31'),
            (8,'Câu hỏi về văn','8','2','4','2021-07-31'),
            (9,'Câu hỏi về sử','9','1','3','2021-07-31'),
            (10,'Câu hỏi về địa','10','2','4','2021-07-31');
INSERT INTO `exammanagement2`.`Question` (`QuestionID`, `Content`, `CategoryID`, `TypeID`, `CreatorID`, `CreateDate`) VALUES ('11', 'địa lý 1', '10', '2', '4', '2021-07-31');

-- SELECT * FROM Question;
-- ===========================================ADD DATA FOR TABLE ANSWER===========================
DELETE FROM Answer;
INSERT INTO Answer(AnswerID, Content, QuestionID, isCorrect)
VALUES 
			(1, 'đáp án Java1','1','right'),
            (2, 'đáp án Java2','1','right'),
            (3, 'đáp án Java3','1','right'),
            (4, 'đáp án Java4','1','right'),
            (5, 'đáp án Java5','1','right'),
            (6, 'đáp án lý','6','right'),
            (7, 'đáp án hóa','7','right'),
            (8, 'đáp án văn','8','right'),
            (9, 'đáp án sử','9','right'),
            (10,'đáp án địa','10','right');
            
-- SELECT * FROM Answer;
-- ===============================================ADD DATA FOR TABLE Exam=============================
DELETE FROM Exam;
INSERT INTO Exam(ExamID, `Code`, Title, CategoryID, Duration, CreatorID, CreateDate)
VALUES 
			(1, '000001',' Đề thi học phần 1','1','01:30:00', '3','2021-07-20'),
            (2, '000002',' Đề thi học phần 2','2', '00:45:00' , '4','2018-07-20'),
			(3, '000003',' Đề thi học phần 3','3',' 01:30:00' , '3','2019-07-20'),
            (4, '000004',' Đề thi học phần 4','4', '02:00:00' , '4','2020-07-20'),
            (5, '000005',' Đề thi học phần 5','5', '00:30:00' , '3','2018-07-20'),
            (6, '000006',' Đề thi học phần 6','6','00:15:00' , '3','2021-07-20');
-- SELECT * FROM Exam ;
-- ================================================ADD DATA FOR TABLE ExamQuestion==================================
DELETE FROM ExamQuestion;
INSERT INTO ExamQuestion(ExamID, QuestionID)
VALUES 
			(1,1),
            (2,2),
            (3,3),
            (4,4),
            (5,5),
            (6,6);
-- SELECT * FROM ExamQuestion;
-- ===================================================================================================================================================================================================
-- ====================================================================================QUERY DATA TESTING_SYSTEM====================================================================================
-- ===================================================================================================================================================================================================
-- Question 2: lấy ra tất cả các phòng ban
SELECT * FROM  	Department
order by DepartmentID ASC ;

-- Question 3: lấy ra id của phòng ban "Trưởng bộ môn "
SELECT 			DepartmentID 
FROM			Department 
WHERE			DepartmentName ='Trưởng bộ môn';

-- Question 4: lấy ra thông tin account có full name dài nhất
-- cách 1 sử dụng hàm max
SELECT 			*, 
				character_length(fullname) AS 'Độ_dài_full_name' FROM `Account`
WHERE 			character_length(Fullname)=(SELECT MAX(character_length(Fullname)) FROM `Account`);
-- cách 2 dùng order by kết hợp với limit
SELECT 			Fullname AS 'Ten', 
				character_length(fullname) AS 'Độ_dài_full_name' 
FROM 			`account` 
ORDER BY 		character_length(fullname) DESC 
LIMIT 			1 ;

--  Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
-- Cách 1 dùng lệnh With...AS
With 				Fullname_max_and_DepartmenID_là_3 										-- giả lập một bảng đã có sẵn một thuộc tính với câu lệnh
AS					(SELECT * FROM `Account` WHERE DepartmentID = '3')       				-- WITH....ABC....AS.....Điều kiện 1 
SELECT * FROM 		Fullname_max_and_DepartmenID_là_3			  							-- và xem ABC như là một bảng đã có sẵn , mình chỉ cần thêm điều kiện còn lại 
WHERE				character_length(Fullname)= (SELECT max(character_length(Fullname)) FROM Fullname_max_and_DepartmenID_là_3 ) ;
-- Cách 2 
INSERT INTO  `account` VALUES (11,'thuong1234@gmail.com','thuong1234','Nguyễn Hoàng Hoài THương','3','3','2018-07-11');
SELECT  			*,
					character_length(fullname) AS 'Độ_dài_fullname' 
FROM 				`account` 
WHERE 				DepartmentID = '3'
ORDER BY  			character_length(fullname) DESC
Limit 				1;

-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT * FROM  		`group`
WHERE				 CreateDate < '2019-12-20';

-- Question 7: Lấy ra ID của question có >= 4 câu trả lời
SELECT * FROM  	answer;
SELECT 			answer.QuestionID,
				count(answer.QuestionID) AS số_câu_trả_lời_cho_câu_hỏi   
FROM 			Answer 
GROUP BY  		QuestionID
HAVING 			count(answer.QuestionID) >= 4 ;


-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
-- CÁCH 1 DÙNG WITH AS 
WITH  				QS8 
AS 					( SELECT `code`, CreateDATE, Duration  FROM Exam WHERE Duration >= '01:00:00' )
SELECT * FROM 		QS8  
WHERE				CreateDate < '2019-12-20';
-- CÁCH 2 


-- Question 9: Lấy ra 5 group được tạo gần đây nhất
SELECT * FROM 		`Group`
ORDER BY 			 CreateDate DESC
LIMIT  				5 ;

-- Question 10: Đếm số nhân viên thuộc department có id = 2
SELECT COUNT(*) FROM `account`
WHERE departmentID = 2 ;

-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT * FROM `account`
WHERE FullName LIKE 'D%o' ;

-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
SELECT * FROM Exam;
DELETE FROM  Exam 
WHERE CreateDate <'2019-12-20';

-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
-- SELECT * FROM Question 
DELETE FROM question WHERE Content LIKE 'câu hỏi%';

-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
SELECT * FROM `Account`;
UPDATE `Account` SET Fullname='Nguyễn Bá Lộc' , Email='loc.nguyenba@vti.com.vn'
WHERE AccountID=5;

-- Question 15 : update account có id = 5 sẽ thuộc group có id = 4
UPDATE GroupAccount SET GroupID=4
WHERE AccountID=5;