
-- 9 Self join
-- https://sqlzoo.net/wiki/Self_join


-- 1. How many stops are in the database.
SELECT COUNT(id)
FROM stops

-- 2. Find the id value for the stop 'Craiglockhart'
SELECT id
FROM stops
WHERE name = 'Craiglockhart'

-- 3. Give the id and the name for the stops on the '4' 'LRT' service.
SELECT id, name
FROM stops
JOIN route ON stops.id = route.stop
WHERE num = '4'
AND company = 'LRT'


-- 4. The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes.
-- Question is asking: Run the query and notice the two services that link these stops have a count of 2
-- Means: routes that will go 149 twice,  or 52 twice, or will go 149 once then 52 once

-- select the info that link these stops have a count of 2
SELECT company, num, COUNT(*)
FROM route
WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) = 2
-- company num count(*)
-- LRT      4    2
-- LRT     45    2


-- select the info that  link stop 149, stop 53 and stop 19 in a total of 3 times (chances a loop bus will go through a same stop more than once, e.g. bus num 1: 137-59-137..)
SELECT company, num, COUNT(*)
FROM route
WHERE stop=149 OR stop=53 OR stop=19
GROUP BY company, num
HAVING COUNT(*) = 3
-- company num count(*)
-- LRT      4    3

SELECT company, num, COUNT(*)
FROM route
WHERE stop=137 OR stop=59
GROUP BY company, num
HAVING COUNT(*) = 3
-- company num count(*)
-- LRT      1    3
-- LRT      6    3

-- select the info that will definitely link stop 149, stop 53
SELECT a.company, a.num
FROM route a, route b, route c
WHERE a.company = b.company
  AND a.num = b.num
  AND a.stop = 149
  AND b.stop = 53
GROUP BY a.company, a.num
-- company num 
-- LRT      4
-- LRT     45


-- select the info that will definitely direct link stop 149, stop 53 and stop 19
SELECT a.company, a.num, COUNT(*)
FROM route a, route b, route c
WHERE a.company = b.company
  AND b.company = c.company
  AND a.num = b.num
  AND b.num = c.num
  AND a.stop = 149
  AND b.stop = 53
  AND c.stop = 19
GROUP BY a.company, a.num
-- company num count(*)
-- LRT      4    1


-- 5. Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.
SELECT DISTINCT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop=149


SELECT DISTINCT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON (a.num = b.num AND a.company = b.company)
WHERE a.stop = (SELECT id FROM stops WHERE name = 'Craiglockhart') 
  AND b.stop = (SELECT id FROM stops WHERE name = 'London Road')
  
-- use DISTINCT as ref. to Question 7
-- 'Haymarket' and 'Leith' - this will show the duplicates
-- 'Craiglockhart' and 'London Road'

-- 6. The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross'
SELECT DISTINCT a.company, a.num, x.name, y.name
FROM route a JOIN route b ON (a.num = b.num AND a.company = b.company) 
             JOIN stops x ON a.stop = x.id
             JOIN stops y ON b.stop = y.id
WHERE x.name = 'Craiglockhart' AND y.name = 'London Road'
-- use DISTINCT as ref. to Question 7
-- 'Haymarket' and 'Leith' - this will show the duplicates

-- 7. Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
SELECT DISTINCT a.company, a.num
FROM route a, route b
WHERE a.num = b.num AND a.company = b.company
 AND a.stop = 115 and b.stop = 137

-- 8. Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
SELECT DISTINCT a.company, a.num
FROM route a, route b
WHERE a.num = b.num AND a.company = b.company
  AND a.stop = (SELECT id FROM stops WHERE name = 'Craiglockhart') 
  AND b.stop = (SELECT id FROM stops WHERE name = 'Tollcross')



-- 9. Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.
SELECT DISTINCT y.name, b.company, b.num
FROM route a, route b, stops x, stops y
WHERE a.num = b.num 
  AND a.company = b.company
  AND a.stop = x.id 
  AND b.stop = y.id
  AND a.company = 'LRT'
  AND x.name = 'Craiglockhart'


-- 10. Find the routes involving two buses that can go from Craiglockhart to Lochend.
-- Show the bus no. and company for the first bus, the name of the stop for the transfer, and the bus no. and company for the second bus.


-- 1. find the num and company for the ones who have 'Craiglockhart' but not 'Lochend'; 
-- 2. find the num and company for the ones who have 'Lochend' but not 'Craiglockhart'; 
-- 3. find the shared stops from the two above-- using the table "stops" as the link; 
-- 4. display as required. 
SELECT DISTINCT ff.num, ff.company, ff.name, tt.num, tt.company
FROM 
    (SELECT a1.num, a1.company, x2.name, a2.stop
     FROM route a1 JOIN route a2 ON a1.num = a2.num AND a1.company= a2.company
                   JOIN stops x1 on a1.stop = x1.id
                   JOIN stops x2 on a2.stop = x2.id
     WHERE x1.name = 'Craiglockhart'
       AND x2.name <> 'Lochend'
    ) AS ff
JOIN
    (SELECT b1.num, b1.company, b1.stop 
     FROM route b1 JOIN route b2 ON b1.num = b2.num AND b1.company= b2.company
                   JOIN stops y1 on b1.stop = y1.id
                   JOIN stops y2 on b2.stop = y2.id
     WHERE y1.name <> 'Craiglockhart'
       AND y2.name = 'Lochend'
    ) AS tt
ON ff.stop = tt.stop




-- quiz for the above
-- 1. Select the code that would show it is possible to get from Craiglockhart to Haymarket

SELECT DISTINCT a.name, b.name
  FROM stops a JOIN route z ON a.id=z.stop
  JOIN route y ON y.num = z.num
  JOIN stops b ON y.stop=b.id
 WHERE a.name='Craiglockhart' AND b.name ='Haymarket'
 
-- 2. Select the code that shows the stops that are on route.num '2A' which can be reached with one bus from Haymarket?
SELECT S2.id, S2.name, R2.company, R2.num
  FROM stops S1, stops S2, route R1, route R2
 WHERE S1.name='Haymarket' AND S1.id=R1.stop
   AND R1.company=R2.company AND R1.num=R2.num
   AND R2.stop=S2.id AND R2.num='2A'

-- 3. Select the code that shows the services available from Tollcross?
SELECT a.company, a.num, stopa.name, stopb.name
  FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
 WHERE stopa.name='Tollcross'
