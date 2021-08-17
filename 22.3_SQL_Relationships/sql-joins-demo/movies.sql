-- in terminal:
-- psql < movies.sql
-- psql movies_example

DROP DATABASE IF EXISTS  movies_example;
DROP DATABASE IF EXISTS  movies_example;

CREATE DATABASE movies_example;

\c movies_example

CREATE TABLE studios
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  founded_in DATE
);

CREATE TABLE movies
(
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  release_year INTEGER,
  runtime INTEGER,
  rating TEXT,
  studio_id INTEGER REFERENCES studios
);

CREATE TABLE actors
(
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT,
  birth_date DATE NOT NULL
);

CREATE TABLE roles
(
  id SERIAL PRIMARY KEY,
  movie_id INTEGER REFERENCES movies ON DELETE CASCADE,
  actor_id INTEGER REFERENCES actors ON DELETE CASCADE
);

INSERT INTO studios
  (name, founded_in)
VALUES
  ('Walt Disney Studios Motion Pictures', '1953-06-23'),
  ('20th Century Fox', '1935-05-31'),
  ('Universal Pictures', '1912-04-30');

INSERT INTO movies
  (title, release_year, runtime, rating, studio_id)
VALUES
  ('Star Wars: The Force Awakens', 2015, 136, 'PG-13', 1),
  ('Avatar', 2009, 160, 'PG-13', 2),
  ('Black Panther', 2018, 140, 'PG-13', 1),
  ('Jurassic World', 2015, 124, 'PG-13', 3),
  ('Marvel’s The Avengers', 2012, 142, 'PG-13', 1);

INSERT INTO actors
  (first_name, last_name, birth_date)
VALUES
  ('Scarlett', 'Johansson', '1984-11-22'),
  ('Samuel L', 'Jackson', '1948-12-21'),
  ('Kristen', 'Wiig', '1973-08-22');

--LEFT JOIN example:--

movies_example=# SELECT title, name AS studio_name FROM movies LEFT JOIN studios ON movies.studio_id = studios.id;
            title             |             studio_name             
------------------------------+-------------------------------------
 Star Wars: The Force Awakens | Walt Disney Studios Motion Pictures
 Avatar                       | 20th Century Fox
 Black Panther                | Walt Disney Studios Motion Pictures
 Jurassic World               | Universal Pictures
 Marvel’s The Avengers        | Walt Disney Studios Motion Pictures
 Amadeus                      | Orion Pictures
 My 1st Indie Movie           | 
 My 2nd Indie Movie           | 
(8 rows)

--Right Join example: --


movies_example=# SELECT title, name AS studio_name FROM movies RIGHT JOIN studios ON movies.studio_id = studios.id;
            title             |             studio_name             
------------------------------+-------------------------------------
 Star Wars: The Force Awakens | Walt Disney Studios Motion Pictures
 Avatar                       | 20th Century Fox
 Black Panther                | Walt Disney Studios Motion Pictures
 Jurassic World               | Universal Pictures
 Marvel’s The Avengers        | Walt Disney Studios Motion Pictures
 Amadeus                      | Orion Pictures
                              | Cat Catss
                              | Chickenz Pictures
(8 rows)

--Full join example: --
movies_example=# SELECT title, name AS studio_name FROM movies FULL JOIN studios ON movies.studio_id = studios.id;
            title             |             studio_name             
------------------------------+-------------------------------------
 Star Wars: The Force Awakens | Walt Disney Studios Motion Pictures
 Avatar                       | 20th Century Fox
 Black Panther                | Walt Disney Studios Motion Pictures
 Jurassic World               | Universal Pictures
 Marvel’s The Avengers        | Walt Disney Studios Motion Pictures
 Amadeus                      | Orion Pictures
 My 1st Indie Movie           | 
 My 2nd Indie Movie           | 
                              | Cat Catss
                              | Chickenz Pictures
(10 rows)

--Many to many example: --
-Columns referencing ids from other tables congregated in the same table

