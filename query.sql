drop table if exists lau;

create table lau ("LAUS Code" varchar, "State FIPS Code" varchar,
				  "County FIPS Code" int, "County Name/State Abbreviation" varchar,
				  "Period" varchar, "Labor Force" int, "Employed" int,
				  "Unemployed" int, "Unemployment Rate (%)" float8);

copy lau from 'C:\temp\lau-clean.csv' csv header;

select * from lau;
