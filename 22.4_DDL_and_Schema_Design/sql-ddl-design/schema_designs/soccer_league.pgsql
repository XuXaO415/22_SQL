-- All of the teams in the league
-- All of the goals scored by every player for each game
-- All of the players in the league and their corresponding teams
-- All of the referees who have been part of each game
-- All of the matches played between teams
-- All of the start and end dates for season that a league has
-- The standings/rankings of each team in the league (This doesn’t have to be its own table if the data can be captured somehow).


DROP DATABASE IF EXISTS soccer_league_db;

CREATE DATABASE soccer_league_db;

\c soccer_league_db;

CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    team_name TEXT UNIQUE NOT NULL,
    team_wins INTEGER DEFAULT 0,
    team_losses INTEGER DEFAULT 0,
    game_goals INTEGER DEFAULT 0,
    goals_for INTEGER DEFAULT 0,
    goals_against INTEGER DEFAULT 0,
    team_stats INTEGER UNIQUE NOT NULL,
    league_standing INTEGER UNIQUE NOT NULL
);


CREATE TABLE goals (
    id SERIAL PRIMARY KEY,
    player_name TEXT REFERENCES players(player_name),
    scoring_team TEXT REFERENCES teams(team_name),
    scored_against TEXT REFERENCES teams(team_name),
    player_scored TEXT REFERENCES players(player_name),
    match INTEGER REFERENCES matches(id)

);


CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    player_stats INTEGER UNIQUE NOT NULL,
    player_name TEXT REFERENCES teams(team_name),
    player_team TEXT REFERENCES teams(team_name),
    goals_from_player INTEGER DEFAULT 0

);



CREATE TABLE referees (
    id SERIAL PRIMARY KEY,
    referees_part INTEGER REFERENCES matches(id),
    referee_call BOOLEAN

);


CREATE TABLE matches (
    id SERIAL PRIMARY KEY,
    season INTEGER REFERENCES seasons(id),
    home_team TEXT REFERENCES teams(team_name) NOT NULL,
    road_team TEXT REFERENCES teams(team_name) NOT NULL,
    game_won BOOLEAN REFERENCES
    game_lost
);


CREATE TABLE seasons (
    id SERIAL PRIMARY KEY,
    start_date DATE,
    end_date DATE
);















