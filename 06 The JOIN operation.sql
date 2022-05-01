
--------------------------------------------------------
--------------------------------------------------------
-- 6 JOIN 
-- https://sqlzoo.net/wiki/The_JOIN_operation

--1. Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
SELECT matchid, player 
FROM goal 
WHERE teamid = 'GER'

--2. Show id, stadium, team1, team2 for game 1012
SELECT id, stadium, team1, team2
FROM game
WHERE id = 1012

--3. Show the player, teamid and mdate and for every German goal. teamid='GER'
SELECT player, teamid, stadium, mdate
FROM game JOIN goal ON (id=matchid)
WHERE teamid = 'GER'


--4. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT team1, team2, player
FROM game JOIN goal ON (id=matchid)
WHERE player LIKE 'Mario%'

--5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT player, teamid, coach, gtime
FROM goal JOIN eteam ON (teamid = id)
WHERE gtime <= 10


--6. List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT mdate, teamname
FROM game JOIN eteam ON (game.team1 = eteam.id)
WHERE coach = 'Fernando Santos'

--7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT player
FROM goal JOIN game ON (goal.matchid = game.id)
WHERE game.stadium = 'National Stadium, Warsaw'


--8. Instead show the name of all players who scored a goal against Germany.
SELECT DISTINCT player
FROM game JOIN goal ON matchid = id 
WHERE (team1 = 'GER' OR team2 = 'GER') 
  AND teamid <> 'GER'

--9. Show teamname and the total number of goals scored.
SELECT teamname, COUNT(matchid)
FROM eteam JOIN goal ON id=teamid
GROUP BY teamname


--10. Show the stadium and the number of goals scored in each stadium.
SELECT stadium, COUNT(matchid)
FROM game JOIN goal ON (id=matchid)
GROUP BY stadium

--11. For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid, mdate, COUNT(matchid)
FROM game JOIN goal ON (matchid = id)
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate


 --12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT matchid, mdate, COUNT(matchid)
FROM game JOIN goal ON (matchid = id)
WHERE (teamid = 'GER')
GROUP BY matchid, mdate

--13. List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises
SELECT mdate, team1, 
 SUM( CASE WHEN teamid=team1 THEN 1 ELSE 0 END ) AS score1,
 team2,
 SUM( CASE WHEN teamid=team2 THEN 1 ELSE 0 END ) AS score2
FROM game LEFT JOIN goal ON matchid = id
GROUP BY mdate, team1, team2
ORDER BY mdate, team1, team2

--------------------------------------------------------
--------------------------------------------------------
-- quiz for above (part of)

-- 3. Select the code which shows players, their team and the amount of goals they scored against Greece(GRE).
SELECT player, teamid, COUNT(*)
  FROM game JOIN goal ON matchid = id
 WHERE (team1 = "GRE" OR team2 = "GRE")
   AND teamid != 'GRE'
 GROUP BY player, teamid
 
-- 5. Select the code which would show the player and their team for those who have scored against Poland(POL) in National Stadium, Warsaw.

SELECT DISTINCT player, teamid 
   FROM game JOIN goal ON matchid = id 
  WHERE stadium = 'National Stadium, Warsaw' 
 AND (team1 = 'POL' OR team2 = 'POL')
   AND teamid != 'POL'

-- 6. Select the code which shows the player, their team and the time they scored, for players who have played in Stadion Miejski (Wroclaw) but not against Italy(ITA).

SELECT DISTINCT player, teamid, gtime
  FROM game JOIN goal ON matchid = id
 WHERE stadium = 'Stadion Miejski (Wroclaw)'
   AND (( teamid = team2 AND team1 != 'ITA') OR ( teamid = team1 AND team2 != 'ITA'))
   
