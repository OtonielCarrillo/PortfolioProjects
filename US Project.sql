SELECT *
FROM us_project.us_household_income;

SELECT *
FROM us_project.us_household_income_statistics;

ALTER TABLE us_project.us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`;

SELECT id, COUNT(id)
FROM us_household_income
GROUP BY id
HAVING COUNT(id) > 1 
;

SELECT *
FROM (
SELECT row_id,
id,
ROW_NUMBER () OVER(PARTITION BY id ORDER BY id) AS row_num
FROM us_household_income) duplicates
WHERE row_num > 1 
;

DELETE FROM us_household_income
WHERE row_id IN (
    SELECT row_id
    FROM (
       SELECT row_id,
	   id,
       ROW_NUMBER () OVER(PARTITION BY id ORDER BY id) AS row_num
       FROM us_household_income) duplicates
	WHERE row_num > 1)
;

SELECT State_Name, COUNT(State_Name)
FROM us_household_income
GROUP BY State_Name
;

SELECT DISTINCT State_Name
FROM us_household_income
ORDER BY 1
; 

UPDATE us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia'
;


UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama'
;

SELECT *
FROM us_household_income
WHERE county = 'Autauga County'
ORDER BY 1
; 

UPDATE us_household_income
SET place = 'Autaugaville'
WHERE county = 'Autauga County'
AND city = 'Vinemont'
;

SELECT type, COUNT(type)
FROM us_household_income
GROUP BY type
; 

UPDATE us_household_income
SET type = 'Borough'
WHERE type = 'Boroughs'
;

SELECT DISTINCT ALand, AWater 
FROM us_household_income
WHERE (ALand = 0 OR ALand = '' OR ALand IS NULL)
;

SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10
;

SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 3 DESC
LIMIT 10
;

SELECT *
FROM us_household_income u
JOIN us_household_income_statistics us
   ON u.id = us.id
WHERE mean <> 0
;

SELECT u.State_Name, county, type, `primary`, mean, median
FROM us_household_income u
JOIN us_household_income_statistics us
   ON u.id = us.id
WHERE mean <> 0
;

SELECT u.State_Name,ROUND(AVG(mean),1), ROUND(AVG(median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
   ON u.id = us.id
WHERE mean <> 0
GROUP BY u.State_Name
ORDER BY 1 
LIMIT 10
;

SELECT type, ROUND(AVG(mean),1), ROUND(AVG(median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
   ON u.id = us.id
WHERE mean <> 0
GROUP BY type
ORDER BY 1 
LIMIT 20
;

SELECT type,COUNT(type), ROUND(AVG(mean),1), ROUND(AVG(median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
   ON u.id = us.id
WHERE mean <> 0
GROUP BY 1
HAVING COUNT(type) > 100
ORDER BY 4 DESC
LIMIT 20
;

SELECT * 
FROM us_household_income 
WHERE type = 'Community'
;

SELECT u.State_Name, city, ROUND(AVG(mean),1)
FROM us_household_income u
JOIN us_household_income_statistics us
    ON u.id = us.id
GROUP BY u.State_Name, city
ORDER BY  ROUND(AVG(mean),1) DESC
;





















