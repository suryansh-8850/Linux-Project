echo "================================"
echo "        AUTOMATED BACKUP"
echo "================================"

echo "Date: $(date)"
echo

read -p "Enter folder or file path to backup: " source

if [[ ! -e "$source" ]]; then
    echo "Error: File or folder does not exist"
    exit 1
fi

backup_dir="$HOME/backup"
mkdir -p "$backup_dir"

date_time=$(date +"%Y-%m-%d_%H-%M-%S")
folder_name=$(basename "$source")

backup_file="$backup_dir/${folder_name}_${date_time}.tar.gz"

echo
echo "========== BACKUP STARTED =========="

tar -czf "$backup_file" -C "$(dirname "$source")" "$folder_name"

if [[ $? -eq 0 ]]; then
    echo "Backup completed successfully"
    echo "Backup File: $backup_file"
    echo "Backup Size: $(du -h "$backup_file" | awk '{print $1}')"
else
    echo "Backup failed"
    rm -f "$backup_file"
    exit 1
fi

echo
echo "================================"
echo "        BACKUP COMPLETED"
echo "================================"