-- Addind to a many-to-many table: --
movies_example=# INSERT INTO actors (first_name, last_name, birth_date)                                                             VALUES                                                                                                                              ('Chris', 'Pratt', '1986-04-04'), ('Billy-Bob', 'Thornton', '1951-08-08');
INSERT 0 2
movies_example=# Select * from actors                                                                                               ;                                                                                                                                    id | first_name | last_name | birth_date 
----+------------+-----------+------------
  1 | Scarlett   | Johansson | 1984-11-22
  2 | Samuel L   | Jackson   | 1948-12-21
  3 | Kristen    | Wiig      | 1973-08-22
  4 | Chris      | Pratt     | 1979-06-21
(4 rows)

movies_example=# INSERT INTO roles (actor_id, movie_id)
movies_example-# VALUES
movies_example-# (4,4), (4,5), (5,1),(5,2),(5,3),(5,4);
INSERT 0 6
movies_example=# SELECT first_name, last_name, COUNT(*) FROM roles JOIN actors ON roles.actor_id = actors.id GROUP BY actors.id;
 first_name | last_name | count 
------------+-----------+-------
 Chris      | Pratt     |     2
 Samuel L   | Jackson   |     2
 Billy-Bob  | Thornton  |     4
 Scarlett   | Johansson |     1
(4 rows)

movies_example=# SELECT * FROM roles;
 id | movie_id | actor_id 
----+----------+----------
  1 |        1 |        1
  2 |        1 |        2
  3 |        3 |        2
  4 |        4 |        4
  5 |        5 |        4
  6 |        1 |        5
  7 |        2 |        5
  8 |        3 |        5
  9 |        4 |        5
(9 rows)

movies_example=# SELECT * FROM roles JOIN actors ON roles.actor_id = actors.id;
id | movie_id | actor_id | id | first_name | last_name | birth_date 
----+----------+----------+----+------------+-----------+------------
  1 |        1 |        1 |  1 | Scarlett   | Johansson | 1984-11-22
  2 |        1 |        2 |  2 | Samuel L   | Jackson   | 1948-12-21
  3 |        3 |        2 |  2 | Samuel L   | Jackson   | 1948-12-21
 17 |       10 |        4 |  4 | Kurt       | Russel    | 1970-10-10
 18 |       10 |        5 |  5 | Bradely    | Cooper    | 1975-01-05
 19 |       10 |        6 |  6 | Chris      | Pratt     | 1979-06-21
 20 |       11 |        4 |  4 | Kurt       | Russel    | 1970-10-10
(7 rows)



movies_example=# SELECT first_name, last_name, COUNT(*) FROM roles JOIN actors ON roles.actor_id = actors.id GROUP BY actors.id;
 first_name | last_name | count 
------------+-----------+-------
 Kurt       | Russel    |     2
 Chris      | Pratt     |     1
 Samuel L   | Jackson   |     2
 Bradely    | Cooper    |     1
 Scarlett   | Johansson |     1


movies_example=# INSERT INTO roles (actor_id, movie_id)
movies_example-# VALUES (6, 4), (6, 5);
INSERT 0 2
movies_example=# SELECT * FROM actors;
 id | first_name | last_name | birth_date 
----+------------+-----------+------------
  1 | Scarlett   | Johansson | 1984-11-22
  2 | Samuel L   | Jackson   | 1948-12-21
  3 | Kristen    | Wiig      | 1973-08-22
  4 | Kurt       | Russel    | 1970-10-10
  5 | Bradely    | Cooper    | 1975-01-05
  6 | Chris      | Pratt     | 1979-06-21
(6 rows)


movies_example=# SELECT * FROM roles;
 id | movie_id | actor_id 
----+----------+----------
  1 |        1 |        1
  2 |        1 |        2
  3 |        3 |        2
 17 |       10 |        4
 18 |       10 |        5
 19 |       10 |        6
 20 |       11 |        4
 22 |        4 |        6
 23 |        5 |        6

INSERT INTO roles
  (movie_id, actor_id)
