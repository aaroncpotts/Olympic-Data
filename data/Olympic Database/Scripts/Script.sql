SELECT *
FROM Olympic_Athlete_Bio oab 
WHERE name = 'Serena Williams'


--Serena Williams appearances 
SELECT edition, event, medal
FROM Olympic_Athlete_Event_Results oaer
JOIN Olympic_Athlete_Bio oab
ON oaer.athlete_id = oab.athlete_id
WHERE oab.name = 'Serena Williams'

SELECT edition, event, medal
FROM Olympic_Athlete_Event_Results oaer
JOIN Olympic_Athlete_Bio oab
ON oaer.athlete_id = oab.athlete_id
WHERE oab.name = 'Venus Williams'


--How does USA do in sport?
SELECT edition_id, country_noc, sport, athlete, medal
FROM Olympic_Athlete_Event_Results oaer 
WHERE sport = 'Tennis' AND country_noc = 'USA' AND medal IN('Bronze,', 'Silver', 'Gold')

--USA Medal count which tells us about Venus Williams' dominance
WITH usa_tennis_results AS (SELECT edition_id, country_noc, sport, athlete, medal
FROM Olympic_Athlete_Event_Results oaer 
WHERE sport = 'Tennis' AND country_noc = 'USA' AND medal IN('Bronze,', 'Silver', 'Gold'))
SELECT athlete, COUNT(medal) AS medal_count
FROM usa_tennis_results
GROUP BY athlete

WITH usa_tennis_results AS (SELECT edition_id, country_noc, sport, athlete, medal
FROM Olympic_Athlete_Event_Results oaer 
WHERE country_noc = 'USA' AND medal IN('Bronze,', 'Silver', 'Gold'))
SELECT athlete, COUNT(medal) AS medal_count
FROM usa_tennis_results
GROUP BY athlete
ORDER BY 2 DESC


SELECT edition
FROM Olympic_Athlete_Event_Results oaer
JOIN Olympic_Athlete_Bio oab
ON oaer.athlete_id = oab.athlete_id
WHERE oab.name = 'Serena Williams'


--Diana code
SELECT edition,
max(CASE WHEN medal = 'Gold' THEN country_noc ELSE 0
END) AS Gold,
max(CASE WHEN medal = 'Silver' THEN country_noc ELSE 0
END) AS Silver,
MAX(CASE WHEN medal = 'Bronze' THEN country_noc ELSE 0
END) AS Bronze
FROM Olympic_Athlete_Event_Results oaer
WHERE sport = 'Tennis' AND athlete = 'Kitty McKane'
GROUP BY edition
ORDER BY edition

SELECT edition,
max(CASE WHEN medal = 'Gold' THEN country_noc ELSE 0
END) AS Gold,
max(CASE WHEN medal = 'Silver' THEN country_noc ELSE 0
END) AS Silver,
MAX(CASE WHEN medal = 'Bronze' THEN country_noc ELSE 0
END) AS Bronze
FROM Olympic_Athlete_Event_Results oaer
WHERE sport = 'Tennis' AND athlete LIKE '%Arantxa%'
GROUP BY edition
ORDER BY edition

--Medal count worldwide
WITH tennis_results AS (SELECT edition_id, country_noc, sport, athlete, medal
FROM Olympic_Athlete_Event_Results oaer 
WHERE sport = 'Tennis' AND medal IN('Bronze', 'Silver', 'Gold'))
SELECT athlete, COUNT(medal) AS medal_count
FROM tennis_results
GROUP BY athlete
ORDER BY 2 DESC

--Medal count worldwide for women
WITH tennis_results AS (SELECT edition_id, country_noc, sport, athlete, medal
FROM Olympic_Athlete_Event_Results oaer 
WHERE sport = 'Tennis' AND event LIKE '%omen%' AND medal IN('Bronze', 'Silver', 'Gold'))
SELECT athlete, COUNT(medal) AS medal_count
FROM tennis_results
GROUP BY athlete
ORDER BY 2 DESC

