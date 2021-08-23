-- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space

CREATE TABLE planets
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  orbital_period_in_years FLOAT NOT NULL,
  orbits_around TEXT NOT NULL,
  galaxy TEXT NOT NULL,
  moons TEXT[]
);

INSERT INTO planets
  (name, orbital_period_in_years, orbits_around, galaxy, moons)
VALUES
  ('Earth', 1.00, 'The Sun', 'Milky Way', '{"The Moon"}'),
  ('Mars', 1.88, 'The Sun', 'Milky Way', '{"Phobos", "Deimos"}'),
  ('Venus', 0.62, 'The Sun', 'Milky Way', '{}'),
  ('Neptune', 164.8, 'The Sun', 'Milky Way', '{"Naiad", "Thalassa", "Despina", "Galatea", "Larissa", "S/2004 N 1", "Proteus", "Triton", "Nereid", "Halimede", "Sao", "Laomedeia", "Psamathe", "Neso"}'),
  ('Proxima Centauri b', 0.03, 'Proxima Centauri', 'Milky Way', '{}'),
  ('Gliese 876 b', 0.23, 'Gliese 876', 'Milky Way', '{}');


  outer_space=# SELECT * FROM planets;

 id |        name        | orbital_period_in_years |  orbits_around   |  galaxy   |                                                      moons                                                       
----+--------------------+-------------------------+------------------+-----------+------------------------------------------------------------------------------------------------------------------
  1 | Earth              |                       1 | The Sun          | Milky Way | {"The Moon"}
  2 | Mars               |                    1.88 | The Sun          | Milky Way | {Phobos,Deimos}
  3 | Venus              |                    0.62 | The Sun          | Milky Way | {}
  4 | Neptune            |                   164.8 | The Sun          | Milky Way | {Naiad,Thalassa,Despina,Galatea,Larissa,"S/2004 N 1",Proteus,Triton,Nereid,Halimede,Sao,Laomedeia,Psamathe,Neso}
  5 | Proxima Centauri b |                    0.03 | Proxima Centauri | Milky Way | {}
  6 | Gliese 876 b       |                    0.23 | Gliese 876       | Milky Way | {}
(6 rows)


*************************************************************
-- We’ve provided you with a handful of SQL files that will create some databases and populate them with some data. 
-- Run each of the seed files and take a look at the data that’s generated. 
-- Next, think about how you could improve the schema. Finally, modify the original seed files based on your updated schema!

DROP DATABASE outer_space;

CREATE DATABASE outer_space;

\c outer_space;

CREATE TABLE galaxies (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  light_years FLOAT NOT NULL,
  galaxy_notes TEXT[]
);

INSERT INTO galaxies
(name, light_years, galaxy_notes)
VALUES('Milky Way',  0.0265, '{Home galaxy of Earth. Barred spiral galaxy.}'),
('Canis Major Dwarf', 0.025, '{Satellite of Milky Way}'),
('Draco II', 0.0701, '{Satellite of Milky Way}'),
('Tucana III',0.0747 ,'{Satellite of Milky Way that is being tidally disrupted[}'),
('Segue 1', 0.075 , '{Satellite of Milky Way}'),
('Sagittarius Dwarf Sphr', 0.081 , '{Satellite of Milky Way}'),
('Hydrus I', 0.0901, '{Satellite of Milky Way, possibly associated with the Magellanic Clouds}'),
('Carina III', 0.0906, '{Satellite of Milky Way}'),
('Ursa Major II Dwarf', 0.098 , '{Satellite of Milky Way}'),
('Triangulum II', 0.098, '{Satellite of Milky Way}'),
('Reticulum II', 	0.102, '{Satellite of Milky Way}'),
('Segue 2', 0.114, '{Satellite of Milky Way, one of the smallest known galaxies}'),
('Carina II', 0.122, '{Satellite of Milky Way}');

-- Sourced from https://en.wikipedia.org/wiki/List_of_nearest_galaxies

outer_space=# SELECT * FROM galaxies;

 id |          name          | light_years |                                galaxy_notes                                 
----+------------------------+-------------+-----------------------------------------------------------------------------
  1 | Milky Way              |      0.0265 | {"Home galaxy of Earth. Barred spiral galaxy."}
  2 | Canis Major Dwarf      |       0.025 | {"Satellite of Milky Way"}
  3 | Draco II               |      0.0701 | {"Satellite of Milky Way"}
  4 | Tucana III             |      0.0747 | {"Satellite of Milky Way that is being tidally disrupted["}
  5 | Segue 1                |       0.075 | {"Satellite of Milky Way"}
  6 | Sagittarius Dwarf Sphr |       0.081 | {"Satellite of Milky Way"}
  7 | Hydrus I               |      0.0901 | {"Satellite of Milky Way","possibly associated with the Magellanic Clouds"}
  8 | Carina III             |      0.0906 | {"Satellite of Milky Way"}
  9 | Ursa Major II Dwarf    |       0.098 | {"Satellite of Milky Way"}
 10 | Triangulum II          |       0.098 | {"Satellite of Milky Way"}
 11 | Reticulum II           |       0.102 | {"Satellite of Milky Way"}
 12 | Segue 2                |       0.114 | {"Satellite of Milky Way","one of the smallest known galaxies"}
 13 | Carina II              |       0.122 | {"Satellite of Milky Way"}
