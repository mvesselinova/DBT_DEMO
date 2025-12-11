WITH daily_weather AS (
    SELECT 
    DATE(TIME) AS daily_weather
    , weather
    , TEMP 
    , humidity
    , clouds
    FROM {{ source('demo', 'weather') }}
)
, daily_weather_agg AS (
    SELECT 
    daily_weather
    , weather
    , round(avg(TEMP),2) AS AVG_TEMP
    , round(avg(humidity), 2) AS AVG_HUMIDITY
    , round(avg(clouds), 2) AS AVG_CLOUD
    FROM daily_weather
    GROUP BY daily_weather, weather
    qualify ROW_NUMBER() OVER (PARTITION BY daily_weather ORDER BY COUNT(weather) desc ) = 1
)
SELECT *
FROM daily_weather_agg
