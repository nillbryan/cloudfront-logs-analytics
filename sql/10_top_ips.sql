SELECT c_ip, COUNT(*) AS hits
FROM cf_logs_curated
GROUP BY c_ip
ORDER BY hits DESC
LIMIT 20;
