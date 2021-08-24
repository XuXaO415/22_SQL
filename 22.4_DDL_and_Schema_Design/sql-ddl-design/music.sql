-- from the terminal run:
-- psql < music.sql

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

CREATE TABLE songs
(
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  release_date DATE NOT NULL,
  artists TEXT[] NOT NULL,
  album TEXT NOT NULL,
  producers TEXT[] NOT NULL
);

INSERT INTO songs
  (title, duration_in_seconds, release_date, artists, album, producers)
VALUES
  ('MMMBop', 238, '04-15-1997', '{"Hanson"}', 'Middle of Nowhere', '{"Dust Brothers", "Stephen Lironi"}'),
  ('Bohemian Rhapsody', 355, '10-31-1975', '{"Queen"}', 'A Night at the Opera', '{"Roy Thomas Baker"}'),
  ('One Sweet Day', 282, '11-14-1995', '{"Mariah Cary", "Boyz II Men"}', 'Daydream', '{"Walter Afanasieff"}'),
  ('Shallow', 216, '09-27-2018', '{"Lady Gaga", "Bradley Cooper"}', 'A Star Is Born', '{"Benjamin Rice"}'),
  ('How You Remind Me', 223, '08-21-2001', '{"Nickelback"}', 'Silver Side Up', '{"Rick Parashar"}'),
  ('New York State of Mind', 276, '10-20-2009', '{"Jay Z", "Alicia Keys"}', 'The Blueprint 3', '{"Al Shux"}'),
  ('Dark Horse', 215, '12-17-2013', '{"Katy Perry", "Juicy J"}', 'Prism', '{"Max Martin", "Cirkut"}'),
  ('Moves Like Jagger', 201, '06-21-2011', '{"Maroon 5", "Christina Aguilera"}', 'Hands All Over', '{"Shellback", "Benny Blanco"}'),
  ('Complicated', 244, '05-14-2002', '{"Avril Lavigne"}', 'Let Go', '{"The Matrix"}'),
  ('Say My Name', 240, '11-07-1999', '{"Destiny''s Child"}', 'The Writing''s on the Wall', '{"Darkchild"}');


  *******************************************************************************

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

CREATE TABLE songs (
  id SERIAL PRIMARY KEY,
  artist TEXT NOT NULL,
  best_selling_album TEXT[],
  album_length FLOAT NOT NULL,
  num_of_tracks INTEGER NOT NULL,
  num_of_albums INTEGER NOT NULL,
  album_award BOOLEAN NOT NULL,
  song_writers TEXT[],
  record_company TEXT NOT NULL
  -- copies_sold INTEGER NOT NULL
);

INSERT INTO songs (artist, best_selling_album, num_of_tracks, num_of_albums, album_award, song_writers, record_company)
VALUES ('Beastie Boys', '{Licensed to Ill}', '13', '8', 'True', '{Beastie Boys, Rick Rubin}', 'Def Jam'),
('Madonna', '{True Blue}', '9', '64', 'True', '{Madonna, Stephen Bray, Patrick Leonard}', 'Sire/Warner Bros'),
('Rihanna', '{Good Girl Gone Bad}',  '12', 'True', '{Rihanna}', 'Def Jam'),
('Keak da Sneak', '{Town Business}', '13', '36', 'False', '{Charles Bowens}', 'Moe Doe Entertainment'),
('Michael Jackson','{Thriller}', '9', '60', 'True', '{Michael Jackson, Quincy Jones}', 'Epic');

('{}', '{}', ),
('{}', '{}', ),
('{}', '{}', ),
('{}', '{}', ),
('{}', '{}', )

