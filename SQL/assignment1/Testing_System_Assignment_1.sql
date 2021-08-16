DROP DATABASE IF EXISTS  	Exammanagement;
CREATE DATABASE  			Exammanagement;
USE 						Exammanagement;

CREATE TABLE 				Deparment(
	DepartmentID 			TINYINT,
    DepartmentName 			VARCHAR(50)
);
    
CREATE TABLE  				`Position` (
	PositionID				TINYINT,
    PositionName 			ENUM('DEV', 'Test','Scrum Master','PM')
);

CREATE TABLE 		`Account`(
	AccountID		TINYINT,
    Email			VARCHAR(50),
    Username		VARCHAR(15),
    Fullname		VARCHAR(50),
    DepartmentID	TINYINT,
    PositionID		TINYINT,
    CreateDate		DATETIME 
);

CREATE TABLE  		`Group` (
	GroupID			TINYINT,
    GroupName		VARCHAR(50),
    CreatorID		TINYINT,
    CreateDate		DATETIME
);

CREATE TABLE  		GroupAccount(
	GroupID			TINYINT,
    AccountID		TINYINT,
    JoinDate		DATETIME
);

CREATE TABLE  		TypeQuestion(
	TypeID			TINYINT,
    TypeName		ENUM('Essay','Multiple-Choice')
);

CREATE TABLE  		CategoryQuestion(
	CategoryID		TINYINT,
    CategoryName	VARCHAR(50)	
);

CREATE TABLE  		Question(
	QuestionID		TINYINT,
    Content			VARCHAR(100),
    CategoryID		TINYINT,
    TypeID			TINYINT,
    CreatorID		TINYINT,
    CreateDate		DATETIME
);

CREATE TABLE  		Answer(
	AnswerID		TINYINT,
    Content			VARCHAR(200),
    QuestionID		TINYINT,
    isCorrect		ENUM('Right','Wrong')
);

CREATE TABLE  		Exam(
	ExamID			TINYINT,
    Codee			VARCHAR(15),
    Title			VARCHAR(20),
    CategoryID		TINYINT,
    Duration		TIME,
    CreatorID		TINYINT,
    CreateDate		DATETIME
);

CREATE TABLE  		ExamQuestion(
	ExamID			TINYINT,
    QuestionID		TINYINT 
);