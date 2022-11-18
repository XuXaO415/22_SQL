CREATE TABLE posts (
  title TEXT,
  username TEXT,
  link TEXT
);
CREATE TABLE
reddit_db=# \d
            List of relations
 Schema | Name  | Type  |      Owner      
--------+-------+-------+-----------------
 public | posts | table | XuXaO415
(1 row)

reddit_db=# INSERT INTO posts
reddit_db-# (title, username, link)
reddit_db-# VALUES
reddit_db-# ('Adorable baby panda', 'flossy_supreme', 'www.lkjdfsdf.com');
INSERT 0 1

reddit_db=# INSERT INTO posts
reddit_db-# (title, username, link)
reddit_db-# VALUES
reddit_db-# ('Adorable baby panda', 'flossy_supreme', 'www.lkjdfsdf.com');
INSERT 0 1
reddit_db=# SELECT * FROM posts;
        title        |    username    |       link       
---------------------+----------------+------------------
 Adorable baby panda | flossy_supreme | www.lkjdfsdf.com
(1 row)

CREATE TABLE subreddits (
  id SERIAL,
  name VARCHAR(15) NOT NULL,
  description TEXT,
  subscribers INTEGER CHECK(subscribers > 0),
  is_private BOOLEAN
);

CREATE TABLE
reddit_db=# \d
                    List of relations
 Schema |       Name        |   Type   |      Owner      
--------+-------------------+----------+-----------------
 public | posts             | table    | XuXaO415
 public | subreddits        | table    | XuXaO415
 public | subreddits_id_seq | sequence | XuXaO415
(3 rows)

INSERT INTO subreddits
(name, description, subscribers, is_private)
VALUES ('puppy_pics', 'super adorable puppy pictures', 455234, false);

reddit_db=# SELECT * FROM  subreddits;
 id |    name    |          description          | subscribers | is_private 
----+------------+-------------------------------+-------------+------------
  1 | puppy_pics | super adorable puppy pictures |      455234 | f
(1 row)

INSERT INTO subreddits (name)
VALUES ('supercalifragilisticexpialidocious');

reddit_db=# INSERT INTO subreddits (name)
VALUES ('penguins');
INSERT 0 1
reddit_db=# SELECT * FROM subreddits
reddit_db-# ;
 id |    name    |          description          | subscribers | is_private 
----+------------+-------------------------------+-------------+------------
  1 | puppy_pics | super adorable puppy pictures |      455234 | f
  2 | penguins   |                               |             | 
(2 rows)

CREATE TABLE users (
  id SERIAL,
  username VARCHAR(15) UNIQUE NOT NULL,
  password VARCHAR(20) NOT NULL
);

DROP DATABASE IF EXISTS reddit_db;
CREATE DATABASE reddit_db;
\c reddit_db;

CREATE TABLE users 
(
  id SERIAL PRIMARY KEY,
  username VARCHAR(15) UNIQUE NOT NULL,
  password VARCHAR(20) NOT NULL
);

CREATE TABLE comments 
(
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users ON DELETE CASCADE,
  comment_text TEXT NOT NULL
);

CREATE TABLE subreddits 
(
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users ON DELETE SET NULL,
  name VARCHAR(15) NOT NULL,
  description TEXT,
  subscribers INTEGER CHECK (subscribers > 0) DEFAULT 1,
  is_private BOOLEAN DEFAULT false
);


INSERT INTO users  (username, password)
VALUES
('graylady',  'askldjas'),
('stevie-chicks', 'asdkljasl');

INSERT INTO subreddits (name, user_id)
VALUES
('chickens', 2),
('waterluvers', 1);



CREATE TABLE subreddits (
  id SERIAL,
  name VARCHAR(15) NOT NULL,
  description TEXT,
  subscribers INTEGER CHECK(subscribers > 0),
  is_private BOOLEAN
);

CREATE TABLE users (
  id SERIAL,
  username VARCHAR(15) UNIQUE NOT NULL,
  password VARCHAR(20) NOT NULL
);

reddit_db=# \d
                    List of relations
 Schema |       Name        |   Type   |      Owner      
--------+-------------------+----------+-----------------
 public | posts             | table    | XuXaO415
 public | subreddits        | table    | XuXaO415
 public | subreddits_id_seq | sequence | XuXaO415
 public | users             | table    | XuXaO415
 public | users_id_seq      | sequence | XuXaO415
(5 rows)

INSERT INTO subreddits (
  name, subscribers
)
VALUES
('pandas', 47000);

reddit_db=# SELECT * FROM subreddits;
 id |  name  | description | subscribers | is_private 
----+--------+-------------+-------------+------------
  1 | pandas |             |       47000 | 
(1 row)

INSERT INTO users (username, password)
VALUES ('stevie_chicks', 'cluck123');

INSERT INTO users (username, password)
VALUES ('stevie_chicks', 'sdfljshdfkj');
reddit_db=# INSERT INTO users (username, password)
VALUES ('stevie_chicks', 'cluck123');
INSERT 0 1
reddit_db=# SELECt * FROM users;
 id |   username    | password 
----+---------------+----------
  1 | stevie_chicks | cluck123
(1 row)

reddit_db=# 
INSERT INTO users (username, password)
VALUES ('stevie_chicks', 'sdfljshdfkj');
ERROR:  duplicate key value violates unique constraint "users_username_key"
DETAIL:  Key (username)=(stevie_chicks) already exists.

DROP DATABASE reddit_db;
CREATE DATABASE reddit_db;
\c reddit_db;

--This procedures below illustrate how to create/utilize a primary key--

