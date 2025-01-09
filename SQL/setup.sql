-- assume role as accountadmin
use role accountadmin;

-- create database
create or replace database EXERCISE_CO2_VS_TEMPERATURE;

-- use database
use database EXERCISE_CO2_VS_TEMPERATURE;

-- create schema
create or replace schema EXERCISE_CO2_VS_TEMPERATURE.PSA;
create or replace schema EXERCISE_CO2_VS_TEMPERATURE.GLOBAL_TEMPERATURES;
create or replace schema EXERCISE_CO2_VS_TEMPERATURE.CARBON_EMISSIONS;

-- use schema
use schema PSA;

-- setup github integration to public github repository
create or replace api integration git_datasets_integration
api_provider = git_https_api
api_allowed_prefixes = ('https://github.com/Data-Navigators')
enabled = true;

create or replace git repository git_datasets
api_integration = git_datasets_integration 
origin = 'https://github.com/Data-Navigators/Data_Processing.git';

-- file format to read csv
create or replace file format EXERCISE_CO2_VS_TEMPERATURE.PSA.my_csv_format
type = csv
skip_header = 1
field_optionally_enclosed_by = '"';

-- create a stage to point to external files from git
create or replace stage EXERCISE_CO2_VS_TEMPERATURE.PSA.files_stage;

-- point to files in git
copy files
into @files_stage
from @git_datasets/branches/automate_sf_setup/new_data;

-- create staging tables
create or replace table EXERCISE_CO2_VS_TEMPERATURE.PSA.EMISSIONBYCOUNTRY(
JSON_STRING varchar,SYS_LOADED_ID varchar);
create or replace table EXERCISE_CO2_VS_TEMPERATURE.PSA.GLOBALTEMPERATURES(
JSON_STRING varchar);
create or replace table EXERCISE_CO2_VS_TEMPERATURE.PSA.TEMPERATURESBYCOUNTRY(
JSON_STRING varchar);

-- copy data from stage to staging tables
COPY INTO EXERCISE_CO2_VS_TEMPERATURE.PSA.EMISSIONBYCOUNTRY
FROM @files_stage/new_data/EMISSIONSBYCOUNTRY.csv
FILE_FORMAT = ( FORMAT_NAME = 'my_csv_format' ) ;

COPY INTO EXERCISE_CO2_VS_TEMPERATURE.PSA.GLOBALTEMPERATURES
FROM @files_stage/new_data/GLOBALTEMPERATURES.csv
FILE_FORMAT = ( FORMAT_NAME = 'my_csv_format' ) ;

COPY INTO  EXERCISE_CO2_VS_TEMPERATURE.PSA.TEMPERATURESBYCOUNTRY
FROM @files_stage/new_data/TEMPERATURESBYCOUNTRY.csv
FILE_FORMAT = ( FORMAT_NAME = 'my_csv_format' ) ;

-- view data
select * from EXERCISE_CO2_VS_TEMPERATURE.PSA.EMISSIONBYCOUNTRY;

select * from EXERCISE_CO2_VS_TEMPERATURE.PSA.GLOBALTEMPERATURES;

select * from EXERCISE_CO2_VS_TEMPERATURE.PSA.TEMPERATURESBYCOUNTRY;
