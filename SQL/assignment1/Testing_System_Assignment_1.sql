Drop database if exists Exammanagement;
CREATE DATABASE  	Exammanagement;
USE 				Exammanagement;

CREATE TABLE 		Deparment(
	DepartmentID 	INT,
    DepartmentName 	VARCHAR(50)
);
    
CREATE TABLE  		Posiition (
	PosiitionID		INT,
    PosiitionName 	ENUM('DEV', 'Test','Scrum Master','PM')
);

CREATE TABLE 		Accountt(
	AccountID		INT,
    Email			VARCHAR(50),
    Username		VARCHAR(15),
    Fullname		VARCHAR(50),
    DepartmentID	INT,
    PossitionID		INT,
    CreateDate		DATETIME 
);

CREATE TABLE  		Groupp (
	GroupID			INT,
    GrouppName		VARCHAR(50),
    CreatorID		INT,
    CreateDate		DATETIME
);

CREATE TABLE  		GroupAccount(
	GroupID			INT,
    AccountID		INT,
    JoinDate		DATETIME
);

CREATE TABLE  		TypeQuestion(
	TypeID			INT,
    TypeName		ENUM('Essay','Multiple-Choice')
);

CREATE TABLE  		CategoryQuestion(
	CategoryID		INT,
    CategoryName	VARCHAR(50)	
);

CREATE TABLE  		Question(
	QuestionID		INT,
    Content			VARCHAR(100),
    CategoryID		INT,
    TypeID			INT,
    CreatorID		INT,
    CreateDate		DATETIME
);

CREATE TABLE  		Answer(
	AnswerID		INT,
    Content			VARCHAR(200),
    QuestionID		INT,
    isCorrect		ENUM('Right','Wrong')
);

CREATE TABLE  		Exam(
	ExamID			INT,
    Codee			VARCHAR(15),
    Title			VARCHAR(20),
    CategoryID		INT,
    Duration		TIME,
    CreatorID		INT,
    CreateDate		DATETIME
);

CREATE TABLE  		ExamQuestion(
	ExamID			INT,
    QuestionID		INT 
);