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