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
CREATE TABLE `Account` (
    AccountID MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Email VARCHAR(50) UNIQUE KEY NOT NULL,
    Username CHAR(10) UNIQUE KEY NOT NULL CHECK (LENGTH(Username) >= 6),
    Fullname VARCHAR(50) NOT NULL,
    DepartmentID SMALLINT UNSIGNED,
		-- FOREIGN KEY (DepartmentID)	REFERENCES Department (DepartmentID),
    PositionID SMALLINT UNSIGNED,
		-- FOREIGN KEY (PositionID)	REFERENCES `Position` (PositionID),
    CreateDate DATE NOT NULL
);
-- ---------------------------------------TẠO BẢNG GROUP--------------------------------------------
DROP TABLE IF EXISTS 				`Group`;
CREATE TABLE  						`Group`(
	GroupID							MEDIUMINT UNSIGNED PRIMARY KEY auto_increment,
    GroupName						VARCHAR(50) UNIQUE KEY NOT NULL ,
    CreatorID						MEDIUMINT UNSIGNED ,
		-- FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID),
    CreateDate						DATETIME NOT NULL
);
-- -----------------------------------------TẠO BẢNG GROUPACCOUNT-------------------------------------
DROP TABLE IF EXISTS 				GroupAccount;
CREATE TABLE  						GroupAccount(
	GroupID							MEDIUMINT UNSIGNED  ,
		  -- FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID),
    AccountID						MEDIUMINT UNSIGNED,
		-- FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID),
    JoinDate						DATETIME
);
-- -----------------------------------------TẠO BẢNG TYPEQUESTION-------------------------------------
DROP TABLE IF EXISTS 				TypeQuestion;
CREATE TABLE  						TypeQuestion(
	TypeID							SMALLINT UNSIGNED PRIMARY KEY ,
    TypeName						ENUM('Tự luận ','Trắc nghiệm ')
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
	QuestionID						SMALLINT UNSIGNED PRIMARY KEY auto_increment ,
    Content							VARCHAR(100)  NULL,
    CategoryID						SMALLINT UNSIGNED,
		-- FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
    TypeID							SMALLINT UNSIGNED,
		-- FOREIGN KEY (TypeID) REFERENCES TypeQuestion(TypeID),
    CreatorID						MEDIUMINT UNSIGNED,
		-- FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID),
    CreateDate						DATETIME 
);
-- --------------------------------------------------TẠO BẢNG ANSWER------------------------------------
DROP TABLE IF EXISTS 				Answer;
CREATE TABLE  						Answer(
	AnswerID						SMALLINT UNSIGNED UNIQUE KEY NOT NULL auto_increment ,
    Content							VARCHAR(500) NULL ,
    QuestionID						SMALLINT UNSIGNED,
		-- FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID),
    isCorrect						ENUM('Right','Wrong') NOT NULL
);
-- --------------------------------------------------TẠO BẢNG EXAM------------------------------------
DROP TABLE IF EXISTS 				Exam;
CREATE TABLE  						Exam(
	ExamID							SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT ,
    Codee							VARCHAR(15) UNIQUE KEY NOT NULL ,
    Title							VARCHAR(20) NOT NULL,
    CategoryID						SMALLINT UNSIGNED,
		-- FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
    Duration						TIME NOT NULL,
    CreatorID						MEDIUMINT UNSIGNED,
		-- FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID),
    CreateDate						DATE
);
-- -----------------------------------------------------TẠO BẢNG EXAMQUESTION-------------------------
DROP TABLE IF EXISTS 				ExamQuestion;
CREATE TABLE  						ExamQuestion(
	ExamID							SMALLINT UNSIGNED,
		-- FOREIGN KEY (ExamID) REFERENCES Exam(ExamID),
    QuestionID						SMALLINT UNSIGNED
		-- FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
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
DELETE FROM  Department;
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
-- SELECT * FROM  Department;
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
            ('tien1234@gmail.com','tien1234','Hoàng văn ngọc','8','8','2018-07-09'),
            ('tien1235@gmail.com','tien1235','Hoàng văn trường','8','8','2018-07-09'),
            ('tien1236@gmail.com','tien1236','Hoàng văn mến','8','8','2018-07-09'),
            ('tien1237@gmail.com','tien1237','Hoàng văn đức','8','8','2018-07-09'),
            ('tien1238@gmail.com','tien1238','Hoàng văn anh','8','8','2018-07-09'),
            ('tien1239@gmail.com','tien1239','Hoàng văn tuân','8','8','2018-07-09');
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
            (6,'Nhóm thanh tra ','1','2019-01-01'),
            (7,'grouptest','1','2019-01-01'),
            (8,'grouptest1','1','2019-01-01'),
            (9,'grouptest2','1','2019-01-01');
-- SELECT * FROM `Group`;
-- ========================================ADD DATA FOR TABLE GroupAccount==============================================
DELETE FROM GroupAccount;
INSERT INTO GroupAccount(groupID,AccountID, JoinDate)
VALUES 
			(1,'1', '2018-07-09'),
            (2,'2', '2018-07-10'),
            (3,'3', '2018-07-11'),
            (4,'4','2018-07-15'),
            (5,'5','2018-07-20'),
            (6,'6','2018-07-12'),
            (7,'7','2019-01-01'),
            (7,'8','2019-01-01'),
            (6,'9','2019-01-02'),
            (2,'9','2019-01-02');
INSERT INTO GroupAccount(groupID)
values  ('8');
INSERT INTO GroupAccount(groupID)
values  ('9');

SELECT * FROM GroupAccount;
-- =================================================ADD DATA FOR TABLE TYPEQUESTION================================================
DELETE FROM TypeQuestion;
INSERT INTO TypeQuestion (TypeID, TypeName)
VALUES  
			(1, 	'Tự luận'),
            (2, 'Trắc nghiệm');
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
INSERT INTO Question(Content, CategoryID, TypeID, CreatorID, CreateDate)
VALUES 
			('Câu hỏi về Java','1','1','3','2021-07-31'),
            ('Câu hỏi về .NET','2','2','4','2021-07-31'),
            ('Câu hỏi về SQL','3','1','3','2021-07-31'),
            ('Câu hỏi về Postman','4','2','4','2021-07-31'),
            ('Câu hỏi về toán','5','1','3','2021-07-31'),
            ('Câu hỏi về lý','6','2','4','2021-07-31'),
            ('Câu hỏi về hóa','7','1','3','2021-07-31'),
            ('Câu hỏi về văn','8','2','4','2021-07-31'),
            ('Câu hỏi về sử','9','1','3','2021-07-31'),
            ('Câu hỏi về địa','10','2','4','2021-07-31'),
            ('Câu hỏi về địa','10','2','4','2021-07-31'),
            ('Câu hỏi về địa','10','2','4','2021-07-31'),
            ('Câu hỏi về địa','10','2','4','2021-07-31');
            
-- SELECT * FROM Question;
-- ===========================================ADD DATA FOR TABLE ANSWER===========================
DELETE FROM Answer;
INSERT INTO Answer(Content, QuestionID, isCorrect)
VALUES 
			('đáp án Java','1','right'),
            ('đáp án Java','1','right'),
            ('đáp án Java','1','right'),
            ('đáp án Java','1','right'),
            ('đáp án Java','1','right'),
			
            ('đáp án hóa','7','right'),
            ('đáp án văn','8','right'),
            ('đáp án sử','9','right'),
            ('đáp án địa','10','right'),
            ('đáp án địa','11','right'),
            ('đáp án địa','12','right'),
            ('đáp án địa','13','right');
INSERT INTO Answer(QuestionID)
VALUES       (6);      
-- SELECT * FROM Answer;
-- ===============================================ADD DATA FOR TABLE Exam=============================
DELETE FROM Exam;
INSERT INTO Exam(Codee, Title, CategoryID, Duration, CreatorID, CreateDate)
VALUES 
			('000001',' Đề thi học phần 1','1','01:30:00','3','2021-07-20'),
            ('000002',' Đề thi học phần 2','2','00:45:00','4','2018-07-20'),
			('000003',' Đề thi học phần 3','3',' 01:30:00' , '3','2019-07-20'),
            ('000004',' Đề thi học phần 4','4', '02:00:00' , '4','2020-07-20'),
            ('000005',' Đề thi học phần 5','5', '00:30:00' , '3','2018-07-20'),
            ('000006',' Đề thi học phần 6','6','00:15:00' , '3','2021-07-20'),
            ('000007',' Đề thi học phần 6','6','00:15:00' , '3','2021-07-20'),
            ('000008',' Đề thi học phần 6','6','00:15:00' , '3','2021-07-20'),
            ('000009',' Đề thi học phần 6','6','00:15:00' , '3','2021-07-20');
-- SELECT * FROM Exam ;
-- ================================================ADD DATA FOR TABLE ExamQuestion==================================
DELETE FROM ExamQuestion;
INSERT INTO ExamQuestion(ExamID,QuestionID)
VALUES 
			(1,1),
            (2,2),
            (3,3),
            (4,4),
            (5,5),
            (6,6),
            (7,6),
            (8,6),
            (9,10),
            (10,7),
            (11,8),
            (12,9);
            
-- SELECT * FROM ExamQuestion;
-- ===================================================================================================================================================================================================
-- ====================================================================================Lệnh JOIN =====================================================================================================
-- ===================================================================================================================================================================================================
-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT 			AccountID,
				Fullname,
				department.DepartmentName,
				Department.DepartmentID
FROM 			`Account`
INNER JOIN 		Department
ON 				Department.DepartmentID = `Account`.DepartmentID
ORDER BY		AccountID ASC  ;

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
-- UPDATE  `Account` SET CreateDate = '2009-07-09' WHERE  AccountID=1;   Thay đổi Data xem lệnh có hoạt động đúng hay không .
-- UPDATE  `Account` SET CreateDate = '2018-07-09' WHERE  AccountID=1;

SELECT  		`Account`.AccountID,
				Email,
                Fullname,
                Username,
                Department.DepartmentId,
                Department.DepartmentName,
                `Position`.PositionID,
                `Position`.PositionName,
                Joindate AS 'Ngày vào nhóm' ,
                GroupAccount.GroupID, 
                `Account`.CreateDate AS 'Ngày Tạo Account'
FROM  			`Account`
INNER JOIN 		Department 		ON		Department.DepartmentId=`Account`.DepartmentId
INNER JOIN 		`Position`		ON		`Position`.PositionID=`Account`.PositionID
INNER JOIN 		GroupAccount	ON		GroupAccount.AccountID=`Account`.AccountID
WHERE 			`Account`.CreateDate > '2010-12-20';

-- Question 3: Viết lệnh để lấy ra tất cả các student 
SELECT			`Account`.AccountID,
				Email,
				Username,
				Fullname,
				Department.DepartmentID,
				Department.DepartmentName,
				`Position`.PositionID,
				`Position`.PositionName,
				CreateDate
From 			`Account`
INNER JOIN 		Department ON Department.DepartmentID= `Account`.DepartmentID
INNER JOIN 		`Position` ON `Position`.PositionID=`Account`.PositionID
Where 			`Position`.positionName = ' Student' OR  Department.departmentName='Học sinh sinh viên ';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên

SELECT 			Department.DepartmentName,
				count(`account`.DepartmentID) AS Số_lượng_nhân_viên ,
                `position`.PositionName
FROM 			`account` 
INNER JOIN 		department 
ON 				`Account`.DepartmentID = Department.DepartmentID
INNER JOIN  	`position` ON `position`.positionID=`Account`.positionID
GROUP BY 		`account`.DepartmentID
HAVING 			COUNT(`account`.DepartmentID) >=3;

-- QUestion5 Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
-- select * from examquestion; 
SELECT 			examquestion.questionID,
				question.content,
				COUNT(examquestion.questionID) AS Số_lượng_câu_hỏi
FROM			examquestion
INNER JOIN		question ON examquestion.questionID = question.questionID
GROUP BY 		examquestion.questionID
order by  		COUNT(examquestion.questionID) DESC
LIMIT 			1;

--  Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question

select * from categoryQuestion;
select * from Question; 

select  Categoryquestion.categoryname , count(question.content) AS Số_câu_hỏi_được_sử_dụng 
from categoryquestion
inner join  question
on  Categoryquestion.CategoryID=question.CategoryID 
group by Categoryquestion.categoryname;
  
  
-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
-- select * from question;
-- select * from examquestion;
-- select * from exam  ;
 select				examquestion.questionID,
					question.content,
					count(examquestion.examID) AS số_exam_có_câu_hỏi_này
 from  				examquestion
 inner join 		question 
 On 				question.questionId= examquestion.questionID
 group by			examquestion.questionID
 order by 			count(examquestion.examID) DESC 
 LIMIT 				1;
 -- select * from examquestion
 -- Question 8: Lấy ra Question có nhiều câu trả lời nhất
select 	answer.questionID,
		answer.content,
		count(answer.questionID) AS số_câu_trả_lời_cho_câu_hỏi_này
        
from answer
where  answer.content is not null 
group by answer.questionID;

-- Question 9: Thống kê số lượng account trong mỗi group 
select * from groupaccount;
select groupaccount.groupID,
		count(groupaccount.accountID) AS số_lượng_account_mỗi_group
from groupaccount
group by groupaccount.groupID;


-- Question 10: Tìm chức vụ có ít người nhất
select 				`position`.positionID,
					`position`.positionName, 
					 count(`account`.accountID) Số_người_thuộc_chức_vụ 
from 				`position`
inner join			`account` 
on   				`position`.positionID=  `account`.positionID
group by			 positionID
having 				 count(`account`.accountID)  <=1 ;

--  Question 11: Thống kê mỗi phòng ban có bao nhiêu GIÁM ĐỐc , Phó giám đốc, mentor , student ......
select 			`account`.departmentID,
				department.departmentName,
				count(`account`.departmentID)
from   			`account`
inner join 		department
on 				`account`.departmentID= department.departmentID
group by 		departmentName
order by 		departmentID ASC 
;
-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, … 
				

select question.questionID,
		Typequestion.TypeName AS Loại_câu_hỏi,
        `account`.FullName AS Người_tạo_câu_hỏi,
        answer.content AS Câu_trả_lời
from question 
inner join Typequestion on Typequestion.TypeID = question.TypeID
inner join `account` on `account`.accountID= question.creatorID
inner join answer on question.questionID= answer.questionID ;

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm

select  typequestion.typename as Loại_câu_hỏi,
		count(question.typeID) as Số_lượng
from question 
inner join typequestion on typequestion.typeID= question.typeID 
group by typequestion.typename; 

-- Question 14: Lấy ra group không có account nào 
-- cách 1 

select 		groupaccount.groupID,
			`group`.groupName,
            count(groupaccount.AccountID) AS số_thành_viên_là
from 		groupaccount
inner join 	`group` on `group`.groupID= `groupaccount`.groupID
group by groupaccount.groupID
having count(groupaccount.AccountID) =0;


-- Question 15: Lấy ra group không có account nào 

-- Question 16: Lấy ra question không có answer nào
select 		question.questionID,
			question.content,
			count(answer.content) AS CÂU_TRẢ_LỜI
from question 
inner join answer on answer.QuestionID= question.questionID 
group by questionID
having count(answer.content)=0 ;


-- Exercise 2: Union
-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
-- b) Lấy các account thuộc nhóm thứ 2
-- c) Ghép 2 kết quả từ câu (a) và câu (b) sao cho không có record nào trùng nhau
-- Câu a -----------------------------
select			`groupaccount`.GroupID, `account`.* 
from 			`groupaccount` 
inner join 		`account` on `groupaccount`.accountID= `account`.accountID
where 			`groupaccount`.groupID =1;
-- Câu b -----------------------------
select			`groupaccount`.GroupID, `account`.* 
from 			`groupaccount` 
inner join 		`account` on `groupaccount`.accountID= `account`.accountID
where 			`groupaccount`.groupID =2;
-- Câu c -----------------------------
select			`groupaccount`.GroupID, 
				`account`.* 
