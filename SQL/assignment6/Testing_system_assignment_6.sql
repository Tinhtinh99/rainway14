use exammanagement_official;
-- ======================================================================================================================--
-- ======================================================================================================================--
-- ======================================================================================================================--
-- ======================================================================================================================--
-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó

DROP PROCEDURE IF EXISTS st_acc_of_department;
DELIMITER $$ 
	CREATE PROCEDURE st_acc_of_department(IN DepartmenName_Input Varchar(50))
		BEGIN
					  SELECT A.FullName
                      FROM `account` A
                      RIGHT JOIN department D  USING(DepartmentID)
					  WHERE D.DepartmentName LIKE DepartmenName_Input;
		END $$;
DELIMITER ;

CALL st_acc_of_department('%học sinh%');

-- Question 2: Tạo store để in ra số lượng account trong mỗi group

DROP PROCEDURE IF EXISTS st_acc_of_group;
DELIMITER $$
	CREATE PROCEDURE st_acc_of_group()
		BEGIN
					  SELECT G.GroupID,G.GroupName, count(GA.accountID) SL_ACCOUNT
                      FROM `groupaccount` GA
                      RIGHT JOIN  `Group` G USING(GroupID)
                      Group by G.GroupID;
		END $$;
DELIMITER ;
CALL st_acc_of_group();

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo
-- trong tháng hiện tại
INSERT INTO `exammanagement_official`.`question` (`QuestionID`, `Content`, `CategoryID`, `TypeID`, `CreatorID`, `CreateDate`) VALUES ('20', 'Câu hỏi về khí nén ', '6', '1', '3', '2021-08-15');
DROP PROCEDURE IF EXISTS Thong_ke_typequestion;
DELIMITER $$ 
	CREATE PROCEDURE Thong_ke_typequestion()
		BEGIN 
					  SELECT TQ.TypeID, count(Q.questionID) SL_question
                      FROM TypeQuestion TQ
                      LEFT JOIN  `question` Q USING(TypeID)
					  WHERE MONTH(Q.CreateDate)=MONTH(NOW()) 
                      Group by TQ.TypeID;
				
		END $$;
DELIMITER ;
CALL Thong_ke_typequestion();
 


-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DROP PROCEDURE IF EXISTS st_typeID_nhieu_cau_hoi_nhat;
DELIMITER $$
CREATE PROCEDURE st_typeID_nhieu_cau_hoi_nhat(OUT TypeID_Output INT)
		BEGIN		 
						DECLARE 		CountQuestion INT;
                        SELECT 			TypeID, Count(questionID) AS `SL_Question` INTO TypeID_Output, CountQuestion
						FROM 			Question Q 
						GROUP BY 		TypeID 
                        ORDER BY  		`SL_Question` DESC 
                        LIMIT 1; 
		END $$;
DELIMITER ;	
CALL st_typeID_nhieu_cau_hoi_nhat(@TypeID_Out);	Select @TypeID_Out AS `TypeID_có_nhiều_câu_hỏi_nhất`;

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
 SELECT TypeName From Typequestion Where TypeID=@TypeID_Out;

-- Question 6: Viết 1 store cho phép người dùng nhập vào (1 chuỗi) và (trả về group có tên
-- chứa chuỗi của người dùng nhập) vào hoặc (trả về user có username chứa
-- chuỗi của người dùng nhập vào)
DROP PROCEDURE IF EXISTS sp_getNameAccOrNameGroup;
DELIMITER $$
CREATE PROCEDURE sp_getNameAccOrNameGroup( IN String_Input VARCHAR(50))
BEGIN
		SELECT G.GroupName 
        FROM `group` G WHERE G.GroupName LIKE CONCAT("%",String_Input,"%")
		UNION
		SELECT A.Username FROM `account` A  WHERE A.Username LIKE CONCAT("%",String_Input,"%");
END$$
DELIMITER ;
Call sp_getNameAccOrNameGroup('nv');
-- ĐOẠN NÀY CHƯA TỐI ƯU , KHI TA INPUT VÀO 1 user thì vẫn hiện ra tên user nhưng tên cột vẫn là groupname ( vấn đề nằm ở lệnh union)



DROP PROCEDURE IF EXISTS sp_getNameAccOrNameGroup;
DELIMITER $$
CREATE PROCEDURE sp_getNameAccOrNameGroup( IN String_Input VARCHAR(50),IN `Case` VARCHAR(20))
BEGIN
		IF `Case` = 'GroupName' -- Đoạn này xử lý điều kiện để lấy tên group có tên trùng với chuỗi nhập vào
				THEN SELECT g.GroupName FROM `group` g WHERE g.GroupName LIKE CONCAT("%",String_Input,"%");
		ELSE
					-- Đoạn này xử lý điều kiện khi flag khác 1, khi đó sẽ tìm User mà Username có chứa chuỗi nhập vào.
				SELECT a.Username FROM `account` a WHERE a.Username LIKE CONCAT("%",String_Input,"%");
		END IF;
        -- Đoạn này được hiểu là : Nếu `Case` =1 thì sẽ tìm ra tên group , nếu khác 1 thì sẽ tìm ra tên user 