VALUES
  (1, 1),
  (1, 2),
  (3, 2);

movies_example=# SELECT first_name, last_name, COUNT(*) AS total_roles FROM roles JOIN actors ON roles.actor_id = actors.id GROUP BY actors.id ORDER BY total_roles DESC;
first_name | last_name | total_roles 
------------+-----------+-------------
Kurt       | Russel    |           2
Samuel L   | Jackson   |           2
Bradely    | Cooper    |           1
Scarlett   | Johansson |           1
(5 rows)

--Joining 3 tables together--
movies_example=# SELECT * FROM roles JOIN actors ON roles.actor_id = actors.id JOIN movies ON roles.movie_id = movies.id;

id | movie_id | actor_id | id | first_name | last_name | birth_date | id |            title             | release_year | runtime | rating | studio_id 
----+----------+----------+----+------------+-----------+------------+----+------------------------------+--------------+---------+--------+-----------
  1 |        1 |        1 |  1 | Scarlett   | Johansson | 1984-11-22 |  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1
  2 |        1 |        2 |  2 | Samuel L   | Jackson   | 1948-12-21 |  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1
  3 |        3 |        2 |  2 | Samuel L   | Jackson   | 1948-12-21 |  3 | Black Panther                |         2018 |     140 | PG-13  |         1
 17 |       10 |        4 |  4 | Kurt       | Russel    | 1970-10-10 | 10 | Guardians 2                  |         2017 |         |        |          
 18 |       10 |        5 |  5 | Bradely    | Cooper    | 1975-01-05 | 10 | Guardians 2                  |         2017 |         |        |          
 19 |       10 |        6 |  6 | Chris      | Pratt     | 1979-06-21 | 10 | Guardians 2                  |         2017 |         |        |          
 20 |       11 |        4 |  4 | Kurt       | Russel    | 1970-10-10 | 11 | The Thing                    |         1982 |         |        |          
 22 |        4 |        6 |  6 | Chris      | Pratt     | 1979-06-21 |  4 | Jurassic World               |         2015 |     124 | PG-13  |         3
 23 |        5 |        6 |  6 | Chris      | Pratt     | 1979-06-21 |  5 | Marvel’s The Avengers        |         2012 |     142 | PG-13  |         1
(9 rows)

--Rewriting your query to search only for title, first_name and last_name --
movies_example=# SELECT title, first_name, last_name FROM roles JOIN actors ON roles.actor_id = actors.id JOIN movies ON roles.movie_id = movies.id;
            title             | first_name | last_name 
------------------------------+------------+-----------
 Star Wars: The Force Awakens | Scarlett   | Johansson
 Star Wars: The Force Awakens | Samuel L   | Jackson
 Black Panther                | Samuel L   | Jackson
 Guardians 2                  | Kurt       | Russel
 Guardians 2                  | Bradely    | Cooper
 Guardians 2                  | Chris      | Pratt
 The Thing                    | Kurt       | Russel
 Jurassic World               | Chris      | Pratt
 Marvel’s The Avengers        | Chris      | Pratt

-- Querying a Many-to-Many: Selecting certain columns, using table alias shorthand: --
movies_example=# SELECT m.title, a.first_name, a.last_name
movies_example-# FROM roles
movies_example-# r JOIN movies m
movies_example-# ON r.movie_id = m.id
movies_example-# JOIN actors a
movies_example-# ON r.actor_id = a.id;
            title             | first_name | last_name 
------------------------------+------------+-----------
 Star Wars: The Force Awakens | Scarlett   | Johansson
 Star Wars: The Force Awakens | Samuel L   | Jackson
 Black Panther                | Samuel L   | Jackson
 Guardians 2                  | Kurt       | Russel
 Guardians 2                  | Bradely    | Cooper
 Guardians 2                  | Chris      | Pratt
 The Thing                    | Kurt       | Russel
 Jurassic World               | Chris      | Pratt
 Marvel’s The Avengers        | Chris      | Pratt
