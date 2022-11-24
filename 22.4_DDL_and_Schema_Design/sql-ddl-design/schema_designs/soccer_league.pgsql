-- All of the teams in the ue
-- All of the goals scored by every player for each game
-- All of the players in the ue and their corresponding teams
-- All of the referees who have been part of each game
-- All of the matches played between teams
-- All of the start and end dates for season that a ue has
-- The standings/rankings of each team in the ue (This doesn’t have to be its own table if the data can be captured somehow).


DROP DATABASE IF EXISTS soccer_ue_db;

CREATE DATABASE soccer_ue_db;

\c soccer_ue_db;

-- CREATE TABLE teams (
--     id SERIAL PRIMARY KEY,
--     team_name TEXT UNIQUE NOT NULL,
--     team_wins INTEGER DEFAULT 0,
--     team_losses INTEGER DEFAULT 0,
--     game_goals INTEGER DEFAULT 0,
--     goals_for INTEGER DEFAULT 0,
--     goals_against INTEGER DEFAULT 0,
--     against_team INTEGER DEFAULT 0,
--     team_stats INTEGER UNIQUE NOT NULL,
--     ue_standing INTEGER UNIQUE NOT NULL
-- );

-- CREATE TABLE players (
--     id SERIAL PRIMARY KEY,
--     player_stats INTEGER UNIQUE NOT NULL,
--     player_name TEXT REFERENCES teams(team_name),
--     player_team TEXT REFERENCES teams(team_name),
--     goals_from_player INTEGER DEFAULT 0

-- );


-- CREATE TABLE goals (
--     id SERIAL PRIMARY KEY,
--     player_name TEXT REFERENCES players(player_name),
--     scoring_team TEXT REFERENCES teams(team_name),
--     scored_against TEXT REFERENCES teams(team_name),
--     player_scored TEXT REFERENCES players(player_name),
--     match INTEGER REFERENCES matches(id)

-- );


-- CREATE TABLE referees (
--     id SERIAL PRIMARY KEY,
--     referees_part INTEGER REFERENCES matches(id),
--     referee_call BOOLEAN NOT NULL

-- );


-- CREATE TABLE matches (
--     id SERIAL PRIMARY KEY,
--     season INTEGER REFERENCES seasons(id),
--     home_team TEXT REFERENCES teams(team_name) NOT NULL,
--     road_team TEXT REFERENCES teams(team_name) NOT NULL,
--     game_won BOOLEAN REFERENCES teams(against_team, team_name) NOT NULL,
--     game_lost BOOLEAN REFERENCES teams(against_team, team_name) NOT NULL
-- );


-- CREATE TABLE seasons (
--     id SERIAL PRIMARY KEY,
--     start_date DATE,
--     end_date DATE
-- );




-- CREATE TABLE teams (
--     id SERIAL PRIMARY KEY,
--     team_name TEXT UNIQUE NOT NULL
-- );


-- CREATE TABLE players (
--     id SERIAL PRIMARY KEY,
--     player_name TEXT UNIQUE NOT NULL,
--     player_team TEXT REFERENCES teams(team_name)
-- );


-- CREATE TABLE goals (
--     id SERIAL PRIMARY KEY,
--     player_name TEXT REFERENCES players(player_name),
--     scoring_team TEXT REFERENCES teams(team_name),
--     scored_against TEXT REFERENCES teams(team_name),
--     player_scored TEXT REFERENCES players(player_name),
--     match INTEGER REFERENCES matches(id)
-- );

----------------------------Redo--------------------------------


CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    team_name TEXT UNIQUE NOT NULL
);

INSERT INTO teams (team_name)
VALUES('Bayern München'),
('SSC Napoli'),
('Real Madrid'),
('Manchester City'),
('Liverpool FC'),
('Barcelona'),
('Paris Saint-Germain'),
('Borussia Dortmund'),
('Tottenham Hotspur'),
('Juventus'),
('Chelsea FC'),
('FC Porto'),
('Atletico Madrid'),
('FC Schalke 04'),
('Manchester United'),
('FC Internazionale Milano'),
('FC Zenit'),
('FC Basel'),
('FC Arsenal'),
('FC Sevilla'),
('FC Barcelona');



CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    player_name TEXT UNIQUE NOT NULL,
    player_team TEXT REFERENCES teams(team_name)
);

INSERT INTO players (player_name, player_team)
VALUES('Robert Lewandowski', 'Bayern München'),
('Dries Mertens', 'SSC Napoli'),
('Karim Benzema', 'Real Madrid'),
('Sergio Agüero', 'Manchester City'),
('Mohamed Salah', 'Liverpool FC'),
('Lionel Messi', 'Barcelona'),
('Kylian Mbappé', 'Paris Saint-Germain'),
('Jadon Sancho', 'Borussia Dortmund'),
('Harry Kane', 'Tottenham Hotspur'),
('Cristiano Ronaldo', 'Juventus'),
('Eden Hazard', 'Chelsea FC'),
('Tiquinho Soares', 'FC Porto'),
('Antoine Griezmann', 'Atletico Madrid');


CREATE TABLE matches (
    id SERIAL PRIMARY KEY,
    match_date_and_time DATE NOT NULL,
    match_team TEXT REFERENCES teams(team_name),
    match_opponent TEXT REFERENCES teams(team_name),
    match_goals INTEGER REFERENCES goals(id),
    match_players INTEGER REFERENCES players(id),
    match_stats INTEGER UNIQUE NOT NULL
);

INSERT INTO matches (match_date_and_time, match_team, match_opponent, match_goals, match_players, match_stats)
VALUES('2021-09-18', 'Bayern München', 'FC Schalke 04', 3, 1, 1),
('2021-09-18', 'Real Madrid', 'FC Internazionale Milano', 3, 1, 2),
('2021-09-18', 'SSC Napoli', 'FC Arsenal', 2, 1, 3),
('2021-09-18', 'FC Basel', 'FC Zenit', 1, 1, 4),
('2021-09-18', 'FC Sevilla', 'FC Internazionale Milano', 2, 1, 5),
('2021-09-18', 'Manchester City', 'FC Sevilla', 3, 1, 6),
('2021-09-18', 'FC Porto', 'FC Basel', 1, 1, 7),
('2022-09-18', 'FC Internazionale Milano', 'FC Sevilla', 1, 1, 8),
('2022-09-18', 'FC Zenit', 'FC Basel', 2, 1, 9),
('2022-09-18', 'FC Arsenal', 'SSC Napoli', 1, 1, 10),
('2022-09-18', 'Atletico Madrid', 'Bayern München', 1, 1, 11),
('2021-09-18', 'FC Schalke 04', 'FC Porto', 1, 1, 12),
('2022-09-18', 'FC Sevilla', 'Manchester City', 1, 1, 13),
('2022-09-18', 'FC Internazionale Milano', 'Real Madrid', 1, 1, 14),
('2022-09-19', 'Tottenham Hotspur', 'Atletico Madrid', 4, 1, 15),
('2021-09-19', 'Borussia Dortmund', 'Real Madrid', 3, 1, 16),
('2021-09-19', 'FC Barcelona', 'FC Internazionale Milano', 5, 1, 17),
('2022-09-19', 'FC Arsenal', 'FC Barcelona', 1, 2, 19);



CREATE TABLE goals (
    id SERIAL PRIMARY KEY,
    goal_player TEXT REFERENCES players(player_name),
    goal_team TEXT REFERENCES teams(team_name),
    goal_opponent TEXT REFERENCES teams(team_name)
    -- goal_scorer TEXT REFERENCES players(player_name),
    -- goal_match INTEGER REFERENCES matches(id)
);

