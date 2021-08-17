--DML Table Joins One to many relationship (1:M)--

─ psql < movies.sql 
DROP DATABASE
NOTICE:  database "movies_example" does not exist, skipping
DROP DATABASE
CREATE DATABASE
You are now connected to database "movies_example" as user "XuXaO415".
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
INSERT 0 3
INSERT 0 5
INSERT 0 3
INSERT 0 3

om

╭─ /Users/Ommited/22_SQL/22.3_SQL_Relationships/sql-joins-demo  main !3 ······························ ✔  03:57:16 PM 
╰─ psql movies_example 
psql (13.3)
Type "help" for help.

movies_example=# SELECT * FROM movies
movies_example-# ;
 id |            title             | release_year | runtime | rating | studio_id 
----+------------------------------+--------------+---------+--------+-----------
  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1
  2 | Avatar                       |         2009 |     160 | PG-13  |         2
  3 | Black Panther                |         2018 |     140 | PG-13  |         1
  4 | Jurassic World               |         2015 |     124 | PG-13  |         3
  5 | Marvel’s The Avengers        |         2012 |     142 | PG-13  |         1
(5 rows)

movies_example=# INSERT INTO movies (title, release_year, runtime, rating, studio_id)
movies_example-# VALUES('Orion Pictures', 'Amadeus', 1980-10-10, 180, 'R', 4);
ERROR:  INSERT has more expressions than target columns
LINE 2: ...ALUES('Orion Pictures', 'Amadeus', 1980-10-10, 180, 'R', 4);
                                                                    ^
movies_example=# SELECT * FROM movies                                                
;
 id |            title             | release_year | runtime | rating | studio_id 
----+------------------------------+--------------+---------+--------+-----------
  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1
  2 | Avatar                       |         2009 |     160 | PG-13  |         2
  3 | Black Panther                |         2018 |     140 | PG-13  |         1
  4 | Jurassic World               |         2015 |     124 | PG-13  |         3
  5 | Marvel’s The Avengers        |         2012 |     142 | PG-13  |         1
(5 rows)

movies_example=# INSERT INTO movies (title, release_year, runtime, rating, studio_id)
VALUES('Orion Pictures', 'Amadeus', 1980-10-10, 180, 'R', 5);
ERROR:  INSERT has more expressions than target columns
LINE 2: ...ALUES('Orion Pictures', 'Amadeus', 1980-10-10, 180, 'R', 5);
                                                                    ^
movies_example=# INSERT INTO movies (title, release_year, runtime, rating, studio_id)
VALUES('Orion Pictures', 'Amadeus', 1980, 180, 'R', 4);
ERROR:  INSERT has more expressions than target columns
LINE 2: VALUES('Orion Pictures', 'Amadeus', 1980, 180, 'R', 4);
                                                            ^
movies_example=# SELECT * FROM movies                                                
;
 id |            title             | release_year | runtime | rating | studio_id 
----+------------------------------+--------------+---------+--------+-----------
  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1
  2 | Avatar                       |         2009 |     160 | PG-13  |         2
  3 | Black Panther                |         2018 |     140 | PG-13  |         1
  4 | Jurassic World               |         2015 |     124 | PG-13  |         3
  5 | Marvel’s The Avengers        |         2012 |     142 | PG-13  |         1
(5 rows)

movies_example=# INSERT INTO movies (title, relase_year, runtime, rating, studio_id)
movies_example-# VALUES('Amadeus', 1984, 180, 'R' 4);
ERROR:  syntax error at or near "4"
LINE 2: VALUES('Amadeus', 1984, 180, 'R' 4);
                                         ^
