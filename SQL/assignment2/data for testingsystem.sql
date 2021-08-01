-- ===================================================================================================================================================================================================
-- 																						ADD DATA FOR TESTING_SYSTEM																				    ==
-- ===================================================================================================================================================================================================
-- ==================================ADD DATA FOR DEPARTMENT ====================================================================================
SET SQL_SAFE_UPDATES = 0;
delete  from Department;
Insert into Department(DepartmentID, DepartmentName) 
VALUES 	
			(1, 	N'Trưởng TT'			),
            (2,		N'Phó TT'				),
            (3, 	N'Trưởng bộ môn'		),
            (4, 	N'Phó bộ môn'			),
            (5,		N'Văn Thư'				),
            (6,		N'Kế Toán'				),
            (7, 	N'Học sinh sinh viên'	);
Select * From Department;
-- ======================================ADD DATA FOR Posiition======================================================================================

delete  from `Position`;
INSERT INTO `Position`(PositionID, PositionName)
VALUES 		
			(1,		N'Giám đốc'),
            (2, 	N'Phó giám đốc'),
            (3, 	N'Mentor'),
            (4, 	N'Trợ giảng'),
            (5, 	N'NV văn thư'),
            (6, 	N'NV kế toán'),
            (7, 	N'student');
select * from `Position`;
-- ============================================ADD DATA FOR Accountt====================================================
delete from `Account` ;
INSERT INTO `Account`( AccountID, Email, Username, Fullname, DepartmentID, PositionID, CreateDate)
VALUES 			
			(1,'nvva0907@gmail.com','nvva0907','Nguyễn văn việt anh', '1','1','2018-07-09'),
            (2,'tung1234@gmail.com','tung1234','Nguyễn Xuân Tùng','2','2','2018-07-10'),
            (3,'hoang1234@gmail.com','hoang1234','Nguyễn Minh Hoàng',3,3,'2018-07-11'),
            (4,'ngoc1234&gmail.com','ngoc1234','Nguyễn Tiến Ngọc',4,4,'2018-07-15'),
            (5,'hiep1234@gmail.com','hiep1234','Hoàng Mạnh Hiệp',5,5,'2018-07-20'),
            (6,'quat1234@gmail.com','quat1234','Thái Duy Quát',6,6,'2018-07-12'),
            (7,'hieu1234@gmail.com','hieu1234','Đỗ Minh Hiếu',7,7,'2019-01-01'),
            (8,'dat1234@gmail.com','dat1234','Nguyễn Quang Đạt',7,7,'2019-01-01'),
            (9,'truong1234@gmail.com','truong1234','Phan Văn Trường',7,7,'2019-01-02');
select * from `Account`;
-- ====================================ADD DATA FOR TABLE GROUP============================================================
Delete From `Group`;
INSERT INTO `Group`(GroupID, GroupName, CreatorID, CreateDate)
VALUES 
			(1, ' Nhóm giám hiệu ', 1, '2018-07-09'),
            (2, ' Nhóm Giáo Dục ' ,1,'2018-07-09'),
            (3, ' Nhóm thư ký ',1,'2018-07-09'),
            (4, ' Nhóm HSSV',1,'2019-01-01');
select * from `Group`;
-- ========================================ADD DATA FOR TABLE GroupAccount==============================================
delete from GroupAccount;
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
        
select * from GroupAccount;
-- =================================================ADD DATA FOR TABLE TYPEQUESTION================================================
Delete from TypeQuestion;
INSERT INTO TypeQuestion (TypeID, TypeName)
VALUES  
			(1, 	'Essay'),
            (2, 'Multiple-Choice');
Select * from TypeQuestion;
-- =================================================Category Question========================================================
delete from CategoryQuestion;
INSERT INTO CategoryQuestion(CategoryID, CategoryName)
VALUES 		
			(1, 'Java'),
            (2, ' .NET'),
            (3, 'SQL'),
            (4, 'Postman'),
            (5,'Liên quân'),
            (6,'FIFA');
Select * from CategoryQuestion;
-- ============================================ADD DATA FROM Question=======================
delete from Question;
Insert into Question(QuestionID, Content, CategoryID, TypeID, CreatorID, CreateDate)
VALUES 
			(1, 'Câu hỏi về Java','1','1','3','2021-07-31'),
            (2, 'Câu hỏi về .NET','2','2','4','2021-07-31'),
            (3, 'Câu hỏi về SQL','3','1','3','2021-07-31'),
            (4, 'Câu hỏi về Postman','4','2','4','2021-07-31'),
            (5,'Câu hỏi về Liên quân','5','1','3','2021-07-31'),
            (6,'Câu hỏi về FIFA','6','2','4','2021-07-31');
select * from Question;
-- ===========================================ADD DATA FOR TABLE ANSWER===========================
Delete from Answer;
Insert into Answer(AnswerID, Content, QuestionID, isCorrect)
Values 
			(1, 'đáp án Java','1','right'),
            (2, 'đáp án  .NET','2','right'),
            (3, 'đáp án SQL','3','right'),
            (4, 'đáp án ostman','4','right'),
            (5,'đáp án Liên quân','5','right'),
            (6,'đáp án FIFA','6','right');
Select * from Answer;
-- ===============================================ADD DATA FOR TABLE Exam=============================
Delete from Exam;
INsert into Exam(ExamID, Codee, Title, CategoryID, Duration, CreatorID, CreateDate)
values 
			(1, '000001',' Đề thi học phần 1','1', 00-90-00 , '3','2021-07-20'),
            (2, '000002',' Đề thi học phần 2','2', 00-90-00, '4','2021-07-20'),
			(3, '000003',' Đề thi học phần 3','3', 00-90-00 , '3','2021-07-20'),
            (4, '000004',' Đề thi học phần 4','4', 00-90-00 , '4','2021-07-20'),
            (5, '000005',' Đề thi học phần 5','5', 00-90-00 , '3','2021-07-20'),
            (6, '000006',' Đề thi học phần 6','6', 00-90-00 , '3','2021-07-20');
Select * from Exam ;
-- ================================================ADD DATA FOR TABLE ExamQuestion==================================
delete from ExamQuestion;
Insert into ExamQuestion(ExamID, QuestionID)
Values 
			(1,1),
            (2,2),
            (3,3),
            (4,4),
            (5,5),
            (6,6);
select * from ExamQuestion
	