DROP DATABASE IF EXISTS 	Point_management;
CREATE DATABASE 			Point_management;
USE							Point_management;

DROP TABLE IF EXISTS Student;
CREATE TABLE Student(
`StudentId` 				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
`StudentName`				VARCHAR(50),
`Age`				TINYINT UNSIGNED,
`Gender` 			ENUM('0','1')
);

DROP TABLE IF EXISTS `Subject`;
CREATE TABLE `Subject`(
`SubjectId`				TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
`SubjectName`				VARCHAR(50)
);

DROP TABLE IF EXISTS StudentSubject;
CREATE TABLE StudentSubject(
StudentId				TINYINT UNSIGNED,
SubjectId				TINYINT UNSIGNED,
Mark					TINYINT ,
Date_Mark 				DATE DEFAULT(NOW()),
PRIMARY KEY (StudentId,SubjectId)
);
-- ==========================================================
-- insert data vào Student 
INSERT INTO `point_management`.`student` (`StudentId`, `StudentName`, `Age`, `Gender`) VALUES ('1', 'Nguyễn Văn A', '18', '0');
INSERT INTO `point_management`.`student` (`StudentId`, `StudentName`, `Age`, `Gender`) VALUES ('2', 'Nguyễn Văn B', '20', '1');
INSERT INTO `point_management`.`student` (`StudentId`, `StudentName`, `Age`, `Gender`) VALUES ('3', 'Nguyễn Văn C', '18', '0');
INSERT INTO `point_management`.`student` (`StudentId`, `StudentName`, `Age`, `Gender`) VALUES ('4', 'Nguyễn Văn D', '18', '1');
INSERT INTO `point_management`.`student` (`StudentId`, `StudentName`, `Age`, `Gender`) VALUES ('5', 'Nguyễn Văn E', '19', '0');
-- insert data vào Subject 
INSERT INTO `point_management`.`subject` (`SubjectId`, `SubjectName`) VALUES ('1', 'Toán');
INSERT INTO `point_management`.`subject` (`SubjectId`, `SubjectName`) VALUES ('2', 'Văn');
INSERT INTO `point_management`.`subject` (`SubjectId`, `SubjectName`) VALUES ('3', 'Sử');
INSERT INTO `point_management`.`subject` (`SubjectId`, `SubjectName`) VALUES ('4', 'Địa');
INSERT INTO `point_management`.`subject` (`SubjectId`, `SubjectName`) VALUES ('5', 'Hóa');
-- -- insert data vào StudentSubject
DELETE FROM studentSubject;
INSERT INTO `point_management`.`studentsubject` (`StudentId`, `SubjectId`, `Mark`) VALUES ('1', '1', '9');
INSERT INTO `point_management`.`studentsubject` (`StudentId`, `SubjectId`, `Mark`) VALUES ('2', '2', '8');
INSERT INTO `point_management`.`studentsubject` (`StudentId`, `SubjectId`, `Mark`) VALUES ('3', '3', '7');
INSERT INTO `point_management`.`studentsubject` (`StudentId`, `SubjectId`, `Mark`) VALUES ('4', '4', '8');
INSERT INTO `point_management`.`studentsubject` (`StudentId`, `SubjectId`, `Mark`) VALUES ('5', '5', '9');
INSERT INTO `point_management`.`studentsubject` (`StudentId`, `SubjectId`) VALUES ('2', '4');
INSERT INTO `point_management`.`studentsubject` (`StudentId`, `SubjectId`) VALUES ('3', '1');
INSERT INTO `point_management`.`studentsubject` (`StudentId`, `SubjectId`, `Mark`) VALUES ('1', '2', '7');
INSERT INTO `point_management`.`studentsubject` (`StudentId`, `SubjectId`, `Mark`) VALUES ('2', '1', '6');
INSERT INTO `point_management`.`studentsubject` (`StudentId`, `SubjectId`, `Mark`) VALUES ('3', '4', '5');

-- =============================================================

-- QUESTION 2 
-- Viết lệnh để
-- a) Lấy tất cả các môn học không có bất kì điểm nào
-- b) Lấy danh sách các môn học có ít nhất 2 điểm

