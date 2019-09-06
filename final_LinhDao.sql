/*
Name : Linh Dao
Date: 13 August 2019
Purpose: To create a database, some tables therein, 
populate them with data and extract information from the tables 
*/
DROP DATABASE IF EXISTS db_premiere_products;
CREATE DATABASE db_premiere_products;
USE db_premiere_products;


DROP TABLE IF EXISTS tbl_rep;
CREATE TABLE tbl_rep
(
	rep_num     	CHAR(2) PRIMARY KEY,
	last_name   	CHAR(15) NOT NULL,
	first_name  	CHAR(15)  NOT NULL,
	street      	CHAR(15)  NOT NULL,
	city        	CHAR(15)  NOT NULL,
	state       	CHAR(2)  NOT NULL,
	zip         	CHAR(5)  NOT NULL,
	commission  	DECIMAL(7,2) UNSIGNED  NOT NULL,
	rate        	DECIMAL(3,2) UNSIGNED  NOT NULL
);

DROP TABLE IF EXISTS tbl_customer;
CREATE TABLE tbl_customer
(
	customer_num 	CHAR(3) PRIMARY KEY,
	customer_name 	CHAR(35) NOT NULL,
	street 		CHAR(15)  NOT NULL,
	city 		CHAR(15)  NOT NULL,
	state 		CHAR(2)  NOT NULL,
	zip 		CHAR(5)  NOT NULL,
	balance 	DECIMAL(8,2) UNSIGNED  NOT NULL,
	credit_limit 	DECIMAL(8,2) UNSIGNED  NOT NULL,
	rep_num 	CHAR(2)  NOT NULL,
        FOREIGN KEY(rep_num) REFERENCES tbl_rep(rep_num)
 );


DROP TABLE IF EXISTS tbl_orders;
CREATE TABLE tbl_orders
(
	order_num 	CHAR(5) PRIMARY KEY,
	order_date 	DATE  NOT NULL,
	customer_num 	CHAR(3)  NOT NULL,
	FOREIGN KEY(customer_num) REFERENCES tbl_customer(customer_num) 
);

DROP TABLE IF EXISTS tbl_part;
CREATE TABLE tbl_part
(
	part_num 	CHAR(4) PRIMARY KEY,
	description CHAR(15)  NOT NULL,
	on_hand 	DECIMAL(4,0)  NOT NULL,
	class 		CHAR(2)  NOT NULL,
	warehouse 	CHAR(1)  NOT NULL,
	price 		DECIMAL(6,2) UNSIGNED  NOT NULL
    );

DROP TABLE IF EXISTS tbl_order_line;
CREATE TABLE tbl_order_line
(
	order_num 	CHAR(5)  ,
	part_num 	CHAR(4)  ,
	num_ordered 	TINYINT UNSIGNED  NOT NULL,
	quoted_price 	DECIMAL(6,2) UNSIGNED  NOT NULL,
	PRIMARY KEY(order_num, part_num),
	FOREIGN KEY(order_num) REFERENCES tbl_orders(order_num),
	FOREIGN KEY(part_num)  REFERENCES tbl_part(part_num)
);

INSERT INTO tbl_rep
VALUES
('20','Kaiser','Valerie','624 Randall','Grove','FL','33321',20542.50,0.05),
('25','Smith','Greg','124 Jackson','Grove','FL','33321',10042.50,0.05),
('30','Burke','Mark','624 Capilano','Grove','FL','33321',30542.50,0.06),
('35','Hull','Richard','532 Jackson','Sheldon','FL','33553',39216.00,0.07),
('40','jackson','Joanne','124 Jackson','Sheldon','FL','33553',40000.00,0.08),
('65','Perez','Juan','1626 Taylor','Fillmore','FL','33336',23487.00,0.05);

