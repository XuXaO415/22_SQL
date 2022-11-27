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
--     league_standing INTEGER UNIQUE NOT NULL
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

----------------------------Redo--------------------------------


CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    team_name TEXT UNIQUE NOT NULL,
    team_wins INTEGER DEFAULT 0,
    team_losses INTEGER DEFAULT 0,
    ties INTEGER DEFAULT 0,
    goals_for INTEGER DEFAULT 0,
    goals_against INTEGER DEFAULT 0,
    league_standing INTEGER UNIQUE NOT NULL
);


CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    player_name TEXT UNIQUE NOT NULL,
    player_position TEXT NOT NULL,
    player_team TEXT REFERENCES teams(team_name),
    goals INTEGER DEFAULT 0,
    assists INTEGER DEFAULT 0,
    yellow_cards INTEGER DEFAULT 0,
    red_cards INTEGER DEFAULT 0,
    player_stats INTEGER UNIQUE NOT NULL
);

INSERT INTO players (player_name, player_position, player_team, goals, assists, yellow_cards, red_cards, player_stats)
VALUES ('Lionel Messi', 'Forward', 'Barcelona', 0, 0, 0, 0, 0),
('Cristiano Ronaldo', 'Forward', 'Juventus', 0, 0, 0, 0, 0),
('Neymar', 'Forward', 'Paris Saint-Germain', 0, 0, 0, 0, 0),
('Kylian Mbappe', 'Forward', 'Paris Saint-Germain', 0, 0, 0, 0, 0),
('Robert Lewandowski', 'Forward', 'Bayern Munich', 0, 0, 0, 0, 0),
('Sadio Mane', 'Forward', 'Liverpool', 0, 0, 0, 0, 0),
('Kevin De Bruyne', 'Midfielder', 'Manchester City', 0, 0, 0, 0, 0),
('Sergio Ramos', 'Defender', 'Real Madrid', 0, 0, 0, 0, 0),
('Virgil Van Dijk', 'Defender', 'Liverpool', 0, 0, 0, 0, 0),
('Sergio Busquets', 'Defender', 'Barcelona', 0, 0, 0, 0, 0);

CREATE TABLE season (
    id SERIAL PRIMARY KEY,
    start_date DATE,
    end_date DATE
);

INSERT INTO season (start_date, end_date)
VALUES('2021-08-09', '2022-05-25');


CREATE TABLE referees (
    id SERIAL PRIMARY KEY,
    referee_name TEXT,
    referees_call BOOLEAN NOT NULL,
    in_game INTEGER REFERENCES matches(id)
);

INSERT INTO referees (referee_name, referees_call, in_game)
VALUES ('Mark Clattenburg', TRUE, 0),
('Howard Webb', TRUE, 0),
('Michael Oliver', TRUE, 0),
('Martin Atkinson', TRUE, 0),
('Mike Dean', TRUE, 0),
('Anthony Taylor', TRUE, 0),
('Andre Marriner', TRUE, 0),
('Paul Tierney', TRUE, 0),
('Lee Mason', TRUE, 0),
('Mike Jones', TRUE, 0);


CREATE TABLE matches (
    id SERIAL PRIMARY KEY,
    home_team TEXT REFERENCES teams(team_name) NOT NULL,
    road_team TEXT REFERENCES teams(team_name) NOT NULL,
    game_won BOOLEAN REFERENCES teams(team_name) NOT NULL,
    game_lost BOOLEAN REFERENCES teams(team_name) NOT NULL,
    game_tied BOOLEAN REFERENCES teams(team_name) NOT NULL,
    season INTEGER REFERENCES seasons(id)
    match_date DATE NOT NULL,
    referee REFERENCES referees(id),
    yellow_cards INTEGER DEFAULT 0,
    red_cards INTEGER DEFAULT 0
);


CREATE TABLE goals (
    id SERIAL PRIMARY KEY,
    scored_by TEXT REFERENCES players(player_name),
    -- player_scored TEXT REFERENCES players(player_name),
    scored_against TEXT REFERENCES teams(team_name),
    scoring_team TEXT REFERENCES teams(team_name),
    match INTEGER REFERENCES matches(id)
);


-- The standings/rankings of each team in the league (This doesn’t have to be its own table if the data can be captured somehow).

CREATE TABLE standings (
    id SERIAL PRIMARY KEY,
    matches_played INTEGER,
    team TEXT REFERENCES teams(team_name),
    games_won INTEGER REFERENCES teams(team_name),
    games_drawn INTEGER REFERENCES teams(team_name),
    games_lost INTEGER REFERENCES teams(team_name),
    goals_scored INTEGER REFERENCES teams(team_name),
    goals_conceded INTEGER REFERENCES teams(team_name),
    goal_difference INTEGER REFERENCES teams(team_name),
    points INTEGER REFERENCES teams(team_name),
    season INTEGER REFERENCES season(id)

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
--TODO: Add goal [key] id

CREATE TABLE games (
    id SERIAL PRIMARY KEY,
    game_date DATE,
    home_team TEXT REFERENCES teams(team_name),
    away_team TEXT REFERENCES teams(team_name),
    home_score INTEGER REFERENCES teams(team_name),
    away_score INTEGER REFERENCES teams(team_name),
    team_goal INTEGER REFERENCES teams(team_name),
    season_id INTEGER REFERENCES matches(id),
    referee_id INTEGER REFERENCES referees(id),
    game_id INTEGER REFERENCES matches(id)
);


-- NOT NECESSARY
-- CREATE TABLE game_goals (
--     id SERIAL PRIMARY KEY,
--     game_id INTEGER REFERENCES games(id),
--     player_id INTEGER REFERENCES players(id),
--     team_id INTEGER REFERENCES teams(id),
--     opponent_team_id INTEGER REFERENCES teams(id)
-- );

-- INSERT INTO game_goals (game_id, player_id, team_id, opponent_team_id)
-- VALUES(1,)