(9 rows)


movies_example=# SELECT m.title, a.first_name, a.last_name
movies_example-# FROM movies m 
movies_example-# JOIN roles r
movies_example-# ON m.id = r.movie_id
movies_example-# JOIN actors a
movies_example-# ON a.id = r.actor_id;
            title             | first_name | last_name 
------------------------------+------------+-----------
 Star Wars: The Force Awakens | Scarlett   | Johansson
 Star Wars: The Force Awakens | Samuel L   | Jackson
 Black Panther                | Samuel L   | Jackson
 Guardians 2                  | Kurt       | Russel
 Guardians 2                  | Bradely    | Cooper
 Guardians 2                  | Chris      | Pratt
 The Thing                    | Kurt       | Russel
 Jurassic World               | Chris      | Pratt
 Marvel’s The Avengers        | Chris      | Pratt
(9 rows)

movies_example=# SELECT m.title, a.first_name, a.last_name
FROM movies m 
JOIN roles r
ON m.id = r.movie_id
JOIN actors a
ON a.id = r.actor_id
movies_example-# WHERE m.release_year < 2000;
   title   | first_name | last_name 
-----------+------------+-----------
 The Thing | Kurt       | Russel
(1 row)

--After 2016 movie query --
movies_example=# SELECT m.title, a.first_name, a.last_name
FROM movies m 
JOIN roles r
ON m.id = r.movie_id
JOIN actors a
ON a.id = r.actor_id
WHERE m.release_year > 2016;
     title     | first_name | last_name 
---------------+------------+-----------
 Black Panther | Samuel L   | Jackson
 Guardians 2   | Kurt       | Russel
 Guardians 2   | Bradely    | Cooper
 Guardians 2   | Chris      | Pratt
(4 rows)


movies_example=# SELECT m.release_year, m.title, a.first_name, a.last_name
FROM movies m 
JOIN roles r
ON m.id = r.movie_id
JOIN actors a
ON a.id = r.actor_id
WHERE m.release_year > 2016
ORDER BY release_year;
 release_year |     title     | first_name | last_name 
--------------+---------------+------------+-----------
         2017 | Guardians 2   | Kurt       | Russel
         2017 | Guardians 2   | Bradely    | Cooper
         2017 | Guardians 2   | Chris      | Pratt
         2018 | Black Panther | Samuel L   | Jackson
(4 rows)

movies_example=# SELECT m.release_year, m.title, a.first_name, a.last_name
FROM movies m 
JOIN roles r
ON m.id = r.movie_id
JOIN actors a
ON a.id = r.actor_id
WHERE m.release_year > 2000
ORDER BY release_year;
 release_year |            title             | first_name | last_name 
--------------+------------------------------+------------+-----------
         2012 | Marvel’s The Avengers        | Chris      | Pratt
         2015 | Star Wars: The Force Awakens | Samuel L   | Jackson
         2015 | Star Wars: The Force Awakens | Scarlett   | Johansson
         2015 | Jurassic World               | Chris      | Pratt
         2017 | Guardians 2                  | Bradely    | Cooper
         2017 | Guardians 2                  | Chris      | Pratt
         2017 | Guardians 2                  | Kurt       | Russel
         2018 | Black Panther          

         movies_example=# SELECT m.release_year, m.title, a.first_name, a.last_name
FROM movies m 
JOIN roles r
ON m.id = r.movie_id
JOIN actors a
ON a.id = r.actor_id
WHERE m.release_year > 2000
ORDER BY release_year, a.first_name;
 release_year |            title             | first_name | last_name 
--------------+------------------------------+------------+-----------
         2012 | Marvel’s The Avengers        | Chris      | Pratt
         2015 | Jurassic World               | Chris      | Pratt
         2015 | Star Wars: The Force Awakens | Samuel L   | Jackson
         2015 | Star Wars: The Force Awakens | Scarlett   | Johansson
         2017 | Guardians 2                  | Bradely    | Cooper
         2017 | Guardians 2                  | Chris      | Pratt
         2017 | Guardians 2                  | Kurt       | Russel
         2018 | Black Panther                | Samuel L   | Jackson
