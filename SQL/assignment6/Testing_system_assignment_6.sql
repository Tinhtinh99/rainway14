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
		BEGIN 
					  DECLARE countQ INT;
					  SELECT TypeID,Count(questionID) as `SL`
                      INTO 	Type_ID, countQ
                      FROM Question Q 
                      Group by TypeID
                      Order by `SL`  DESC LIMIT 1; 
		END $$;
DELIMITER ;
CALL typequestion_nhieu_ch(@TypeOut);
Select @TypeOut;


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
















