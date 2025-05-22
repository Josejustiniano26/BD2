#1
SELECT id, title
 FROM movie
 WHERE yr=1962
#2
SELECT yr
FROM movie 
WHERE title='Citizen Kane'
#3
select id,title,yr
from movie
where title like 'Star Trek%'
order by yr
#4
select id 
from actor
where name='Glenn Close'
#5
Select id 
from movie 
where title='Casablanca'
#6
Select a.name
from casting c left join actor a on c.actorid = a.id
where movieid=11768 
#7
Select name
from casting c left join actor a on c.actorid=a.id
where movieid=10522
#8
Select title
from casting c left join movie m on c.movieid= m.id
where actorid=(select id from actor where name='Harrison Ford')
#9
SELECT title
FROM movie m
JOIN casting c ON m.id = c.movieid
JOIN actor a ON c.actorid = a.id
WHERE a.name = 'Harrison Ford' AND c.ord != 1;
#10
SELECT m.title, a.name 
FROM movie m
JOIN casting c ON m.id = c.movieid
JOIN actor a ON c.actorid = a.id
WHERE m.yr = 1962 AND c.ord = 1;

--#11
SELECT yr,COUNT(title) 
FROM movie 
JOIN casting ON movie.id=movieid
JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;

--#12
SELECT m.title, a.name 
FROM movie m
JOIN casting c ON m.id = c.movieid AND c.ord = 1
JOIN actor a ON c.actorid = a.id
WHERE m.id IN (
  SELECT movieid
  FROM casting
  WHERE actorid = (
    SELECT id FROM actor WHERE name = 'Julie Andrews'));