INSERT INTO goals (goal_player, goal_team, goal_opponent)
VALUES('Robert Lewandowski', 'Bayern München', 'SSC Napoli'),
('Dries Mertens', 'SSC Napoli', 'Bayern München'),
('Karim Benzema', 'Real Madrid', 'Manchester City'),
('Sergio Agüero', 'Manchester City', 'Real Madrid'),
('Mohamed Salah', 'Liverpool FC', 'Barcelona'),
('Lionel Messi', 'Barcelona', 'Liverpool FC'),
('Kylian Mbappé', 'Paris Saint-Germain', 'Borussia Dortmund'),
('Jadon Sancho', 'Borussia Dortmund', 'Paris Saint-Germain'),
('Harry Kane', 'Tottenham Hotspur', 'Juventus'),
('Cristiano Ronaldo', 'Juventus', 'Tottenham Hotspur'),
('Eden Hazard', 'Chelsea FC', 'FC Porto'),
('Tiquinho Soares', 'FC Porto', 'Chelsea FC'),
('Antoine Griezmann', 'Atletico Madrid', 'FC Schalke 04');


CREATE TABLE referees (
    id SERIAL PRIMARY KEY,
    referee_name TEXT,
    referees_call BOOLEAN NOT NULL
);

INSERT INTO referees (referee_name, referees_call)
VALUES('Cüneyt Çakır', 'TRUE'),
('Pawel Raczkowski', 'TRUE'),
('Szymon Marciniak', 'TRUE'),
('Björn Kuipers', 'TRUE'),
('Milorad Mažić', 'TRUE'),
('Damir Skomina', 'TRUE'),
('Andreas Ekberg', 'TRUE'),
('Ovidiu Hategan', 'TRUE'),
('Björn Kuipers', 'TRUE'),
('Milorad Mažić', 'TRUE'),
('Damir Skomina', 'TRUE'),
('Andreas Ekberg', 'TRUE');


CREATE TABLE season (
    id SERIAL PRIMARY KEY,
    start_date DATE,
    end_date DATE
);

INSERT INTO season (start_date, end_date)
VALUES('2021-08-09', '2022-05-25');


CREATE TABLE standings (
    id SERIAL PRIMARY KEY,
    team_name TEXT REFERENCES teams(team_name),
    team_wins INTEGER,
    team_losses INTEGER,
    team_ties INTEGER,
    team_points INTEGER
);

INSERT INTO standings (team_name, team_wins, team_losses, team_ties, team_points)
VALUES('Bayern München', 2, 5, 1, 1),
('SSC Napoli', 2, 8, 2, 9),
('Real Madrid', 3, 5, 1, 1),
('Manchester City', 4, 3, 1, 1),
('Liverpool FC', 5, 5, 1, 3),
('Barcelona', 2, 5, 1, 1),
('Paris Saint-Germain', 3, 9, 1, 1),
('Borussia Dortmund', 4, 5, 1, 1),
('Tottenham Hotspur', 3, 5, 1, 1),
('Juventus', 1, 5, 2, 3),
('Chelsea FC', 6, 1, 1, 1),
('FC Porto', 3, 5, 1, 1),
('Atletico Madrid', 3, 5, 1, 1),
('FC Schalke 04', 3, 5, 1, 1),
('Manchester United', 3, 5, 1, 1),
('FC Internazionale Milano', 3, 5, 1, 1),
('FC Zenit', 3, 5, 1, 1),
('FC Basel', 3, 5, 1, 1),
('FC Arsenal', 3, 5, 1, 1),
('FC Sevilla', 3, 5, 1, 1);

--TODO: Either fix or create a new table that keeps track of [all] the teams (not just one team)
-- Mentor said my original table only assigned one team and goals were not referencing games
-- I think I fixed it by creating the table below and referencing the teams, matches.
--TODO: Add goal key id

CREATE TABLE games (
    id SERIAL PRIMARY KEY,
    game_date DATE,
    home_team TEXT REFERENCES teams(team_name),
    away_team TEXT REFERENCES teams(team_name),
    home_score INTEGER,
    away_score INTEGER,
    season_id INTEGER REFERENCES matches(id),
    referee_id INTEGER REFERENCES referees(id),
    game_id INTEGER REFERENCES matches(id)
);

CREATE TABLE game_goals (
    id SERIAL PRIMARY KEY,
    game_id INTEGER REFERENCES games(id),
    player_id INTEGER REFERENCES players(id),
    team_id INTEGER REFERENCES teams(id),
    opponent_team_id INTEGER REFERENCES teams(id)
);

INSERT INTO game_goals (game_id, player_id, team_id, opponent_team_id)
VALUES(1,)











