SELECT * 
FROM world_life_expectancy
;

SELECT country, Year, CONCAT(country, Year), COUNT(CONCAT(country, Year))
FROM world_life_expectancy
GROUP BY country, Year, CONCAT(country, Year)
HAVING COUNT(CONCAT(country, Year)) > 1 
;

SELECT *
FROM(
SELECT Row_ID, 
CONCAT(country, Year), 
ROW_NUMBER() OVER(PARTITION BY CONCAT(country, Year) ORDER BY CONCAT(country, Year)) AS Row_Num
FROM world_life_expectancy) AS row_table
WHERE Row_Num > 1
;

DELETE FROM world_life_expectancy
WHERE 
	 Row_ID IN(
     SELECT Row_ID
FROM(
SELECT Row_ID, 
CONCAT(country, Year), 
ROW_NUMBER() OVER(PARTITION BY CONCAT(country, Year) ORDER BY CONCAT(country, Year)) AS Row_Num
FROM world_life_expectancy) AS row_table
WHERE Row_Num > 1)
;

SELECT * 
FROM world_life_expectancy
WHERE status = ''
;

     
SELECT DISTINCT(status) 
FROM world_life_expectancy
WHERE status <> ''
;

SELECT DISTINCT(country)
FROM world_life_expectancy
WHERE status = 'Developing'
;

UPDATE world_life_expectancy
SET status = 'Developing'
WHERE country IN (SELECT DISTINCT(country)
				 FROM world_life_expectancy
                 WHERE status = 'Developing');
                 
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
   ON t1.country = t2.country
SET t1.status = 'Developing'
WHERE t1.status = ''
AND t2.status <> ''
AND t2.status = 'Developing'
;

SELECT * 
FROM world_life_expectancy
WHERE country = 'United States of America'
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
   ON t1.country = t2.country
SET t1.status = 'Developed'
WHERE t1.status = ''
AND t2.status <> ''
AND t2.status = 'Developed'
;

SELECT * 
FROM world_life_expectancy
WHERE `Life expectancy` = ''
;

SELECT country, Year, `Life expectancy`
FROM world_life_expectancy
WHERE `Life expectancy` = ''
;

SELECT t1.country, t1.Year, t1.`Life expectancy`,
t2.country, t2.Year, t2.`Life expectancy`,
t3.country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
    ON t1.country = t2.country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
    ON t1.country = t3.country
    AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = ''
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
    ON t1.country = t2.country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
    ON t1.country = t3.country
    AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = ''
;

SELECT *
FROM world_life_expectancy
;

SELECT country, 
MIN(`Life expectancy`), 
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS life_increase_15_years
FROM world_life_expectancy
GROUP BY country
HAVING MIN(`Life expectancy`) <> 0 
AND MAX(`Life expectancy`) <> 0 
ORDER BY life_increase_15_years ASC
;

SELECT Year, ROUND(AVG(`Life expectancy`),2)
FROM world_life_expectancy
WHERE `Life expectancy` <> 0 
AND `Life expectancy` <> 0 
GROUP BY Year
ORDER BY Year
;

SELECT country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY country
HAVING Life_Exp > 0 
AND GDP > 0
ORDER BY GDP DESC
;

SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count, 
ROUND(AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END),1) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count, 
ROUND(AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END),1) Low_GDP_Life_Expectancy
FROM world_life_expectancy
;

SELECT status, ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY status
;

SELECT status, 
COUNT(DISTINCT country),
ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY status
;

SELECT country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY country
HAVING Life_Exp > 0 
AND BMI > 0
ORDER BY BMI ASC
;

SELECT country,
Year,
`Life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
WHERE country LIKE '%UNITED%'
;