END$$
DELIMITER ;
Call sp_getNameAccOrNameGroup('V','GroupName');
Call sp_getNameAccOrNameGroup('t','UserName');
-- CÁCH NÀY LÀ TỐI ƯU NHẤT 

DROP PROCEDURE IF EXISTS sp_getNameAccOrNameGroup_Union;
DELIMITER $$
CREATE PROCEDURE sp_getNameAccOrNameGroup_Union( IN var_String VARCHAR(50))
BEGIN
			SELECT g.GroupName AS Name_Group_Username 
            FROM `group` g WHERE g.GroupName LIKE CONCAT("%",var_String,"%")
			UNION
			SELECT a.Username 
            FROM `account` a WHERE a.Username LIKE CONCAT("%",var_String,"%");
END$$
DELIMITER ;
Call sp_getNameAccOrNameGroup_Union('t');
-- UNION NHƯ THẾ NÀY ĐÔI KHI KHÔNG NHẬN RA ĐƯỢC ĐÂU LÀ TÊN GROUP ĐÂU LÀ TÊN USERNAME



-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email
-- và trong store sẽ tự động gán:
 -- username sẽ giống email nhưng bỏ phần @..mail đi 
 -- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công

DELETE FROM `account` WHERE FullName='Nguyễn Đức Anh';
DROP PROCEDURE IF EXISTS `Insertacc`;
DELIMITER $$
CREATE PROCEDURE `Insertacc`( IN Email_input VARCHAR(50), IN Fullname_input VARCHAR(50))
BEGIN
	DECLARE User_name VARCHAR(50) Default Substring_index(Email_input,'@','1'); -- Lấy ra dữ liệu con từ một chuỗi bằng cách tìm dấu phân cách 
	DECLARE Department_ID TINYINT UNSIGNED DEFAULT 11;
	DECLARE Position_ID TINYINT UNSIGNED DEFAULT 1;
    DECLARE Create_Date Date Default(NOW());
	INSERT INTO `account` (`Email`, `Username`,`Fullname`,`DepartmentID`,`PositionID`,`CreateDate`)
    VALUES (`Email_input`,`User_name`,`Fullname_input`,`Department_ID`,`Position_ID`,`Create_date`);
    END $$;
DELIMITER ;
Call `Insertacc`('newacc@gmail.com', 'Nguyễn Đức Anh');


SELECT * FROM `account` WHERE FullName='Nguyễn Đức Anh';


-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất


DROP PROCEDURE IF EXISTS TKe_Cau_hoi_Dai_nhat;
DELIMITER $$
CREATE PROCEDURE TKe_Cau_hoi_Dai_nhat(IN Type_Name_question ENUM('Tự luận','Trắc nghiệm'))
			BEGIN
			DECLARE DM INT;
            SET DM = (SELECT Character_length(Q.Content) AS `Độ_Dài_content`
			FROM Question Q 
			RIGHT JOIN typeQuestion TQ USING(typeID)
			WHERE TQ.typeName = Type_Name_question
			ORDER BY `Độ_Dài_content` DESC LIMIT 1);
            
            SELECT TQ.TypeID,TQ.typeName, Character_length(Q.Content) AS `Độ_Dài_content`
            FROM Question Q 
            RIGHT JOIN typeQuestion TQ USING(typeID)
            WHERE TQ.typeName = Type_Name_question
            Having `Độ_Dài_content` =DM;
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
INSERT INTO Exam(`Code`, Title, CategoryID, Duration, CreatorID, CreateDate)
VALUES ('000001',' Đề thi học phần 1','1','01:30:00','3','2021-07-20');
UPDATE Exam SET ExamID =1 Where `Code`=000001;



