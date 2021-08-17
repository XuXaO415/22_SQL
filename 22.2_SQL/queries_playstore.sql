-- Comments in SQL Start with dash-dash --

╰─ psql < seed_playstore.sql
NOTICE:  database "playstore" does not exist, skipping
DROP DATABASE
CREATE DATABASE
You are now connected to database "playstore" as user "XuXaO415".
CREATE TABLE
INSERT 0 9637



1) Find the app with an ID of 1880.
playstore=# \x auto
Expanded display is used automatically.
playstore=# SELECT * FROM analytics WHERE id = 1880;
-[ RECORD 1 ]---+------------------------
id              | 1880
app_name        | Web Browser for Android
category        | PRODUCTIVITY
rating          | 4.3
reviews         | 144879
size            | Varies with device
min_installs    | 10000000
price           | 0
content_rating  | Everyone
genres          | {Productivity}
last_updated    | 2016-01-24
current_version | 3.5.0
android_version | Varies with device

2) Find the ID and app name for all apps that were last updated on August 01, 2018.
playstore=# SELECT ID, app_name WHERE analytics WHERE last_updated = 2018-08-01;
ERROR:  syntax error at or near "WHERE"
LINE 1: SELECT ID, app_name WHERE analytics WHERE last_updated = 201...
                                            ^
playstore=# SELECT ID, app_name FROM analytics WHERE last_updated = 2018-08-01;
ERROR:  operator does not exist: date = integer
LINE 1: ...CT ID, app_name FROM analytics WHERE last_updated = 2018-08-...

HINT:  No operator matches the given name and argument types. You might need to add explicit type casts.    
playstore=# SELECT ID, app_name FROM analytics WHERE last_updated = '2018-08-01';

  id  |                                     app_name                                      
------+-----------------------------------------------------------------------------------
   10 | Clash Royale
   11 | Candy Crush Saga
   12 | UC Browser - Fast Download Private & Secure
   74 | Score! Hero
  101 | Tiny Flashlight + LED
  102 | Crossy Road
  103 | SimCity BuildIt
  111 | FIFA Soccer
  112 | Angry Birds 2
  125 | Need for Speed™ No Limits
  126 | YouCam Makeup - Magic Selfie Makeovers
  etc.           

3) Count the number of apps in each category, e.g. “Family | 1972”.
playstore=# SELECT category, COUNT(*) AS cat_count FROM analytics GROUP BY category;
      category       | cat_count 
---------------------+-----------
 BOOKS_AND_REFERENCE |       191
 COMMUNICATION       |       342
 BEAUTY              |        46
 EVENTS              |        52
 PARENTING           |        59
 PHOTOGRAPHY         |       313
 GAME                |      1110
 BUSINESS            |       313
 SOCIAL              |       269
 MEDICAL             |       350
 TOOLS               |       753
 TRAVEL_AND_LOCAL    |       234
 ART_AND_DESIGN      |        63
 LIFESTYLE           |       319
 WEATHER             |        79
 COMICS              |        59
 PRODUCTIVITY        |       360
 PERSONALIZATION     |       329
 FINANCE             |       331
 SPORTS              |       338
 ENTERTAINMENT       |       149
 NEWS_AND_MAGAZINES  |       249
 HOUSE_AND_HOME      |        82
 SHOPPING            |       241
 DATING              |       204
 HEALTH_AND_FITNESS  |       298
 EDUCATION           |       156
 MAPS_AND_NAVIGATION |       129
 LIBRARIES_AND_DEMO  |        80
 FOOD_AND_DRINK      |       110
 FAMILY              |      1789
 VIDEO_PLAYERS       |       165
 AUTO_AND_VEHICLES   |        75
(33 rows)

4) Find the top 5 most-reviewed apps and the number of reviews for each.
playstore=# SELECT app_name, reviews FROM analytics WHERE reviews = 5;

                      app_name                      | reviews 
----------------------------------------------------+---------
 CE AR LOG                                          |       5
 CE Airbus                                          |       5
 CE Intelligence                                    |       5
 Team CF                                            |       5
 Squeezy CF                                         |       5
 Wallpapers DAF CF 85 Trucks                        |       5
 CF SPOT                                            |       5
 CF Etowah                                          |       5
 CF Themis                                          |       5
 CG 3D Model Viewer: view 3D models interactively   |       5
 ASCP® CG Exam Flashcards 2018                      |       5
 My CG                                              |       5
 CG Vidhansabha Chunav 2018                         |       5
 (108 rows)
 etc.

