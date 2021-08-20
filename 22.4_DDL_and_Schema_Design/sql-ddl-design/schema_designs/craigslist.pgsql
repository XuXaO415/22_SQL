-- The region of the craigslist post (San Francisco, Atlanta, Seattle, etc) (1:1)
-- Users and preferred region (1:M)
-- Posts: contains title, text, the user who has posted, the location of the posting, the region of the posting (M:M)
-- Categories that each post belongs to (1:1)


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

-- CREATE TABLE
-- craigslist_db=# SELECT * FROM users;
--  id | username | password | preferred_region 
-- ----+----------+----------+------------------
-- (0 rows)


CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    post_title VARCHAR(30),
    post_text TEXT,
    user_post INTEGER REFERENCES users(id),
    posting_loc INTEGER REFERENCES regions(id)
);

--    FOREIGN KEY (category_id, posts_id)
--     REFERENCES users (id)
--     ON UPDATE CASCADE ON DELETE,

-- craigslist_db=# SELECT * FROM posts;
--  id | post_title | post_text | user_post | posting_loc 
-- ----+------------+-----------+-----------+-------------
-- (0 rows)



CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    category TEXT UNIQUE NOT NULL,
    match_post_to_cat INTEGER REFERENCES posts(id)
);

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




