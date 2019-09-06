/*
Name : Linh Dao
Date: 13 August 2019
Purpose: To create a database and a table therein. 
Populate the table with data. Ensure that all tables are in 1NF
The table tbl_student_information given is not in the first normal form(1NF)
*/
SET SQL_MODE = "STRICT_ALL_TABLES";
SET SQL_SAFE_UPDATES=0;
SET DEFAULT_STORAGE_ENGINE =  INNODB;

#drop the databse if exists, create and use it
DROP DATABASE IF EXISTS db_normalization;
CREATE DATABASE db_normalization;
USE db_normalization; 

#drop table if exists and create a new one 
DROP TABLE IF EXISTS tbl_student;
CREATE TABLE tbl_student(
	student_number		CHAR(5) PRIMARY KEY,
    student_name		VARCHAR(50) NOT NULL
);
#drop table if exists and create a new one 
DROP TABLE IF EXISTS tbl_course;
CREATE TABLE tbl_course(
	course_id			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    course_name			VARCHAR(50) NOT NULL
);
#drop table if exists and create a new one 
DROP TABLE IF EXISTS tbl_student_information;
CREATE TABLE tbl_student_information(
	student_number		CHAR(5) NOT NULL,
    CONSTRAINT C1_FK
    FOREIGN KEY(student_number)
    REFERENCES tbl_student(student_number),
    course_id			INT UNSIGNED NOT NULL,
    CONSTRAINT C2_FK
    FOREIGN KEY(course_id)
    REFERENCES tbl_course(course_id),
    
    PRIMARY KEY(student_number, course_id)
);

#insert records in the table tbl_student
INSERT INTO tbl_student(student_number, student_name)
VALUES
('12345','Anju Chawla'),
('13456','Ross Bigelow'),
('12333','Jaret Wright');
#insert records in the table tbl_course
INSERT INTO tbl_course(course_name)
VALUES
('COMP2003'),
('MATH1003'),
('COMP1008'),
('COMP1090');

#insert records in the table tbl_student_information
INSERT INTO tbl_student_information(student_number, course_id)
VALUES
('12345',1),
('12345',2),
('12345',3),
('13456',1),
('13456',4),
('12333',1);

#display the structure of all tables
DESC tbl_student_information;
DESC tbl_student;
DESC tbl_course;

#show all records from all  tables
SELECT * FROM tbl_student;
SELECT * FROM tbl_course;
SELECT * FROM tbl_student_information;

#see which student is currently taking which course
DROP VIEW IF EXISTS view_student_enrolled_in_course;
CREATE VIEW view_student_enrolled_in_course AS(
SELECT student_name 'Student Name', course_name 'Course Name'
FROM tbl_student S, tbl_course C, tbl_student_information SC
WHERE S.student_number = SC.student_number
AND C.course_id = SC.course_id);

#show all information
SELECT * FROM view_student_enrolled_in_course;