INSERT INTO tbl_customer
VALUES
('148','Al''s Appliance and Sport','2837 Greenway','Fillmore','FL','33336',6550.00,7500.00,'20'),
('282','Brookings Direct','3827 Devon','Grove','FL','33321',431.50,10000.00,'35'),
('356','Ferguson''s','382 Wildwood','Northfield','FL','33146',5785.00,7500.00,'65'),
('408','The Everything Shop','1828 Raven','Crystal','FL','33503',5285.25,5000.00,'35'),
('462','Bargains Galore','3829 Central','Fillmore','FL','33321',3412.00,10000.00,'65'),
('524','Kline''s','838 Ridgeland','Fillmore','FL','33336',12762.00,15000.00,'20'),
('608','Johnson''s Department Store','372 Oxford','Sheldon','FL','33553',2106.00,10000.00,'65'),
('687','Lee''s Sport and Appliance','282 Evergreen','Altonville','FL','32543',2851.00,5000.00,'35'),
('725','Deerfield''s Four Seasons','282 Columbia','Sheldon','FL','33553',248.00,7500.00,'35'),
('842','All Season','28 Lakeview','Grove','FL','33321',8221.00,7500.00,'20');

INSERT INTO tbl_orders
VALUES
('21608','2010-10-20','148'),
('21610','2010-11-20','356'),
('21613','2010-10-21','408'),
('21614','2010-10-21','282'),
('21617','2010-11-23','608'),
('21619','2010-10-23','148'),
('21623','2010-11-25','608');


INSERT INTO tbl_part
VALUES
('AT94','Iron',50,'HW','3',24.95),
('BV06','Home Gym',45,'SG','2',794.95),
('CD52','Microwave Oven',32,'AP','1',165.00),
('DL71','Cordless Drill',21,'HW','3',129.95),
('DR93','Gas Range',8,'AP','2',495.00),
('DW11','Washer',12,'AP','3',399.99),
('FD21','Stand Mixer',22,'HW','3',159.95),
('KL62','Dryer',12,'AP','1',1349.95),
('KT03','Dishwasher',8,'AP','3',595.00),
('KV29','Treadmill',9,'SG','2',1390.00);

INSERT INTO tbl_order_line
VALUES
('21608','AT94',11,21.95),
('21610','DR93',1,495.00),
('21610','DW11',1,399.99),
('21613','KL62',4,329.95),
('21614','KT03',2,595.00),
('21617','BV06',2,794.95),
('21617','CD52',4,150.00),
('21619','DR93',1,495.00),
('21623','KV29',2,1290.00);

SELECT * FROM tbl_rep;
SELECT * FROM tbl_customer;
SELECT * FROM tbl_orders;
SELECT * FROM tbl_part;
SELECT * FROM tbl_order_line;

-- a)
SELECT C.customer_num 'Customer Number', customer_name 'Customer Name', COUNT(order_num) 'Number of Orders'
FROM tbl_customer C INNER JOIN tbl_orders O
ON TRIM(C.customer_num) = TRIM(O.customer_num)
GROUP BY C.customer_num
HAVING COUNT(order_num) >=2
ORDER BY C.customer_num;

-- b)
SELECT CONCAT_WS(' ',first_name,last_name) 'Name', R.rep_num 'Rep Number'
FROM tbl_rep R 
WHERE EXISTS
(SELECT C.rep_num FROM tbl_customer C
WHERE C.rep_num = R.rep_num
AND zip = '33321')
ORDER BY R.rep_num;

-- c)
SELECT part_num, description, price, class
FROM tbl_part
WHERE NOT price < ANY
(SELECT price
FROM tbl_part
WHERE class='AP')
ORDER BY part_num;

-- d)
SELECT P.part_num 'Part Number', description 'Description', on_hand 'Unit On Hand'-- *
FROM tbl_part P LEFT OUTER JOIN tbl_order_line OL
ON TRIM(P.part_num) = TRIM(OL.part_num)
WHERE OL.order_num IS NULL
ORDER BY P.part_num;