5) Find the app that has the most reviews with a rating greater than equal to 4.8.
playstore=# SELECT app_name, reviews FROM analytics WHERE reviews >= 4.8;

-[ RECORD 1 ]------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
app_name | Facebook
reviews  | 78158306
-[ RECORD 2 ]------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
app_name | WhatsApp Messenger
reviews  | 78128208
-[ RECORD 3 ]------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
app_name | Instagram
reviews  | 69119316
-[ RECORD 4 ]------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
app_name | Messenger – Text and Video Chat for Free
reviews  | 69119316
-[ RECORD 5 ]------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
app_name | Clash of Clans
reviews  | 69109672
-[ RECORD 6 ]------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
app_name | Clean Master- Space Cleaner & Antivirus
reviews  | 66577446
-[ RECORD 7 ]------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
app_name | Subway Surfers
reviews  | 66577313
-[ RECORD 8 ]------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
(19 rows)
etc. 
6) Find the average rating for each category ordered by the highest rated to lowest rated.
playstore=# SELECT category, COUNT(category) AVG(rating) FROM analytics GROUP BY rating ORDER BY DESC;
ERROR:  syntax error at or near "("
LINE 1: SELECT category, COUNT(category) AVG(rating) FROM analytics ...

playstore=# SELECT category, AVG(rating) FROM analytics GROUP BY category ORDER BY AVG(rating) DESC;
      category       |        avg         
---------------------+--------------------
 EVENTS              |  4.395238104320708
 EDUCATION           |   4.38903223006956
 ART_AND_DESIGN      |  4.347540949211746
 BOOKS_AND_REFERENCE | 4.3423728633061645
 PERSONALIZATION     |    4.3283387457509
 BEAUTY              |  4.299999970656175
 GAME                |  4.287167731498383
 PARENTING           |  4.285714266251545
 HEALTH_AND_FITNESS  | 4.2743944663902464
 SHOPPING            |  4.253648051376507
 SOCIAL              |  4.245669291244717
 WEATHER             |   4.24399998664856
 SPORTS              |  4.233333332576449
 PRODUCTIVITY        |  4.212173904543338
 AUTO_AND_VEHICLES   |  4.200000017881393
 HOUSE_AND_HOME      |  4.197368430463891
 PHOTOGRAPHY         |  4.196116511489967
 MEDICAL             | 4.1926829182520144
 FAMILY              | 4.1904873752761995
 LIBRARIES_AND_DEMO  | 4.1784615259904125
 FOOD_AND_DRINK      |  4.155660354866172
 COMICS              |  4.155172401461108
 COMMUNICATION       |  4.151234589241169
 FINANCE             |  4.146835436549368
 NEWS_AND_MAGAZINES  |  4.130131007281974
 ENTERTAINMENT       |   4.12617449632427
 BUSINESS            |  4.116666667004849
 TRAVEL_AND_LOCAL    |   4.10179372753263
 LIFESTYLE           |  4.077076400237226
 VIDEO_PLAYERS       |  4.059748438919115
 MAPS_AND_NAVIGATION |  4.058196711735647
 TOOLS               |  4.050627608678331
 DATING              |  3.993684190825412


7)Find the name, price, and rating of the most expensive app with a rating that’s less than 3.
playstore=# SELECT app_name, price, rating FROM analytics WHERE rating < 3 ORDER BY price DESC;
                        app_name                        | price  | rating 
--------------------------------------------------------+--------+--------
 Naruto & Boruto FR                                     | 379.99 |    2.9
 Best CG views                                          |  17.99 |    2.9
 Note FE Theme And Launcher For Samsung Galaxy          |   9.99 |    2.6
 AB Match                                               |   6.99 |    2.6
 GO CP Evolution Calculator                             |   4.99 |    2.9
 PhotoFrame for Synology DS                             |   4.99 |    2.9
 DM Buddy » Learn Digital Marketing                     |   4.99 |    1.7
 BK Shivani Videos                                      |   4.99 |    2.9
 DK Readers                                             |   4.99 |    2.7
 CINE BR                                                |   4.99 |    2.8
 BM Physiotherapy Clinic                                |   4.59 |      2
