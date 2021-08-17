-- ===================================================================================================================================================================================================
-- ====================================================================================CREATE DATABASE================================================================================================
-- ===================================================================================================================================================================================================
DROP DATABASE IF EXISTS 			Exammanagement_assignment2;
CREATE DATABASE  					Exammanagement_assignment2;
USE 								Exammanagement_assignment2;
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
		  CONSTRAINT fk_DpID FOREIGN KEY (DepartmentID) REFERENCES Department (DepartmentID) ON DELETE CASCADE ON UPDATE CASCADE,
    PositionID 						SMALLINT UNSIGNED,
		  CONSTRAINT fk_PID FOREIGN KEY (PositionID)	REFERENCES `Position` (PositionID) ON DELETE CASCADE ON UPDATE CASCADE,
    CreateDate						DATE NOT NULL
);
-- ---------------------------------------TẠO BẢNG GROUP--------------------------------------------
DROP TABLE IF EXISTS 				`Group`;
CREATE TABLE  						`Group`(
	GroupID							MEDIUMINT UNSIGNED PRIMARY KEY auto_increment,
    GroupName						VARCHAR(50) UNIQUE KEY NOT NULL ,
    CreatorID						MEDIUMINT UNSIGNED ,
		  CONSTRAINT fk_CreGr FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID) ON DELETE CASCADE ON UPDATE CASCADE,
    CreateDate						DATETIME NOT NULL
);
-- -----------------------------------------TẠO BẢNG GROUPACCOUNT-------------------------------------
DROP TABLE IF EXISTS 				GroupAccount;
CREATE TABLE  						GroupAccount(
	GroupID							MEDIUMINT UNSIGNED  ,
		   CONSTRAINT fk_grID FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID) ON DELETE CASCADE ON UPDATE CASCADE,
    AccountID						MEDIUMINT UNSIGNED,
		 CONSTRAINT fk_Acc FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID) ON DELETE CASCADE ON UPDATE CASCADE,
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
    Content							VARCHAR(500)  NULL,
    CategoryID						SMALLINT UNSIGNED,
		 CONSTRAINT fk_CateId FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID) ON DELETE CASCADE ON UPDATE CASCADE,
    TypeID							SMALLINT UNSIGNED,
		CONSTRAINT fk_TpId FOREIGN KEY (TypeID) REFERENCES TypeQuestion(TypeID) ON DELETE CASCADE ON UPDATE CASCADE,
    CreatorID						MEDIUMINT UNSIGNED,
		 CONSTRAINT fk_CreaQ FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID) ON DELETE CASCADE ON UPDATE CASCADE,
    CreateDate						DATE
);
-- --------------------------------------------------TẠO BẢNG ANSWER------------------------------------
DROP TABLE IF EXISTS 				Answer;
CREATE TABLE  						Answer(
	AnswerID						SMALLINT UNSIGNED UNIQUE KEY NOT NULL auto_increment ,
    Content							VARCHAR(500) NULL ,
    QuestionID						SMALLINT UNSIGNED,
		CONSTRAINT fk_QueId FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID) ON DELETE CASCADE ON UPDATE CASCADE,
    isCorrect						ENUM('Right','Wrong') NOT NULL
);
-- --------------------------------------------------TẠO BẢNG EXAM------------------------------------
DROP TABLE IF EXISTS 				Exam;
CREATE TABLE  						Exam(
	ExamID							SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT ,
    Codee							VARCHAR(15) UNIQUE KEY NOT NULL ,
    Title							VARCHAR(20) NOT NULL,
    CategoryID						SMALLINT UNSIGNED,
		CONSTRAINT fk_CateExId FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID) ON DELETE CASCADE ON UPDATE CASCADE,
    Duration						TIME NOT NULL,
    CreatorID						MEDIUMINT UNSIGNED,
		CONSTRAINT fk_CreaEx FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID) ON DELETE CASCADE ON UPDATE CASCADE,
    CreateDate						DATE
);
-- -----------------------------------------------------TẠO BẢNG EXAMQUESTION-------------------------
DROP TABLE IF EXISTS 				ExamQuestion;
CREATE TABLE  						ExamQuestion(
	ExamID							SMALLINT UNSIGNED,
		CONSTRAINT fk_ExId FOREIGN KEY (ExamID) REFERENCES Exam(ExamID) ON DELETE CASCADE ON UPDATE CASCADE,
    QuestionID						SMALLINT UNSIGNED,
		CONSTRAINT fk_QsEx FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID) ON DELETE CASCADE ON UPDATE CASCADE
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
            ('Vệ sinh'				),
            ('Sale');

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
            ('Ghi Chép'		),
            ('nhân viên sale');
            