-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử
-- dụng store ở câu 9 để xóa)
-- Sau đó in số lượng record đã xóa từ các table liên quan trong khi xóa 
DROP PROCEDURE IF EXISTS st_del_exam_cu;
DELIMITER $$ 
CREATE PROCEDURE st_del_exam_cu()
BEGIN 
				DECLARE Count_exam SMALLINT;
				DECLARE Count_examquestion SMALLINT;
				-- Tìm ra số lượng exam cần xóa ở các bảng liên quan 
				SELECT count(E.examID)  INTO Count_exam 
                From Exam E 
                WHERE E.ExamID IN (SELECT E.ExamID  FROM Exam E  WHERE YEAR(E.CreateDate) =YEAR(Now())-3); 
				
                SELECT Count(Eq.examID) INTO Count_examquestion 
                FROM ExamQuestion EQ 
                WHERE EQ.ExamID IN (SELECT E.ExamID  FROM Exam E  WHERE YEAR(E.CreateDate) =YEAR(Now())-3); 
				
                -- xóa exam 
                DELETE FROM Exam WHERE ExamID IN (SELECT ExamID  FROM Exam  WHERE YEAR(CreateDate) =YEAR(Now())-3);
				DELETE FROM Examquestion  WHERE ExamID IN (SELECT ExamID  FROM Exam  WHERE YEAR(CreateDate) =YEAR(Now())-3);
				
                -- in ra số lượng exam đã xóa từ các bảng liên quan 
				DROP TABLE IF EXISTS `TB`; CREATE TABLE `TB`(MESS VARCHAR(100)); INSERT INTO `TB`
				SELECT CONCAT('Đã xóa ', Count_exam ,' Exam ở bảng Exam và ', Count_examquestion ,' Exam ở bảng examquestion');
				SELECT * FROM `TB`;
				DROP TABLE IF EXISTS `TB`;
END $$;
DELIMITER ; 
Call st_del_exam_cu();

-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng
-- nhập vào tên phòng ban 
-- và các account thuộc phòng ban đó sẽ được chuyển về phòng ban default là phòng ban chờ việc
DROP PROCEDURE IF EXISTS DEL_DEPARTMENT;
DELIMITER $$
CREATE PROCEDURE DEL_DEPARTMENT(IN DepartmentName_Input VARCHAR(50))
		BEGIN
                -- Tạo phòng ban chờ 
                INSERT INTO Department(DepartmentID,DepartmentName) VALUES ('505','PHÒNG CHỜ');
                
                -- Chuyển tất cả account đó sang phòng ban Chờ
                UPDATE `Account` SET DepartmentID = '505' WHERE DepartmentID =(	SELECT	A.DepartmentID FROM `Account` A
																				RIGHT JOIN Department D USING(DepartmentID)
																				WHERE D.DepartmentName LIKE DepartmentName_Input
																				ORDER BY A.DepartmentID DESC LIMIT 1);
                -- Xóa phòng ban đó 
                DELETE FROM Department WHERE DepartmentName LIKE DepartmentName_Input;
        END $$;
DELIMITER ;
CALL DEL_DEPARTMENT('%Học sinh%');

SELECT * FROM Department;
SELECT * FROM `account`;


-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay
DROP PROCEDURE IF EXISTS `Questions_Every_Month`;
DELIMITER $$
CREATE PROCEDURE `Questions_Every_Month`()
			BEGIN
            SELECT MONTH(Q.CreateDate) AS `Tháng`,Count(Q.QuestionID) AS `Số_câu_hỏi_được_tạo`
			FROM Question Q
            WHERE YEAR(Q.CreateDate) = YEAR(NOW())
            GROUP BY `Tháng`;
			
		END $$ ;
DELIMITER ;
CALL `Questions_Every_Month`();

-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng gần đây nhất 
-- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")
DROP PROCEDURE IF EXISTS sp_CountQuesBefore6Month;
DELIMITER $$
CREATE PROCEDURE sp_CountQuesBefore6Month()
BEGIN
-- tạo ra CTE gồm 6 tháng gần đây nhất trong  năm nay ,
WITH CTE_Talbe_6MonthBefore AS (
SELECT MONTH(DATE_SUB(NOW(), INTERVAL 5 MONTH)) AS `MONTH`,
YEAR(DATE_SUB(NOW(), INTERVAL 5 MONTH)) AS `YEAR`
UNION
SELECT MONTH(DATE_SUB(NOW(), INTERVAL 4 MONTH)) AS `MONTH`,
YEAR(DATE_SUB(NOW(), INTERVAL 4 MONTH)) AS `YEAR`
UNION
SELECT MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AS `MONTH`,
YEAR(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AS `YEAR`
UNION
SELECT MONTH(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AS `MONTH`,
YEAR(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AS `YEAR`UNION
SELECT MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS `MONTH`,
YEAR(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS `YEAR`
UNION
SELECT MONTH(NOW()) AS `MONTH`, YEAR(NOW()) AS `YEAR`)
-- ==========================================================
-- join  giữa 2 bảng CTE và question 
SELECT M.`MONTH`,M.`YEAR`,CASE 
								WHEN 
									CONVERT(COUNT(QuestionID) USING utf8) = 0 THEN 'Không có'
									ELSE CONVERT(COUNT(QuestionID) USING utf8)
								END AS `SL`
FROM CTE_Talbe_6MonthBefore M
LEFT JOIN (SELECT * FROM question where CreateDate >= DATE_SUB(NOW(), INTERVAL 6 MONTH) AND CreateDate <= now()) AS `Sub_Question` 
ON M.`MONTH` = MONTH(CreateDate)
GROUP BY M.MONTH
ORDER BY M.MONTH ASC;
END$$
DELIMITER ;
CALL sp_CountQuesBefore6Month;






