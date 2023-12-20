select * from raw_credits_2nf limit 10;

select * from new_raw_titles_2nf limit 10;


-- Creating media_id table
-- Will be used to create relationships between tables

CREATE TABLE media_id AS
SELECT DISTINCT ON (id) id, title, release_year
FROM new_raw_titles_2nf
GROUP BY id, title, release_year;

select * from media_id limit 10;

ALTER TABLE media_id
ADD COLUMN index INT GENERATED ALWAYS AS IDENTITY UNIQUE;

ALTER TABLE media_id
ADD PRIMARY KEY(id);


-- Creating media_genres table
-- Will be used to create relationships between tables

CREATE TABLE db_users.media_genres AS
SELECT id, title, genres
FROM new_raw_titles_2nf;

select * from db_users.media_genres limit 10;

ALTER TABLE db_users.media_genres
ADD COLUMN index INT GENERATED ALWAYS AS IDENTITY UNIQUE;

ALTER TABLE db_users.media_genres
ADD PRIMARY KEY(index);

-- drop table db_users.media_genres;


-- Creating media_countries table
-- Will be used to create relationships between tables

CREATE TABLE db_users.media_countries AS
SELECT id, title, production_countries
FROM new_raw_titles_2nf
GROUP BY id, title, production_countries;

select * from db_users.media_countries limit 10;

ALTER TABLE db_users.media_countries
ADD COLUMN index INT GENERATED ALWAYS AS IDENTITY UNIQUE;

ALTER TABLE db_users.media_countries
ADD PRIMARY KEY(index);

-- drop table db_users.media_countries;

ALTER TABLE new_raw_titles_2nf
DROP COLUMN production_countries,
DROP COLUMN genres;




-- Copying tables to a db_users schema
-- Tables will be used by db_analyst and db_scientist users

CREATE TABLE db_users.new_raw_titles_2nf
AS
SELECT id, title, type, release_year, age_certification, runtime, seasons, imdb_id, imdb_score, imdb_votes
FROM new_raw_titles_2nf
GROUP BY id, title, type, release_year, age_certification, runtime, seasons, imdb_id, imdb_score, imdb_votes;

SELECT * FROM db_users.new_raw_titles_2nf LIMIT 10;

ALTER TABLE db_users.new_raw_titles_2nf
ADD COLUMN index INT GENERATED ALWAYS AS IDENTITY UNIQUE;

ALTER TABLE db_users.new_raw_titles_2nf
ADD PRIMARY KEY(index);



CREATE TABLE db_users.raw_credits_2nf
AS
TABLE raw_credits_2nf;

SELECT * FROM db_users.raw_credits_2nf LIMIT 10;

ALTER TABLE db_users.raw_credits_2nf
ADD PRIMARY KEY(index);



CREATE TABLE db_users.media_id
AS
TABLE media_id;

SELECT * FROM db_users.media_id LIMIT 10;

ALTER TABLE db_users.media_id
ADD COLUMN index INT GENERATED ALWAYS AS IDENTITY UNIQUE;

ALTER TABLE db_users.media_id
ADD PRIMARY KEY(id);



CREATE TABLE db_users.media_person_id
AS
SELECT person_id, name
FROM db_users.raw_credits_2nf
GROUP BY person_id, name;

SELECT * FROM db_users.media_person_id LIMIT 10;

ALTER TABLE db_users.media_person_id
ADD COLUMN index INT GENERATED ALWAYS AS IDENTITY UNIQUE;

ALTER TABLE db_users.media_person_id
ADD PRIMARY KEY(person_id);



-- Adding FK constraints to tables
-- to create relationships between tables


-- 1. raw_credits_2nf

ALTER TABLE db_users.raw_credits_2nf 
ADD FOREIGN KEY (id) 
REFERENCES media_id (id)
ON DELETE CASCADE;


-- 2. new_raw_titles_2nf

ALTER TABLE db_users.new_raw_titles_2nf
ADD FOREIGN KEY (id) 
REFERENCES media_id (id)
ON DELETE CASCADE;


-- 3. media_countries

ALTER TABLE db_users.media_countries
ADD FOREIGN KEY (id) 
REFERENCES media_id (id)
ON DELETE CASCADE;


-- 4. media_genres

ALTER TABLE db_users.media_genres
ADD FOREIGN KEY (id) 
REFERENCES media_id (id)
ON DELETE CASCADE;


-- iNTERMEDIATE TABLE FOR MANY-TO-MANY RELATIONSHIPS

CREATE TABLE IF NOT EXISTS db_users.new_raw_titles_2nf_raw_credits_2nf
(
    new_raw_titles_2nf_id character varying(10) COLLATE pg_catalog."default",
    raw_credits_2nf_id character varying(10) COLLATE pg_catalog."default"
);

ALTER TABLE IF EXISTS db_users.new_raw_titles_2nf_raw_credits_2nf
    ADD FOREIGN KEY (new_raw_titles_2nf_id)
    REFERENCES db_users.new_raw_titles_2nf (id) MATCH SIMPLE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS db_users.new_raw_titles_2nf_raw_credits_2nf
    ADD FOREIGN KEY (raw_credits_2nf_id)
    REFERENCES db_users.raw_credits_2nf (id) MATCH SIMPLE
    ON DELETE CASCADE;



-- Adding id column from media_id table 
-- to tables that don't have one in order
-- to create a relationship between tables

-- 1. (example code for future if needed)

-- alter table best_movie_by_year_2nf
-- add column id varchar(10);

-- update best_movie_by_year_2nf t1
-- set id = t2.id
-- from media_id t2 
-- where t2.title = t1.title
-- and t2.release_year = t1.release_year;

-- select * from best_movie_by_year_2nf;







-- Checking tables

select * from raw_credits_2nf 
where person_id = 14658;

select * from raw_credits_2nf 
where id = 'tm84618';

-- Taxi Driver movie

select * from db_users.new_raw_titles_2nf where title like '%Taxi Driver%';

select * from raw_credits_2nf
where id like '%tm84618%';

select * from new_raw_titles_2nf
where id like '%tm84618%';






