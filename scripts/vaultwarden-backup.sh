#!/bin/bash
# Vaultwarden daily backup to Google Drive via rclone
# Cron: 0 2 * * * /home/kelvin/vaultwarden-backup.sh

set -e

SOURCE="/home/kelvin/docker/vaultwarden/data"
DEST_LATEST="gdrive:vaultwarden-backup/latest"
DEST_ARCHIVE="gdrive:vaultwarden-backup/archive/$(date +%Y-%m-%d)"

echo "[$(date)] Starting Vaultwarden backup..."
rclone sync "$SOURCE" "$DEST_LATEST"
rclone copy "$SOURCE" "$DEST_ARCHIVE"
echo "[$(date)] Backup complete."
