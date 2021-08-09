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
		 -- FOREIGN KEY (DepartmentID)	REFERENCES Department (DepartmentID) ON DELETE CASCADE ON UPDATE CASCADE,
    PositionID 						SMALLINT UNSIGNED,
		 -- FOREIGN KEY (PositionID)	REFERENCES `Position` (PositionID) ON DELETE CASCADE ON UPDATE CASCADE,
    CreateDate						DATE NOT NULL
);
-- ---------------------------------------TẠO BẢNG GROUP--------------------------------------------
DROP TABLE IF EXISTS 				`Group`;
CREATE TABLE  						`Group`(
	GroupID							MEDIUMINT UNSIGNED PRIMARY KEY auto_increment,
    GroupName						VARCHAR(50) UNIQUE KEY NOT NULL ,
    CreatorID						MEDIUMINT UNSIGNED ,
		 -- FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID) ON DELETE CASCADE ON UPDATE CASCADE,
    CreateDate						DATETIME NOT NULL
);
-- -----------------------------------------TẠO BẢNG GROUPACCOUNT-------------------------------------
DROP TABLE IF EXISTS 				GroupAccount;
CREATE TABLE  						GroupAccount(
	GroupID							MEDIUMINT UNSIGNED  ,
		   -- FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID) ON DELETE CASCADE ON UPDATE CASCADE,
    AccountID						MEDIUMINT UNSIGNED,
		 -- FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID) ON DELETE CASCADE ON UPDATE CASCADE,
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
		 -- FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID) ON DELETE CASCADE ON UPDATE CASCADE,
    TypeID							SMALLINT UNSIGNED,
		-- FOREIGN KEY (TypeID) REFERENCES TypeQuestion(TypeID) ON DELETE CASCADE ON UPDATE CASCADE,
    CreatorID						MEDIUMINT UNSIGNED,
		 -- FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID) ON DELETE CASCADE ON UPDATE CASCADE,
    CreateDate						DATETIME 
);
-- --------------------------------------------------TẠO BẢNG ANSWER------------------------------------
DROP TABLE IF EXISTS 				Answer;
CREATE TABLE  						Answer(
	AnswerID						SMALLINT UNSIGNED UNIQUE KEY NOT NULL auto_increment ,
    Content							VARCHAR(500) NULL ,
    QuestionID						SMALLINT UNSIGNED,
		-- FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID) ON DELETE CASCADE ON UPDATE CASCADE,
    isCorrect						ENUM('Right','Wrong') NOT NULL
);
-- --------------------------------------------------TẠO BẢNG EXAM------------------------------------
DROP TABLE IF EXISTS 				Exam;
CREATE TABLE  						Exam(
	ExamID							SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT ,
    Codee							VARCHAR(15) UNIQUE KEY NOT NULL ,
    Title							VARCHAR(20) NOT NULL,
    CategoryID						SMALLINT UNSIGNED,
		-- FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID) ON DELETE CASCADE ON UPDATE CASCADE,
    Duration						TIME NOT NULL,
    CreatorID						MEDIUMINT UNSIGNED,
		-- FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID) ON DELETE CASCADE ON UPDATE CASCADE,
    CreateDate						DATE
);
-- -----------------------------------------------------TẠO BẢNG EXAMQUESTION-------------------------
DROP TABLE IF EXISTS 				ExamQuestion;
CREATE TABLE  						ExamQuestion(
	ExamID							SMALLINT UNSIGNED,
		-- FOREIGN KEY (ExamID) REFERENCES Exam(ExamID) ON DELETE CASCADE ON UPDATE CASCADE,
    QuestionID						SMALLINT UNSIGNED
		-- FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID) ON DELETE CASCADE ON UPDATE CASCADE
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
			('Trưởng TT'			),
            ('Phó TT'				),
            ('Trưởng bộ môn'		),
            ('Phó bộ môn'			),
            ('Văn Thư'				),
            ('Kế Toán'				),
            ('Học sinh sinh viên'	),
            ('Bảo vệ '				),
            ('Phòng ăn'				),
            ('Vệ sinh'				);