--Gold Medal count
WITH tennis_results AS (SELECT edition_id, country_noc, sport, athlete, medal
FROM Olympic_Athlete_Event_Results oaer 
WHERE sport = 'Tennis' AND medal IN('Gold'))
SELECT athlete, COUNT(medal) AS medal_count
FROM tennis_results
GROUP BY athlete
ORDER BY 2 DESC

--Gold medal count for women

--Compare with Kitty McCane

--Compare with Vicario

--What years did she appear?
SELECT oaer.edition, oaer.edition_id, oaer.sport, oaer.athlete 
FROM Olympic_Athlete_Event_Results oaer
JOIN Olympic_Athlete_Bio oab
ON oaer.athlete_id = oab.athlete_id
WHERE oab.name = 'Serena Williams'
GROUP BY oaer.edition_id 

SELECT edition, edition_id, YEAR 
FROM Olympics_Games og

--Medal results
SELECT oaer.edition, oaer.edition_id, oaer.event, oaer.pos, oab.name, oaer.medal
FROM Olympic_Athlete_Event_Results oaer
JOIN Olympic_Athlete_Bio oab
ON oaer.athlete_id = oab.athlete_id
WHERE oab.name = 'Serena Williams' AND oaer.medal IN('Bronze', 'Silver', 'Gold')

--Times she lost
SELECT oaer.edition, oaer.edition_id, oaer.event, oaer.pos, oab.name, oaer.medal
FROM Olympic_Athlete_Event_Results oaer
JOIN Olympic_Athlete_Bio oab
ON oaer.athlete_id = oab.athlete_id
WHERE oab.name = 'Serena Williams' AND oaer.medal NOT IN('Bronze', 'Silver', 'Gold')


--Medal count
WITH results AS(SELECT oaer.edition, oaer.edition_id, oaer.event, oaer.pos, oab.name, oaer.medal
FROM Olympic_Athlete_Event_Results oaer
JOIN Olympic_Athlete_Bio oab
ON oaer.athlete_id = oab.athlete_id
WHERE oab.name = 'Serena Williams' AND oaer.medal IN('Bronze', 'Silver', 'Gold'))
SELECT name, COUNT(medal)
FROM results

--Filter data - find when sport and events were introduced
SELECT edition, edition_id, sport, event
FROM Olympic_Athlete_Event_Results oaer
WHERE sport LIKE '%ockey%'
GROUP BY edition, event 
ORDER BY edition ASC

--List of olympics where roller hockey was present
SELECT edition, edition_id, sport, event
FROM Olympic_Athlete_Event_Results oaer
WHERE sport = 'Roller Hockey'
GROUP BY edition, event 
ORDER BY edition ASC

SELECT *
FROM Olympic_Athlete_Event_Results oaer 
WHERE sport LIKE '%ockey%'
ORDER BY edition ASC

--Edition id with country code and athlete_id - this can be used to generate a count
SELECT DISTINCT oaer.edition_id, oaer.edition, oab.country_noc, oab.athlete_id, oaer.sport
FROM Olympic_Athlete_Bio oab
JOIN Olympic_Athlete_Event_Results oaer 
ON oab.athlete_id = oaer.athlete_id
WHERE oaer.sport LIKE '%ockey%' 
GROUP BY oaer.edition_id, oaer.country_noc, oab.athlete_id
ORDER BY oaer.edition_id ASC	

--Debugging Canadian national team
SELECT DISTINCT oaer.edition_id, oaer.edition, oab.country_noc, oab.athlete_id
FROM Olympic_Athlete_Bio oab
JOIN Olympic_Athlete_Event_Results oaer 
ON oab.athlete_id = oaer.athlete_id
WHERE oaer.sport LIKE '%ockey%' AND edition_id = 31 AND oab.country_noc = 'CAN'
GROUP BY oaer.edition_id, oaer.country_noc, oab.athlete_id
ORDER BY oaer.edition_id ASC	

--team size by country - look at 1908
WITH cte AS (SELECT DISTINCT oaer.edition_id, oaer.edition, oab.country_noc, oab.athlete_id
FROM Olympic_Athlete_Bio oab
JOIN Olympic_Athlete_Event_Results oaer 
ON oab.athlete_id = oaer.athlete_id
WHERE oaer.sport LIKE '%ockey%'
GROUP BY oaer.edition_id, oaer.country_noc, oab.athlete_id)
SELECT DISTINCT cte.edition_id, cte.edition, cte.country_noc, COUNT(athlete_id) AS team_size
FROM cte
GROUP BY edition_id, country_noc
ORDER BY team_size DESC