from 			`groupaccount` 
inner join 		`account` on `groupaccount`.accountID= `account`.accountID
where 			`groupaccount`.groupID =1
union DISTINCT
select			`groupaccount`.GroupID, `account`.* 
from 			`groupaccount` 
inner join		`account` on `groupaccount`.accountID= `account`.accountID
where 			`groupaccount`.groupID =2;

-- Question 18:
-- a) Lấy các group có lớn hơn 5 thành viên
-- b) Lấy các group có nhỏ hơn 7 thành viên
-- c) Ghép 2 kết quả từ câu a) và câu b) 

insert into groupaccount(groupID, accountID,joindate)
values ('2','11','2021-08-04'),
('2','12','2021-08-04'),
('2','13','2021-08-04'),
('2','14','2021-08-04'),
('2','15','2021-08-04');
select * from groupaccount;

-- câu a------------------
select * from groupaccount;
select  groupaccount.groupID,
		count(groupaccount.groupID) AS số_thành_viên
from groupaccount 
group by groupID
having count(groupaccount.groupID) > 5;
-- câu b --------------------------
select * from groupaccount;
select  groupaccount.groupID,
		count(groupaccount.groupID) AS số_thành_viên
from groupaccount 
group by groupID
having count(groupaccount.groupID) <7 ;
-- câu C ---------------------
select * from groupaccount;
select  groupaccount.groupID,
		count(groupaccount.groupID) AS số_thành_viên
from groupaccount 
group by groupID
having count(groupaccount.groupID) > 5
union 
select * from groupaccount;
select  groupaccount.groupID,
		count(groupaccount.groupID) AS số_thành_viên
from groupaccount 
group by groupID
having count(groupaccount.groupID) <7 

