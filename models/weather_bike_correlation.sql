WITH CTE AS (

SELECT 
t.*
 ,w.*
FROM {{ ref('trip_fact') }} t
LEFT JOIN  {{ ref('daily_weather') }} w
    ON T.TRIP_DATE = W.DAILY_WEATHER
order by TRIP_DATE desc
)
select *
from CTE