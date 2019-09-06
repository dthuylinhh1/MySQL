/**
Name: Linh Dao & Chris
Date: July 2019
Purpose: To create a database and five tables therein, 
populate them with data and extract information from the tables 
*/

SET SQL_MODE = "STRICT_ALL_TABLES";
SET SQL_SAFE_UPDATES=0;
SET DEFAULT_STORAGE_ENGINE =  INNODB;

DROP DATABASE IF EXISTS db_premiere_products;
CREATE DATABASE db_premiere_products;
USE db_premiere_products;



#DROP TABLE IF EXISTS tbl_rep;
CREATE TABLE tbl_rep
(
	rep_num     	CHAR(2) PRIMARY KEY,
	last_name   	CHAR(15) NOT NULL,
	first_name  	CHAR(15) NOT NULL,
	street      	CHAR(15) NOT NULL,
	city        	CHAR(15) NOT NULL,
	state       	CHAR(2) NOT NULL,
	zip         	CHAR(5) NOT NULL,
	commission  	DECIMAL(7,2) UNSIGNED NOT NULL,
	rate        	DECIMAL(3,2) UNSIGNED NOT NULL
);

#DROP TABLE IF EXISTS tbl_customer;
CREATE TABLE tbl_customer
(
	customer_num  		CHAR(3) PRIMARY KEY,
	customer_name 		CHAR(35) NOT NULL,
	street 		      	CHAR(15) NOT NULL,
	city 		        CHAR(15) NOT NULL,
	state 		      	CHAR(2) NOT NULL,
	zip 		        CHAR(5) NOT NULL,
	balance 	      	DECIMAL(8,2) UNSIGNED NOT NULL,
	credit_limit 	  	DECIMAL(8,2) UNSIGNED NOT NULL,
	rep_num 	      	CHAR(2) NOT NULL,
	FOREIGN KEY(rep_num) REFERENCES tbl_rep(rep_num)
 );

#DROP TABLE IF EXISTS tbl_orders;
CREATE TABLE tbl_orders
(
	order_num 	   		CHAR(5) PRIMARY KEY,
	order_date 	   		DATE NOT NULL,
	customer_num 	 	CHAR(3) NOT NULL,
	FOREIGN KEY(customer_num) REFERENCES tbl_customer(customer_num) 
);

#DROP TABLE IF EXISTS tbl_part;
CREATE TABLE tbl_part
(
	part_num 	    	CHAR(4) PRIMARY KEY,
	description 		CHAR(15) NOT NULL,
	on_hand 	    	DECIMAL(4,0) UNSIGNED NOT NULL,
	class 		   	 	CHAR(2) NOT NULL,
	warehouse 	  		CHAR(1) NOT NULL,
	price 		    	DECIMAL(6,2) UNSIGNED NOT NULL
    );

#DROP TABLE IF EXISTS tbl_order_line;
CREATE TABLE tbl_order_line
(
	order_num 	    CHAR(5) NOT NULL,
	part_num 	      CHAR(4) NOT NULL,
	num_ordered	    DECIMAL(3,0) UNSIGNED NOT NULL,
	quoted_price  	DECIMAL(6,2) UNSIGNED NOT NULL,
	PRIMARY KEY(order_num, part_num),
	FOREIGN KEY(order_num) REFERENCES tbl_orders(order_num),
	FOREIGN KEY(part_num)  REFERENCES tbl_part(part_num)
);

INSERT INTO tbl_rep
VALUES
('20','Kaiser','Valerie','624 Randall','Grove','FL','33321',20542.50,0.05),
('35','Hull','Richard','532 Jackson','Sheldon','FL','33553',39216.00,0.07),
('65','Perez','Juan','1626 Taylor','Fillmore','FL','33336',23487.00,0.05);

INSERT INTO tbl_customer
VALUES
('148','Al''s Appliance and Sport','2837 Greenway','Fillmore','FL','33336',6550.00,7500.00,'20'),
('282','Brookings Direct','3827 Devon','Grove','FL','33321',431.50,10000.00,'35'),
('356','Ferguson''s','382 Wildwood','Northfield','FL','33146',5785.00,7500.00,'65'),
('408','The Everything Shop','1828 Raven','Crystal','FL','33503',5285.25,5000.00,'35'),
('462','Bargains Galore','3829 Central','Grove','FL','33321',3412.00,10000.00,'65'),
('524','Kline''s','838 Ridgeland','Fillmore','FL','33336',12762.00,15000.00,'20'),
('608','Johnson''s Department Store','372 Oxford','Sheldon','FL','33553',2106.00,10000.00,'65'),
('687','Lee''s Sport and Appliance','282 Evergreen','Altonville','FL','32543',2851.00,5000.00,'35'),
('725','Deerfield''s Four Seasons','282 Columbia','Sheldon','FL','33553',248.00,7500.00,'35'),
('842','All Season','28 Lakeview','Grove','FL','33321',8221.00,7500.00,'20');

INSERT INTO tbl_orders
VALUES
('21608','2010-10-20','148'),
('21610','2010-10-20','356'),
('21613','2010-10-21','408'),
('21614','2010-10-21','282'),
('21617','2010-10-23','608'),
('21619','2010-10-23','148'),
('21623','2010-10-23','608');


INSERT INTO tbl_part
VALUES
('AT94','Iron',50,'HW','3',24.95),
('BV06','Home Gym',45,'SG','2',794.95),
('CD52','Microwave Oven',32,'AP','1',165.00),
('DL71','Cordless Drill',21,'HW','3',129.95),
('DR93','Gas Range',8,'AP','2',495.00),
('DW11','Washer',12,'AP','3',399.99),
('FD21','Stand Mixer',22,'HW','3',159.95),
('KL62','Dryer',12,'AP','1',349.95),
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

