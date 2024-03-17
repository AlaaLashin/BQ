PROJECT_ID='valeo-cp0512-acp3'
DATASET_ID='Config'
TABLE_ID='configurations1'

bq ls --transfer_config --transfer_location=eu --format=prettyjson "$PROJECT_ID" | \
jq -c '.[] | select(.dataSourceId == "scheduled_query") | {schedule, displayName, destinationDatasetId, name, "params": { "destination_table_name_template": .params.destination_table_name_template, "write_disposition": .params.write_disposition }}' | \
jq -c '. | "INSERT INTO `${DATASET_ID}.${TABLE_ID}` JSON '"'"'[\(.)]'"'"' " | \
bq query --use_legacy_sql=false
  
