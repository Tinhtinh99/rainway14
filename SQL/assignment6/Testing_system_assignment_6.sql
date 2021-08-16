use exammanagement2;
-- VÍ DỤ VỀ TẠO PROCEDURE 
DROP PROCEDURE IF EXISTS GetdepartmentID;
DELIMITER VA7
	CREATE PROCEDURE `GetdepartmentID`(IN department_NAME  VARCHAR(50), OUT departmentIDOut INT, OUT departmentnameOut Varchar(50))
		BEGIN 
				
					  SELECT DepartmentID, DepartmentName 
                      INTO 	departmentIDOut, departmentnameOut 
                      FROM Department 
					  WHERE DepartmentName LIKE department_NAME ;
		END VA7;
DELIMITER ;

CALL `GetdepartmentID`('%sale%', @idOut, @NameOut);

Select @idOut, @nameOut;
Select * from department Where departmentID=@idout;

Select * from `account` Where departmentID=@idout;
-- khi đi phỏng vấn : Procedure là tập hợp các câu lệnh mình có thể sử dụng nhiều lần 







-- ======================================================================================================================--
-- ======================================================================================================================--
-- ======================================================================================================================--
-- ======================================================================================================================--
-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó

DROP PROCEDURE IF EXISTS Get_account_of_department;
DELIMITER $$ 
	CREATE PROCEDURE Get_account_of_department(IN department_Name Varchar(50))
		BEGIN
					  SELECT * 
                      FROM `account` A
                      Join department D  Using(DepartmentID)
					  WHERE D.DepartmentName LIKE department_Name;
		END $$;
DELIMITER ;

CALL Get_account_of_department('%học sinh%');

-- Question 2: Tạo store để in ra số lượng account trong mỗi group

DROP PROCEDURE IF EXISTS Get_SL_account_of_Group;
DELIMITER $$
	CREATE PROCEDURE Get_SL_account_of_Group(IN Group_ID INT)
		BEGIN
					  SELECT G.GroupID, count(GA.accountID) SL_ACCOUNT
                      FROM `groupaccount` GA
                      RIGHT JOIN  `Group` G USING(GroupID)
					  WHERE Group_ID=GroupID
                      Group by G.GroupID;
		END $$;
DELIMITER ;
CALL Get_SL_account_of_Group(2);

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo
-- trong tháng hiện tại
DROP PROCEDURE IF EXISTS Thong_ke_typequestion;
DELIMITER $$ 
	CREATE PROCEDURE Thong_ke_typequestion(IN Type_ID INT)
		BEGIN 
					  SELECT TQ.TypeID, count(Q.questionID) SL_question
                      FROM TypeQuestion TQ
                      LEFT JOIN  `question` Q USING(TypeID)
					  WHERE Q.CreateDate Between '2021-08-01' AND '2021-08-31'
                      Group by TQ.TypeID
                      HAVING Type_ID=TypeID;
		END $$;
DELIMITER ;
CALL Thong_ke_typequestion(2);
 


-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DROP PROCEDURE IF EXISTS typequestion_nhieu_ch;
DELIMITER $$
CREATE PROCEDURE typequestion_nhieu_ch(OUT Type_ID INT)
		BEGIN		  SELECT 		TypeID INTO Type_ID
                      FROM 			Question Q 
                      Group by 		TypeID Order by Count(questionID) DESC LIMIT 1; 
		END $$;
DELIMITER ;	
CALL typequestion_nhieu_ch(@TypeOut);	Select @TypeOut;

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
 SELECT TypeName From Typequestion Where TypeID=@TypeOut;

-- Question 6: Viết 1 store cho phép người dùng nhập vào (1 chuỗi) và (trả về group có tên
-- chứa chuỗi của người dùng nhập) vào hoặc (trả về user có username chứa
-- chuỗi của người dùng nhập vào)
 DROP PROCEDURE IF EXISTS Tim_Infor;
 DELIMITER $$ 
 CREATE PROCEDURE Tim_Infor(IN INFOR_IN VARCHAR(50))
			BEGIN
					SELECT GroupName from `Group` Where GroupName LIKE INFOR_IN;
                    SELECT Username From `Account` where Username LIKE INFOR_IN;
            END $$;
DELIMITER ; 
CALL Tim_Infor('%HSSV%');


-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email
-- và trong store sẽ tự động gán:
 -- username sẽ giống email nhưng bỏ phần @..mail đi 
 -- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công
