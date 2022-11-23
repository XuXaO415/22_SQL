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

-------------------Regions table------------------

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

--------------------Users table----------------------------
---------------------Updated table-------------------------
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(15) UNIQUE NOT NULL,
    password VARCHAR(15) NOT NULL,
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
  1 | Fluffsterz4573  | weur34323      |                1
  2 | CaptainJacz     | sfkshjf2372esa |                3
  3 | GeorgiaPeach    | ewiry782349r   |                2
  4 | Mission_kid_415 | password12345  |                1
(4 rows)



-- CREATE TABLE
-- craigslist_db=# SELECT * FROM users;
--  id | username | password | preferred_region 
-- ----+----------+----------+------------------
-- (0 rows)


-- craigslist_db=# \d posts;
--                                       Table "public.posts"
--     Column    |         Type          | Collation | Nullable |              Default              
-- --------------+-----------------------+-----------+----------+-----------------------------------
--  id           | integer               |           | not null | nextval('posts_id_seq'::regclass)
--  post_title   | character varying(50) |           |          | 
--  post_text    | text                  |           | not null | 
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


--------------------Categories table----------------------- 
---------------------Updated table-------------------------
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    category TEXT NOT NULL,
    category_section TEXT NOT NULL
);

-- INSERT INTO categories (category_section, category)
-- VALUES('For Sale', 'Electronics'),
-- ('For Sale', 'Instruments'),
-- ('For Sale', 'Electronics'),
-- ('For Sale', 'Video games');


--------------------Posts table----------------------------
---------------------Updated table-------------------------

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  post_title VARCHAR(50),
  post_text TEXT NOT NULL,
  category INTEGER REFERENCES categories(id),
  user_post_id INTEGER REFERENCES users(id),
  posting_loc INTEGER REFERENCES regions(id)
);

-- CREATE TABLE posts (
--     id SERIAL PRIMARY KEY,
--     post_title VARCHAR(30),
--     post_text TEXT,
--     user_post_id INTEGER REFERENCES users(id),
--     posting_loc INTEGER REFERENCES regions(id)
-- );


------------------Posts data-----------------------------

INSERT INTO posts(post_title, post_text, user_post_id, posting_loc)
VALUES ('MacBook pro 16-inch, $1000 OBO', '{MacBook pro (16-inch, 2022) for sale $1000}',  1, 1),
('Piano for sale $300', '{Antique Piano for sale $300}', 3, 2),
('Smart TV for sale', '{Used 80 inch Samsung TV 4 sale. $600 or best offer}', 2, 3),
('PS5 $1000', '{BNIB PS5 $1000 or trade for a used car}', 4, 1);

craigslist_db=#
SELECT * FROM posts;
 id |           post_title           |                      post_text                       | user_post_id | posting_loc 
----+--------------------------------+------------------------------------------------------+--------------+-------------
  5 | MacBook pro 16-inch, $1000 OBO | {MacBook pro (16-inch, 2022) for sale $1000}         |            1 |           1
  6 | Piano for sale $300            | {Antique Piano for sale $300}                        |            3 |           2
  7 | Smart TV for sale              | {Used 80 inch Samsung TV 4 sale. $600 or best offer} |            2 |           3
  8 | PS5 $1000                      | {BNIB PS5 $1000 or trade for a used car}             |            4 |           1
-- (4 rows)

----------------------------------Disregard everything below this line-------------------------------------

-- INSERT INTO posts (post_title, post_text, user_post_id, posting_loc)
-- VALUES('Piano for sale', '{Antique piano for sale. $200 or best offer}', 1, 1),
-- ('Apple watch for sale', '{3rd generation apple watch for sale. $300}', 2, 3);
--    FOREIGN KEY (category_id, posts_id)
--     REFERENCES users (id)
--     ON UPDATE CASCADE ON DELETE,
-- );

-- Empty table
-- craigslist_db=# SELECT * FROM posts;
--  id | post_title | post_text | user_post | posting_loc 
-- ----+------------+-----------+-----------+-------------
-- (0 rows)


-- here you need to have a separate join table for categories to posts 
-- how you have it here each category can only have one post

--------------------Categories table---------------------
-- CREATE TABLE categories (
--     id SERIAL PRIMARY KEY,
--     category_section TEXT NOT NULL,
--     match_cat_to_post TEXT
-- );

-- INSERT INTO categories (category_section, match_cat_to_post)
-- VALUES('For Sale', 'Electronics'),
-- ('For Sale', 'Instruments'),
-- ('For Sale', 'Antiques'),
-- ('For Sale', 'Video games');

-- craigslist_db=# SELECT * FROM categories;
--  id | category_title | match_cat_to_post 
-- ----+----------------+-------------------
--   1 | For Sale       | Electronics
--   2 | For Sale       | Instruments
--   3 | For Sale       | Antiques
--   4 | For Sale       | Video games
-- (4 rows)


-- SELECT category_title, post_title
-- FROM categories
-- JOIN posts
-- ON categories.id = posts.id;


--  category_title |     post_title      
-- ----------------+---------------------
--  For Sale       | Piano for sale $300
--  For Sale       | Smart TV for sale
--  For Sale       | PS5 $1000
-- (3 rows)


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



craigslist_db=# \dt
               List of relations
 Schema |    Name    | Type  |      Owner      
--------+------------+-------+-----------------
 public | categories | table | XuXaO415
 public | posts      | table | XuXaO415
 public | regions    | table | XuXaO415
 public | users      | table | XuXaO415
