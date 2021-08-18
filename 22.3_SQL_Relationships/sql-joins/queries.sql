-- write your queries here
--https://www.vertica.com/docs/9.2.x/HTML/Content/Authoring/ConnectingToVertica/vsql/Meta-Commands/DPATTERNMeta-commands.htm--

Join the two tables so that every column and record appears, regardless of if there is not an owner_id. Your output should look like this:
So, it looks like I would have to do an full join of owners an vehicles

First step, show all tables so we have a better idea on organizing everything

joins_exercise=# \d
                   List of relations
 Schema |      Name       |   Type   |      Owner      
--------+-----------------+----------+-----------------
 public | owners          | table    | XuXaO415
 public | owners_id_seq   | sequence | XuXaO415
 public | vehicles        | table    | XuXaO415
 public | vehicles_id_seq | sequence | XuXaO415
(4 rows)


joins_exercise=# SELECT * FROM vehicles;
 id |  make  |  model  | year |  price   | owner_id 
----+--------+---------+------+----------+----------
  1 | Toyota | Corolla | 2002 |  2999.99 |        1
  2 | Honda  | Civic   | 2012 | 12999.99 |        1
  3 | Nissan | Altima  | 2016 | 23999.99 |        2
  4 | Subaru | Legacy  | 2006 |  5999.99 |        2
  5 | Ford   | F150    | 2012 |  2599.99 |        3
  6 | GMC    | Yukon   | 2016 | 12999.99 |        3
  7 | GMC    | Yukon   | 2014 | 22999.99 |        4
  8 | Toyota | Avalon  | 2009 | 12999.99 |        4
  9 | Toyota | Camry   | 2013 | 12999.99 |        4
 10 | Honda  | Civic   | 2001 |  7999.99 |        5
 11 | Nissan | Altima  | 1999 |  1899.99 |        6
 12 | Lexus  | ES350   | 1998 |  1599.99 |        6
 13 | BMW    | 300     | 2012 | 22999.99 |        6
 14 | BMW    | 700     | 2015 | 52999.99 |        6
(14 rows)


joins_exercise=# SELECT * FROM owners
joins_exercise-# JOIN vehicles
joins_exercise-# ON owners.id = vehicles.owner_id;
 id | first_name | last_name | id |  make  |  model  | year |  price   | owner_id 
----+------------+-----------+----+--------+---------+------+----------+----------
  1 | Bob        | Hope      |  1 | Toyota | Corolla | 2002 |  2999.99 |        1
  1 | Bob        | Hope      |  2 | Honda  | Civic   | 2012 | 12999.99 |        1
  2 | Jane       | Smith     |  3 | Nissan | Altima  | 2016 | 23999.99 |        2
  2 | Jane       | Smith     |  4 | Subaru | Legacy  | 2006 |  5999.99 |        2
  3 | Melody     | Jones     |  5 | Ford   | F150    | 2012 |  2599.99 |        3
  3 | Melody     | Jones     |  6 | GMC    | Yukon   | 2016 | 12999.99 |        3
  4 | Sarah      | Palmer    |  7 | GMC    | Yukon   | 2014 | 22999.99 |        4
  4 | Sarah      | Palmer    |  8 | Toyota | Avalon  | 2009 | 12999.99 |        4
  4 | Sarah      | Palmer    |  9 | Toyota | Camry   | 2013 | 12999.99 |        4
  5 | Alex       | Miller    | 10 | Honda  | Civic   | 2001 |  7999.99 |        5
  6 | Shana      | Smith     | 11 | Nissan | Altima  | 1999 |  1899.99 |        6
  6 | Shana      | Smith     | 12 | Lexus  | ES350   | 1998 |  1599.99 |        6
  6 | Shana      | Smith     | 13 | BMW    | 300     | 2012 | 22999.99 |        6
  6 | Shana      | Smith     | 14 | BMW    | 700     | 2015 | 52999.99 |        6


joins_exercise=# SELECT * FROM owners
joins_exercise-# FULL JOIN vehicles
joins_exercise-# ON owners.id = vehicles.owner_id;
 id | first_name | last_name | id |  make  |  model  | year |  price   | owner_id 
----+------------+-----------+----+--------+---------+------+----------+----------
  1 | Bob        | Hope      |  1 | Toyota | Corolla | 2002 |  2999.99 |        1
  1 | Bob        | Hope      |  2 | Honda  | Civic   | 2012 | 12999.99 |        1
  2 | Jane       | Smith     |  3 | Nissan | Altima  | 2016 | 23999.99 |        2
  2 | Jane       | Smith     |  4 | Subaru | Legacy  | 2006 |  5999.99 |        2
  3 | Melody     | Jones     |  5 | Ford   | F150    | 2012 |  2599.99 |        3
  3 | Melody     | Jones     |  6 | GMC    | Yukon   | 2016 | 12999.99 |        3
  4 | Sarah      | Palmer    |  7 | GMC    | Yukon   | 2014 | 22999.99 |        4
  4 | Sarah      | Palmer    |  8 | Toyota | Avalon  | 2009 | 12999.99 |        4
  4 | Sarah      | Palmer    |  9 | Toyota | Camry   | 2013 | 12999.99 |        4
  5 | Alex       | Miller    | 10 | Honda  | Civic   | 2001 |  7999.99 |        5
  6 | Shana      | Smith     | 11 | Nissan | Altima  | 1999 |  1899.99 |        6
  6 | Shana      | Smith     | 12 | Lexus  | ES350   | 1998 |  1599.99 |        6
  6 | Shana      | Smith     | 13 | BMW    | 300     | 2012 | 22999.99 |        6
  6 | Shana      | Smith     | 14 | BMW    | 700     | 2015 | 52999.99 |        6
  7 | Maya       | Malarkin  |    |        |         |      |          |         
