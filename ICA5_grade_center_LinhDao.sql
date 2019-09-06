/*
Name : Linh Dao
Date: July 2019
Purpose: To create a database with a table therein  to store grades of students in various courses. Perform sone queries/analysis on the table data. 

*/

#drop existing database, if any. Recreate one by same name and use it.
DROP DATABASE IF EXISTS db_grade_center;
CREATE DATABASE db_grade_center;
USE db_grade_center;

#drop existing table, if any, by the same name
DROP TABLE IF EXISTS tbl_grade_center;

#create the table
CREATE TABLE tbl_grade_center
    (
      id 				INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
      first_name  		VARCHAR(30) NOT NULL,
      last_name   		VARCHAR(30) NOT NULL,
      student_number 	CHAR(10) NOT NULL,
      course      		CHAR(8) NOT NULL,
      grade       		TINYINT UNSIGNED NOT NULL DEFAULT 0
    );
    
#decribe the table structure
DESC tbl_grade_center;

#insert records in the table
INSERT INTO tbl_grade_center(first_name, last_name, student_number, course, grade) VALUES ('Phineas', 'Flynn', '1234510001','COMP2003', 88);
INSERT INTO tbl_grade_center(first_name, last_name, student_number, course, grade) VALUES ('Ferb', 'Fletcher', '1234510002','COMP2003', 100);
INSERT INTO tbl_grade_center(first_name, last_name, student_number, course, grade) VALUES ('Candace','Fletcher', '1234510003','COMP2003', 60);
INSERT INTO tbl_grade_center(first_name, last_name, student_number, course, grade) VALUES ('Baljeet', ' ', '1234510004','COMP2003', 100);
INSERT INTO tbl_grade_center(first_name, last_name, student_number, course, grade) VALUES ('Major', 'Monogram ', '1234510005','COMP2003', 50);
INSERT INTO tbl_grade_center(first_name, last_name, student_number, course, grade) VALUES ('Dr.', 'Doofenshmirtz', '1234510006','COMP2003', 55);
INSERT INTO tbl_grade_center(first_name, last_name, student_number, course, grade) VALUES ('Isabella', 'Garcia-Shapiro', '1234510007','COMP2003', 90);
INSERT INTO tbl_grade_center(first_name, last_name, student_number, course, grade) VALUES ('Phineas', 'Flynn', '1234510001','COMP2007', 79);
INSERT INTO tbl_grade_center (first_name, last_name, student_number, course, grade)VALUES ('Ferb', 'Fletcher', '1234510002','COMP2007', 100);
INSERT INTO tbl_grade_center(first_name, last_name, student_number, course, grade) VALUES ('Candace', 'Fletcher', '1234510003','COMP2007', 72);
INSERT INTO tbl_grade_center(first_name, last_name, student_number, course, grade) VALUES ('Baljeet', ' ', '1234510004','COMP2007', 100);
INSERT INTO tbl_grade_center (first_name, last_name, student_number, course, grade)VALUES ('Major', 'Monogram ', '1234510005','COMP2007', 68);
INSERT INTO tbl_grade_center (first_name, last_name, student_number, course, grade)VALUES ('Dr.', 'Doofenshmirtz', '1234510006','COMP2007', 78);
INSERT INTO tbl_grade_center (first_name, last_name, student_number, course, grade)VALUES ('Isabella', 'Garcia-Shapiro', '1234510007','COMP2007', 88);
INSERT INTO tbl_grade_center (first_name, last_name, student_number, course, grade)VALUES ('Anju', 'Chawla', '1234567890','COMP2007', 88);

#show all records of the table
SELECT * FROM tbl_grade_center;

#1. Find the student(s) with the highest mark in COMP2003, display the first name, last name and grade (2 marks)
SET @highest_mark = (SELECT MAX(grade)
FROM tbl_grade_center
WHERE course = 'COMP2003');

SELECT first_name, last_name, MAX(grade) 'Highest Mark'
FROM tbl_grade_center
GROUP BY first_name
HAVING MAX(grade) = @highest_mark;


#2. List the students by first and last name (no repetitions please), that have any grade at or above 80%. Display the result in descending order of first name (2 marks)
SELECT first_name, last_name
FROM tbl_grade_center
WHERE grade >= 80
GROUP BY first_name
ORDER BY first_name DESC;


#3. List the full name (first name and last name together), student number and the average grade(one place after decimal) with a proper display heading, for each student. Display the result in ascending order of student number (2 marks)
SELECT CONCAT(first_name, ' ', last_name) AS 'Full Name', student_number AS 'Student Number', ROUND(AVG(grade),1) 'Average Mark'
FROM tbl_grade_center
GROUP BY student_number
ORDER BY student_number;

#4 Find the maximum and the minimum mark for the class COMP2003 - display the result with proper display headings (2 marks)
SELECT MIN(grade) 'Minimum Mark', MAX(grade) 'Maximum Mark', course AS 'Course'
FROM tbl_grade_center
WHERE course = 'COMP2003';

#5 Find the average mark for each distinct course- display the course and the average mark , rounded to an integer, with proper display headings (2 marks)
SELECT course AS 'Course', ROUND(AVG(grade)) 'Average Mark'
FROM tbl_grade_center
GROUP BY course;
