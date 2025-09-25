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
# CloudFront Logs Analytics com S3 + Athena

## O que é
Pipeline para analisar logs do CloudFront usando Amazon S3 e Amazon Athena.
Converto os logs brutos em uma **tabela curated em Parquet particionado (ano/mês/dia/hora)** para reduzir custo e tempo de consulta.

## Arquitetura
S3 (AWSLogs/CloudFront) → Athena (tabela raw) → Views → CTAS Parquet (curated)  
![architecture](docs/architecture.png)

## Por que essas decisões
- **Parquet + Partições**: leitura colunar e pruning → consultas mais baratas/rápidas.
- **Lifecycle Rules**:
  - `AWSLogs/...`: Glacier IR aos 90 dias + expirar em 365d (reduz custo de retenção).
  - `athena-results/`: expirar em 14d (evita “lixo” caro).
- **Workgroup Athena**: saída centralizada e limites de custo por consulta (governança).
- **Saved Queries**: operabilidade (Top URIs, 4xx/5xx por hora, etc).

## Como reproduzir
1. Ative o **Standard Logging** no CloudFront → Bucket S3 (privado).
2. Athena:
   - Execute `sql/00_ddl_cf_logs_raw.sql`
   - `sql/01_view_cf_logs_view.sql`
   - `sql/02_view_cf_logs_view_friendly.sql`
   - `sql/03_ctas_cf_logs_curated_parquet.sql`
3. Salve as consultas em `sql/10..14_*.sql` (as mesmas que uso no README).
4. (Opcional) agende `MSCK REPAIR TABLE cf_logs_raw` ou habilite **Partition Projection**.
5. Crie regras de **Lifecycle** conforme `docs/*`.

## Consultas úteis (exemplos)
- Erros 4xx/5xx por hora  
- Top URIs e Top IPs  
- Tráfego por hora  
(Código em `sql/10..14_*.sql`)

## Custos & limites
- Parquet/partições minimizam bytes lidos (Athena cobra por TB lido).
- Glacier IR aos 90d: retenção barata + recuperação rápida quando preciso.

## Segurança
- Bucket privado, **S3 Block Public Access** ON.
- IAM mínimo: Athena read/query + S3 read/list nos prefixos de logs e `athena-results/`.

## Limpeza
- Excluir tabelas e views no Athena.
- Remover objetos S3 (logs e results) se for ambiente de teste.
- Opcional: excluir o Workgroup criado.

## Próximos passos
- **Partition Projection** na `cf_logs_raw` (evita MSCK).
- Painel no **QuickSight** (erros/dia, top URIs, picos).
