create or replace view EXERCISE_CO2_VS_TEMPERATURE.PSA.STG_GLOBAL_TEMPERATURES(
    "Date",
    LANDANDOCEANAVERAGETEMPERATURE,
    LANDANDOCEANAVERAGETEMPERATUREUNCERTAINTY,
    LANDAVERAGETEMPERATURE,
    LANDAVERAGETEMPERATUREUNCERTAINTY,
    LANDMAXTEMPERATURE,
    LANDMAXTEMPERATUREUNCERTAINTY,
    LANDMINTEMPERATURE,
    LANDMINTEMPERATUREUNCERTAINTY
) as (
    select  
        PARSE_JSON(JSON_STRING):"Date"::VARCHAR AS "Date",
        PARSE_JSON(JSON_STRING):"LandAndOceanAverageTemperature"::VARCHAR AS LandAndOceanAverageTemperature,
        PARSE_JSON(JSON_STRING):"LandAndOceanAverageTemperatureUncertainty"::VARCHAR AS LandAndOceanAverageTemperatureUncertainty,
        PARSE_JSON(JSON_STRING):"LandAverageTemperature"::VARCHAR AS LandAverageTemperature,
        PARSE_JSON(JSON_STRING):"LandAverageTemperatureUncertainty"::VARCHAR AS LandAverageTemperatureUncertainty,
        PARSE_JSON(JSON_STRING):"LandMaxTemperature"::VARCHAR AS LandMaxTemperature,
        PARSE_JSON(JSON_STRING):"LandMaxTemperatureUncertainty"::VARCHAR AS LandMaxTemperatureUncertainty,
        PARSE_JSON(JSON_STRING):"LandMinTemperature"::VARCHAR AS LandMinTemperature,
        PARSE_JSON(JSON_STRING):"LandMinTemperatureUncertainty"::VARCHAR AS LandMinTemperatureUncertainty
    from EXERCISE_CO2_VS_TEMPERATURE.PSA.GLOBALTEMPERATURES
);