/*
Name: Linh Dao
Date: 14 May, 2019
Purpose: Create a database and a table therein to store drink information
*/

#drop the database if exists 
DROP DATABASE IF EXISTS db_drinks;
#create a databse
CREATE DATABASE db_drinks;
#use the database
USE db_drinks;

#create a table to store drink information
CREATE TABLE tbl_drinks
(
	drink_name		VARCHAR(20) NOT NULL,
    cost			DECIMAL(4,2) NOT NULL,
    carbs			DECIMAL(3,1) NOT NULL,
    drink_color		VARCHAR(10) NOT NULL,
    drink_ice		CHAR(1) NOT NULL DEFAULT 'Y',
    calories		TINYINT UNSIGNED NOT NULL
    
);
#populate the table with drink data
-- fields can be inserted in any order if the field list is provided, with DEFAULT VALUE
INSERT INTO tbl_drinks(drink_name, cost, carbs, drink_color, calories)
VALUES
('Blackthorn',3,8.4,'Yellow',33),
('Blue Moon',2.50,3.2,'Blue',12),
('Oh My Gosh',3.50,8.61,'Orange',35),
('Lime Fizz', 2.50,5.4,'Green',24),
('Kiss on the Lips', 5.50, 42.52, 'Purple',171);

-- fields can be inserted by default provide 6 fields/columns for every record
INSERT INTO tbl_drinks
VALUES
('Hot Gold', 3.20, 32.1, 'Orange','N', 135),
('Lone Tree', 3.60, 4.2, 'Red', 'Y', 17),
('Greyhound', 4.5, 14, 'Yellow', 'Y', 50),
('Indian Summer', 2.80, 7.2, 'Brown', 'N', 30),
('Bull Frog', 2.60, 21.5, 'Tan', 'Y', 80),
('Soda and It', 3.80, 4.7, 'Red', 'N', 19);


#display table names in the database
SHOW TABLES;
#display the structure of the table
DESCRIBE tbl_drinks; 
#display all the columns(*) and all the rows in the table
SELECT * FROM tbl_drinks;



 