movies_example=# INSERT INTO movies (title, relase_year, runtime, rating, studio_id)
VALUES('Amadeus', 1984, 180, 'R', 4);
ERROR:  column "relase_year" of relation "movies" does not exist
LINE 1: INSERT INTO movies (title, relase_year, runtime, rating, stu...
                                   ^
movies_example=# INSERT INTO movies (title, release_year, runtime, rating, studio_id)
VALUES('Amadeus', 1984, 180, 'R' 4);
ERROR:  syntax error at or near "4"
LINE 2: VALUES('Amadeus', 1984, 180, 'R' 4);
                                         ^
movies_example=# INSERT INTO movies (title, release_year, runtime, rating, studio_id)
VALUES('Amadeus', 1984, 180, 'R', 4);
ERROR:  insert or update on table "movies" violates foreign key constraint "movies_studio_id_fkey"
DETAIL:  Key (studio_id)=(4) is not present in table "studios".
movies_example=# SELECT * FROM movies
movies_example-# ;
 id |            title             | release_year | runtime | rating | studio_id 
----+------------------------------+--------------+---------+--------+-----------
  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1
  2 | Avatar                       |         2009 |     160 | PG-13  |         2
  3 | Black Panther                |         2018 |     140 | PG-13  |         1
  4 | Jurassic World               |         2015 |     124 | PG-13  |         3
  5 | Marvel’s The Avengers        |         2012 |     142 | PG-13  |         1
(5 rows)

movies_example=# INSERT INTO studios (name, founded_in) VALUES ('Orion Pictures', '1980-10-10');
INSERT 0 1
movies_example=# SELECT * FROM studios;
 id |                name                 | founded_in 
----+-------------------------------------+------------
  1 | Walt Disney Studios Motion Pictures | 1953-06-23
  2 | 20th Century Fox                    | 1935-05-31
  3 | Universal Pictures                  | 1912-04-30
  4 | Orion Pictures                      | 1980-10-10
(4 rows)

movies_example=# INSERT INTO movies(title, release_year, runtime, rating, studio_id)
movies_example-# VALUES('Amadeus', 1984, 180, 'R', 4);
INSERT 0 1
movies_example=# SELECT * FROM movies;
 id |            title             | release_year | runtime | rating | studio_id 
----+------------------------------+--------------+---------+--------+-----------
  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1
  2 | Avatar                       |         2009 |     160 | PG-13  |         2
  3 | Black Panther                |         2018 |     140 | PG-13  |         1
  4 | Jurassic World               |         2015 |     124 | PG-13  |         3
  5 | Marvel’s The Avengers        |         2012 |     142 | PG-13  |         1
  7 | Amadeus                      |         1984 |     180 | R      |         4
(6 rows)

movies_example=# SELECT id FROM studios WHERE name = 'Walt Disney Studios Motion Pictures';
 id 
----
  1
(1 row)

movies_example=# SELECT * FROM movies WHERE studio_id  = 1;
 id |            title             | release_year | runtime | rating | studio_id 
----+------------------------------+--------------+---------+--------+-----------
  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1
  3 | Black Panther                |         2018 |     140 | PG-13  |         1
  5 | Marvel’s The Avengers        |         2012 |     142 | PG-13  |         1
(3 rows)

movies_example=# SELECT * FROM movies WHERE studio_id  = 2;
 id | title  | release_year | runtime | rating | studio_id 
----+--------+--------------+---------+--------+-----------
  2 | Avatar |         2009 |     160 | PG-13  |         2
(1 row)

movies_example=# SELECT * FROM movies WHERE studio_id  = 3;
 id |     title      | release_year | runtime | rating | studio_id 
----+----------------+--------------+---------+--------+-----------
  4 | Jurassic World |         2015 |     124 | PG-13  |         3
(1 row)

movies_example=# SELECT title, name FROM movies JOIN studios ON movies.studio_id = studio.id;
ERROR:  missing FROM-clause entry for table "studio"
LINE 1: ...me FROM movies JOIN studios ON movies.studio_id = studio.id;
                                                             ^
movies_example=# SELECT title, name FROM movies JOIN studios ON movies.studio_id = studios.id;
            title             |                name                 
------------------------------+-------------------------------------
 Star Wars: The Force Awakens | Walt Disney Studios Motion Pictures
 Avatar                       | 20th Century Fox
 Black Panther                | Walt Disney Studios Motion Pictures
 Jurassic World               | Universal Pictures
 Marvel’s The Avengers        | Walt Disney Studios Motion Pictures
 Amadeus                      | Orion Pictures
(6 rows)

movies_example=# SELECT * FROM movies JOIN studios ON movies.studio_id = studios.id;
movies_example=# SELECT title, founded_in FROM movies JOIN studios ON movies.studio_id = studios.id;
            title             | founded_in 
------------------------------+------------
 Star Wars: The Force Awakens | 1953-06-23
 Avatar                       | 1935-05-31
 Black Panther                | 1953-06-23
 Jurassic World               | 1912-04-30
 Marvel’s The Avengers        | 1953-06-23
 Amadeus                      | 1980-10-10
(6 rows)

movies_example=# SELECT movies.id, studios_id FROM movies JOIN studios ON movies.studio_id = studios.id;
ERROR:  column "studios_id" does not exist
LINE 1: SELECT movies.id, studios_id FROM movies JOIN studios ON mov...
                          ^
HINT:  Perhaps you meant to reference the column "movies.studio_id".
movies_example=# SELECT movies_id movies.studios_id FROM movies JOIN studios ON moies.studio_id = studios.id;
ERROR:  syntax error at or near "."
LINE 1: SELECT movies_id movies.studios_id FROM movies JOIN studios ...
                               ^
movies_example=# SELECT movies.id, studios.id FROM movies JOIN studios ON movies.studio_id = studios.id;
 id | id 
----+----
  1 |  1
  2 |  2
  3 |  1
  4 |  3
  5 |  1
  7 |  4
(6 rows)

movies_example=# SELECT * FROM studios JOIN ON studios.id = movies,studios_id;
ERROR:  syntax error at or near "ON"
LINE 1: SELECT * FROM studios JOIN ON studios.id = movies,studios_id...
                                   ^
movies_example=# SELECT * FROM movies INNER JOIN studios ON movies.studio_id = studios.id;
movies_example=# SELECT * FROM movies INNER JOIN studios ON movies.studio_id = studios.id;
movies_example=# SELECT * FROM movies;
 id |            title             | release_year | runtime | rating | studio_id 
----+------------------------------+--------------+---------+--------+-----------
  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1
  2 | Avatar                       |         2009 |     160 | PG-13  |         2
  3 | Black Panther                |         2018 |     140 | PG-13  |         1
  4 | Jurassic World               |         2015 |     124 | PG-13  |         3
  5 | Marvel’s The Avengers        |         2012 |     142 | PG-13  |         1
  7 | Amadeus                      |         1984 |     180 | R      |         4
(6 rows)

movies_example=# INSERT INTO movies (title, release_year, runtime, rating)
movies_example-# VALUES('My first Indie Movie', 2015, 90, 'PG-12');
INSERT 0 1
movies_example=# INSERT INTO movies (title, release_year, runtime, rating)
movies_example-# VALUES('My second indie movie', 2020, 110, 'R');
INSERT 0 1
movies_example=# SELECT * FROM movies;
 id |            title             | release_year | runtime | rating | studio_id 
----+------------------------------+--------------+---------+--------+-----------
  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1
  2 | Avatar                       |         2009 |     160 | PG-13  |         2
  3 | Black Panther                |         2018 |     140 | PG-13  |         1
  4 | Jurassic World               |         2015 |     124 | PG-13  |         3
  5 | Marvel’s The Avengers        |         2012 |     142 | PG-13  |         1
  7 | Amadeus                      |         1984 |     180 | R      |         4
  8 | My first Indie Movie         |         2015 |      90 | PG-12  |          
  9 | My second indie movie        |         2020 |     110 | R      |          
(8 rows)

movies_example=# INSERT INTO studios (name, founded_in) VALUES ('Love my Pup pictures', 2012-12-12);
ERROR:  column "founded_in" is of type date but expression is of type integer
LINE 1: ...name, founded_in) VALUES ('Love my Pup pictures', 2012-12-12...
                                                             ^
HINT:  You will need to rewrite or cast the expression.
movies_example=# INSERT INTO studios (name, founded_in) VALUES ('Love my Pup pictures', '2012-12-12');
INSERT 0 1
movies_example=# SELECT * FROM studios;
 id |                name                 | founded_in 
----+-------------------------------------+------------
  1 | Walt Disney Studios Motion Pictures | 1953-06-23
  2 | 20th Century Fox                    | 1935-05-31
  3 | Universal Pictures                  | 1912-04-30
  4 | Orion Pictures                      | 1980-10-10
  5 | Love my Pup pictures                | 2012-12-12
(5 rows)

movies_example=# INSERT INTO studios (name, founded_in) VALUES ('Love my Pup pictures', '1985-10-31');
INSERT 0 1
movies_example=# SELECT * FROM studios;
 id |                name                 | founded_in 
----+-------------------------------------+------------
  1 | Walt Disney Studios Motion Pictures | 1953-06-23
  2 | 20th Century Fox                    | 1935-05-31
  3 | Universal Pictures                  | 1912-04-30
  4 | Orion Pictures                      | 1980-10-10
  5 | Love my Pup pictures                | 2012-12-12
  6 | Love my Pup pictures                | 1985-10-31
(6 rows)

movies_example=# DELETE * FROM studios WHERE founded_in = 1985-10-31;
ERROR:  syntax error at or near "*"
LINE 1: DELETE * FROM studios WHERE founded_in = 1985-10-31;
               ^
movies_example=# DELETE FROM studios WHERE founded_in = 1985-10-31;
ERROR:  operator does not exist: date = integer
LINE 1: DELETE FROM studios WHERE founded_in = 1985-10-31;
                                             ^
HINT:  No operator matches the given name and argument types. You might need to add explicit type casts.
movies_example=# DELETE FROM studios WHERE founded_in = '1985-10-31';
DELETE 1
movies_example=# SELECT * FROM studios;
 id |                name                 | founded_in 
----+-------------------------------------+------------
  1 | Walt Disney Studios Motion Pictures | 1953-06-23
  2 | 20th Century Fox                    | 1935-05-31
  3 | Universal Pictures                  | 1912-04-30
  4 | Orion Pictures                      | 1980-10-10
  5 | Love my Pup pictures                | 2012-12-12
(5 rows)

movies_example=# INSERT INTO studios (name, founded_in) 
movies_example-# VALUES ('EDG pictures', '1985-10-31');
INSERT 0 1
movies_example=# SELECT * FROM studios;
 id |                name                 | founded_in 
----+-------------------------------------+------------
  1 | Walt Disney Studios Motion Pictures | 1953-06-23
  2 | 20th Century Fox                    | 1935-05-31
  3 | Universal Pictures                  | 1912-04-30
  4 | Orion Pictures                      | 1980-10-10
  5 | Love my Pup pictures                | 2012-12-12
  7 | EDG pictures                        | 1985-10-31
(6 rows)

movies_example=# SELECT title, name FROM movies INNER JOIN studios ON movies.studios_id = studios_id;
ERROR:  column movies.studios_id does not exist
LINE 1: ...ECT title, name FROM movies INNER JOIN studios ON movies.stu...
                                                             ^
HINT:  Perhaps you meant to reference the column "movies.studio_id".
movies_example=# SELECT title, name FROM movies INNER JOIN studios ON movies.studio_id = studios_id;
ERROR:  column "studios_id" does not exist
LINE 1: ...M movies INNER JOIN studios ON movies.studio_id = studios_id...
                                                             ^
HINT:  Perhaps you meant to reference the column "movies.studio_id".
movies_example=# SELECT title, name FROM movies INNER JOIN studios ON movies.studio_id = studios.id;
            title             |                name                 
------------------------------+-------------------------------------
 Star Wars: The Force Awakens | Walt Disney Studios Motion Pictures
 Avatar                       | 20th Century Fox
 Black Panther                | Walt Disney Studios Motion Pictures
 Jurassic World               | Universal Pictures
 Marvel’s The Avengers        | Walt Disney Studios Motion Pictures
 Amadeus                      | Orion Pictures
(6 rows)

movies_example=# SELCT title, name AS studio_name FROM movies LEFT JOIN studios ON movies.studio_id = studios.id;
ERROR:  syntax error at or near "SELCT"
LINE 1: SELCT title, name AS studio_name FROM movies LEFT JOIN studi...
        ^
movies_example=# SELECT title, name AS studio_name FROM movies LEFT JOIN studios ON movies.studio_id = studios.id;
            title             |             studio_name             
------------------------------+-------------------------------------
 Star Wars: The Force Awakens | Walt Disney Studios Motion Pictures
 Avatar                       | 20th Century Fox
 Black Panther                | Walt Disney Studios Motion Pictures
 Jurassic World               | Universal Pictures
 Marvel’s The Avengers        | Walt Disney Studios Motion Pictures
 Amadeus                      | Orion Pictures
 My first Indie Movie         | 
 My second indie movie        | 
(8 rows)

movies_example=# SELECT title, name AS studio_name FROM movies RIGHT JOIN studios ON movies.studio_id = studios.id;
            title             |             studio_name             
------------------------------+-------------------------------------
 Star Wars: The Force Awakens | Walt Disney Studios Motion Pictures
 Avatar                       | 20th Century Fox
 Black Panther                | Walt Disney Studios Motion Pictures
 Jurassic World               | Universal Pictures
 Marvel’s The Avengers        | Walt Disney Studios Motion Pictures
 Amadeus                      | Orion Pictures
                              | EDG pictures
                              | Love my Pup pictures
(8 rows)

movies_example=# SELECT * FROM movies RIGHT JOIN studios ON movies.studio_id = studios.id;
movies_example=# SELECT * FROM movies LEFT JOIN studios ON movies.studio_id = studios.id;
 id |            title             | release_year | runtime | rating | studio_id | id |                name                 | founded_in 
----+------------------------------+--------------+---------+--------+-----------+----+-------------------------------------+------------
  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1 |  1 | Walt Disney Studios Motion Pictures | 1953-06-23
  2 | Avatar                       |         2009 |     160 | PG-13  |         2 |  2 | 20th Century Fox                    | 1935-05-31
  3 | Black Panther                |         2018 |     140 | PG-13  |         1 |  1 | Walt Disney Studios Motion Pictures | 1953-06-23
  4 | Jurassic World               |         2015 |     124 | PG-13  |         3 |  3 | Universal Pictures                  | 1912-04-30
  5 | Marvel’s The Avengers        |         2012 |     142 | PG-13  |         1 |  1 | Walt Disney Studios Motion Pictures | 1953-06-23
  7 | Amadeus                      |         1984 |     180 | R      |         4 |  4 | Orion Pictures                      | 1980-10-10
  8 | My first Indie Movie         |         2015 |      90 | PG-12  |           |    |                                     | 
  9 | My second indie movie        |         2020 |     110 | R      |           |    |                                     | 
(8 rows)

movies_example=# SELECT * FROM studios RIGHT JOIN movies ON movies.studio_id = studios.id;
 id |                name                 | founded_in | id |            title             | release_year | runtime | rating | studio_id 
----+-------------------------------------+------------+----+------------------------------+--------------+---------+--------+-----------
  1 | Walt Disney Studios Motion Pictures | 1953-06-23 |  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1
  2 | 20th Century Fox                    | 1935-05-31 |  2 | Avatar                       |         2009 |     160 | PG-13  |         2
  1 | Walt Disney Studios Motion Pictures | 1953-06-23 |  3 | Black Panther                |         2018 |     140 | PG-13  |         1
  3 | Universal Pictures                  | 1912-04-30 |  4 | Jurassic World               |         2015 |     124 | PG-13  |         3
  1 | Walt Disney Studios Motion Pictures | 1953-06-23 |  5 | Marvel’s The Avengers        |         2012 |     142 | PG-13  |         1
  4 | Orion Pictures                      | 1980-10-10 |  7 | Amadeus                      |         1984 |     180 | R      |         4
    |                                     |            |  8 | My first Indie Movie         |         2015 |      90 | PG-12  |          
    |                                     |            |  9 | My second indie movie        |         2020 |     110 | R      |          
(8 rows)

movies_example=# SELECT * FROM studios FULL JOIN movies ON movies.studio_id = studios.id;
 id |                name                 | founded_in | id |            title             | release_year | runtime | rating | studio_id 
----+-------------------------------------+------------+----+------------------------------+--------------+---------+--------+-----------
  1 | Walt Disney Studios Motion Pictures | 1953-06-23 |  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1
  2 | 20th Century Fox                    | 1935-05-31 |  2 | Avatar                       |         2009 |     160 | PG-13  |         2
  1 | Walt Disney Studios Motion Pictures | 1953-06-23 |  3 | Black Panther                |         2018 |     140 | PG-13  |         1
  3 | Universal Pictures                  | 1912-04-30 |  4 | Jurassic World               |         2015 |     124 | PG-13  |         3
  1 | Walt Disney Studios Motion Pictures | 1953-06-23 |  5 | Marvel’s The Avengers        |         2012 |     142 | PG-13  |         1
  4 | Orion Pictures                      | 1980-10-10 |  7 | Amadeus                      |         1984 |     180 | R      |         4
    |                                     |            |  8 | My first Indie Movie         |         2015 |      90 | PG-12  |          
    |                                     |            |  9 | My second indie movie        |         2020 |     110 | R      |          
  7 | EDG pictures                        | 1985-10-31 |    |                              |              |         |        |          
  5 | Love my Pup pictures                | 2012-12-12 |    |                              |              |         |        |          
(10 rows)

movies_example=# SELECT name, COUNT(*) FROM movies JOIN studios ON movies.studio_id = studios.id GROUP BY studios.name;
                name                 | count 
-------------------------------------+-------
 Universal Pictures                  |     1
 Orion Pictures                      |     1
 Walt Disney Studios Motion Pictures |     3
 20th Century Fox                    |     1
(4 rows)

movies_example=# SELECT name, COUNT(*) AS total FROM movies JOIN studios ON movies.studio_id = studios.id GROUP BY studios.name
movies_example-# ORDER BY total DESC;
                name                 | total 
-------------------------------------+-------
 Walt Disney Studios Motion Pictures |     3
 Universal Pictures                  |     1
 Orion Pictures                      |     1
 20th Century Fox                    |     1
(4 rows)


-- When trying to delete a studio, we cannot delete it outright while movies still referencing it.
-- You have 2 options:
-- 1. Clear out the studio_id columns of movies that reference it
-- 2. Delete the movies associated with that studio first

-- JOIN Operation - creates a temporary table in memory, combining info from different tables
-- -Data from tables is matched according to a join condition
-- -Most commonly, the join condition involves comparing a foreign key from one table and a primary key in another table
-- ex: SELECT title, name FROM movies JOIN studios ON movies.studio_id = studios.id;

-- JOIN and INNER JOIN are the same in SQL
-- -Only the rows that match the condition in both tables
-- Outer
-- -Left - All the rows from the first table (left) combined with the matching rows from the second table (right)
-- -Right - Vice-versa of above
-- Full - All rows from both tables

--We will mostly use inner join 
--Outer join is helpful when trying to rows in one table with no match in another table
--Outer join example:
--SELECT name FROM movies
--  LEFT JOINS studios
--    ON movies.studio_id = studio.id