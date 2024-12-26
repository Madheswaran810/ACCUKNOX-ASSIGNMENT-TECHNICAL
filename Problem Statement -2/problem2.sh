#!/bin/bash

# Set variables
SOURCE_DIR="/path/to/source/directory"
BACKUP_DIR="/path/to/backup/directory"
REMOTE_SERVER="username@remote_server_ip:/path/to/remote/backup/directory"
LOG_FILE="/var/log/backup.log"

# Function to log messages
log_message() {
    local message=$1
    echo "$(date): $message" | tee -a $LOG_FILE
}

# Create a timestamp for the backup file
TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")

# Create a tarball of the source directory
tar -czf "$BACKUP_DIR/backup-$TIMESTAMP.tar.gz" "$SOURCE_DIR"
if [ $? -eq 0 ]; then
    log_message "Tarball creation successful: backup-$TIMESTAMP.tar.gz"
else
    log_message "Tarball creation failed"
    exit 1
fi

# Copy the tarball to the remote server
scp "$BACKUP_DIR/backup-$TIMESTAMP.tar.gz" "$REMOTE_SERVER"
if [ $? -eq 0 ]; then
    log_message "Copy to remote server successful: $REMOTE_SERVER"
else
    log_message "Copy to remote server failed"
    exit 1
fi

# Remove the local tarball
rm "$BACKUP_DIR/backup-$TIMESTAMP.tar.gz"
if [ $? -eq 0 ]; then
    log_message "Local tarball removal successful"
else
    log_message "Local tarball removal failed"
    exit 1
fi

# Print a success message
log_message "Backup successful!"
