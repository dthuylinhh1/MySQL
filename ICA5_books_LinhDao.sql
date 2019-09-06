
#Name: Linh Dao
#Purpose: Create a database and a table therein to store information about authors. Thereafter, alter the table structure by adding new columns. Using string functions, split the data in the address field into the new fields, thereafter dropping the address field

#set the environment
SET SQL_MODE="STRICT_ALL_TABLES";
SET SQL_SAFE_UPDATES = 0;

#drop existing database by same name before creating a new one
DROP DATABASE IF EXISTS db_books;
CREATE DATABASE db_books;

#drop table by same name before creating a new one
#DROP TABLE IF EXISTS db_books.tbl_author_information;

#create the table
CREATE TABLE db_books.tbl_author_information(
author_id CHAR(11) PRIMARY KEY ,
author_lname VARCHAR(10) NOT NULL, 
author_fname VARCHAR(10) NOT NULL,
author_address VARCHAR(50) NOT NULL
);

#insert data into the table
INSERT INTO db_books.tbl_author_information
VALUES
('409-56-7008', 'Bennet','Abraham', '6223 Bateman St., Berkeley, CA, 94705'),
('213-46-8915', 'Green','Marjorie', '309 63rd St. #411, Oakland, CA, 94618'),
('238-95-7766', 'Carson','Cheryl', '589 Darwin Ln., Berkeley, CA, 94705'),
('998-72-3567', 'Ringer','Albert', '67 Seventh Av., Salt Lake City,UT, 84152'),
('899-46-2035', 'Ringer', 'Anne','67 Seventh Av., Salt Lake City, UT, 84152'),
('722-51-5454', 'DeFrance','Michel','3 Balding Pl., Gary, IN, 46403'),
('807-91-6654', 'Panteley','Sylvia','1956 Arlington Pl., Rockville, MD, 20853');

#describe the table structure
DESC db_books.tbl_author_information;
#select all records from the table
SELECT * FROM db_books.tbl_author_information;

#Complete the following requirements now

# 1. Alter the table structure - add four new fields to the end of the table- number_and_street(varchar(20)), city(varchar(15)) , state(char(2)) and zip(char(5)), in the given order (2 marks)
ALTER TABLE db_books.tbl_author_information
ADD COLUMN number_and_street VARCHAR(20), 
ADD COLUMN city VARCHAR(15), 
ADD COLUMN state CHAR(2), 
ADD COLUMN zip CHAR(5); 

# 2. The values for these fields have to be extracted from the address field using string functions. Please note that the address is currently available in 4 sub units, each separated by 'comma followed by a blank' -  number and street, city, state and zip. None of the fields can contain a null value (5 marks)
UPDATE db_books.tbl_author_information
SET number_and_street = TRIM(LEFT(author_address, INSTR(author_address,',')-1)),
    city = TRIM(MID(SUBSTRING_INDEX(author_address,',',2),INSTR(SUBSTRING_INDEX(author_address,',',2),',')+1)),
    state = TRIM(RIGHT(SUBSTRING_INDEX(author_address, ',',3),2)),
    zip = TRIM(RIGHT(author_address,5));
    



#3. Drop the address column since its value has been extracted (1 mark)
ALTER TABLE db_books.tbl_author_information
DROP COLUMN author_address;

#4. Describe the table structure (1 mark)
DESC db_books.tbl_author_information;
#5. Select all records from the table (1 mark)
SELECT * FROM db_books.tbl_author_information;