DELETE FROM `account` WHERE FullName='Nguyễn Đức Anh';
DROP PROCEDURE IF EXISTS `Insertacc`;
DELIMITER $$
CREATE PROCEDURE `Insertacc`( IN In_Email VARCHAR(50), IN In_Fullname VARCHAR(50))
BEGIN
	DECLARE User_name VARCHAR(50) Default Substring_index(In_Email,'@','1'); -- Lấy ra dữ liệu con từ một chuỗi bằng cách tìm dấu phân cách 
	DECLARE Department_ID TINYINT UNSIGNED DEFAULT 11;
	DECLARE Position_ID TINYINT UNSIGNED DEFAULT 1;
    DECLARE Create_Date DateTime Default NOW();
	INSERT INTO `account` (`Email`, `Username`,`Fullname`,`DepartmentID`,`PositionID`,`CreateDate`)
    VALUES (`In_Email`,`User_name`,`In_Fullname`,`Department_ID`,`Position_ID`,`Create_Date`);
    END $$;
DELIMITER ;
Call `Insertacc`('newacc@gmail.com', 'Nguyễn Đức Anh');


SELECT * FROM `account` WHERE FullName='Nguyễn Đức Anh';



-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
DROP PROCEDURE IF EXISTS TKe_Cau_hoi_Dai_nhat;
DELIMITER $$
CREATE PROCEDURE TKe_Cau_hoi_Dai_nhat(IN Type_Question ENUM('Tự luận','Trắc nghiệm'))
			BEGIN
            
            WiTH `T` AS( 
							SELECT TQ.*, CHARACTER_LENGTH(Q.content) AS `ĐD_content` FROM TypeQuestion TQ
							LEFT JOIN Question Q USING(TypeID)
							WHERE TypeName=Type_Question		)
			Select * FROM  `T`
            Where  `ĐD_content`= (Select `ĐD_content` From `T` Order by `ĐD_content` Desc Limit 1);
            END $$;
DELIMITER ;
CALL TKe_Cau_hoi_Dai_nhat('Trắc nghiệm');
CALL TKe_Cau_hoi_Dai_nhat('Tự luận');



-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
DROP PROCEDURE IF EXISTS DEL_Exam;
DELIMITER $$
CREATE PROCEDURE  DEL_Exam (IN Exam_IN INT )
				BEGIN
                DELETE FROM Exam 
                WHERE ExamID=Exam_IN;
				END $$;
DELIMITER ;
CALL DEL_Exam(1);
SELECT * FROM Exam;


-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử
-- dụng store ở câu 9 để xóa)
-- Sau đó in số lượng record đã xóa từ các table liên quan trong khi xóa 
DROP PROCEDURE IF EXISTS DEL_Exam_3_nam_truoc;
DELIMITER $$
CREATE PROCEDURE  DEL_Exam_3_nam_truoc(OUT Count_ON_Exam INT , OUT Count_ON_Examquestion INT )
		BEGIN
                DECLARE PRINT_Del_info_Exam VARCHAR(50) ;

				-- Tạo bảng tạm chứa exam cần xóa
                DROP taBLE IF EXISTs DEL_exam_3_nam;
				create Table DEL_exam_3_nam(
				ID_Def			TiNYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
				ExamID			SMALLINT UNSIGNED,
                CreateDate 		DATETIME );
                
                -- Insert vào bảng tạm thông tin về exam cần xóa 
                INSERT INTO DEL_exam_3_nam(ExamID, CreateDate)
                SELECT e.ExamID, e.CreateDate  FROM exam e WHERE (year(now()) - year(e.CreateDate)) >2;
				SELECT * FROM DEL_exam_3_nam;
                
                -- Lấy số lượng số Exam và ExamQuestion cần xóa.
				SELECT count(EXamID) INTO Count_ON_Exam   FROM DEL_exam_3_nam;
                SELECT count(ex.ExamID) INTO Count_ON_Examquestion FROM  examquestion ex
				INNER JOIN DEL_exam_3_nam DEL ON ex.ExamID = DEL.ExamID;
                
                -- xóa exam tạo 3 năm trước 
                 delete from exam where ExamID IN (SELECT DEL_exam_3_nam.ExamID FROM  DEL_exam_3_nam);
                 delete from examquestion  where ExamID IN (SELECT DEL_exam_3_nam.ExamID FROM  DEL_exam_3_nam);
                 
                  -- In câu thông báo số lượng record đã xóa từ các table liên quan trong khi xóa
				 SELECT CONCAT("Đã xóa", Count_ON_Exam ," Exam trong bảng Exam và ", Count_ON_Examquestion ," Exam trong bảng ExamQuestion") AS `Thông báo`;
				 
                -- Xóa bảng tạm sau khi hoàn thành
				DROP TABLE IF EXISTS DEL_exam_3_nam;
		END $$ ;
DELIMITER ;
CALL DEL_Exam_3_nam_truoc(@countexam, @countexamquestion);

