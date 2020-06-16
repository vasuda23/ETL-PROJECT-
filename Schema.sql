-- Database: Project 2

-- DROP DATABASE "Project 2";

CREATE DATABASE "Project 2"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;


-- Table: public."Corona"

-- DROP TABLE public."Corona";

CREATE TABLE public."Corona"
(
    "Total_Cases" character(10485760) COLLATE pg_catalog."default",
    "Total_Deaths" character(10485760) COLLATE pg_catalog."default",
    fips character(10485760) COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."Corona"
    OWNER to postgres;