-- ======================================ADD DATA FOR Posiition======================================================================================

DELETE FROM `Position`;
INSERT INTO `Position`(PositionName)
VALUES 		
			('Giám đốc'		),
            ('Phó giám đốc'	),
            ('Mentor'		),
            ('Trợ giảng'	),
            ('NV văn thư'	),
            ('NV kế toán'	),
            ('student'		),
            ('NV Bảo vệ'	),
            ('Đầu bếp'		),
            ('Lao công'		),
            ('Ghi Chép'		);
-- ============================================ADD DATA FOR Accountt====================================================
TRUNCATE `Account`;
DELETE FROM `Account` ;
INSERT INTO `Account`(Email, Username, Fullname, DepartmentID, PositionID, CreateDate)
VALUES 			
			('nvva0907@gmail.com','nvva0907','Nguyễn văn việt anh', '1','1','2009-07-09'),
            ('tung1234@gmail.com','tung1234','Dương Do','2','2','2018-07-10'			),
            ('hoang1234@gmail.com','hoang1234','Nguyễn Minh Hoàng',3,3,'2018-07-11'		),
            ('ngoc1234&gmail.com','ngoc1234','Nguyễn Tiến Ngọc',4,4,'2018-07-15'		),
            ('hiep1234@gmail.com','hiep1234','Hoàng Mạnh Hiệp',5,5,'2018-07-20'			),
            ('quat1234@gmail.com','quat1234','Thái Duy Quát',8,8,'2018-07-12'			),
            ('hieu1234@gmail.com','hieu1234','Đỗ Minh Hiếu',7,7,'2019-01-01'			),
            ('dat1234@gmail.com','dat1234','Nguyễn Quang Đạt',7,7,'2019-01-01'			),
            ('truong1234@gmail.com','truong1234','Phan Văn Trường',7,7,'2019-01-02'		),
            ('tien1234@gmail.com','tien1234','Hoàng văn ngọc','7','7','2018-07-09'		),
            ('tien1235@gmail.com','tien1235','Hoàng văn trường','7','7','2018-07-09'	),
            ('tien1236@gmail.com','tien1236','Hoàng văn mến','8','8','2018-07-09'		),
            ('tien1237@gmail.com','tien1237','Hoàng văn đức','8','8','2018-07-09'		),
            ('tien1238@gmail.com','tien1238','Hoàng văn anh','8','8','2018-07-09'		),
            ('tien1239@gmail.com','tien1239','Hoàng văn tuân','8','8','2018-07-09'		);
-- ====================================ADD DATA FOR TABLE GROUP============================================================
DELETE FROM `Group`;
INSERT INTO `Group`(GroupID, GroupName, CreatorID, CreateDate)
VALUES 
			(1,'Nhóm giám hiệu', 1, '2018-07-07'	),
            (2,'Nhóm Giáo Dục' ,1,'2018-07-09'		),
            (3,'Nhóm thư ký',1,'2018-07-10'			),
            (4,'Nhóm HSSV',1,'2019-01-01'			),
            (5,'Nhóm bảo vệ','1','2019-01-01'		),
            (6,'Nhóm thanh tra','1','2019-01-01'	),
            (7,'grouptest','1','2019-01-01'			),
            (8,'grouptest1','1','2019-01-01'		),
            (9,'grouptest2','1','2019-01-01'		);
-- ========================================ADD DATA FOR TABLE GroupAccount==============================================
DELETE FROM GroupAccount;
INSERT INTO GroupAccount(groupID,AccountID, JoinDate)
VALUES 
			(1,'1', '2018-07-09'),
            (2,'2', '2018-07-10'),
            (3,'3', '2018-07-11'),
            (4,'4','2018-07-15'	),
            (5,'5','2018-07-20'	),
            (6,'6','2018-07-12'	),
            (7,'7','2019-01-01'	),
            (7,'8','2019-01-01'	),
            (6,'9','2019-01-02'	),
            (2,'10','2019-01-02'),
			(2,'11','2021-08-04'),
			(2,'12','2021-08-04'),
			(2,'13','2021-08-04'),
			(2,'14','2021-08-04'),
			(2,'15','2021-08-04');
