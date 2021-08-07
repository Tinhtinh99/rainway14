DROP DATABASE IF EXISTS Fresher_Training_Management;
CREATE DATABASE Fresher_Training_Management;
USE 			Fresher_Training_Management;



DROP TABLE IF EXISTS Trainee;
CREATE TABLE 			Trainee(  
TraineeID 				MEDIUMINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Fullname				VARCHAR(50) NOT NULL,
Birth_Date 				DATE NOT NULL,
Gender					ENUM('Male','Female','Unknown'),
IQ_Test 				TINYINT UNSIGNED NOT NULL CHECK(IQ_Test >=0 AND IQ_Test <= 20),
Gmath_Test 				TINYINT UNSIGNED NOT NULL CHECK(Gmath_Test >=0 AND IQ_Test <= 20),
English_Test			TINYINT UNSIGNED NOT NULL CHECK(English_Test >=0 AND IQ_Test <= 50),
Training_Class			CHAR(10) NOT NULL,
Evaluation_Note 		VARCHAR(500)
);

ALTER TABLE Trainee ADD VTI_Account VARCHAR(50) NOT NULL UNIQUE KEY;

DROP TABLE IF EXISTS EX2;
CREATE TABLE EX2(
ID 						MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
`NAME`					VARCHAR(50),
`Code`					CHAR(5) CHECK (length(`code`)=5),
ModifiedDate 			DATETIME NOT NULL   
);

DROP TABLE IF EXISTS EX3;
CREATE TABLE 		EX3(
ID 						MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
`NAME`					VARCHAR(50),
Birthdate				DATE,
Gender					TINYINT UNSIGNED CHECK (Gender=0 Or gender=1),
IsDeletedFlag			ENUM('0','1')
);


