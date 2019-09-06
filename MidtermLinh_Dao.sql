/*
*Name: Linh Dao
*Date: 18 June, 2019
*Purpose: To create a database to store a table with movies information.
*/

#set the environment
SET SQL_MODE = 'STRICT_ALL_TABLES';

#drop existing database, if it exists
DROP DATABASE IF EXISTS db_movies;    
#create the database 
CREATE DATABASE db_movies;
#use the database
USE db_movies;

#drop the table, if it exists
DROP TABLE IF EXISTS tbl_movies;

CREATE TABLE tbl_movies(
	movie_id 			VARCHAR(5) NOT NULL,
    movie_title			VARCHAR(50) NOT NULL,
    movie_start_year	YEAR UNSIGNED NOT NULL,
    movie_time			SMALLINT NOT NULL DEFAULT 60,
    movie_language		VARCHAR(20) NOT NULL,
    movie_date_release	DATE 
);

DESC tbl_movies;

INSERT INTO tbl_movies
VALUES
('901' , 'Vertigo'                                            ,     1958 ,      128 , 'Spanish'         , '1958-08-24'),
    ('902' , 'The Innocents'                                      ,     1961 ,      100 , 'English'         , '1962-02-19'),
    ('903' , 'Lawrence of Arabia'                                 ,     1962 ,      216 , 'English'         , '1962-12-11'),
    ('904' , 'The Deer Hunter'                                    ,     1978 ,      183 , 'French'          , '1979-03-08'),
    ('905' , 'Amadeus'                                            ,     1984 ,      160 , 'English'         , '1985-01-07'),
    ('906' , 'Blade Runner'                                       ,     1982 ,      117 , 'English'         , '1982-09-09'),
    ('908' , 'The Usual Suspects'                                 ,     1995 ,      106 , 'English'         , '1995-08-25'),
    ('909' , 'Chinatown'                                          ,     1974 ,      130 , 'English'         , '1974-08-09'),
    ('910' , 'Boogie Nights'                                      ,     1997 ,      155 , 'Spanish'         , '1998-02-16'),
    ('911' , 'Annie\'s Hall'                                      ,     1977 ,       93 , 'English'         , '1977-04-20'),
    ('912' , 'Princess Mononoke'                                  ,     1997 ,      134 , 'Japanese'        , '2001-10-19'),
    ('913' , 'The Shawshank Redemption '                          ,     1994 ,      142 , 'English'         , '1995-02-17'),
    ('915' , 'Titanic'                                            ,     1997 ,      194 , 'English'         , '1998-01-23'),
    ('916' , 'Good Will Hunting'                                  ,     1997 ,      126 , 'English'         , '1998-06-03'),
    ('917' , 'Deliverance'                                        ,     1972 ,      109 , 'English'         , '1982-10-05'),
    ('918' , 'Trainspotting '                                     ,     1996 ,       94 , 'English'         , '1996-02-23') ,
    ('919' , 'The Prestige '                                      ,     2006 ,      130 , 'Spanish'         , '2006-11-10') ,
    ('921' , 'Slumdog Millionaire'                                ,     2008 ,      120 , 'English'         , '2009-01-09') ,
    ('922' , 'Aliens'                                             ,     1986 ,      137 , 'English'         , '1986-08-29'),
    ('923' , 'Beyond the Sea'                                     ,     2004 ,      118 , 'English'         , '2004-11-26'),
    ('924' , 'Avatar'                                             ,     2009 ,      162 , 'English'         , '2009-12-17'),
    ('926' , 'Seven Samurai'                                      ,     1954 ,      207 , 'Japanese'        , '1954-04-26'), 
    ('927' , 'Spirited Away'                                      ,     2001 ,      125 , 'Japanese'        , '2003-09-12'),
    ('928' , 'Back to the Future'                                 ,     1985 ,      116 , 'English'         , '1985-12-04'),
    ('925' , 'Braveheart'                                         ,     1995 ,      178 , 'English'         , '1995-09-08'), 
    ('907' , 'Eyes Wide Shut'                                     ,     1999 ,  DEFAULT, 'French', NULL) ,      
    ('914' , 'American Beauty'                                    ,     1999 ,  DEFAULT, 'English', NULL),         
    ('920' , 'Donnie Darko'                                       ,     2001 ,  DEFAULT, 'English', NULL);

SELECT * FROM tbl_movies;

ALTER TABLE tbl_movies
MODIFY COLUMN movie_id VARCHAR(5) NOT NULL PRIMARY KEY,
ADD COLUMN movie_release_country CHAR(3) AFTER movie_time;

DESC tbl_movies;

SELECT movie_title, movie_time, movie_date_release FROM tbl_movies
WHERE movie_date_release BETWEEN CAST('1900-01-01' AS DATE) AND CAST('1999-12-31' AS DATE);

SELECT * FROM tbl_movies
WHERE movie_title LIKE 'S%' OR movie_title LIKE 'T%';

SELECT * FROM tbl_movies
WHERE YEAR(movie_date_release) = movie_start_year
ORDER BY movie_title DESC;

SELECT movie_title AS 'Movie Name', movie_language AS 'Language' FROM tbl_movies
WHERE movie_language IN('Spanish', 'Japanese');

UPDATE tbl_movies
SET movie_time = 0
WHERE movie_date_release IS NULL;

UPDATE tbl_movies
SET movie_release_country
= CASE
	WHEN movie_language = 'English' THEN 'UK'
    WHEN movie_language = 'French' THEN 'CA'
    WHEN movie_language = 'Spanish' THEN 'USA'
    WHEN movie_language = 'Japanese' THEN 'JP'
END;

SELECT * FROM tbl_movies;

DELETE FROM tbl_movies
WHERE movie_language = 'Japanese';

SELECT * FROM tbl_movies;