-- =================================================ADD DATA FOR TABLE TYPEQUESTION================================================
DELETE FROM TypeQuestion;
INSERT INTO TypeQuestion (TypeID, TypeName)
VALUES  
			(1,'Tự luận'	),
            (2,'Trắc nghiệm');
-- =================================================Category Question========================================================
DELETE FROM CategoryQuestion;
INSERT INTO CategoryQuestion(CategoryID, CategoryName)
VALUES 		
			(1, 'Java'		),
            (2, ' .NET'		),
            (3, 'SQL'		),
            (4, 'Postman'	),
            (5,'toán'		),
            (6,'lý'			),
            (7,'hóa'		),
            (8,'văn'		),
            (9,'sử'			),
            (10,'địa'		),
			('11', 'Sinh học'),
			('12', 'Văn hóa');
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
-- ===========================================ADD DATA FOR TABLE ANSWER===========================
TRUNCATE Answer;
DELETE FROM Answer;
INSERT INTO Answer(Content, QuestionID, isCorrect)
VALUES 
			('đáp án Java','1','right'),
            ('đáp án Java1','1','right'),
            ('đáp án Java2','1','right'),
            ('đáp án Java3','1','right'),
            ('đáp án văn2','3','right'),
			('đáp án hóa','2','right'),
            ('đáp án văn','3','right'),
            ('đáp án sử','4','right'),
            ('đáp án địa','5','right'),
            ('đáp án địa1','6','right'),
            ('đáp án địa2','7','right'),
            ('đáp án địa3','8','right'),
            ('đáp án địa4','9','right'),
			('văn1', '3', 'right'),
			('văn4', '3', 'right'),
			('sử 2', '4', 'right'),
			('sử3', '4', 'right'),
			('sử4', '4', 'right');
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
            ('000009',' Đề thi học phần 6','6','00:15:00' , '3','2021-07-20'),
            ('000010',' Đề thi học phần 6','6','00:15:00' , '3','2021-07-20'),
            ('000011',' Đề thi học phần 6','6','00:15:00' , '3','2021-07-20'),
            ('000012',' Đề thi học phần 6','6','00:15:00' , '3','2021-07-20'),
			('000013',' Đề thi học phần 5','6','00:15:00' , '3','2021-07-20'),
			('000014',' Đề thi học phần 5','6','00:15:00' , '3','2021-07-20'),
			('000015',' Đề thi học phần 5','6','00:15:00' , '3','2021-07-20');
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
            (12,9),
            (13,9),
            (14,9);
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
SELECT  		`Account`.*,
				Department.DepartmentName,
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
SELECT			`Account`.*,
				`Position`.PositionName
FROM			`Account`
INNER JOIN 		`Position` ON `Position`.PositionID=`Account`.PositionID
WHERE 			`Position`.positionName = 'Student';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT 			Department.DepartmentName,
				count(`account`.DepartmentID) AS Số_lượng_nhân_viên 
FROM 			`account` 
INNER JOIN 		department 
ON 				`Account`.DepartmentID = Department.DepartmentID
GROUP BY 		`account`.DepartmentID
HAVING 			COUNT(`account`.DepartmentID) >=3;

-- Question5 Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT 				examquestion.questionID,
					COUNT(examquestion.questionID) AS SL,
                    Question.Content
FROM 				examquestion 
INNER JOIN 			Question ON Question.questionID=examquestion.questionID
GROUP BY 			examquestion.questionID
HAVING SL=			(Select count(examquestion.questionID) AS SL
					from Examquestion
					group by Examquestion.questionID 
					order by SL DESC 
					LIMIT 1);

