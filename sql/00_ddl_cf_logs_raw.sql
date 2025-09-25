CREATE EXTERNAL TABLE IF NOT EXISTS cf_logs_raw (
  date                              string,
  time                              string,
  x_edge_location                   string,
  sc_bytes                          bigint,
  c_ip                              string,
  cs_method                         string,
  cs_host                           string,
  cs_uri_stem                       string,
  sc_status                         int,
  cs_referer                        string,
  cs_user_agent                     string,
  cs_uri_query                      string,
  cs_cookie                         string,
  x_edge_result_type                string,
  x_edge_request_id                 string,
  x_host_header                     string,
  cs_protocol                       string,
  cs_bytes                          bigint,
  time_taken                        double,
  x_forwarded_for                   string,
  ssl_protocol                      string,
  ssl_cipher                        string,
  x_edge_response_result_type       string,
  cs_protocol_version               string,
  fle_status                        string,
  fle_encrypted_fields              string,
  c_port                            int,
  time_to_first_byte                double,
  x_edge_detailed_result_type       string,
  sc_content_type                   string,
  sc_content_len                    bigint,
  sc_range_start                    bigint,
  sc_range_end                      bigint
)
PARTITIONED BY (year string, month string, day string, hour string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
  'field.delim'='\t',
  'serialization.format'='\t'
)
LOCATION 's3://SEU-BUCKET/AWSLogs/';  -- ajuste aqui
