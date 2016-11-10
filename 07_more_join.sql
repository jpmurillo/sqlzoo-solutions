/* 1. List the films where the yr is 1962 [Show id, title] */
SELECT id, title
FROM movie
WHERE yr=1962

 /* 2. Give year of 'Citizen Kane'. */
SELECT yr FROM movie
WHERE title='Citizen Kane'

/* 3. List all of the Star Trek movies, include the id, title and yr
(all of these movies include the words Star Trek in the title). Order results by year. */
SELECT id, title, yr FROM movie
WHERE title LIKE '%Star Trek%'

/* 4. What are the titles of the films with id 11768, 11955, 21191 */
SELECT title FROM movie
WHERE id IN (11768, 11955, 21191)

/* 5. What id number does the actress 'Glenn Close' have? */
SELECT id FROM actor
WHERE name='Glenn Close'

/* 6. What is the id of the film 'Casablanca'*/
SELECT id FROM movie
WHERE title='Casablanca'

/* 7. Obtain the cast list for 'Casablanca'. */
SELECT name FROM actor
  INNER JOIN casting ON actorid=id
WHERE movieid=11768

/* 8. Obtain the cast list for the film 'Alien' */
SELECT name FROM movie
  INNER JOIN casting ON movie.id=movieid
  INNER JOIN actor ON actorid=actor.id
WHERE title='Alien'

/* 9. List the films in which 'Harrison Ford' has appeared */
SELECT title FROM actor
  INNER JOIN casting ON actorid=actor.id
  INNER JOIN movie ON movieid=movie.id
WHERE name='Harrison Ford'

/* 10. List the films where 'Harrison Ford' has appeared - but not in the starring role.  */
SELECT title FROM actor
  INNER JOIN casting ON actorid=actor.id
  INNER JOIN movie ON movieid=movie.id
WHERE name='Harrison Ford' AND ord>1

/* 11. List the films together with the leading star for all 1962 films. */
SELECT DISTINCT title, name FROM actor
  INNER JOIN casting ON actorid=actor.id
  INNER JOIN movie ON movieid=movie.id
WHERE yr=1962 AND ord=1

/* 12. Which were the busiest years for 'John Travolta', show the year and the number of movies
he made each year for any year in which he made more than 2 movies.*/
SELECT yr,COUNT(title) FROM
  movie INNER JOIN casting ON movie.id=movieid
        INNER JOIN actor   ON actorid=actor.id
WHERE name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
   movie INNER JOIN casting ON movie.id=movieid
         INNER JOIN actor   ON actorid=actor.id
 WHERE name='John Travolta'
 GROUP BY yr) AS t
)

/* 13. List the film title and the leading actor for all of the films 'Julie Andrews' played in. */
SELECT DISTINCT title, name FROM movie
  INNER JOIN casting ON movieid=movie.id
  INNER JOIN actor ON actorid=actor.id
WHERE ORD=1 AND movieid IN
(SELECT movieid FROM actor
  INNER JOIN casting ON actorid=actor.id
WHERE name='Julie Andrews')

/* 14. Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.*/
SELECT name FROM movie
  INNER JOIN casting ON movieid=movie.id
  INNER JOIN actor ON actorid=actor.id
WHERE ord=1
GROUP BY name
HAVING COUNT(actorid)>=30
ORDER BY name ASC

/* 15. List the films released in the year 1978 ordered by the number of actors in the cast, then by title. */
SELECT title, COUNT(movieid) FROM movie
  INNER JOIN casting ON movieid=movie.id
  INNER JOIN actor ON actorid=actor.id
WHERE yr=1978
GROUP BY title
ORDER BY COUNT(movieid) DESC, title ASC
