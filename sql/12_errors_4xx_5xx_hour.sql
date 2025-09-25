SELECT
  year, month, day, hour,
  SUM(CASE WHEN status BETWEEN 400 AND 499 THEN 1 ELSE 0 END) AS http4xx,
  SUM(CASE WHEN status BETWEEN 500 AND 599 THEN 1 ELSE 0 END) AS http5xx
FROM cf_logs_curated
GROUP BY year, month, day, hour
ORDER BY year, month, day, hour
LIMIT 200;
