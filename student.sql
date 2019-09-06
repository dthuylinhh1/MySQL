/*
Name: Linh Dao
Date: May 7, 2019
Purpose: Create a database and a table therein to store student information
*/
#drop the database if exists
DROP DATABASE IF EXISTS db_georgiancollege;
#create a database
CREATE DATABASE db_georgiancollege;
#use the database
USE db_georgiancollege;

#create a table to store student information
#example of DDL - data defining language
CREATE TABLE tbl_students
(
	student_name 	VARCHAR(50),
    student_age 	TINYINT UNSIGNED,
    birthplace		VARCHAR(40),
    student_email 	VARCHAR(40),
    semester_fee	DECIMAL(6,2),
    job_desired 	VARCHAR(80),
    favorite_sites	VARCHAR(100)
);