(15 rows)

joins_exercise=# \ds
                   List of relations
 Schema |      Name       |   Type   |      Owner      
--------+-----------------+----------+-----------------
 public | owners_id_seq   | sequence | XuXaO415
 public | vehicles_id_seq | sequence | XuXaO415
(2 rows)

joins_exercise=# SELECT o.first_name, o.last_name, COUNT(*)
FROM owners o
JOIN vehicles v
ON o.id = v.owner_id
GROUP BY v.owner_id, o.first_name, o.last_name ORDER BY COUNT(*) ASC;
 first_name | last_name | count 
------------+-----------+-------
 Alex       | Miller    |     1
 Bob        | Hope      |     2
 Melody     | Jones     |     2
 Jane       | Smith     |     2
 Sarah      | Palmer    |     3
 Shana      | Smith     |     4
(6 rows)

joins_exercise=# SELECT o.first_name, o.last_name, AVG(price) AS average_price
FROM owners o
joins_exercise-# JOIN vehicles v
joins_exercise-# ON o.id = v.owner_id
joins_exercise-# GROUP BY o.first_name, o.last_name
joins_exercise-# ORDER BY average_price DESC;
 first_name | last_name |   average_price    
------------+-----------+--------------------
 Shana      | Smith     | 19874.989624023438
 Sarah      | Palmer    | 16333.323567708334
 Jane       | Smith     |    14999.990234375
 Alex       | Miller    |     7999.990234375
 Bob        | Hope      | 7999.9901123046875
 Melody     | Jones     | 7799.9901123046875
(6 rows)


joins_exercise=# SELECT o.first_name, o.last_name, AVG(price) AS average_price
FROM vehicles v
JOIN owners o
ON o.id = v.owner_id
GROUP BY o.first_name, o.last_name
HAVING COUNT(v.owner_id) > 1 AND AVG(price) > 10000
ORDER BY first_name DESC;
 first_name | last_name |   average_price    
------------+-----------+--------------------
 Shana      | Smith     | 19874.989624023438
 Sarah      | Palmer    | 16333.323567708334
 Jane       | Smith     |    14999.990234375
(3 rows)

joins_exercise=# SELECT o.first_name, o.last_name, COUNT(*), AVG(price) AS average_price
FROM owners o
JOIN vehicles v
ON o.id = v.owner_id
GROUP BY o.first_name, o.last_name
HAVING COUNT(v.owner_id) > 1 AND AVG(price) > 10000
ORDER BY first_name DESC, COUNT(*);
 first_name | last_name | count |   average_price    
------------+-----------+-------+--------------------
 Shana      | Smith     |     4 | 19874.989624023438
 Sarah      | Palmer    |     3 | 16333.323567708334
 Jane       | Smith     |     2 |    14999.990234375
(3 rows)

joins_exercise=# SELECT o.first_name, o.last_name, AVG(price) AS average_price, COUNT(*)
FROM owners o
JOIN vehicles v
ON o.id = v.owner_id
GROUP BY o.first_name, o.last_name
HAVING COUNT(v.owner_id) > 1 AND AVG(price) > 10000
ORDER BY first_name DESC, average_price,  COUNT(*);
 first_name | last_name |   average_price    | count 
------------+-----------+--------------------+-------
 Shana      | Smith     | 19874.989624023438 |     4
 Sarah      | Palmer    | 16333.323567708334 |     3
 Jane       | Smith     |    14999.990234375 |     2
(3 rows)


joins_exercise=# SELECT o.first_name, o.last_name, AVG(price) AS average_price, COUNT(*)
FROM owners o
JOIN vehicles v
ON o.id = v.owner_id
GROUP BY o.first_name, o.last_name
HAVING COUNT(v.owner_id) > 1 AND AVG(price) > 10000
ORDER BY first_name DESC;
 first_name | last_name |   average_price    | count 
------------+-----------+--------------------+-------
 Shana      | Smith     | 19874.989624023438 |     4
 Sarah      | Palmer    | 16333.323567708334 |     3
 Jane       | Smith     |    14999.990234375 |     2
(3 rows)

-- Count the number of cars for each owner and display the average price for each of the cars as integers. 
-- Display the owners first_name, last_name, average price and count of vehicles. The first_name should be ordered in descending order. 
-- Only display results with more than one vehicle and an average price greater than 10000. Your output should look like this:

--THIS WORKS!--
joins_exercise=# SELECT o.first_name, o.last_name, ROUND(AVG(v.price)) AS average_price, COUNT(*)
FROM owners o
JOIN vehicles v
ON o.id = v.owner_id
GROUP BY o.first_name, o.last_name
HAVING COUNT(v.owner_id) > 1 AND AVG(price) > 10000
ORDER BY first_name DESC;
 first_name | last_name | average_price | count 
------------+-----------+---------------+-------
 Shana      | Smith     |         19875 |     4
 Sarah      | Palmer    |         16333 |     3
 Jane       | Smith     |         15000 |     2
(3 rows)


