#!/bin/bash

INPUT="titik-penting.txt"
OUTPUT="posisipusaka.txt"

lat1=$(awk -F',' 'NR==1 {print $3}' "$INPUT")
lon1=$(awk -F',' 'NR==1 {print $4}' "$INPUT")

lat2=$(awk -F',' 'NR==3 {print $3}' "$INPUT")
lon2=$(awk -F',' 'NR==3 {print $4}' "$INPUT")

lat_pusat=$(awk "BEGIN {printf \"%.6f\", ($lat1 + $lat2) / 2}")
lon_pusat=$(awk "BEGIN {printf \"%.6f\", ($lon1 + $lon2) / 2}")

echo "Koordinat pusat: $lat_pusat, $lon_pusat"
echo "$lat_pusat,$lon_pusat" > "$OUTPUT"

echo "Hasil disimpan ke $OUTPUT"