-- liệt kê danh sách phòng ban có nhiều nhân viên nhất
SELECT 							`account`.departmentID,
								department.departmentName,
								Count(`account`.departmentID) AS SL_nhân_viên 
FROM 							`account`
INNER JOIN 						Department ON Department.DepartmentID=`Account`.DepartmentID 
GROUP BY 						`account`.departmentID
HAVING SL_nhân_viên = 			(SELECT Count(`account`.departmentID) AS SL_nhân_viên
								FROM 	`account`
								GROUP BY  `account`.departmentID
								ORDER BY  SL_nhân_viên DESC
								LIMIT 1);
                                
                                
--  Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question

-- cách 1 dùng right join 
SELECT CQ.categoryID, CQ.categoryName,count(Q.categoryID) AS `Sl`
from question Q RIGHT JOIN categoryQuestion CQ ON CQ.categoryID=Q.categoryID
Group BY ( CQ.categoryID);


-- cách 2 dùng left join 
SELECT CQ.categoryID, CQ.categoryName,count(Q.categoryID) AS `Sl`
from  categoryQuestion CQ LEFT JOIN question Q ON CQ.categoryID=Q.categoryID
Group BY ( CQ.categoryID);


-- cách 3 dùng inner join + union 
SELECT CQ.categoryname, count(Q.content) AS `SL`
FROM question Q 
INNER JOIN categoryquestion CQ 
ON CQ.categoryID=Q.categoryID 
Group by CQ.categoryname
UNION 
SELECT CQ.categoryName, 0 
From categoryquestion CQ 
left join question Q 
ON CQ.categoryID=Q.categoryID 
where Q.content is null ;
  
-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT 		Q.questionID,
			count(EX.ExamID) AS `Sl`
from  		question Q left JOIN examquestion EX ON Q.questionID=EX.questionID
Group BY 	(Q.questionID);
 
-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
-- CÁCH 1 : DÙNG SELECT ĐÔ
SELECT 			A.QuestionID,
				Q.content,
				count(A.AnswerID) AS `SL`
From 			Answer A 
INNER JOIN 		Question Q 
ON 				A.questionID=Q.questionID
Group by  		A.QuestionID
HAVING `SL`= 
(select count(A.AnswerID) AS `SL`
From Answer A 
Group by  A.QuestionID
ORDER BY `SL` DESC LIMIT 1);
-- cách 2 : select đôi + hàm MAX 
SELECT 			A.QuestionID,
				Q.content,
				count(A.AnswerID) AS `SL`
From 			Answer A 
INNER JOIN 		Question Q 
ON 				A.questionID=Q.questionID
Group by  		A.QuestionID
HAVING `SL`= (Select MAX(T.`SL`) from (SELECT QuestionID, count(AnswerID) AS `SL` From Answer Group by QuestionID) AS `T`);

-- Question 9: Thống kê số lượng account trong mỗi group 
select		G.GroupID,
			count(GA.accountID) as `SL`
from 		`Group`G 
Left join 	Groupaccount GA On G.GroupID=GA.GroupID
group by 	G.GroupID;

-- Question 10: Tìm chức vụ có ít người nhất
SELECT  		p.positionID, p.positionName,
				count(A.accountID) AS `SL` 
FROM 			`Position` P
LEFT JOIN 		`Account` A 
ON 				p.positionID=A.positionID
GROUP BY  		p.positionID
HAVING `SL` =  (SELECT  count(A.accountID) AS `SL` FROM `Position` P LEFT JOIN `Account` A ON p.positionID=A.positionID
				GROUP BY  p.positionID
				HAVING  `SL` <> 0 
				ORDER BY count(A.accountID) ASC LIMIT 1);
 

--  Question 11: Thống kê mỗi phòng ban có bao nhiêu GIÁM ĐỐc , Phó giám đốc, mentor , student ......
SELECT D.*, count(A.AccountID) AS SL 
FROM Department D 
LEFT JOIN `account` A ON D.DepartmentID=A.DepartmentID
GROUP BY D.DepartmentID;

