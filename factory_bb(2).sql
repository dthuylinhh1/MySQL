/*
Name: Anju Chawla
Date: June, 2019
Purpose: To create a database and a table therein to store information about factories. To add a field to a table and update the data in the field using CASE statement
*/

#drop, create and use the database
DROP DATABASE IF EXISTS dbfactory;
CREATE DATABASE dbfactory;
USE dbfactory;

#create the table structure
CREATE TABLE factories
(
    id       INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    city     VARCHAR(30),
    province CHAR(2)
   
);

#insert data in the table
INSERT INTO factories (city, province) VALUES ('London', 'ON');
INSERT INTO factories (city, province) VALUES ('Barrie', 'ON');
INSERT INTO factories (city, province) VALUES ('Tacoma', 'WA');
INSERT INTO factories (city, province) VALUES ('Seattle', 'WA');


# add the country field to the table



/*CASE - update different records w/different values
UPDATE [table_name]
SET [field_to_update]
CASE
WHEN [condition1] THEN [new_value1]
WHEN [condition2] THEN [new_value2]
END;*/

#update the country field -if province is ON, set it to CA, if WA, then to US

DESC factories;
SELECT * FROM factories;

    
    











