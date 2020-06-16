drop table if exists covid;

create table covid ("fips" float8, "Total Cases" int, "Total Deaths" int, "Count" int);

copy covid from 'C://temp/us_counties_final_data.csv' csv header;

select * from covid;

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

create view lau_unemploy_more
select "County Name/State Abbreviation", "Employed", "Unemployed", "Unemployment Rate (%)" from lau
where "Unemployment Rate (%)" >= 3.6
order by "Unemployment Rate (%)" desc

create view lau_unemploy_less
select "County Name/State Abbreviation", "Employed", "Unemployed", "Unemployment Rate (%)" from lau
where "Unemployment Rate (%)" < 3.6
and "Unemployment Rate (%)" > 0
order by "Unemployment Rate (%)" desc

create view qcew_avgpay_less as
select "Area","Annual Average Pay" from hlcn
where "Ownership" = 'Total Covered'
and "Area Type" = 'County'
and "Annual Average Pay" <
(
select "Annual Average Pay" from hlcn
where "Area" = 'U.S. TOTAL'
and "Ownership" = 'Total Covered'
)

create view qcew_avgpay_more as
select "Area","Annual Average Pay" from hlcn
where "Ownership" = 'Total Covered'
and "Area Type" = 'County'
and "Annual Average Pay" >
(
select "Annual Average Pay" from hlcn
where "Area" = 'U.S. TOTAL'
and "Ownership" = 'Total Covered'
)

update lau set "LAUS Code" = substring("LAUS Code",3,5);

alter table lau
alter column "LAUS Code" type float8
using "LAUS Code"::double precision;

delete from hlcn
where "Area Code" = 'US000';

delete from hlcn
where "Area Code" like 'C%';

alter table hlcn
alter column "Area Code" type float8
using "Area Code"::double precision;

create view final_db as
select  covid.fips, hlcn."Area", covid."Total Cases",
		covid."Total Deaths", lau."Unemployed",
		lau."Unemployment Rate (%)",
		hlcn."Annual Average Pay",
		hlcn."Industry", lau."Period" from lau
join covid on covid.fips=lau."LAUS Code"
join hlcn on hlcn."Area Code"=lau."LAUS Code";
