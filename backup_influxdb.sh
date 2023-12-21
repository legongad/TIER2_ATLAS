#!/bin/bash

# Path to the InfluxDB backup utility
INFLUXDUMP=/usr/bin/influxd

# Path to the directory where backups are stored
BACKUP_DIR=/DB-backup

# Name of the influxDB database to be copied  
DATABASE=telegraf

# Check for the existence of the directory for backups
if [ ! -d "${BACKUP_DIR}" ]; then
    echo "Error: Backup directory does not exist."
    exit 1
fi

# Getting the current date and time
DATE=$(date '+%Y%m%d_%H%M%S')
if [ $? -ne 0 ]; then
    echo "Error: Unable to obtain the current date and time."
    exit 1
fi

# Generating a unique filename for the backup
BACKUP_FILE="${BACKUP_DIR}/backup_${DATE}.tar.gz"

# Checking the completion of the backup process
if ! influxd backup -portable -database ${DATABASE} -host localhost:8088 ${BACKUP_DIR}; then
    echo "Error during backup execution."
    exit 1
fi

echo "Backup completed successfully."



