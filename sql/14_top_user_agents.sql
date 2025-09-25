SELECT user_agent, COUNT(*) AS hits
FROM cf_logs_curated
GROUP BY user_agent
ORDER BY hits DESC
LIMIT 20;
