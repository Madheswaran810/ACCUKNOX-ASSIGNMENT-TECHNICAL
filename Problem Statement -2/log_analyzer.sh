#!/bin/bash

# Set variables
LOG_FILE="/path/to/log/file"
REPORT_FILE="/path/to/report/file"

# Analyze the log file
echo "Log File Analysis Report" > "$REPORT_FILE"
echo "-------------------------" >> "$REPORT_FILE"

# Count the number of 404 errors
NUM_404=$(grep " 404 " "$LOG_FILE" | wc -l)
echo "404 Errors: $NUM_404" >> "$REPORT_FILE"

# Find the most requested pages
MOST_REQUESTED=$(awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -n 10)
echo "Most Requested Pages:" >> "$REPORT_FILE"
echo "$MOST_REQUESTED" >> "$REPORT_FILE"

# Find the IP addresses with the most requests
MOST_REQUESTING_IPS=$(awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -n 10)
echo "IP Addresses with Most Requests:" >> "$REPORT_FILE"
echo "$MOST_REQUESTING_IPS" >> "$REPORT_FILE"

# Print a success message
echo "Log file analysis complete!"