(264 rows)
etc.

SELECT app_name, price, rating FROM analytics 
  WHERE rating < 3 
  ORDER BY price DESC 
  LIMIT 1;


8) Find all apps with a min install not exceeding 50, that have a rating. Order your results by highest rated first.


playstore=# SELECT * FROM analytics WHERE min_installs  <= 50 AND rating IS NOT NULL ORDER BY rating DESC;

  id  |                    app_name                    |      category       | rating | reviews | size | min_installs | price | content_rating |        genres         | last_updated |  current_version   | android_version 
------+------------------------------------------------+---------------------+--------+---------+------+--------------+-------+----------------+-----------------------+--------------+--------------------+-----------------
 9468 | DT                                             | FAMILY              |      5 |       4 | 52M  |           50 |     0 | Everyone       | {Education}           | 2018-04-03   | 1.1                | 4.1 and up
 9464 | DQ Akses                                       | PERSONALIZATION     |      5 |       4 | 31M  |           50 |  0.99 | Everyone       | {Personalization}     | 2018-04-27   | 1.1                | 4.1 and up
 9453 | DM Adventure                                   | MEDICAL             |      5 |       4 | 25M  |            1 |     0 | Everyone       | {Medical}             | 2018-08-02   | 1.0.72             | 4.0.3 and up
 9427 | db Meter - sound level meter with data logging | GAME                |      5 |       5 | 4.6M |           10 |     0 | Everyone       | {Racing}              | 2018-08-01   | 1.11               | 4.0.3 and up
 9452 | Otto DM                                        | MEDICAL             |      5 |       4 | 2.5M |            5 |     0 | Everyone       | {Medical}             | 2018-08-03   | 1                  | 4.1 and up
 9431 | ElejaOnline DF                                 | FAMILY              |      5 |       5 | 15M  |           50 |     0 | Everyone       | {Education}           | 2017-10-06   | 2.3.3              | 4.4 and up
 8785 | Labs on Demand                                 | BUSINESS            |      5 |      14 | 3.3M |           50 |     0 | Everyone 
 (57 rows)
 etc.

9) Find the names of all apps that are rated less than 3 with at least 10000 reviews.
playstore=# SELECT app_name FROM analytics WHERE rating < 3 AND reviews >= 10000;

                    app_name                     
-------------------------------------------------
 The Wall Street Journal: Business & Market News
 Vikings: an Archer’s Journey
 Shoot Em Down Free
(3 rows)

10) Find the top 10 most-reviewed apps that cost between 10 cents and a dollar.
playstore=# SELECT * FROM analytics WHERE price BETWEEN 0.1 AND 1 ORDER BY reviews DESC LIMIT 10;

  id  |                  app_name                   |    category     | rating | reviews | size | min_installs | price | content_rating |            genres             | last_updated | current_version | android_version 
------+---------------------------------------------+-----------------+--------+---------+------+--------------+-------+----------------+-------------------------------+--------------+-----------------+-----------------
 1144 | Free Slideshow Maker & Video Editor         | GAME            |    4.6 |  408292 | 29M  |     10000000 |  0.99 | Mature 17+     | {Action}                      | 2018-07-12   | 1.7.110758      | 4.1 and up
 2298 | Couple - Relationship App                   | GAME            |    4.3 |   85468 | 36M  |      1000000 |  0.99 | Everyone       | {Arcade}                      | 2018-06-08   | 2.4.1.485300    | 4.0.3 and up
 2315 | Anime X Wallpaper                           | FAMILY          |    4.6 |   84114 | 23M  |       500000 |  0.99 | Everyone 10+   | {Puzzle}                      | 2018-07-05   | 1.13.108869     | 2.3.3 and up
 2603 | Dance On Mobile                             | FAMILY          |    4.6 |   61264 | 43M  |      1000000 |  0.99 | Everyone       | {Puzzle}                      | 2018-06-19   | 3.7.0           | 4.1 and up
 2645 | Marvel Unlimited                            | PERSONALIZATION |    4.3 |   58617 | 26M  |      1000000 |  0.99 | Everyone       | {Personalization}             | 2016-12-07   | 4.3.2           | 4.4 and up
 2646 | FastMeet: Chat, Dating, Love                | PERSONALIZATION |    4.3 |   58614 | 26M  |      1000000 |  0.99 | Everyone       | {Personalization}             | 2016-12-07   | 4.3.2           | 4.4 and up
 2811 | IHG®: Hotel Deals & Rewards                 | FAMILY          |    4.5 |   48754 | 9.3M |       100000 |  0.99 | Everyone       | {Arcade,"Action & Adventure"} | 2014-10-07   | 1.5.2           | 2.3 and up
 3050 | Live Weather & Daily Local Weather Forecast | GAME            |    4.4 |   38419 | 100M |      1000000 |  0.99 | Everyone 10+   | {Action}                      | 2018-08-03   | 2.3.24          | 4.1 and up
 3214 | DreamMapper                                 | GAME            |    4.4 |   32496 | 99M  |      1000000 |  0.99 | Teen           | {Action}                      | 2018-07-03   | 5.3.3           | 2.3 and up
 3227 | Můj T-Mobile Business                       | GAME            |    4.5 |   32344 | 29M  |      1000000 |  0.99 | Everyone       | {Adventure}                   | 2016-10-21   | 1.3.12          | 3.0 and up
