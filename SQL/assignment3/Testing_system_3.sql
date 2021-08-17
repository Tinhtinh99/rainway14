USE 								Exammanagement_assignment2;
-- ===================================================================================================================================================================================================
-- ====================================================================================QUERY DATA TESTING_SYSTEM====================================================================================
-- ===================================================================================================================================================================================================
-- Question 2: lấy ra tất cả các phòng ban
SELECT * FROM  	Department;
-- Question 3: lấy ra id của phòng ban "Trưởng bộ môn "
SELECT 			DepartmentID
FROM			Department 
WHERE			DepartmentName ='Trưởng bộ môn';
-- Question 4: lấy ra thông tin account có full name dài nhất
-- cách 1 sử dụng hàm max
SELECT 			*, character_length(fullname) AS 'Độ_dài_full_name' FROM `Account`
WHERE 			character_length(Fullname)=(SELECT MAX(character_length(Fullname)) FROM `Account`);
-- cách 2 dùng order by kết hợp với limit
SELECT 			Fullname AS 'Ten', 
				character_length(fullname) AS 'Độ_dài_full_name' 
FROM 			`account` 
ORDER BY 		character_length(fullname) DESC 
LIMIT 			1 ;
--  Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
-- Cách 1 dùng lệnh With...AS
With 				Fullname_max_and_DepartmenID_là_3 										-- giả lập một bảng đã có sẵn một thuộc tính với câu lệnh
AS					(SELECT * FROM `Account` WHERE DepartmentID = '3')       				-- WITH....ABC....AS.....Điều kiện 1 
SELECT * FROM 		Fullname_max_and_DepartmenID_là_3			  							-- và xem ABC như là một bảng đã có sẵn , mình chỉ cần thêm điều kiện còn lại 
WHERE				character_length(Fullname)= (SELECT max(character_length(Fullname)) FROM Fullname_max_and_DepartmenID_là_3 ) ;
-- Cách 2 
BEGIN WORK;
INSERT INTO  `account` VALUES ('18','thuong1234@gmail.com','thuong1234','Nguyễn Hoàng Hoài THương','3','3','2018-07-11');
ROLLBACK;
SELECT  			*,
					character_length(fullname) AS 'Độ_dài_fullname' 
FROM 				`account` 
WHERE 				DepartmentID = '3'
ORDER BY  			character_length(fullname) DESC
Limit 				1;

-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT * FROM  		`group`
WHERE				 CreateDate < '2019-12-20';

-- Question 7: Lấy ra ID của question có > 4 câu trả lời
BEGIN WORK;
INSERT INTO `exammanagement_assignment2`.`answer` (`AnswerID`, `Content`, `QuestionID`, `isCorrect`) VALUES ('19', 'đáp án java 4', '1', 'right');
ROLLBACK;

SELECT * FROM  	answer;
SELECT 			answer.QuestionID,
				count(answer.QuestionID) AS số_câu_trả_lời_cho_câu_hỏi   
FROM 			Answer 
GROUP BY  		QuestionID
HAVING 			count(answer.QuestionID) > 4 ;


-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
WITH  				CTE_examCode
AS 					( SELECT `code`, CreateDATE, Duration  FROM Exam WHERE Duration >= '01:00:00' )
SELECT * FROM 		CTE_examCode
WHERE				CreateDate < '2019-12-20';

-- Question 9: Lấy ra 5 group được tạo gần đây nhất
SELECT * FROM 		`Group`
ORDER BY 			 CreateDate DESC
LIMIT  				5 ;

-- Question 10: Đếm số nhân viên thuộc department có id = 2
SELECT departmentID, COUNT(*) as Số_lượng_NV FROM `account`
WHERE departmentID = 2 ;

-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT * FROM `account`
WHERE FullName LIKE 'D%o' ;

-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
BEGIN WORK;
DELETE FROM  Exam WHERE CreateDate <'2019-12-20';
ROLLBACK;
-- vì không muốn xóa dữ liệu trên database nên em làm vậy ạ 
-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
BEGIN WORK; 
DELETE FROM question WHERE Content LIKE 'câu hỏi%';
ROLLBACK;

-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
SELECT * FROM `Account`;
UPDATE `Account` SET Fullname='Nguyễn Bá Lộc' , Email='loc.nguyenba@vti.com.vn'
WHERE AccountID=5;

-- Question 15 : update account có id = 5 sẽ thuộc group có id = 4
UPDATE GroupAccount SET GroupID=4
WHERE AccountID=5;
