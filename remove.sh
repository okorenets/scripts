#REMOVE BACKUPS OLDER THEN 30 DAYS
find ~/backups/ -type d -mtime +10 -exec rm -rf {} \; # remove directories
find ~/backups/ -type f -name "*.txt" -mtime +10 -delete # remove log files