(10 rows)

11) Find the most out of date app. Hint: You don’t need to do it this way, but it’s possible to do with a subquery: http://www.postgresqltutorial.com/postgresql-max-function/
playstore=# SELECT * FROM analytics WHERE last_updated = (SELECT MIN(last_updated) FROM analytics);

  id  |  app_name  | category | rating | reviews | size | min_installs | price | content_rating |     genres      | last_updated | current_version | android_version 
------+------------+----------+--------+---------+------+--------------+-------+----------------+-----------------+--------------+-----------------+-----------------
 5701 | CP Clicker | FAMILY   |    4.2 |    1415 | 209k |       100000 |     0 | Everyone       | {Entertainment} | 2010-05-21   | 3.1             | 1.5 and up
(1 row)

playstore=# SELECT * FROM analytics ORDER BY last_updated LIMIT 10;

  id  |                      app_name                      |      category      | rating | reviews | size | min_installs | price | content_rating |        genres        | last_updated | current_version | android_version 
------+----------------------------------------------------+--------------------+--------+---------+------+--------------+-------+----------------+----------------------+--------------+-----------------+-----------------
 5701 | CP Clicker                                         | FAMILY             |    4.2 |    1415 | 209k |       100000 |     0 | Everyone       | {Entertainment}      | 2010-05-21   | 3.1             | 1.5 and up
 6960 | Barcelona Live - Goal Score & News for Barca Fans  | GAME               |    4.1 |     207 | 116k |        50000 |     0 | Everyone       | {Card}               | 2011-01-30   | 1.2             | 1.6 and up
 5913 | Encumbrance Certificate - (Obsolete)               | TOOLS              |    4.1 |     981 | 73k  |       100000 |     0 | Everyone       | {Tools}              | 2011-03-16   | 1.2.4           | 1.6 and up
 3040 | Al Mayadeen                                        | GAME               |    3.7 |   38767 | 4.1M |      5000000 |     0 | Everyone 10+   | {Action}             | 2011-04-11   | 1.4.3           | 2.0 and up
 6546 | Virtual Mother Surgery Doctor : Emergency Hospital | GAME               |      4 |     387 | 1.1M |        50000 |     0 | Everyone       | {Card}               | 2011-04-16   | 1.3.3           | 1.6 and up
 6926 | BF Browser by Betfilter - Stop Gambling Today!     | FAMILY             |    3.6 |     215 | 2.6M |        50000 |     0 | Everyone       | {Puzzle}             | 2011-04-18   | 1               | 2.1 and up
 9162 | tournaments and more.aj.2                          | TOOLS              |    3.9 |       7 | 81k  |          100 |  4.99 | Everyone       | {Tools}              | 2011-05-12   | 1.2.0           | 1.5 and up
 7158 | CG Patwari Exam                                    | TOOLS              |    4.6 |     159 | 29k  |         1000 |  1.49 | Everyone       | {Tools}              | 2011-06-23   | 1.1             | 1.6 and up
 7229 | CS Customizer                                      | TOOLS              |    4.5 |     142 | 26k  |         5000 |     1 | Everyone       | {Tools}              | 2011-06-26   | 1.0.0           | 2.1 and up
 4469 | K-@ Mail - Email App                               | LIBRARIES_AND_DEMO |    3.8 |    7750 | 292k |      1000000 |     0 | Everyone       | {"Libraries & Demo"} | 2011-06-29   | 1               | 1.6 and up

