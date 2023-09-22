#!/bin/bash
# Set the directory containing the files
# Set up as Cronjob, so that old Backups will be deleted At 04:00 at the 1. of every month.
# crontab -e

# delete old backups
# 0 4 1 * * ~/scripts/delete-old-backup/delete-old-backup.sh

directory="directory where the backup are created"
# Find all files in the directory that are older than 1 month
# with the .tar.gz extension and delete them
find $directory -type f -name "*.tar.gz" -mtime +30 -delete

