-- ФОРТОВ ЕГОР, БПИ214
-- Для Олимпийских игр 2004 года сгенерируйте список (год рождения, количество игроков,
-- количество золотых медалей), содержащий годы, в которые родились игроки,
-- количество игроков, родившихся в каждый из этих лет, которые выиграли по крайней мере
-- одну золотую медаль, и количество золотых медалей, завоеванных игроками,
-- родившимися в этом году.
SELECT EXTRACT(year FROM p.birthdate) AS birth_year,
       COUNT(DISTINCT p.player_id) AS num_players,
       COUNT(DISTINCT CASE WHEN r.medal = 'GOLD' THEN p.player_id END) AS num_gold_medals
FROM Players p
JOIN Results r ON p.player_id = r.player_id
JOIN Events e ON r.event_id = e.event_id
JOIN Olympics o ON e.olympic_id = o.olympic_id
WHERE EXTRACT(year FROM o.startdate) = 2004 AND
      r.medal = 'GOLD'
GROUP BY birth_year;


-- Перечислите все индивидуальные (не групповые) соревнования, в которых была ничья в счете,
-- и два или более игрока выиграли золотую медаль.
SELECT e.name
FROM Events e
JOIN Results r on e.event_id = r.event_id
WHERE is_team_event = 0 AND
      r.medal = 'GOLD'
GROUP BY e.name
HAVING COUNT(DISTINCT r.player_id) >= 2 AND
       COUNT(DISTINCT r.medal) = 1;


-- Найдите всех игроков, которые выиграли хотя бы одну медаль (GOLD, SILVER и
-- BRONZE) на одной Олимпиаде. (player-name, olympics-id).
SELECT DISTINCT Players.name, Results.event_id
FROM Players
JOIN Results ON Players.player_id = Results.player_id
WHERE Results.medal IN ('GOLD', 'SILVER', 'BRONZE');


--  В какой стране был наибольший процент игроков (из перечисленных в наборе данных),
--  чьи имена начинались с гласной?
SELECT c.name
FROM Countries c
JOIN Players p ON c.country_id = p.country_id
WHERE p.name ILIKE 'A%' OR
      p.name ILIKE 'E%' OR
      p.name ILIKE 'I%' OR
      p.name ILIKE 'O%' OR
      p.name ILIKE 'U%'
GROUP BY c.name
ORDER BY COUNT(DISTINCT p.player_id) / CAST(COUNT(*) AS float) DESC
LIMIT 1;


-- Для Олимпийских игр 2000 года найдите 5 стран с минимальным соотношением количества
-- групповых медалей к численности населения.
SELECT c.name, COUNT(DISTINCT e.event_id) / c.population AS medals_per_capita
FROM Countries c
JOIN Players p ON c.country_id = p.country_id
JOIN Results r ON p.player_id = r.player_id
JOIN Events e ON r.event_id = e.event_id
JOIN Olympics o ON e.olympic_id = o.olympic_id
WHERE EXTRACT(year FROM o.startdate) = 2000 AND
      e.is_team_event = 1
GROUP BY c.name, c.population
ORDER BY medals_per_capita
LIMIT 5;
