/*
*Name: Linh Dao
*Date: 28 May, 2019
*Purpose: To create a database to store a table with car information.
*/

#set the environment
SET SQL_MODE = 'STRICT_ALL_TABLES';

#drop existing database, if it exists
DROP DATABASE IF EXISTS db_auto;    
#create the database 
CREATE DATABASE db_auto;
#use the database
USE db_auto;

CREATE TABLE auto(
	color		VARCHAR(10),
    years		SMALLINT UNSIGNED NOT NULL, #YEAR typeUNSUNU
    make		VARCHAR(40) NOT NULL,
    mo			VARCHAR(15) NOT NULL,
    howmuch		DEC(7,2) UNSIGNED NOT NULL
);

INSERT INTO auto 
VALUES
('Silver', 1998, 'Porsche', 'Boxter', 17992.541),
(NULL, 2000, 'Jaguar', 'XJ', 15995),
('Red', 2002, 'Cadillac', 'Escalade', 40215.9);

#display table structure
DESC auto;
#select all records from the table
SELECT * FROM auto;

#rename the table to tbl_auto, deleting any previous one by that name
DROP TABLE IF EXISTS tbl_auto;

#rename table auto to tbl_auto
ALTER TABLE auto
RENAME TO tbl_auto;

#add new column car_id and VIN 
ALTER TABLE tbl_auto
ADD COLUMN car_id TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST,
ADD COLUMN VIN VARCHAR(17) NOT NULL AFTER car_id;

#modify column VIN and make to change type and size
ALTER TABLE tbl_auto
MODIFY COLUMN VIN VARCHAR(17) NOT NULL UNIQUE,
MODIFY COLUMN make VARCHAR(20) NOT NULL AFTER VIN;

#change column name and type
ALTER TABLE tbl_auto
CHANGE COLUMN mo model VARCHAR(20) NOT NULL AFTER make,
CHANGE COLUMN years model_year SMALLINT UNSIGNED NOT NULL,
CHANGE COLUMN howmuch price DEC(7,2) UNSIGNED NOT NULL AFTER model_year;

#Update VIN Number for existing records
UPDATE tbl_auto
SET VIN = 'RNKLK66N33G213481'
WHERE car_id = 1;

UPDATE tbl_auto
SET VIN = 'SADEA16N33G213481'
WHERE car_id = 2;

UPDATE tbl_auto
SET VIN = '3GYEK66N33G213481'
WHERE car_id = 3;

#duplicate entry for key VIN
INSERT INTO tbl_auto(VIN, make, model, color, model_year, price)
VALUES ('3GYEK66N33G213481', 'Toyota', 'Rav4', 'Black', 2018, 50250);

#ALTER TABLE tbl_auto
#ADD CONSTRAINT UNIQUE(VIN)
DESC tbl_auto;

SELECT * FROM tbl_auto;