(8 rows)

movies_example=# SELECT * FROM roles r
movies_example-# JOIN movies m
movies_example-# ON r.movie_id = m.id;

 id | movie_id | actor_id | id |            title             | release_year | runtime | rating | studio_id 
----+----------+----------+----+------------------------------+--------------+---------+--------+-----------
  1 |        1 |        1 |  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1
  2 |        1 |        2 |  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1
  3 |        3 |        2 |  3 | Black Panther                |         2018 |     140 | PG-13  |         1
 17 |       10 |        4 | 10 | Guardians 2                  |         2017 |         |        |          
 18 |       10 |        5 | 10 | Guardians 2                  |         2017 |         |        |          
 19 |       10 |        6 | 10 | Guardians 2                  |         2017 |         |        |          
 20 |       11 |        4 | 11 | The Thing                    |         1982 |         |        |          
 22 |        4 |        6 |  4 | Jurassic World               |         2015 |     124 | PG-13  |         3
 23 |        5 |        6 |  5 | Marvel’s The Avengers        |         2012 |     142 | PG-13  |         1
(9 rows)

movies_example=# SELECT * FROM roles r
RIGHT JOIN movies m
ON r.movie_id = m.id;



 id | movie_id | actor_id | id |            title             | release_year | runtime | rating | studio_id 
----+----------+----------+----+------------------------------+--------------+---------+--------+-----------
  1 |        1 |        1 |  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1
  2 |        1 |        2 |  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1
  3 |        3 |        2 |  3 | Black Panther                |         2018 |     140 | PG-13  |         1
 17 |       10 |        4 | 10 | Guardians 2                  |         2017 |         |        |          
 18 |       10 |        5 | 10 | Guardians 2                  |         2017 |         |        |          
 19 |       10 |        6 | 10 | Guardians 2                  |         2017 |         |        |          
 20 |       11 |        4 | 11 | The Thing                    |         1982 |         |        |          
 22 |        4 |        6 |  4 | Jurassic World               |         2015 |     124 | PG-13  |         3
 23 |        5 |        6 |  5 | Marvel’s The Avengers        |         2012 |     142 | PG-13  |         1
    |          |          |  2 | Avatar                       |         2009 |     160 | PG-13  |         2
    |          |          |  8 | My first Indie Movie         |         2015 |      90 | PG-12  |          
    |          |          |  9 | My second indie movie        |         2020 |     110 | R      |          
    |          |          |  7 | Amadeus                      |         1984 |     180 | R      |         4
(13 rows)


movies_example=# SELECT * FROM roles r
LEFT JOIN movies m
ON r.movie_id = m.id;
 id | movie_id | actor_id | id |            title             | release_year | runtime | rating | studio_id 
----+----------+----------+----+------------------------------+--------------+---------+--------+-----------
  1 |        1 |        1 |  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1
  2 |        1 |        2 |  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1
  3 |        3 |        2 |  3 | Black Panther                |         2018 |     140 | PG-13  |         1
 17 |       10 |        4 | 10 | Guardians 2                  |         2017 |         |        |          
 18 |       10 |        5 | 10 | Guardians 2                  |         2017 |         |        |          
 19 |       10 |        6 | 10 | Guardians 2                  |         2017 |         |        |          
 20 |       11 |        4 | 11 | The Thing                    |         1982 |         |        |          
 22 |        4 |        6 |  4 | Jurassic World               |         2015 |     124 | PG-13  |         3
 23 |        5 |        6 |  5 | Marvel’s The Avengers        |         2012 |     142 | PG-13  |         1
(9 rows)


movies_example=# SELECT * FROM roles r
movies_example-# RIGHT JOIN movies m
movies_example-# ON r.movie_id = m.id
movies_example-# JOIN actors a 
movies_example-# ON r.actor_id = a.id;

 id | movie_id | actor_id | id |            title             | release_year | runtime | rating | studio_id | id | first_name | last_name | birth_date 
