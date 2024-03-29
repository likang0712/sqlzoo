--------------------------------------------------------
--------------------------------------------------------
-- 3 SELECT from Nobel
-- https://sqlzoo.net/wiki/SELECT_from_Nobel_Tutorial

-- 1. Change the query shown so that it displays Nobel prizes for 1950.
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950

--2. Show who won the 1962 prize for Literature.
SELECT winner
FROM nobel
WHERE yr = 1962
  AND subject = 'Literature';

--3. Show the year and subject that won 'Albert Einstein' his prize.
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein'

--4. Give the name of the 'Peace' winners since the year 2000, including 2000.
SELECT winner
FROM Nobel
WHERE subject = 'Peace' AND yr >= 2000


--5. Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive.
SELECT *
FROM nobel
WHERE subject = 'Literature' 
  AND (yr BETWEEN 1980 AND 1989)
-- AND (yr >= 1980 AND yr <= 1989)

--6. Show all details of the presidential winners
-- Theodore Roosevelt
-- Woodrow Wilson
-- Jimmy Carter
-- Barack Obama
SELECT * 
FROM nobel
WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Barack Obama',
                  'Jimmy Carter')
				  


--7. Show the winners with first name John
SELECT winner
FROM nobel
WHERE winner LIKE 'John%'

--8. Show the Physics winners for 1980 together with the Chemistry winners for 1984.
SELECT yr, subject, winner
FROM nobel
WHERE (subject = 'Physics' AND yr = 1980 )
   OR (subject = 'Chemistry' and yr = 1984 )
	  
--9. Show the winners for 1980 excluding the Chemistry and Medicine
SELECT yr, subject, winner
FROM nobel
WHERE (yr = 1980 ) 
  AND (subject <> 'Chemistry' AND subject != 'Medicine' )
-- AND subject NOT IN ('Chemistry', 'Medicine')

--10. Show who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004)
SELECT yr, subject, winner 
FROM nobel
WHERE (subject = 'Medicine' AND yr < 1910 )
   OR (subject = 'Literature' AND yr >= 2004)
	  
--11. Find all details of the prize won by PETER GRÜNBERG
SELECT *
FROM nobel
WHERE (winner = 'PETER GRÜNBERG' )


--12.Find all details of the prize won by EUGENE O'NEILL
SELECT *
FROM nobel
WHERE (winner = 'EUGENE O''NEILL' )

--13. List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.
SELECT winner , yr, subject
FROM nobel
WHERE (winner LIKE 'Sir%') 
ORDER BY yr DESC, winner


--14. Show the 1984 winners ordered by subject and winner name; but list Chemistry and Physics last.
SELECT winner, subject
FROM nobel
WHERE yr=1984
ORDER BY subject IN ('Physics','Chemistry'), subject, winner

--------------------------------------------------------
--------------------------------------------------------
-- quiz for above (part of)
-- 3. Pick the code that shows the amount of years where no Medicine awards were given
SELECT COUNT(DISTINCT yr) FROM nobel
 WHERE yr NOT IN (SELECT DISTINCT yr FROM nobel WHERE subject = 'Medicine')

-- 5. Select the code which would show the year when neither a Physics or Chemistry award was given
SELECT yr FROM nobel
 WHERE yr NOT IN(SELECT yr 
                   FROM nobel
                 WHERE subject IN ('Chemistry','Physics'))
 
-- 6. Select the code which shows the years when a Medicine award was given but no Peace or Literature award was
SELECT DISTINCT yr
  FROM nobel
 WHERE subject='Medicine' 
   AND yr NOT IN(SELECT yr FROM nobel 
                  WHERE subject='Literature')
   AND yr NOT IN (SELECT yr FROM nobel
                   WHERE subject='Peace')
