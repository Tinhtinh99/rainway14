USE 		Exammanagement2;

-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
CREATE OR REPLACE VIEW 	`DS_NV` AS 
SELECT					A.*, D.DepartmentName
FROM   					`Account` A 
JOIN  					`Department` D  USING(DepartmentID)
WHERE 					D.Departmentname LIKE '%SALE%';

SELECT * FROM 			`DS_NV`;


-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
CREATE OR REPLACE VIEW 	`Account of many group` AS 
SELECT 					A.*,count(GA.GroupID) AS `Số_nhóm_đã_tham_gia`
FROM 					`Groupaccount` GA 
RIGHT JOIN 				`account` A USING(AccountID)
GROUP BY 				A.AccountID 
HAVING 					`Số_nhóm_đã_tham_gia` = (SELECT count(GA.GroupID) AS `Số_nhóm_đã_tham_gia`
												FROM `Groupaccount` GA 
												RIGHT JOIN `account` A USING(AccountID)
												GROUP BY A.AccountID
												ORDER BY `Số_nhóm_đã_tham_gia` DESC LIMIT 1);
SELECT * FROM 			`Account of many group`;


-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi 
-- LỆNH 1: LẤY RA CÂU HỎI CÓ CONTENT DÀI QUÁ 300 TỪ
Select 					*, Character_length(Q.content) AS `Độ dài content` FROM `Question` Q
WHERE					 Character_length(Q.content) > 300;
-- LỆNH 2: TẠO VIEW 
CREATE OR REPLACE VIEW `Câu_hỏi_quá_dài` AS
Select 					*, Character_length(Q.content) AS `Độ dài content` FROM `Question` Q
WHERE 					Character_length(Q.content) > 300;
SELECT * from 			`Câu_hỏi_quá_dài`;
-- LỆNH 3 : XÓa VIEW 
DROP VIEW  				`Câu_hỏi_quá_dài`;

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
-- Cách 1 dùng hàm max (ưu tiên)
CREATE OR REPLACE VIEW 	`PB` AS 
SELECT					D.*, 
						count(A.accountID) AS `Số nhân viên`
FROM					`Department` D 
LEFT JOIN 				`Account` A USING(DepartmentID)
Group by				D.DepartmentID
HAVING 					`Số nhân viên`= (Select max(`y`.`Số nhân viên`) from (SELECT count(A.accountID) AS `Số nhân viên` FROM `Department` D 
																				LEFT JOIN 	`Account` A USING(DepartmentID)
																				Group by	D.DepartmentID) AS `Y`);
SELECT * FROM 			`PB`;
-- cách 2, dùng order by limit 
CREATE OR REPLACE VIEW `PBc2` AS
SELECT					D.*, 
						count(A.accountID) AS `Số nhân viên`
FROM					`Department` D 
LEFT JOIN 				`Account` A 		USING(DepartmentID)
Group by				D.DepartmentID
HAVING 					`Số nhân viên`=(SELECT count(A.accountID) AS `Số nhân viên`
										FROM  `Department` D 
										LEFT JOIN `Account` A USING(DepartmentID)
										Group by D.DepartmentID
										ORDER BY `Số nhân viên` DESC LIMIT 1);
SELECT * FROM 			`PBc2`;


-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo 
CREATE OR REPLACE VIEW `Q_OF_NGUYEN` AS 
SELECT 					Q.*, A.FULLname AS `người tạo`
FROM 					`Question` Q
JOIN 					`account` A on Q.creatorID = A.accountID 
WHERE 					A.FULLname LIKE 'Nguyễn%';

SELECT * FROM 			`Q_OF_NGUYEN`




