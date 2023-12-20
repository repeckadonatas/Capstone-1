

CREATE SCHEMA db_users;


-- GIVING GRANTS TO USERS
-- Grants for db_analyst user

GRANT USAGE ON SCHEMA db_users
TO db_analyst;

GRANT SELECT ON ALL TABLES IN SCHEMA db_users TO db_analyst;


-- Grants for db_scientist user

GRANT USAGE, CREATE ON SCHEMA db_users
TO db_scientist;

GRANT SELECT, INSERT ON ALL TABLES IN SCHEMA db_users TO db_scientist;


-- Checking user privileges

SET ROLE db_analyst;

SET ROLE db_scientist;



-- Back to db_admin

SELECT CURRENT_USER;

SET ROLE db_admin;

GRANT ALL ON ALL TABLES IN SCHEMA db_users TO db_admin;

-- GRANT USAGE ON SCHEMA public
-- TO db_admin;

-- GRANT USAGE ON SCHEMA db_users
-- TO db_admin;


-- Table check

select * from db_users.raw_credits_2nf limit 10;

select * from db_users.new_raw_titles_2nf limit 10;


