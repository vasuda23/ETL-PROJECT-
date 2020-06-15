drop table if exists lau;

create table lau (  "LAUS Code" varchar,
                    "State FIPS Code" varchar,
				    "County FIPS Code" int,
                    "County Name/StateAbbreviation" varchar,
				    "Period" varchar,
                    "Labor Force" int,
                    "Employed" int,
                    "Unemployed" int,
                    "Unemployment Rate (%)" float8);

copy lau from 'C:\temp\lau-clean.csv' csv header;

select * from lau;

drop table if exists hlcn;

create table hlcn ( "Area Code" varchar,
                    "St" varchar,
                    "Cnty" float8, "Own" int,
                    "NAICS" int,
                    "Year" int, "Qtr" varchar,
                    "Area Type" varchar,
                    "St Name" varchar,
                    "Area" varchar,
                    "Ownership" varchar,
                    "Industry" varchar,
                    "Annual Average Status Code" varchar,
                    "Annual Average Establishment Count" int,
                    "Annual Average Employment" int,
                    "Annual Total Wages" int,
                    "Annual Average Weekly Wage" int,
                    "Annual Average Pay" int,
                    "Employment Location Quotient Relative to U.S." float8,
                    "Total Wage Location Quotient Relative to U.S." float8);

copy hlcn from 'C:\temp\hlcn-clean.csv' csv header;

select * from hlcn;
