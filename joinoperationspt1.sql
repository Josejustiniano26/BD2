-- Ejercicio 1
SELECT matchid, player
FROM goal
WHERE teamid = 'GER';


-- Ejercicio 2
SELECT id, stadium, team1, team2
FROM game
WHERE id = 1012;


-- Ejercicio 3
SELECT player, teamid, stadium, mdate
FROM game
JOIN goal ON game.id = goal.matchid
WHERE teamid = 'GER';


-- Ejercicio 4
SELECT team1, team2, player
FROM game
JOIN goal ON game.id = goal.matchid
WHERE player LIKE 'Mario%';


-- Ejercicio 5
SELECT player, teamid, coach, gtime
FROM goal
JOIN eteam ON goal.teamid = eteam.id
WHERE gtime <= 10;


-- Ejercicio 6
SELECT mdate, teamname
FROM game
JOIN eteam ON game.team1 = eteam.id
WHERE eteam.coach = 'Fernando Santos';


-- Ejercicio 7
SELECT player
FROM game
JOIN goal ON game.id = goal.matchid
WHERE stadium = 'National Stadium, Warsaw';



-- Ejercicio 8

SELECT DISTINCT player
FROM game
JOIN goal ON game.id = goal.matchid
WHERE (team1 = 'GER' OR team2 = 'GER')
  AND goal.teamid != 'GER';


-- Ejercicio 9

SELECT teamname, COUNT(player) AS total_goals
FROM eteam
JOIN goal ON eteam.id = goal.teamid
GROUP BY teamname;



-- Ejercicio 10

SELECT stadium, COUNT(player) AS total_goals
FROM game
JOIN goal ON game.id = goal.matchid
GROUP BY stadium;


-- Ejercicio 11

SELECT matchid, mdate, COUNT(player) AS total_goals
FROM game
JOIN goal ON game.id = goal.matchid
WHERE team1 = 'POL' OR team2 = 'POL'
GROUP BY matchid, mdate;



-- Ejercicio 12

SELECT matchid, mdate, COUNT(player) AS goals_by_GER
FROM game
JOIN goal ON game.id = goal.matchid
WHERE teamid = 'GER'
GROUP BY matchid, mdate;



 