-- a) 
SELECT Su.SubjectName
FROM studentSubject SS 
RIGHT JOIN `Subject` Su USING(SubjectID)
WHERE Mark IS NULL ;
-- b) 
SELECT su.subjectID ,su.SubjectName, Count(ss.mark) as `Số_con_điểm_đã_chấm`
FROM StudentSubject SS 
RIGHT JOIN `subject` su USING(SubjectID)
GROUP BY su.subjectID
HAVING `Số_con_điểm_đã_chấm` >=2 ;

-- QUESTION 3 : Tạo view có tên là "StudentInfo" lấy các thông tin về học sinh bao gồm:
-- Student ID,Subject ID, Student Name, Student Age, Student Gender, Subject Name, Mark, Date
-- (Với cột Gender show 'Male' để thay thế cho 0, 'Female' thay thế cho 1 và
-- 'Unknow' thay thế cho null)
CREATE OR REPLACE VIEW StudentInfo AS 
SELECT	st.StudentID,st.StudentName,st.age,su.subjectid, su.subjectName,ss.mark,ss.`date_mark`,
Case 		
WHEN 	CONVERT(st.gender USING utf8) =1 THEN 'female'
WHEN 	CONVERT(st.gender USING utf8) =0 THEN 'male'
WHEN 	CONVERT(st.gender USING utf8) is null then 'unknown'
ELSE CONVERT(st.gender USING utf8)
END AS `Giới_tính`
FROM StudentSubject SS 
RIGHT JOIN Student St USING(studentID)
RIGHT JOIN `Subject` Su USING(SubjectID);

SELECT * FROM StudentInfo;


-- QUESTION 4 
-- a) Tạo trigger cho table Subject có tên là SubjectUpdateID:
-- Khi thay đổi data của cột ID của table Subject, thì giá trị tương
-- ứng với cột SubjectID của table StudentSubject cũng thay đổi theo

DROP TRIGGER IF EXISTS trig_SubjectUpdateID;
DELIMITER $$
CREATE TRIGGER trig_SubjectUpdateID
BEFORE UPDATE ON `Subject`
FOR EACH ROW
BEGIN		Update Studentsubject ss Set ss.SubjectID = NEW.SubjectID WHERE  ss.SubjectID=OLD.SubjectID;
END $$;
DELIMITER ; 
Update `subject` set subjectID =7 Where subjectID =4 ;

-- b) Tạo trigger cho table StudentSubject có tên là StudentDeleteID: Khi xóa data của cột ID của table Student, thì giá trị tương ứng với
-- cột StudentID của table StudentSubject cũng bị xóa theo 

DROP TRIGGER IF EXISTS trig_StudentDeleteID;
DELIMITER $$
CREATE TRIGGER trig_StudentDeleteID
BEFORE DELETE ON `Student`
FOR EACH ROW
BEGIN		DELETE FROM `studentsubject` Where StudentID=OLD.StudentID ;
END $$;
DELIMITER ; 
BEGIN WORK;
DELETE FROM `Student` where StudentID = 4;
ROLLBACK;


/* Question5. Viết 1 store procedure (có 1 parameters: studentname) sẽ xóa tất cả các
thông tin liên quan tới học sinh có cùng tên như parameter

Trong trường hợp nhập vào studentname = "*" thì procedure sẽ xóa tất cả
các học sinh*/

DROP PROCEDURE IF EXISTS stpr_Del_student;
DELIMITER $$
CREATE PROCEDURE stpr_Del_student(IN studentname_input VARCHAR(50))
BEGIN 
		IF studentname_input='*'
        THEN DELETE FROM studentsubject ;Delete from student ;
        ELSE 
        DELETE FROM Studentsubject WHERE StudentID= (SELECT StudentID FROM student Where studentName = studentname_input );
        DELETE FROM student WHERE  studentName = studentname_input;
        END IF;
END $$ ;
DELIMITER ; 
CALL stpr_Del_student('*');
CALL stpr_Del_student('Nguyễn Văn A');








