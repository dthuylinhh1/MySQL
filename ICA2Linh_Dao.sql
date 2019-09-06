/*
*Name: Linh Dao
*Date: 28 May, 2019
*Purpose: To create a database to store a table with drink information. To write SELECT statements to query the data.
*/

#drop any existing database; create a new one and use it
DROP DATABASE IF EXISTS db_drinks;
CREATE DATABASE db_drinks;
USE db_drinks;

#drop if the table already exists, create a new one
#DROP TABLE IF EXISTS tbl_drinks;
CREATE TABLE tbl_drinks(
	drink_name  VARCHAR(20) NOT NULL,
	cost		DEC(4,2) NOT NULL,
	carbs		DEC(4,1) NOT NULL,
	color		VARCHAR(10) NOT NULL,
	ice	        ENUM('Y', 'N') NOT NULL,
	calories	TINYINT UNSIGNED NOT NULL
);

#insert data into the drinks table
INSERT INTO tbl_drinks
VALUES
('Blackthorn', 3, 8.4, 'Yellow', 'y', 33),
('Blue Moon', 2.5, 3.2, 'Blue', 'Y', 12),
('Oh My Gosh', 3.5, 8.61, 'Orange', 'Y', 35),
('Lime Fizz', 2.5, 5.4, 'Green', 'Y', 24),
('Kiss on the Lips', 5.5, 42.52, 'Purple', 'Y', 171),
('Hot Gold', 3.2, 32.1, 'Orange', 'N', 135),
('Lone Tree', 3.6, 4.2, 'Red', 'Y', 17),
('Greyhound', 4, 14, 'Yellow', 'Y', 50),
('Indian Summer', 2.8, 7.2, 'Brown', 'N', 30),
('Bull Frog', 2.6, 21.5, 'Tan', 'y', 80),
('Soda and It', 3.8, 4.7, 'Red', 'N', 19),
('P', 3.8, 4.7, 'Red', 'N', 19),
('Pop', 3.8, 4.7, 'Red', 'n', 19);
#last two records added to check that query 8 works properly

SELECT * FROM tbl_drinks;


#1 Select the drinks that have name starting with an ‘B’.
SELECT * FROM tbl_drinks
WHERE drink_name LIKE 'B%';

#2 Select drink name of all the drinks that have more than 50 calories.
SELECT drink_name
FROM tbl_drinks
WHERE calories > 50;

#3 Select all drinks that have no carbs information (remember NULL?).
SELECT * 
FROM tbl_drinks
WHERE carbs IS NULL;

#4 Select all drinks that have a defined calories.
SELECT * 
FROM tbl_drinks
WHERE calories IS NOT NULL;

#5 Select the name, cost, carbs and calories of all drinks that have ‘on’ embedded in their name 
SELECT drink_name, cost, carbs, calories
FROM tbl_drinks
WHERE drink_name LIKE '%on%';

#6 Select the drink name, cost, carbs and calories of all drinks that end with the letter ‘z’. Sort the records in ascending order by drink name.
SELECT drink_name, cost, carbs, calories
FROM tbl_drinks
WHERE drink_name LIKE '%z'
ORDER BY drink_name ASC;

#7 Using the relational operators and the AND verb, select the name and cost of all the drinks that have calories in the range 130 to 170, inclusive.. Display Drink Name and Price($) as the column headings respectively.
SELECT drink_name AS 'Drink Name', cost AS 'Price' 
FROM tbl_drinks
WHERE calories >= 130 AND calories <= 170;

#8 Select all the information of drinks that begin with the letters G through O using the BETWEEN verb. So drink name starts with G, H, I, J, K, L, M, N or O. Sort the records in descending order by drink name.
SELECT *
FROM tbl_drinks
WHERE drink_name BETWEEN 'G' AND 'O' OR drink_name LIKE 'O%'
ORDER BY drink_name DESC;


#9 S9)	Select the drink names of all those drinks that have ice. Display Drink Name as the column heading.
SELECT drink_name AS 'Drink Name'
FROM tbl_drinks
WHERE ice = 'Y';

#10 Use the OR verb to select all drinks that are either blue or red.
SELECT *
FROM tbl_drinks
WHERE color = 'blue' OR color = 'red';

#11 Repeat the above query using the IN verb.
SELECT * 
FROM tbl_drinks
WHERE color IN('blue','red');

#12 Use the NOT IN verb to select all drinks that are neither blue nor red.
SELECT *
FROM tbl_drinks
WHERE color NOT IN('blue','red');

#13 Write a select to display all drinks with a cost greater than $3.75 and less than 50 calories.
SELECT *
FROM tbl_drinks
WHERE cost > 3.75 AND calories <50;

#14 Write a select statement to display the first 5 records of the table.
SELECT *
FROM tbl_drinks
LIMIT 0,5;


