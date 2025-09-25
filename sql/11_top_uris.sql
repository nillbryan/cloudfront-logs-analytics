SELECT uri_stem, COUNT(*) AS hits
FROM cf_logs_curated
WHERE status BETWEEN 200 AND 399
GROUP BY uri_stem
ORDER BY hits DESC
LIMIT 20;
