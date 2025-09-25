SELECT
  year, month, day, hour,
  COUNT(*) AS hits
FROM cf_logs_curated
GROUP BY year, month, day, hour
ORDER BY year, month, day, hour
LIMIT 200;