-- 1)
SELECT tbl_rep.rep_num 'Sales Rep Number', CONCAT_WS(' ', first_name, last_name) 'Sales Name', customer_num 'Customer Number', customer_name 'Customer Name'-- *
FROM tbl_rep LEFT OUTER JOIN tbl_customer
ON tbl_rep.rep_num = tbl_customer.rep_num
ORDER BY tbl_rep.rep_num;

-- 2)
SELECT tbl_rep.rep_num 'Sales Rep Number', CONCAT_WS(' ', first_name, last_name) 'Sales Name', customer_num 'Customer Number', customer_name 'Customer Name'
FROM tbl_rep INNER JOIN tbl_customer
ON tbl_rep.rep_num = tbl_customer.rep_num
WHERE credit_limit = 7500
ORDER BY tbl_rep.rep_num;

-- 3)
SELECT order_num 'Order Number', OL.part_num 'Part Number', description 'Part Description', num_ordered 'Number Ordered', quoted_price 'Quoted Price', price 'Unit Price'-- *
FROM tbl_order_line OL LEFT OUTER JOIN tbl_part TP
ON OL.part_num = TP.part_num
ORDER BY order_num;

-- 4)
SELECT description 'Description'-- *
FROM tbl_order_line OL INNER JOIN tbl_part TP
ON OL.part_num = TP.part_num
WHERE order_num = '21610';

-- 5)
SELECT TC1.customer_num, TC1.customer_name, TC1.city, TC2.customer_num, TC2.customer_name-- *
FROM tbl_customer TC1,tbl_customer TC2
WHERE TC1.customer_num <> TC2.customer_num
AND TC1.city = TC2.city
ORDER BY TC1.customer_name;

-- 6)
SELECT tbl_customer.customer_num 'Customer Number' , tbl_customer.customer_name 'Customer Name'-- *
FROM tbl_customer INNER JOIN tbl_orders
ON tbl_customer.customer_num = tbl_orders.customer_num
WHERE rep_num = 65;

-- 7)
SELECT TC.customer_num 'Customer Number' , TC.customer_name 'Customer Name', OD.order_num ' Order Number', OD.order_date 'Order Date'-- *
FROM tbl_customer TC INNER JOIN tbl_orders OD
ON TC.customer_num = OD.customer_num
ORDER BY TC.customer_num;

-- 8)
SELECT TC.customer_num 'Customer Number' , TC.customer_name 'Customer Name', OD.order_num ' Order Number', OD.order_date 'Order Date'-- *
FROM tbl_customer TC LEFT OUTER JOIN tbl_orders OD
ON TC.customer_num = OD.customer_num
ORDER BY TC.customer_num;

-- 9)
SELECT description 'Part Description'
FROM tbl_part
WHERE part_num IN
(SELECT part_num
FROM tbl_order_line
WHERE order_num = 21610);

-- 10)
SELECT order_num 'Order Number', order_date 'Order Date'
FROM tbl_orders
WHERE EXISTS
(SELECT order_num
FROM tbl_order_line
WHERE tbl_order_line.order_num = tbl_orders.order_num
AND part_num = 'DR93');

-- 11)
SELECT order_num, order_date
FROM tbl_orders
WHERE order_num IN
(SELECT order_num
FROM tbl_order_line
WHERE part_num IN
(SELECT part_num
FROM tbl_part
WHERE warehouse = 3));

-- 12)
ALTER TABLE tbl_order_line
ADD COLUMN ORDER_TOTAL DECIMAL(6,2) UNSIGNED NOT NULL;

UPDATE tbl_order_line
SET ORDER_TOTAL = num_ordered * quoted_price;

SELECT customer_num 'Customer Number', order_num 'Order Number', order_date 'Order Date', (SELECT SUM(ORDER_TOTAL) FROM tbl_order_line WHERE tbl_orders.order_num = tbl_order_line.order_num) AS 'ORDER_TOTAL($)'
FROM tbl_orders;

-- 13)
SELECT customer_num 'Customer Number', customer_name 'Customer Name'
FROM tbl_customer
WHERE customer_num IN
(SELECT customer_num
FROM tbl_orders)
AND rep_num = '65';

-- 14)
SELECT customer_num 'Customer Number', customer_name 'Customer Name'
FROM tbl_customer
WHERE customer_num NOT IN
(SELECT customer_num
FROM tbl_orders)
AND rep_num = '65';

-- 15)
-- Solution 1
SET @max_balance = (SELECT MAX(balance)
FROM tbl_customer
WHERE rep_num = '65');

SELECT customer_num 'Customer Number', customer_name 'Customer Name', balance 'Balance', rep_num 'Representative Number'
FROM tbl_customer
WHERE balance > @max_balance;

-- Solution 2
SELECT customer_num 'Customer Number', customer_name 'Customer Name', balance 'Balance', rep_num 'Representative Number'
FROM tbl_customer
WHERE balance > ALL
(SELECT balance
FROM tbl_customer
WHERE rep_num = '65');

-- 16)
-- Solution 1
SET @min_balance = (SELECT MIN(balance)
FROM tbl_customer
WHERE rep_num = '65');

SELECT customer_num 'Customer Number', customer_name 'Customer Name', balance 'Balance', rep_num 'Representative Number'
FROM tbl_customer
WHERE balance > @min_balance;

-- Solution 2
SELECT customer_num 'Customer Number', customer_name 'Customer Name', balance 'Balance', rep_num 'Representative Number'
FROM tbl_customer
WHERE balance > ANY
(SELECT balance
FROM tbl_customer
WHERE rep_num = '65');