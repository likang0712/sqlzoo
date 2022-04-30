--------------------------------------------------------
--------------------------------------------------------
-- 2 SELECT from WORLD
-- https://sqlzoo.net/wiki/SELECT_from_WORLD_Tutorial

-- 1.
-- Observe the result of running this SQL command to show the name, continent and population of all countries.
SELECT name, continent, population 
FROM world

-- 2.
-- Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros.
SELECT name 
FROM world
WHERE population >200000000

-- 3.
-- Give the name and the per capita GDP for those countries with a population of at least 200 million.
SELECT name, gdp/population AS 'per capita GDP' 
FROM world
WHERE population >200000000

-- 4. 
-- Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions.
SELECT name, population/1000000 
FROM world
WHERE continent = 'South America'

-- 5. 
-- Show the name and population for France, Germany, Italy
-- Show the name and population for France, Germany, Italy
SELECT name, population 
FROM world
WHERE name IN ('France','Germany','Italy')

-- 6. 
-- Show the countries which have a name that includes the word 'United'
-- Show the countries which have a name that includes the word 'United'
SELECT name 
FROM world
WHERE name LIKE 'United%'

-- 7. 
-- Two ways to be big: A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million.
-- Show the countries that are big by area or big by population. Show name, population and area.
SELECT name, population ,area
FROM world
WHERE population > 250000000 OR area > 3000000

-- 8. 
-- Exclusive OR (XOR). Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both. Show name, population and area.
SELECT name, population ,area
FROM world
WHERE (population > 250000000 AND area <= 3000000) 
   OR (population <= 250000000 and area > 3000000)

-- 9. 
-- For South America show population in millions and GDP in billions both to 2 decimal places
SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2)
FROM world
WHERE continent = 'South America'

-- 10. 
-- Show per-capita GDP for the trillion dollar countries to the nearest $1000.
SELECT name, ROUND(gdp/population, -3)
FROM world
WHERE gdp >= 1000000000000

-- 11. 
-- Show the name and capital where the name and the capital have the same number of characters.
SELECT name, capital
FROM world
WHERE LEN(name) = LEN(capital)
