
PROJECT_ID='valeo-cp0512-acp3'
DATASET_ID='Config'
TABLE_ID='configurations1'
bq ls --transfer_config --transfer_location=eu --format=prettyjson "$PROJECT_ID" | jq -c '.[] | select(.dataSourceId == "scheduled_query") | {schedule, displayName, destinationDatasetId, name, "params": { "destination_table_name_template": .params.destination_table_name_template, "write_disposition": .params.write_disposition }}' > transfer_configs_filtered_1.json
bq load --autodetect --source_format=NEWLINE_DELIMITED_JSON "${DATASET_ID}.${TABLE_ID}" transfer_configs_filtered_1.json