-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng
-- nhập vào tên phòng ban 
-- và các account thuộc phòng ban đó sẽ được chuyển về phòng ban default là phòng ban chờ việc
DROP PROCEDURE IF EXISTS DEL_DEPARTMENT;
DELIMITER $$
CREATE PROCEDURE DEL_DEPARTMENT(IN Name_Of_Department VARCHAR(50))
		BEGIN
				-- Tìm ra những account thuộc phòng ban sắp bị xóa 
                -- SELECT	A.DepartmentID FROM `Account` A
                -- RIGHT JOIN Department D USING(DepartmentID)
                -- WHERE D.DepartmentName LIKE Name_Of_Department
                -- ORDER BY A.DepartmentID DESC LIMIT 1;
				
                -- Tạo phòng ban chờ 
                INSERT INTO Department(DepartmentID,DepartmentName) VALUES ('505','PHÒNG CHỜ');
                
                -- Chuyển tất cả account đó sang phòng ban Chờ
                UPDATE `Account` SET DepartmentID = '505' WHERE DepartmentID =(SELECT	A.DepartmentID FROM `Account` A
																				RIGHT JOIN Department D USING(DepartmentID)
																				WHERE D.DepartmentName LIKE Name_Of_Department
																				ORDER BY A.DepartmentID DESC LIMIT 1);
                -- Xóa phòng ban đó 
                DELETE FROM Department WHERE DepartmentName LIKE Name_Of_Department;
        END $$;
DELIMITER ;
CALL DEL_DEPARTMENT('%Học sinh%');

SELECT * FROM Department;
SELECT * FROM `account`;


-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay
DROP PROCEDURE IF EXISTS `Questions_Every_Month`;
DELIMITER $$
CREATE PROCEDURE `Questions_Every_Month`(IN MONTH_INPUT INT)
			BEGIN
            SELECT MONTH(Q.CreateDate) AS `Tháng`,Count(Q.QuestionID) AS `Số_câu_hỏi_được_tạo`
			FROM Question Q
            WHERE YEAR(Q.CreateDate) = YEAR(NOW())
            GROUP BY `Tháng`
			HAVING `Tháng`= MONTH_INPUT;
		END $$ ;
DELIMITER ;
CALL `Questions_Every_Month`(1);

-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng gần đây nhất 
-- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")
UPDATE `exammanagement2`.`question` SET `CreateDate` = '2021-05-25' WHERE (`QuestionID` = '3');
select * from `question`;

DROP PROCEDURE IF EXISTS `Questions_Last_6_Month`;
DELIMITER $$
CREATE PROCEDURE `Questions_Last_6_Month`()
			BEGIN
            -- Tạo ra bảng tạm Tất cả các tháng trong năm 
            DROP TABLE IF EXISTS MONTH_OF_YEAR2021;
			CREATE TABLE MONTH_OF_YEAR2021(
			ID_MONTH	TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
			THANG 		TINYINT
			);
			INSERT INTO MONTH_OF_YEAR2021(`THANG`)
			VALUES ('1'),('2'),('3'),('4'),('5'),('6'),('7'),('8'),('9'),('10'),('11'),('12');
            -- Đối chiếu ấy ra tất cả những tháng không có câu hỏi nào được tạo
            /*WITH CTE_T0 AS 
			(SELECT 			MOY.THANG 
			FROM 			QUESTION Q
			RIGHT JOIN 		MONTH_OF_YEAR2021 MOY
			ON 				MONTH(Q.CreateDate)=MOY.THANG
			WHERE 			Q.QUESTIONID IS NULL)
			SELECT *
			FROM CTE_T0
			WHERE 		(MONTH(NOW())-CTE_T0.THANG) <= 5 AND (MONTH(NOW())-CTE_T0.THANG) >=0*/
		
            -- Kết hợp 
			WITH CTE_T0 AS 
							(SELECT 		MOY.THANG AS Tháng,YEAR(NOW()) AS Năm, Count(QuestionID) AS `Số_câu_hỏi_được_tạo`
							FROM 			QUESTION Q
							RIGHT JOIN 		MONTH_OF_YEAR2021 MOY
							ON 				MONTH(Q.CreateDate)=MOY.THANG
							WHERE 			Q.QUESTIONID IS NULL
							GROUP BY		MOY.THANG)
				SELECT 		*
				FROM 		CTE_T0
				WHERE 		(MONTH(NOW())-CTE_T0.Tháng) <= 5 AND (MONTH(NOW())-CTE_T0.Tháng) >=0
				UNION 
				SELECT 		MONTH(Q.CreateDate) AS `Tháng`,YEAR(NOW()) AS Năm,Count(Q.QuestionID) AS `Số_câu_hỏi_được_tạo`
				FROM 		Question Q
				WHERE 		(MONTH(NOW())-MONTH(Q.CreateDate)) <= 5
				GROUP BY 	`Tháng`;
               
             
                
            --  Xóa bảng tạm 
             DROP TABLE IF EXISTS MONTH_OF_YEAR2021;
		
		END $$ ;
DELIMITER ;
CALL `Questions_Last_6_Month`();








