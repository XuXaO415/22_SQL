-- The region of the craigslist post (San Francisco, Atlanta, Seattle, etc) (1:1)
-- Users and preferred region (1:M)
-- Posts: contains title, text, the user who has posted, the location of the posting, the region of the posting (M:M)
-- Categories that each post belongs to (1:1)

-- Note: the region of the user is not necessarily the same as the region of the post
-- Also, remember that a user can post multiple posts, and a post can belong to multiple categories
-- And, a user can belong to multiple regions (this is considered 1:M relationship)
-- Remember column data types:
-- Interger, Float, Text, Varchar, Boolean, Date, Timestamp, Serial



                -- <h2 class="area">city of san francisco</h2>
                -- <ul class="sublinks"><li>sfc</li><li><a href="/sby/" title="south bay">sby</a></li><li><a href="/eby/" title="east bay">eby</a></li><li><a href="/pen/" title="peninsula">pen</a></li><li><a href="/nby/" title="north bay">nby</a></li><li><a href="/scz/" title="santa cruz">scz</a></li></ul>
                -- <div class="enter-area">
                -- <input type="text" class="subarea-input flatinput"
                --     data-autocomplete="subarea" value="">


DROP DATABASE IF EXISTS craigslist_db;

CREATE DATABASE craigslist_db;

\c craigslist_db;

CREATE TABLE regions (
    id SERIAL PRIMARY KEY,
    area_city VARCHAR(30),
    area_state VARCHAR(30)
);

INSERT INTO regions (area_city, area_state)
VALUES ('San Francisco', 'CA'),
('Atlanta', 'Georgia'),
('Seattle', 'Washington');
-- INSERT 0 3

SELECT * FROM regions;
 id |   area_city   | area_state 
----+---------------+------------
  1 | San Francisco | CA
  2 | Atlanta       | Georgia
  3 | Seattle       | Washington
(3 rows)

-- CREATE TABLE
-- craigslist_db=# SELECT * FROM regions;
--  id | area_city | area_state 
-- ----+-----------+------------
-- (0 rows)


CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(15) UNIQUE NOT NULL,
    password VARCHAR(15) UNIQUE NOT NULL,
    preferred_region INTEGER REFERENCES regions(id)
);

-- craigslist_db=# 
INSERT INTO users(username, password,  preferred_region)
VALUES ('Fluffsterz4573', 'weur34323', 1),
('CaptainJacz', 'sfkshjf2372esa', 3),
('GeorgiaPeach','ewiry782349r', 2),
('Mission_kid_415', 'password12345', 1);
-- INSERT 0 4

-- craigslist_db=# 
SELECT * FROM users;
 id |    username     |    password    | preferred_region 
----+-----------------+----------------+------------------
  5 | Fluffsterz4573  | weur34323      |                1
  6 | CaptainJacz     | sfkshjf2372esa |                3
  7 | GeorgiaPeach    | ewiry782349r   |                2
  8 | Mission_kid_415 | password12345  |                1
-- (4 rows)

-- CREATE TABLE
-- craigslist_db=# SELECT * FROM users;
--  id | username | password | preferred_region 
-- ----+----------+----------+------------------
-- (0 rows)


-- craigslist_db-# \d posts;
--                                       Table "public.posts"
--     Column    |         Type          | Collation | Nullable |              Default              
-- --------------+-----------------------+-----------+----------+-----------------------------------
--  id           | integer               |           | not null | nextval('posts_id_seq'::regclass)
--  post_title   | character varying(30) |           |          | 
--  post_text    | text                  |           |          | 
--  user_post_id | integer               |           |          | 
--  posting_loc  | integer               |           |          | 
-- Indexes:
--     "posts_pkey" PRIMARY KEY, btree (id)
-- Foreign-key constraints:
--     "posts_posting_loc_fkey" FOREIGN KEY (posting_loc) REFERENCES regions(id)
--     "posts_user_post_id_fkey" FOREIGN KEY (user_post_id) REFERENCES users(id)

-- This is older table that has an array as a data type
-- CREATE TABLE posts (
--     id SERIAL PRIMARY KEY,
--     post_title VARCHAR(30),
--     post_text TEXT[],
--     user_post_id INTEGER REFERENCES users(id),
--     posting_loc INTEGER REFERENCES regions(id)
-- );

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    post_title VARCHAR(30),
    post_text TEXT,
    user_post_id INTEGER REFERENCES users(id),
    posting_loc INTEGER REFERENCES regions(id)
);

-- INSERT INTO posts(post_title, post_text, user_post_id, posting_loc)
-- VALUES ('Piano for sale $300', '{Antique Piano for sale $300}', 9, 3),
-- ('Smart TV for sale', '{Used 80 inch Samsung TV 4 sale. $600 or best offer}', 8, 1),
-- ('PS5 $1000', '{BNIB PS5 $1000 or trade for a used car}', 10, 2);

-- craigslist_db=# INSERT INTO posts(post_title, post_text, user_post_id, posting_loc)
-- VALUES ('Piano for sale $300', '{Antique Piano for sale $300}', 9, 3),
-- ('Smart TV for sale', '{Used 80 inch Samsung TV 4 sale. $600 or best offer}', 8, 1),
-- ('PS5 $1000', '{BNIB PS5 $1000 or trade for a used car}', 10, 2);
-- INSERT 0 3
-- craigslist_db=# SELECT * FROM posts;
--  id |     post_title      |                       post_text                        | user_post_id | posting_loc 
-- ----+---------------------+--------------------------------------------------------+--------------+-------------
--   1 | Piano for sale $300 | {"Antique Piano for sale $300"}                        |            9 |           3
--   2 | Smart TV for sale   | {"Used 80 inch Samsung TV 4 sale. $600 or best offer"} |            8 |           1
--   3 | PS5 $1000           | {"BNIB PS5 $1000 or trade for a used car"}             |           10 |           2