----+----------+----------+----+------------------------------+--------------+---------+--------+-----------+----+------------+-----------+------------
  1 |        1 |        1 |  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1 |  1 | Scarlett   | Johansson | 1984-11-22
  2 |        1 |        2 |  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1 |  2 | Samuel L   | Jackson   | 1948-12-21
  3 |        3 |        2 |  3 | Black Panther                |         2018 |     140 | PG-13  |         1 |  2 | Samuel L   | Jackson   | 1948-12-21
 17 |       10 |        4 | 10 | Guardians 2                  |         2017 |         |        |           |  4 | Kurt       | Russel    | 1970-10-10
 18 |       10 |        5 | 10 | Guardians 2                  |         2017 |         |        |           |  5 | Bradely    | Cooper    | 1975-01-05
 19 |       10 |        6 | 10 | Guardians 2                  |         2017 |         |        |           |  6 | Chris      | Pratt     | 1979-06-21
 20 |       11 |        4 | 11 | The Thing                    |         1982 |         |        |           |  4 | Kurt       | Russel    | 1970-10-10
 22 |        4 |        6 |  4 | Jurassic World               |         2015 |     124 | PG-13  |         3 |  6 | Chris      | Pratt     | 1979-06-21
 23 |        5 |        6 |  5 | Marvel’s The Avengers        |         2012 |     142 | PG-13  |         1 |  6 | Chris      | Pratt     | 1979-06-21


 --Full join --
 movies_example=# SELECT * FROM roles r
movies_example-# FULL JOIN movies m
movies_example-# ON r.movie_id = m.id
movies_example-# FULL JOIN actors a
movies_example-# ON r.actor_id = a.id;

 id | movie_id | actor_id | id |            title             | release_year | runtime | rating | studio_id | id | first_name | last_name | birth_date 
----+----------+----------+----+------------------------------+--------------+---------+--------+-----------+----+------------+-----------+------------
  1 |        1 |        1 |  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1 |  1 | Scarlett   | Johansson | 1984-11-22
  2 |        1 |        2 |  1 | Star Wars: The Force Awakens |         2015 |     136 | PG-13  |         1 |  2 | Samuel L   | Jackson   | 1948-12-21
  3 |        3 |        2 |  3 | Black Panther                |         2018 |     140 | PG-13  |         1 |  2 | Samuel L   | Jackson   | 1948-12-21
 17 |       10 |        4 | 10 | Guardians 2                  |         2017 |         |        |           |  4 | Kurt       | Russel    | 1970-10-10
 18 |       10 |        5 | 10 | Guardians 2                  |         2017 |         |        |           |  5 | Bradely    | Cooper    | 1975-01-05
 19 |       10 |        6 | 10 | Guardians 2                  |         2017 |         |        |           |  6 | Chris      | Pratt     | 1979-06-21
 20 |       11 |        4 | 11 | The Thing                    |         1982 |         |        |           |  4 | Kurt       | Russel    | 1970-10-10
 22 |        4 |        6 |  4 | Jurassic World               |         2015 |     124 | PG-13  |         3 |  6 | Chris      | Pratt     | 1979-06-21
 23 |        5 |        6 |  5 | Marvel’s The Avengers        |         2012 |     142 | PG-13  |         1 |  6 | Chris      | Pratt     | 1979-06-21
    |          |          |  2 | Avatar                       |         2009 |     160 | PG-13  |         2 |    |            |           | 
    |          |          |  8 | My first Indie Movie         |         2015 |      90 | PG-12  |           |    |            |           | 
    |          |          |  9 | My second indie movie        |         2020 |     110 | R      |           |    |            |           | 
    |          |          |  7 | Amadeus                      |         1984 |     180 | R      |         4 |    |            |           | 
    |          |          |    |                              |              |         |        |           |  3 | Kristen    | Wiig      | 1973-08-22
(14 rows)
