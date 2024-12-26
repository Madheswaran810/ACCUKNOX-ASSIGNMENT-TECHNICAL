#!/bin/bash

# Thresholds
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80
PROCESS_THRESHOLD=200

# Get current usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
DISK_USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//g')
PROCESS_COUNT=$(ps aux | wc -l)

# Log file
LOG_FILE="/var/log/system_health.log"

# Function to log message
log_message() {
    local message=$1
    echo "$(date): $message" | tee -a $LOG_FILE
}

# Check CPU usage
if (( ${CPU_USAGE%.*} > CPU_THRESHOLD )); then
    log_message "CPU usage is above threshold: ${CPU_USAGE}%"
fi

# Check memory usage
if (( ${MEMORY_USAGE%.*} > MEMORY_THRESHOLD )); then
    log_message "Memory usage is above threshold: ${MEMORY_USAGE}%"
fi

# Check disk usage
if (( DISK_USAGE > DISK_THRESHOLD )); then
    log_message "Disk usage is above threshold: ${DISK_USAGE}%"
fi

# Check process count
if (( PROCESS_COUNT > PROCESS_THRESHOLD )); then
    log_message "Process count is above threshold: ${PROCESS_COUNT}"
fi

# Summarize system health
log_message "System Health Summary: CPU: ${CPU_USAGE}%, Memory: ${MEMORY_USAGE}%, Disk: ${DISK_USAGE}%, Processes: ${PROCESS_COUNT}"
