# CloudFront Logs Analytics com S3 + Athena

Pipeline para analisar logs do CloudFront usando Amazon S3 e Amazon Athena.
Converto os logs brutos em uma **tabela curated em Parquet particionado (ano/mês/dia/hora)** para reduzir custo e tempo de consulta.

---

## Arquitetura (Mermaid)
### Pipeline (tabelas e views no Athena)

```mermaid
flowchart TB
  %% Buckets + lifecycles (auto-loops pontilhados só ilustrativos)
  B["S3: AWSLogs/CloudFront"] -.-> B;
  G["S3: athena-results/"] -.-> G;

  %% Tabelas/views
  B --> R["Athena: cf_logs_raw"];
  R --> V1["View: cf_logs_view"];
  V1 --> V2["View: cf_logs_view_friendly"];
  V2 --> C["CTAS: cf_logs_curated (Parquet + partitions)"];
```

```text
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
├─ scripts/
│  └─ create-workgroup-cli.sh  (opcional)
└─ docs/                       (opcional se usar imagens)
   ├─ architecture.png
   ├─ lifecycle-cf-logs.png
   ├─ lifecycle-athena-results.png
   └─ athena-saved-queries.png
```