--Trying something
SELECT oaer.edition_id, oaer.edition, oab.country_noc, oab.athlete_id, oaer.sport
FROM Olympic_Athlete_Bio oab
JOIN Olympic_Athlete_Event_Results oaer 
ON oab.athlete_id = oaer.athlete_id
WHERE oaer.sport LIKE '%ockey%'
GROUP BY oaer.edition_id, oaer.country_noc, oab.athlete_id 


--Gives AVG team size
WITH cte AS( SELECT oaer.edition_id, oaer.edition, oab.country_noc, COUNT(oab.athlete_id) AS team_size
FROM Olympic_Athlete_Bio oab
JOIN Olympic_Athlete_Event_Results oaer 
ON oab.athlete_id = oaer.athlete_id
WHERE oaer.sport LIKE '%ockey%'
GROUP BY oaer.edition_id, oaer.country_noc
ORDER BY oaer.edition_id ASC)
SELECT ROUND(AVG(cte.team_size), 1) AS avg_team_size
FROM CTE



--Gives countries that participated each year
SELECT oaer.edition_id, oaer.country_noc  FROM Olympic_Athlete_Bio oab
JOIN Olympic_Athlete_Event_Results oaer 
ON oab.athlete_id = oaer.athlete_id
WHERE oaer.sport LIKE '%ockey%'
GROUP BY oaer.edition_id, oaer.country_noc
ORDER BY oaer.edition_id ASC


WITH cte AS(SELECT oab.*, oaer.country_noc  FROM Olympic_Athlete_Bio oab
JOIN Olympic_Athlete_Event_Results oaer 
ON oab.athlete_id = oaer.athlete_id
WHERE oaer.sport LIKE '%ockey'
GROUP BY oaer.country_noc
ORDER BY country_noc ASC)
SELECT COUNT(country_noc)
FROM cte

SELECT oaer.country_noc  FROM Olympic_Athlete_Bio oab
JOIN Olympic_Athlete_Event_Results oaer 
ON oab.athlete_id = oaer.athlete_id
WHERE oaer.sport LIKE '%ockey%'
GROUP BY oaer.country_noc
ORDER BY oaer.country_noc ASC

SELECT og.edition, og.edition_id, sport, og.country_noc
FROM Olympic_Athlete_Event_Results oaer
JOIN Olympics_Games og 
ON oaer.edition_id = og.edition_id
WHERE sport LIKE '%ockey'
GROUP BY og.edition_id, sport, oaer.country_noc

SELECT DISTINCT edition_id, COUNT(country_noc)
FROM Olympic_Athlete_Event_Results oaer
WHERE sport LIKE '%ockey' AND edition_id = 5
GROUP BY edition_id


--Gives list of all athletes that have participated in a sport
SELECT oab.athlete_id, oab.name
FROM Olympic_Athlete_Bio oab
JOIN Olympic_Athlete_Event_Results oaer 
ON oab.athlete_id = oaer.athlete_id 
WHERE oaer.sport LIKE '%ockey'
GROUP BY oab.athlete_id


SELECT athlete_id, athlete, sport, COUNT(medal)
FROM Olympic_Athlete_Event_Results oaer 
WHERE sport LIKE '%ockey%' AND medal = 'Gold'
GROUP BY athlete_id
ORDER BY COUNT(medal) DESC

SELECT *
FROM Olympics_Games


--This table gives Olympics where hockey happened
SELECT edition, edition_id
FROM Olympic_Athlete_Event_Results oaer
WHERE oaer.sport LIKE '%ockey'
ORDER BY edition_id

--Gives all results where Hockey is involved
SELECT * FROM Olympic_Athlete_Event_Results oaer 
WHERE oaer.sport LIKE '%ockey'
ORDER BY edition_id

SELECT edition, count(country_noc)
FROM Olympic_Athlete_Event_Results oaer 
WHERE sport LIKE '%ockey'
GROUP BY edition