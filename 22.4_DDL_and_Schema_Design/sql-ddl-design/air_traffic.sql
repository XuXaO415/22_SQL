-- from the terminal run:
-- psql < air_traffic.sql

DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

CREATE TABLE tickets
(
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  seat TEXT NOT NULL,
  departure TIMESTAMP NOT NULL,
  arrival TIMESTAMP NOT NULL,
  airline TEXT NOT NULL,
  from_city TEXT NOT NULL,
  from_country TEXT NOT NULL,
  to_city TEXT NOT NULL,
  to_country TEXT NOT NULL
);

INSERT INTO tickets
  (first_name, last_name, seat, departure, arrival, airline, from_city, from_country, to_city, to_country)
VALUES
  ('Jennifer', 'Finch', '33B', '2018-04-08 09:00:00', '2018-04-08 12:00:00', 'United', 'Washington DC', 'United States', 'Seattle', 'United States'),
  ('Thadeus', 'Gathercoal', '8A', '2018-12-19 12:45:00', '2018-12-19 16:15:00', 'British Airways', 'Tokyo', 'Japan', 'London', 'United Kingdom'),
  ('Sonja', 'Pauley', '12F', '2018-01-02 07:00:00', '2018-01-02 08:03:00', 'Delta', 'Los Angeles', 'United States', 'Las Vegas', 'United States'),
  ('Jennifer', 'Finch', '20A', '2018-04-15 16:50:00', '2018-04-15 21:00:00', 'Delta', 'Seattle', 'United States', 'Mexico City', 'Mexico'),
  ('Waneta', 'Skeleton', '23D', '2018-08-01 18:30:00', '2018-08-01 21:50:00', 'TUI Fly Belgium', 'Paris', 'France', 'Casablanca', 'Morocco'),
  ('Thadeus', 'Gathercoal', '18C', '2018-10-31 01:15:00', '2018-10-31 12:55:00', 'Air China', 'Dubai', 'UAE', 'Beijing', 'China'),
  ('Berkie', 'Wycliff', '9E', '2019-02-06 06:00:00', '2019-02-06 07:47:00', 'United', 'New York', 'United States', 'Charlotte', 'United States'),
  ('Alvin', 'Leathes', '1A', '2018-12-22 14:42:00', '2018-12-22 15:56:00', 'American Airlines', 'Cedar Rapids', 'United States', 'Chicago', 'United States'),
  ('Berkie', 'Wycliff', '32B', '2019-02-06 16:28:00', '2019-02-06 19:18:00', 'American Airlines', 'Charlotte', 'United States', 'New Orleans', 'United States'),
  ('Cory', 'Squibbes', '10D', '2019-01-20 19:30:00', '2019-01-20 22:45:00', 'Avianca Brasil', 'Sao Paolo', 'Brazil', 'Santiago', 'Chile');


  *******************************************************************************


DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

CREATE TABLE airline_manifest (
  id SERIAL PRIMARY KEY,
  passenger_name TEXT[],
  ticket_num INTEGER NOT NULL,
  depart_date TIMESTAMP NOT NULL,
  arrival_date TIMESTAMP NOT NULL,
  destination TEXT[],
  flight_num VARCHAR(10),
  gate_num VARCHAR(3)
);

INSERT INTO airline_manifest (passenger_name, ticket_num, depart_date, arrival_date, destination, flight_num, gate_num)
VALUES ('{Landry, Zoe}','16510117','2020-09-24', '2020-09-24 22:00:00','{Las Vegas, Nevada}', 'HME05N', 'G9'),
('{Hendricks, Isadora}','16780323','2020-09-24','2020-09-24 22:00:00','{Las Vegas, Nevada}', 'KDE97O', 'G9'),
('{Hammond, Mara}','16931016','2021-09-30', '2021-09-29 22:45:00', '{Tokyo, Japan}', 'CDN06Q','B22'),
('{Whitley, Noah}','16800818','2021-10-11', '2021-10-10 15:56:00', '{London, England}', 'CIK75S' , 'F19' ),
('{Davis, Galvin}','16511029','2021-01-12', '2021-01-12 21:00:00', '{Rio de Janeiro , Brazil}', 'WDU89I', 'D4'),
('{Glass, Ganasia}','16380425','2021-03-12','2021-03-12 19:03:00' , '{Patagonia, Argentina}', 'GGZ64Q', 'E4'),
('{Wilkinson, Kendra}','16850110','2022-02-11', '2022-02-11 17:27:00', '{Machu Picchu, Peru}', 'SER03L', 'A4'),
('{Galloway, Plato}','16470311','2021-12-04','2021-12-04 09:00:00','{New Delhi, India}','XDZ94P', 'D2'),
('{Ewing, Stuart}','16390626 ','2022-05-03','2022-05-03 13:32:44','{Phuket, Thailand}', 'CZN43N', 'C2');

air_traffic=# SELECT * FROM airline_manifest;

 id |   passenger_name    | ticket_num |     depart_date     |    arrival_date     |        destination        | flight_num | gate_num 
----+---------------------+------------+---------------------+---------------------+---------------------------+------------+----------
  1 | {Landry,Zoe}        |   16510117 | 2020-09-24 00:00:00 | 2020-09-24 22:00:00 | {"Las Vegas",Nevada}      | HME05N     | G9
  2 | {Hendricks,Isadora} |   16780323 | 2020-09-24 00:00:00 | 2020-09-24 22:00:00 | {"Las Vegas",Nevada}      | KDE97O     | G9
  3 | {Hammond,Mara}      |   16931016 | 2021-09-30 00:00:00 | 2021-09-29 22:45:00 | {Tokyo,Japan}             | CDN06Q     | B22
  4 | {Whitley,Noah}      |   16800818 | 2021-10-11 00:00:00 | 2021-10-10 15:56:00 | {London,England}          | CIK75S     | F19
  5 | {Davis,Galvin}      |   16511029 | 2021-01-12 00:00:00 | 2021-01-12 21:00:00 | {"Rio de Janeiro",Brazil} | WDU89I     | D4
  6 | {Glass,Ganasia}     |   16380425 | 2021-03-12 00:00:00 | 2021-03-12 19:03:00 | {Patagonia,Argentina}     | GGZ64Q     | E4
  7 | {Wilkinson,Kendra}  |   16850110 | 2022-02-11 00:00:00 | 2022-02-11 17:27:00 | {"Machu Picchu",Peru}     | SER03L     | A4
  8 | {Galloway,Plato}    |   16470311 | 2021-12-04 00:00:00 | 2021-12-04 09:00:00 | {"New Delhi",India}       | XDZ94P     | D2
  9 | {Ewing,Stuart}      |   16390626 | 2022-05-03 00:00:00 | 2022-05-03 13:32:44 | {Phuket,Thailand}         | CZN43N     | C2
(9 rows)

--https://support.travelport.com/webhelp/GlobalWare/Content/14-Groups/Airline_Manifest.htm --

-- https://www.generatedata.com/--