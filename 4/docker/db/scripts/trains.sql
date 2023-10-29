CREATE DATABASE fortov_214;

\c fortov_214;

CREATE TABLE cities (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100),
    region VARCHAR(100),
    UNIQUE(name, region)
);

CREATE TABLE stations (
    name VARCHAR(100) PRIMARY KEY,
    num_of_tracks INTEGER,
    city_id INTEGER REFERENCES cities(id)
);

CREATE TABLE trains (
    train_number INTEGER PRIMARY KEY,
    length INTEGER,
    start_station VARCHAR(100) REFERENCES stations(name),
    end_station VARCHAR(100) REFERENCES stations(name)
);

CREATE TABLE connections (
    from_station VARCHAR(100) REFERENCES stations(name),
    to_station VARCHAR(100) REFERENCES stations(name),
    train_number INTEGER REFERENCES trains(train_number),
    departure TIMESTAMP,
    arrival TIMESTAMP,
    PRIMARY KEY (from_station, to_station)
);