
-- Question 1: Tạo table với các ràng buộc và kiểu dữ liệu
DROP DATABASE IF EXISTS Employee_management;
CREATE DATABASE 		Employee_management;
USE 					Employee_management;


DROP TABLE IF EXISTS	`Department`;
CREATE TABLE			`Department`(
`Department_number`		SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
`Department_name`		VARCHAR(50) UNIQUE KEY NOT NULL
);

DROP TABLE IF EXISTS	`Employee`;
CREATE TABLE			`Employee`(
`Employee_number`		SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
`Employee_name`			VARCHAR(50) UNIQUE KEY NOT NULL,
`Department_number`		SMALLINT UNSIGNED,
FOREIGN KEY (`Department_number`) REFERENCES `Department`(`Department_number`) ON DELETE CASCADE 
);

DROP TABLE IF EXISTS	`Employee_Skill`;
CREATE TABLE			`Employee_Skill`(
`Employee_number`		SMALLINT UNSIGNED,
FOREIGN KEY (`Employee_number`) REFERENCES `Employee`(`Employee_number`) ON DELETE CASCADE ,
`Skill_code`			CHAR(10) NOT NULL CHECK(LENGTH(`Skill_code`) >= '5'),
`Date_Registerrd`		DATE DEFAULT NOW()
);
-- --------------------------------------------------------------------------------------------------
-- Question 2: Thêm ít nhất 10 bản ghi vào table
-- ADD DATA Department
DELETE FROM `department`;
INSERT INTO `employee_management`.`department` (`Department_name`) VALUES ('Phòng Giám Đốc');
INSERT INTO `employee_management`.`department` (`Department_name`) VALUES ('Phòng Kế Toán');
INSERT INTO `employee_management`.`department` (`Department_name`) VALUES ('Phòng Bảo Vệ');
INSERT INTO `employee_management`.`department` (`Department_name`) VALUES ('Phòng Nhân Sự');
INSERT INTO `employee_management`.`department` (`Department_name`) VALUES ('Phòng Văn Thư');
INSERT INTO `employee_management`.`department` (`Department_name`) VALUES ('Phòng Quản Lý');
INSERT INTO `employee_management`.`department` (`Department_name`) VALUES ('Phòng Sale');
INSERT INTO `employee_management`.`department` (`Department_name`) VALUES ('Phòng Marketing');
INSERT INTO `employee_management`.`department` (`Department_name`) VALUES ('Phòng Thiết Kế');
INSERT INTO `employee_management`.`department` (`Department_name`) VALUES ('Phòng Chủ Tịch');

-- ADD DATA Employee 
DELETE FROM `Employee`;
INSERT INTO `employee_management`.`employee` (`Employee_name`, `Department_number`) VALUES ('Hoàng Hoài Thương', '1');
INSERT INTO `employee_management`.`employee` (`Employee_name`, `Department_number`) VALUES ('Nguyễn Văn Việt Anh', '2');
INSERT INTO `employee_management`.`employee` (`Employee_name`, `Department_number`) VALUES ('Nguyễn Tiến Ngọc ', '3');
INSERT INTO `employee_management`.`employee` (`Employee_name`, `Department_number`) VALUES ('Nguyễn Xuân Tùng', '4');
INSERT INTO `employee_management`.`employee` (`Employee_name`, `Department_number`) VALUES ('Nguyễn Viết Thắng', '5');
INSERT INTO `employee_management`.`employee` (`Employee_name`, `Department_number`) VALUES ('Nguyễn Đức Long', '6');
INSERT INTO `employee_management`.`employee` (`Employee_name`, `Department_number`) VALUES ('Cấn Đức Quân', '7');
INSERT INTO `employee_management`.`employee` (`Employee_name`, `Department_number`) VALUES ('Nguyễn Minh Hoàng', '8');
INSERT INTO `employee_management`.`employee` (`Employee_name`, `Department_number`) VALUES ('Nguyễn Minh Phong', '9');
INSERT INTO `employee_management`.`employee` (`Employee_name`, `Department_number`) VALUES ('Nguyễn Văn Toàn', '10');
INSERT INTO `employee_management`.`employee` (`Employee_name`, `Department_number`) VALUES ('Nguyễn Văn Tuân', '1');
INSERT INTO `employee_management`.`employee` (`Employee_name`, `Department_number`) VALUES ('Phạm Thị Hoài ', '1');
INSERT INTO `employee_management`.`employee` (`Employee_name`, `Department_number`) VALUES ('Nguyễn Bảo Châu ', '1');
INSERT INTO `employee_management`.`employee` (`Employee_name`, `Department_number`) VALUES ('Nguyễn Cô VI ', '2');
INSERT INTO `employee_management`.`employee` (`Employee_name`, `Department_number`) VALUES ('Hoàng Văn Văn', '2');
INSERT INTO `employee_management`.`employee` (`Employee_name`, `Department_number`) VALUES ('Chu Minh Phong', '2');

-- ADD DATA Employee Skill 
DELETE FROM `Employee_skill`;
INSERT INTO `Employee_Skill`(Employee_number, Skill_code)
Values 		(1, 'JAVA01'),
			(1,'JAVA02'),
			(2, 'JAVA02'),
			(3, 'JAVA03'),
			(4, 'NET01'),
			(5, 'JAVA01'),
			(6, 'SQL01'),
			(7, 'JAVA01'),
			(8, 'SQL02'),
			(9, 'NET02'),
			(10, 'JAVA04');
-- -----------------------------------------------------------------------------------------------------
-- Question 3: Viết lệnh để lấy ra danh sách nhân viên (name) có skill Java
-- Hướng dẫn: sử dụng UNION 
SELECT 			Employee.Employee_name,
				Employee_skill.Skill_code 
FROM 			employee_skill

INNER JOIN 		Employee 
ON 				Employee.Employee_number = employee_skill.Employee_number
GROUP BY 		employee_skill.Employee_number
HAVING 			Skill_code LIKE '%JAVA%';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
 
SELECT 			Department.Department_name,
				COUNT(Employee.Employee_number) AS 'Số_Nhân_Viên'
FROM 			Employee
INNER JOIN 		Department
ON 				Department.Department_number= Employee.Department_number
GROUP BY 		Employee.Department_number
HAVING 			COUNT(Employee.Employee_number) >=3 ;


-- Question 5: Viết lệnh để lấy ra danh sách nhân viên của mỗi văn phòng ban.
-- Hướng dẫn: sử dụng GROUP By
SELECT 		Department_number AS 'PHÒNG BAN' ,
			Employee_name AS 'NHÂN VIÊN'
FROM 		Employee
GROUP BY 	Employee_name
ORDER BY	Department_number ASC; 

-- Question 6: Viết lệnh để lấy ra danh sách nhân viên có > 1 skills.
--  Hướng dẫn: sử dụng DISTINCT
SELECT DISTINCT 	Employee_name,
					Count(Employee_skill.Employee_number) AS 'SỐ_SKILL'
FROM 				Employee_skill 
INNER JOIN 			Employee 
ON 					Employee.Employee_number=Employee_skill.Employee_number
GROUP BY 			Employee_name
HAVING 				Count(Employee_skill.Employee_number)>1 








