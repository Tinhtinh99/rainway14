USE exammanagement2;
-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo
-- trước 1 năm trước

DROP TRIGGER IF EXISTS INSERT_Group;
DELIMITER $$
	CREATE TRIGGER INSERT_Group
    BEFORE INSERT ON `Group`
    FOR EACH ROW 
    BEGIN 
			IF NEW.CreateDate < date_sub(NOW(), interval 1 YEAR)
            THEN 
				SIGNAL SQLSTATE '12345'
                SET MESSAGE_TEXT='Insert fail do ngày tạo không hợp lệ';
			END IF;
	END $$ ;
DELIMITER ;
SELECT * FROM `GROUP`;
INSERT INTO `exammanagement2`.`group` (`GroupID`, `GroupName`, `CreatorID`, `CreateDate`) VALUES ('11', 'tesetx', '1', '2006-09-08');


-- Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào
-- department "Sale" nữa, khi thêm thì hiện ra thông báo "Department
-- "Sale" cannot add more user

DROP TRIGGER IF EXISTS INSERT_USER;
DELIMITER $$
	CREATE TRIGGER INSERT_USER
    BEFORE INSERT ON `Account`
    FOR EACH ROW 
    BEGIN 
			DECLARE ID_temp INT; 
            SELECT DepartmentID INTO ID_temp 
            FROM Department Where DepartmentName Like '%Sale%';
            IF NEW.DepartmentID = ID_temp
            THEN 
				SIGNAL SQLSTATE '12345'
                SET MESSAGE_TEXT='Department Sale cannot add more user';
			END IF;
	END $$ ;
DELIMITER ;

select * from `account`;
INSERT INTO `exammanagement2`.`account` (`AccountID`, `Email`, `Username`, `Fullname`, `DepartmentID`, `PositionID`, `CreateDate`) VALUES ('18', 'ngoc12@gmail.com', 'ngoc9274', 'Hoàng Đức Ngọ', '11', '12', '2018-07-09');

-- Question 3: Cấu hình 1 group có nhiều nhất là 5 user
DROP TRIGGER IF EXISTS User_Of_Group;
DELIMITER $$
CREATE TRIGGER User_Of_Group
BEFORE INSERT ON `groupaccount`
FOR EACH ROW
BEGIN
DECLARE 	CountAccountID TINYINT;
DECLARE 	Group_ID TINYINT;
SELECT 		GroupID, count(GA.AccountID)  INTO Group_ID,CountAccountID
FROM		groupaccount GA
WHERE 		GA.GroupID = NEW.GroupID
GROUP BY 	GroupID ;


IF (CountAccountID >5) 
THEN
		SIGNAL SQLSTATE '12345'
		SET MESSAGE_TEXT = 'Không thể thêm vào nhóm này(Quá thành Viên)';
END IF;
END$$
DELIMITER ;
INSERT INTO `groupaccount` (`GroupID`, `AccountID`, `JoinDate`)
VALUES (2, 7,'2021-05-11 00:00:00');

-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question
DROP TRIGGER IF EXISTS Question_Of_Exam;
DELIMITER $$
CREATE TRIGGER Question_Of_Exam
BEFORE INSERT ON `ExamQuestion`
FOR EACH ROW
BEGIN
DECLARE 	CountExamID TINYINT; DECLARE 	Question_ID TINYINT;
SELECT 		QuestionID, count(EQ.ExamID)  INTO Question_ID,CountExamID
FROM		ExamQuestion EQ
WHERE 		EQ.QuestionID = NEW.QuestionID
GROUP BY 	EQ.QuestionID;
IF (CountExamID >10) 
THEN
		SIGNAL SQLSTATE '12345'
		SET MESSAGE_TEXT = 'Không thể thêm câu hỏi cho exam ';
END IF;
END$$
DELIMITER ;
INSERT INTO Examquestion(ExamID,QuestionID)
VALUES ('26','9');

-- Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là
-- admin@gmail.com (đây là tài khoản admin, không cho phép user xóa),
-- còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông
-- tin liên quan tới user đó
SELECT * FROM `Account`;
INSERT INTO `exammanagement2`.`account` (`AccountID`, `Email`, `Username`, `Fullname`, `DepartmentID`, `PositionID`, `CreateDate`) VALUES ('18', 'admin@gmail.com', 'AD_MIN123', 'VTI ADMIN', '1', '1', '2018-07-09');

DROP TRIGGER IF EXISTS DEL_ACC;
DELIMITER $$
	CREATE TRIGGER DEL_ACC
    BEFORE DELETE ON `Account`
    FOR EACH ROW 
    BEGIN 
			DECLARE ID_ADMIN INT;
            SELECT AccountID INTO ID_ADMIN From `account` Where email='admin@gmail.com';
            IF (ID_ADMIN=OLD.AccountID)
            THEN 	
					SIGNAL SQLSTATE '12345'
					SET MESSAGE_TEXT = 'Không thể xóa admin ';
			END IF;
	END $$ ;
DELIMITER ;
BEGIN WORK;
DELETE FROM `account` WHERE email='admin@gmail.com';
ROLLbACK;


-- Question 6: Không sử dụng cấu hình default cho field DepartmentID của table
-- Account, hãy tạo trigger cho phép người dùng khi tạo account không điền
-- vào departmentID thì sẽ được phân vào phòng ban "waiting Department"
INSERT INTO DEPARTMENT(DepartmentID,DepartmentName)
VALUES ('909','Waiting Department');
SELECT * FROM department ;


DROP TRIGGER IF EXISTS INS_NEW_ACC;
DELIMITER $$
	CREATE TRIGGER INS_NEW_ACC
    AFTER INSERT ON `Account`
    FOR EACH ROW 
    BEGIN 
			DECLARE ID_WAIT INT;
            Select DepartmentID INTO ID_Wait FROM department Where departmentName='Waiting Department';
            UPDATE `account` SET DepartmentID=ID_WAIT WhERE accountID=NEW.accountID ;
	END $$ ;
DELIMITER ;

SELECT * FROM	`account` ;
INSERT INTO `exammanagement2`.`account` (`AccountID`, `Email`, `Username`, `Fullname`, `CreateDate`) 
VALUES ('20', 'ngoc126473@gmail.com', 'ngc997745', 'Hoàng tuân', '2018-07-09');






