CREATE TABLE cf_logs_curated
WITH (
  format = 'PARQUET',
  parquet_compression = 'SNAPPY',
  partitioned_by = ARRAY['year','month','day','hour']
) AS
SELECT
  year, month, day, hour,
  date, time, x_edge_location,
  sc_bytes, c_ip, method, host, uri_stem, uri_query, status, referer, user_agent,
  x_edge_result_type, x_host_header, cs_protocol, client_bytes, time_taken,
  x_forwarded_for, ssl_protocol, ssl_cipher, x_edge_response_result_type,
  cs_protocol_version, fle_status, fle_encrypted_fields, c_port, time_to_first_byte,
  x_edge_detailed_result_type, sc_content_type, sc_content_len, sc_range_start, sc_range_end
FROM cf_logs_view_friendly;