12) Find the most expensive app (the query is very similar to #11).
playstore=# SELECT * FROM analytics ORDER BY price DESC LIMIT 5;

  id  |          app_name           | category  | rating | reviews | size | min_installs | price  | content_rating |     genres      | last_updated | current_version | android_version 
------+-----------------------------+-----------+--------+---------+------+--------------+--------+----------------+-----------------+--------------+-----------------+-----------------
 6766 | Cardi B Piano Game          | LIFESTYLE |    3.6 |     275 | 7.3M |        10000 |    400 | Everyone       | {Lifestyle}     | 2018-05-03   | 1.0.1           | 4.1 and up
 5041 | Korean Dungeon: K-Word 1000 | LIFESTYLE |    3.8 |    3547 | 1.8M |       100000 | 399.99 | Everyone       | {Lifestyle}     | 2018-01-12   | 2               | 4.0.3 and up
 6011 | B-BLE(BLE4.0 Scan)          | FAMILY    |      4 |     856 | 8.7M |        10000 | 399.99 | Everyone       | {Entertainment} | 2018-05-19   | 3               | 4.4 and up
 5515 | TV Local El Salvador        | FINANCE   |    4.1 |    1867 | 4.7M |        50000 | 399.99 | Everyone       | {Finance}       | 2017-11-12   | 1.6             | 4.0 and up
 6132 | CZ-Cyberon Voice Commander  | LIFESTYLE |    3.8 |     718 | 26M  |        10000 | 399.99 | Everyone       | {Lifestyle}     | 2018-03-11   | 1.0.0           | 4.4 and up
(5 rows)


13) Count all the reviews in the Google Play Store.
playstore=# SELECT SUM(reviews) AS count_all_reviews FROM analytics;
 count_all_reviews 
-------------------
        4814575866
(1 row)


playstore=# SELECT * FROM analytics COUNT(reviews);

-[ RECORD 1 ]---+------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------
reviews         | 1
app_name        | Facebook
category        | SOCIAL
rating          | 4.1
reviews         | 78158306
size            | Varies with device
min_installs    | 1000000000
price           | 0
content_rating  | Teen
genres          | {Social}
last_updated    | 2018-08-03
current_version | Varies with device
android_version | Varies with device
-[ RECORD 2 ]---+------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------
reviews         | 2
app_name        | WhatsApp Messenger
category        | SOCIAL
rating          | 4.1
reviews         | 78128208
size            | Varies with device
min_installs    | 1000000000
price           | 0
content_rating  | Teen
genres          | {Social}
last_updated    | 2018-08-03
current_version | Varies with device
android_version | Varies with device
-[ RECORD 3 ]---+------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------
reviews         | 3
app_name        | Instagram
category        | COMMUNICATION
rating          | 4.4
reviews         | 69119316
size            | Varies with device
min_installs    | 1000000000
price           | 0
content_rating  | Everyone
genres          | {Communication}
last_updated    | 2018-08-03
current_version | Varies with device
android_version | Varies with device
-[ RECORD 4 ]---+------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------
reviews         | 4
etc. 
14) Find all the categories that have more than 300 apps in them.
playstore=# SELECT category FROM analytics GROUP BY category HAVING COUNT(*) > 300;
    category     
-----------------
 COMMUNICATION
 PHOTOGRAPHY
 GAME
 BUSINESS
 MEDICAL
 TOOLS
 LIFESTYLE
 PRODUCTIVITY
 PERSONALIZATION
 FINANCE
 SPORTS
 FAMILY
(12 rows)

16) Find the app that has the highest proportion of min_installs to reviews, among apps that have been installed at least 100,000 times. Display the name of the app along with the number of reviews, the min_installs, and the proportion.
playstore=# SELECT app_name, reviews, min_installs,  min_installs / reviews AS proportion
  FROM analytics
  WHERE min_installs >= 100000
  ORDER BY proportion DESC
  LIMIT 1;
     app_name     | reviews | min_installs | proportion 
------------------+---------+--------------+------------
 Kim Bu Youtuber? |      66 |     10000000 |     151515
(1 row)