-- craigslist_db=# 
INSERT INTO posts(post_title, post_text, user_post_id, posting_loc)
VALUES('Macbook pro 16-inch, $1000', '{Macbook pro (16-inch, 2022) for sale $1000}', 11, 1);
INSERT 0 1

-- Added to post 11/22
craigslist_db=# SELECT * FROM posts;
 id |         post_title         |                       post_text                        | user_post_id | posting_loc 
----+----------------------------+--------------------------------------------------------+--------------+-------------
  1 | Piano for sale $300        | {"Antique Piano for sale $300"}                        |            9 |           3
  2 | Smart TV for sale          | {"Used 80 inch Samsung TV 4 sale. $600 or best offer"} |            8 |           1
  3 | PS5 $1000                  | {"BNIB PS5 $1000 or trade for a used car"}             |           10 |           2
  4 | Macbook pro 16-inch, $1000 | {"Macbook pro (16-inch","2022) for sale $1000"}        |           11 |           1
(4 rows)


-- INSERT INTO posts (post_title, post_text, user_post_id, posting_loc)
-- VALUES('Piano for sale', '{Antique piano for sale. $200 or best offer}', 1, 94110),
-- ('Apple watch for sale', '{3rd generation apple watch for sale. $300}', NULL);
--    FOREIGN KEY (category_id, posts_id)
--     REFERENCES users (id)
--     ON UPDATE CASCADE ON DELETE,

-- craigslist_db=# SELECT * FROM posts;
--  id | post_title | post_text | user_post | posting_loc 
-- ----+------------+-----------+-----------+-------------
-- (0 rows)


-- here you need to have a separate join table for categories to posts 
-- how you have it here each category can only have one post
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    category_title VARCHAR(100),
    match_cat_to_post TEXT
);

INSERT INTO categories (category_title, match_cat_to_post)
VALUES('For Sale', 'Electronics'),
('For Sale', 'Instruments'),
('For Sale', 'Antiques'),
('For Sale', 'Video games');

craigslist_db=# SELECT * FROM categories;
 id | category_title | match_cat_to_post 
----+----------------+-------------------
  1 | For Sale       | Electronics
  2 | For Sale       | Instruments
  3 | For Sale       | Antiques
  4 | For Sale       | Video games
(4 rows)


SELECT category_title, post_title
FROM categories
JOIN posts
ON categories.id = posts.id;


 category_title |     post_title      
----------------+---------------------
 For Sale       | Piano for sale $300
 For Sale       | Smart TV for sale
 For Sale       | PS5 $1000
(3 rows)


-- SELECT match_cat_to_post, post_title
-- FROM categories
-- JOIN posts
-- ON categories.id = posts.id;

-- craigslist_db=# SELECT match_cat_to_post, post_title
-- FROM categories
-- JOIN posts
-- ON categories.id = posts.id;
--  match_cat_to_post |     post_title      
-- -------------------+---------------------
--  Electronics       | Piano for sale $300
--  Instruments       | Smart TV for sale
--  Antiques          | PS5 $1000
-- (3 rows)


-- CREATE TABLE
-- craigslist_db=# SELECT * FROM categories;
--  id | category | match_post_to_cat 
-- ----+----------+-------------------
-- (0 rows)


-- ALTER TABLE craigslist_db.posts WITH CHECK ADD CONSTRAINT
-- [FK_categories_posts] FOREIGN KEY([posts_id])
-- REFERENCES craigslist_db.posts ([post_id])
-- ON UPDATE CASCADE;

craigslist_db=# \d
                    List of relations
 Schema |       Name        |   Type   |      Owner      
--------+-------------------+----------+-----------------
 public | categories        | table    | XuXaO415
 public | categories_id_seq | sequence | XuXaO415
 public | posts             | table    | XuXaO415
 public | posts_id_seq      | sequence | XuXaO415
 public | regions           | table    | XuXaO415
 public | regions_id_seq    | sequence | XuXaO415
 public | users             | table    | XuXaO415
 public | users_id_seq      | sequence | XuXaO415




-- here you need to have a seperate join table for categories to posts 
-- how you have it here each category can only have one post
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    category_title VARCHAR(100),
    match_cat_to_post TEXT
);

INSERT INTO categories (category_title, match_cat_to_post)
VALUES('For Sale', 'Electronics'),
('For Sale', 'Instruments'),
('For Sale', 'Antiques'),
('For Sale', 'Video games');

-- craigslist_db=# 
SELECT * FROM categories;
 id | category_title | match_cat_to_post 
----+----------------+-------------------
  1 | For Sale       | Electronics
  2 | For Sale       | Instruments
  3 | For Sale       | Antiques
  4 | For Sale       | Video games
-- (4 rows)


-- Design a schema for Craigslist! Your schema should keep track of the following

-- The region of the craigslist post (San Francisco, Atlanta, Seattle, etc)
-- Users and preferred region
-- Posts: contains title, text, the user who has posted, the location of the posting, the region of the posting
-- Categories that each post belongs to
-- avoid implementing array elements in your sql TABLES 
S