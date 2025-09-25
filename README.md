# cloudfront-logs-analytics
cloudfront-logs-analytics/
├─ README.md
├─ sql/
│  ├─ 00_ddl_cf_logs_raw.sql
│  ├─ 01_view_cf_logs_view.sql
│  ├─ 02_view_cf_logs_view_friendly.sql
│  ├─ 03_ctas_cf_logs_curated_parquet.sql
│  ├─ 10_top_ips.sql
│  ├─ 11_top_uris.sql
│  ├─ 12_errors_4xx_5xx_hour.sql
│  ├─ 13_traffic_by_hour.sql
│  └─ 14_top_user_agents.sql
├─ docs/
│  ├─ architecture.png
│  ├─ lifecycle-cf-logs.png
│  ├─ lifecycle-athena-results.png
│  └─ athena-saved-queries.png
└─ scripts/
   └─ create-workgroup-cli.sh