-- ============================================ADD DATA FOR Accountt====================================================
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
            ('tien1239@gmail.com','tien1239','Hoàng văn tuân','8','8','2018-07-09'		),
            ('ngoc12343@gmail.com','ngoc9977','Hoàng Mạnh Ngọc','11','12','2018-07-09'		),
             ('ngoc12323@gmail.com','ngoc9277','Hoàng Đức Ngọc','11','12','2018-07-09'		);
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
			(7,'1','2021-08-04'),
            (6,'1','2021-08-04'),
            (7,'2','2021-08-04'),
            (6,'2','2021-08-04');
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
INSERT INTO Question(Content, CategoryID, TypeID, CreatorID,CreateDate)
VALUES 
			('Câu hỏi về Java','1','1','3','2021-07-15'),
            ('Câu hỏi về .NET','2','2','4','2021-05-12'),
            ('Câu hỏi về SQL','3','1','3','2021-06-25'),
            ('Câu hỏi về Postman','4','2','4','2021-04-24'),
            ('Câu hỏi về toán','5','1','3','2021-01-05'),
            ('Câu hỏi về lý','6','2','4','2021-07-17'),
            ('Câu hỏi về hóa','7','1','3','2021-07-13'),
            ('Câu hỏi về văn','8','2','4','2021-07-26'),
            ('Câu hỏi về sử','9','1','3','2021-07-28'),
            ('Câu hỏi về địa','10','2','4','2021-04-30'),
            ('Câu hỏi về địa','10','2','4','2021-07-31'),
            ('Câu hỏi về địa','10','2','4','2021-07-31'),
            ('Câu hỏi về địa','10','2','4','2021-07-25'),
            ('Nước ta có bao nhiêu tỉnh và thành phố. Miền Bắc, miền Trung và miền Nam có những tỉnh và thành phố nào?
            Nằm gọn trong vùng nội chí tuyến nửa cầu Bắc từ 8030’B đến 23022’B, đồng thời lại nằm gọn trong vùng hoạt động của gió mùa Đông Nam Á, 
            nước ta có khí hậu nhiệt đới ẩm gió mùa, với đặc điểm nổi bật là nóng ẩm và mưa nhiều theo mùa.
			- Nhiệt độ trung bình cả năm trong toàn quốc trên 230C, mỗi năm có ít nhất 1200 giờ nắng, cán cân bức xạ quanh năm dương','7','1','3','2021-07-31'),
			('Nước ta có bao nhiêu tỉnh và thành phố. Miền Bắc, miền Trung và miền Nam có những tỉnh và thành phố nào?
            Nằm gọn trong vùng nội chí tuyến nửa cầu Bắc từ 8030’B đến 23022’B, đồng thời lại nằm gọn trong vùng hoạt động của gió mùa Đông Nam Á,
            nước ta có khí hậu nhiệt đới ẩm gió mùa, với đặc điểm nổi bật là nóng ẩm và mưa nhiều theo mùa.
			- Nhiệt độ trung bình cả năm trong toàn quốc trên 230C, mỗi năm có ít nhất 1200 giờ nắng, cán cân bức xạ quanh năm dương','6','2','3','2021-07-31'),
			('Câu hỏi về lúa gạo','10','2','4','2021-01-31'),
			('Câu hỏi về nông nghiệp','10','2','4','2021-03-31'),
			('Câu hỏi về thủy sản','10','2','4','2021-04-30'),
			('Câu hỏi về thể tích','10','2','4','2021-05-31');
  
-- ===========================================ADD DATA FOR TABLE ANSWER===========================
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
            ('000007',' Đề thi học phần 6','1','00:15:00' , '3','2021-07-20'),
            ('000008',' Đề thi học phần 6','2','00:15:00' , '3','2021-07-20'),
            ('000009',' Đề thi học phần 6','6','00:15:00' , '3','2021-07-20'),
            ('000010',' Đề thi học phần 6','3','00:15:00' , '3','2021-07-20'),
            ('000011',' Đề thi học phần 6','6','00:15:00' , '3','2021-07-20'),
            ('000012',' Đề thi học phần 6','7','00:15:00' , '3','2021-07-20'),
			('000013',' Đề thi học phần 5','6','00:15:00' , '3','2021-07-20'),
			('000014',' Đề thi học phần 14','6','00:15:00' , '3','2021-07-20'),
			('000015',' Đề thi học phần 15','9','00:15:00' , '3','2021-07-20'),
            ('000016',' Đề thi học phần 16','7','00:15:00' , '3','2005-07-20'),
            ('000017',' Đề thi học phần 17','8','00:15:00' , '3','2005-07-20'),
            ('000018',' Đề thi học phần 18','7','00:15:00' , '3','2005-07-20');
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
            (14,9),
            (15,9),
            (16,9),
            (17,9),
            (18,9);
    
          