reddit_db=# CREATE TABLE subreddits (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users,
  name VARCHAR(15) NOT NULL,
  descriptions TEXT,
  subscribers INTEGER CHECK (subscribers > 0) DEFAULT 1,
  is_private BOOLEAN DEFAULT false
);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(15) UNIQUE NOT NULL,
  password VARCHAR(20) NOT NULL
);

INSERT INTO subreddits (name)
VALUES ('Dororo_rocks');
INSERT 0 1
reddit_db=# \d
                    List of relations
 Schema |       Name        |   Type   |      Owner      
--------+-------------------+----------+-----------------
 public | subreddits        | table    | XuXaO415
 public | subreddits_id_seq | sequence | XuXaO415
 public | users             | table    | XuXaO415
 public | users_id_seq      | sequence | XuXaO415
(4 rows)


reddit_db=# SELECT * FROM subreddits;
 id |     name     | descriptions | subscribers | is_private 
----+--------------+--------------+-------------+------------
  1 | Dororo_rocks |              |           1 | f
(1 row)

INSERT INTO users (username, password)
VALUES ('graylady', 'skjhwe'),
('stevie-chicks', 'asdkfuwoeir');

INSERT INTO subreddits (name, user_id)
VALUES ('Chickens', 2),
('waterluvers', 1);

SELECT * FROM subreddits;
 id | user_id |    name     | descriptions | subscribers | is_private 
----+---------+-------------+--------------+-------------+------------
  1 |       2 | Chickens    |              |           1 | f
  2 |       1 | waterluvers |              |           1 | f
(2 rows)

------------------------------------------------------------------------------------------

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(15) UNIQUE NOT NULL,
  password VARCHAR(20) NOT NULL
);

CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users ON DELETE CASCADE,
  comment_text TEXT NOT NULL
);

CREATE TABLE subreddits (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users ON DELETE SET NULL,
  name VARCHAR(15) NOT NULL,
  descriptions TEXT,
  subscribers INTEGER CHECK (subscribers > 0) DEFAULT 1,
  is_private BOOLEAN DEFAULT false
);

INSERT INTO comments (user_id, comment_text)
VALUES (2, 'cluck cluck'),
(2, 'bock bock'),
(1, 'doodle doo');

INSERT INTO comments (user_id, comment_text)
VALUES (2, 'cluck cluck'),
(2, 'bock bock'),
(1, 'doodle doo');
INSERT 0 3
reddit_db=# SELECT * FROM comments;
 id | user_id | comment_text 
----+---------+--------------
  1 |       2 | cluck cluck
  2 |       2 | bock bock
  3 |       1 | doodle doo
(3 rows)


INSERT INTO comments (user_id, comment_text)
VALUES (2, 'cluck cluck'),
(2, 'bock bock'),
(1, 'doodle doo');
INSERT 0 3
reddit_db=# SELECT * FROM comments;
 id | user_id | comment_text 
----+---------+--------------
  1 |       2 | cluck cluck
  2 |       2 | bock bock
  3 |       1 | doodle doo
(3 rows)


-- DELETE FROM users WHERE id = 2;
reddit_db=# DELETE FROM users WHERE id = 2;
DELETE 1
reddit_db=# SELECT * FROM users;
 id |   username    |  password   
----+---------------+-------------
  1 | graylady      | askldjas
  3 | stevie_chicks | sdfljshdfkj
(2 rows)

reddit_db=# SELECT * FROM comments;
 id | user_id | comment_text 
----+---------+--------------
  3 |       1 | doodle doo
(1 row)


ALTER TABLE subreddits DROP COLUMN description;
reddit_db=# SELECT * FROM subreddits;
 id | user_id |     name     | description | subscribers | is_private 
----+---------+--------------+-------------+-------------+------------
  2 |       1 | waterluvers  |             |           1 | f
  3 |         | Dororo_rocks |             |           1 | f
  5 |       1 | waterluvers  |             |           1 | f
  1 |         | chickens     |             |           1 | f
  4 |         | Chickens     |             |           1 | f
(5 rows)

reddit_db=# ALTER TABLE subreddits DROP COLUMN description;
ALTER TABLE
reddit_db=# SELECT * FROM subreddits;
 id | user_id |     name     | subscribers | is_private 
----+---------+--------------+-------------+------------
  2 |       1 | waterluvers  |           1 | f
  3 |         | Dororo_rocks |           1 | f
  5 |       1 | waterluvers  |           1 | f
  1 |         | chickens     |           1 | f
  4 |         | Chickens     |           1 | f


ALTER TABLE subreddits DROP COLUMN is_private;

reddit_db=# ALTER TABLE subreddits DROP COLUMN is_private;
ALTER TABLE
reddit_db=# SELECT * FROM subreddits;
 id | user_id |     name     | subscribers 
----+---------+--------------+-------------
  2 |       1 | waterluvers  |           1
  3 |         | Dororo_rocks |           1
  5 |       1 | waterluvers  |           1
  1 |         | chickens     |           1
  4 |         | Chickens     |           1
(5 rows)


-- ALTER TABLE subreddits RENAME COLUMN user_id TO owner_id;
reddit_db=# ALTER TABLE subreddits RENAME COLUMN user_id TO owner_id;
ALTER TABLE
reddit_db=# SELECT * FROM subreddits;
 id | owner_id |     name     | subscribers 
----+----------+--------------+-------------
  2 |        1 | waterluvers  |           1
  3 |          | Dororo_rocks |           1
  5 |        1 | waterluvers  |           1
  1 |          | chickens     |           1
  4 |          | Chickens     |           1
(5 rows)


-- ALTER TABLE users ADD COLUMN permissions TEXT;