-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, … 
SELECT				question.questionID,
					Typequestion.TypeName AS Loại_câu_hỏi,
					`account`.FullName AS Người_tạo_câu_hỏi,
					answer.content AS Câu_trả_lời
FROM 				question 
INNER JOIN 			Typequestion on Typequestion.TypeID = question.TypeID
INNER JOIN 			`account` on `account`.accountID= question.creatorID
INNER JOIN			answer on question.questionID= answer.questionID ;

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT   			typequestion.typename AS Loại_câu_hỏi,
					count(question.typeID) AS Số_lượng
FROM 				question 
INNER JOIN 			typequestion ON typequestion.typeID= question.typeID 
GROUP BY 			typequestion.typename; 

-- Question 14: Lấy ra group không có account nào 
-- Question 15: Lấy ra group không có account nào 
select		G.GroupID,
			count(GA.accountID) as `SL`
from 		`Group`G 
Left join 	Groupaccount GA On G.GroupID=GA.GroupID
group by 	G.GroupID
HAVING `SL`=0;


-- Question 16: Lấy ra question không có answer nào
SELECT Q.* , count(AN.AnswerID) AS SL 
FROM Question Q
LEFT JOIN Answer AN ON AN.QuestionID=Q.QuestionID
GROUP BY Q.QuestionID
HAVING `SL` = 0 ;


-- Exercise 2: Union
-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
-- b) Lấy các account thuộc nhóm thứ 2
-- c) Ghép 2 kết quả từ câu (a) và câu (b) sao cho không có record nào trùng nhau
-- Câu a -----------------------------
SELECT				`groupaccount`.GroupID, 
					`account`.* 
FROM 				`groupaccount` 
INNER JOIN 			`account` ON `groupaccount`.accountID= `account`.accountID
WHERE 				`groupaccount`.groupID =1;
-- Câu b -----------------------------
SELECT				`groupaccount`.GroupID, 
					`account`.* 
FROM  				`groupaccount` 
INNER JOIN 			`account` 
ON 					`groupaccount`.accountID= `account`.accountID
WHERE 				`groupaccount`.groupID =2;
-- Câu c -----------------------------
SELECT				`groupaccount`.GroupID, 
					`account`.* 
FROM  				`groupaccount` 
INNER JOIN 			`account` 
ON 					`groupaccount`.accountID= `account`.accountID
WHERE 				`groupaccount`.groupID =1


UNION DISTINCT


SELECT				`groupaccount`.GroupID, 
					`account`.* 
FROM  				`groupaccount` 
INNER JOIN			`account` 
ON 					`groupaccount`.accountID= `account`.accountID
WHERE 				`groupaccount`.groupID =2;

-- Question 18:
-- a) Lấy các group có lớn hơn 5 thành viên
-- b) Lấy các group có nhỏ hơn 7 thành viên
-- c) Ghép 2 kết quả từ câu a) và câu b) 
-- THÊM DỮ LIỆU



-- câu a------------------
SELECT G.GroupID, count(GA.accountID) AS SL
FROM `Group` G
LEFT JOIN Groupaccount GA ON G.GroupID=GA.GroupID 
GROUP BY G.GroupID 
HAVING SL > 5 ;

-- câu b --------------------------
SELECT G.GroupID, count(GA.accountID) AS SL
FROM `Group` G
LEFT JOIN Groupaccount GA ON G.GroupID=GA.GroupID 
GROUP BY G.GroupID 
HAVING SL < 7  ;


-- câu C ---------------------

SELECT G.GroupID, count(GA.accountID) AS SL
FROM `Group` G
LEFT JOIN Groupaccount GA ON G.GroupID=GA.GroupID 
GROUP BY G.GroupID 
HAVING SL > 5 

UNION DISTINCT

SELECT G.GroupID, count(GA.accountID) AS SL
FROM `Group` G
LEFT JOIN Groupaccount GA ON G.GroupID=GA.GroupID 
GROUP BY G.GroupID 
HAVING SL < 7  ;




