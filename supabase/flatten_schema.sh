#!/bin/bash
# supabase/flatten_schema.sh

SCHEMA_FILE="supabase/schema.sql"
# OUTPUT_FILE="supabase/migrations/$(date +%Y%m%d%H%M%S)_flattened_schema.sql"

OUTPUT_FILE="supabase/migrations/1_flattened_schema.sql"

echo "-- Flattened schema for BuildConnect" > "$OUTPUT_FILE"
echo "-- Generated on $(date)" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

while IFS= read -r line; do
  if [[ $line =~ ^[[:space:]]*["\']([^\"\']+.sql)["\'] ]]; then
    RELATIVE_PATH="${BASH_REMATCH[1]}"
    FULL_PATH="supabase/$RELATIVE_PATH"

    echo "-- Included file: $RELATIVE_PATH" >> "$OUTPUT_FILE"
    if [[ -f "$FULL_PATH" ]]; then
      cat "$FULL_PATH" >> "$OUTPUT_FILE"
    else
      echo "-- WARNING: File not found: $FULL_PATH" >> "$OUTPUT_FILE"
    fi
    echo -e "\n" >> "$OUTPUT_FILE"
  else
    echo "$line" >> "$OUTPUT_FILE"
  fi
done < "$SCHEMA_FILE"

echo "✅ Flattened schema generated: $OUTPUT_FILE"
