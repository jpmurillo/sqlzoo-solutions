/* 1. */
SELECT COUNT(*) FROM stops

/* 2. */
SELECT id FROM stops
WHERE name IN ('Craiglockhart')

/* 3. */
SELECT id, name FROM stops
JOIN route
ON stops.id=route.stop
WHERE company='LRT' AND num=4

/* 4. */
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*)=2

/* 5. */
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53
  AND b.stop=(SELECT id FROM stops WHERE name='London Road')

/* 6. */
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='London Road'

/* 7. */
SELECT DISTINCT a.company, a.num FROM route a
JOIN route b ON (a.company=b.company AND a.num=b.num)
WHERE a.stop=115 AND b.stop=137

/* 8. */
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
(a.company=b.company AND a.num=b.num)
WHERE
a.stop=(SELECT id FROM stops WHERE name='Craiglockhart')
AND
b.stop=(SELECT id FROM stops WHERE name='Tollcross')

/* 9. */
SELECT y.name, x.company, x.num FROM
stops y JOIN
(SELECT a.company, a.num, b.stop
FROM route a JOIN route b ON
(a.company=b.company AND a.num=b.num)
WHERE a.stop=53) x
ON x.stop=y.id

/* 10. */
SELECT DISTINCT x.num1, x.company1, y.name, x.num2, x.company2
FROM
(SELECT  first.num as num1, first.company as company1,
first.stop as stop, second.num as num2, second.company as company2
FROM
(SELECT a1.company, a1.num, b1.stop
FROM route a1 JOIN route b1 ON
(a1.company=b1.company AND a1.num=b1.num)
WHERE a1.stop=53) first
JOIN
(SELECT a2.company, a2.num, a2.stop
FROM route a2 JOIN route b2 ON
(a2.company=b2.company AND a2.num=b2.num)
WHERE b2.stop=213) second
ON first.stop=second.stop) x
JOIN stops y ON x.stop=y.id
