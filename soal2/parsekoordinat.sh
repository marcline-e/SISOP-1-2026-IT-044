#!/bin/bash

INPUT="gsxtrack.json"
OUTPUT="titik-penting.txt"

> "$OUTPUT"

ids=$(grep -o '"id": *"node_[0-9]*"' "$INPUT" | sed 's/"id": *"\(.*\)"/\1/')
site_names=$(grep -o '"site_name": *"[^"]*"' "$INPUT" | sed 's/"site_name": *"\(.*\)"/\1/')
latitudes=$(grep -o '"latitude": *-\?[0-9.]*' "$INPUT" | sed 's/"latitude": *\(.*\)/\1/')
longitudes=$(grep -o '"longitude": *-\?[0-9.]*' "$INPUT" | sed 's/"longitude": *\(.*\)/\1/')

IFS=$'\n' read -r -d '' -a arr_ids <<< "$ids"
IFS=$'\n' read -r -d '' -a arr_names <<< "$site_names"
IFS=$'\n' read -r -d '' -a arr_lats <<< "$latitudes"
IFS=$'\n' read -r -d '' -a arr_lons <<< "$longitudes"

total=${#arr_ids[@]}
for ((i=0; i<total; i++)); do
    echo "${arr_ids[$i]},${arr_names[$i]},${arr_lats[$i]},${arr_lons[$i]}" >> "$OUTPUT"
done

echo "Parsing selesai, hasil disimpan ke $OUTPUT"