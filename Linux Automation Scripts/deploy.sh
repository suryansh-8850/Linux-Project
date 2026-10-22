echo "================================"
echo "       APPLICATION DEPLOYMENT"
echo "================================"
echo "Date: $(date)"
echo

read -p "Enter website ZIP file path: " source

if [[ ! -f "$source" ]]; then
    echo "FAIL: ZIP file not found"
    exit 1
fi

echo
echo "========== INSTALLING PACKAGES =========="

sudo apt update
sudo apt install nginx php-fpm unzip zip curl -y

if [[ $? -ne 0 ]]; then
    echo "FAIL: Package installation failed"
    exit 1
fi

echo
echo "========== CHECKING PREVIOUS WEBSITE =========="

app_dir="/var/www/myapp"
backup_dir="/var/www/backup"

sudo mkdir -p "$app_dir"
sudo mkdir -p "$backup_dir"

if [[ -n "$(sudo ls -A "$app_dir")" ]]; then

    echo "Previous website found"
    echo "Creating backup..."

    backup_name="website_$(date +%Y-%m-%d_%H-%M-%S).zip"

    cd "$app_dir" || exit 1

    sudo zip -qr "$backup_dir/$backup_name" .

    if [[ $? -ne 0 ]]; then
        echo "FAIL: Backup failed"
        exit 1
    fi

    echo "PASS: Backup created successfully"
    echo "Backup location: $backup_dir/$backup_name"

    echo "Removing previous website..."

    sudo find "$app_dir" -mindepth 1 -maxdepth 1 -exec rm -rf -- {} +

    if [[ $? -ne 0 ]]; then
        echo "FAIL: Could not remove previous website"
        exit 1
    fi

else
    echo "No previous website found"
fi

echo
echo "========== EXTRACTING NEW WEBSITE =========="

sudo unzip -o "$source" -d "$app_dir"

if [[ $? -ne 0 ]]; then
    echo "FAIL: Website extraction failed"
    exit 1
fi

echo
echo "========== SETTING PERMISSIONS =========="

sudo chown -R www-data:www-data "$app_dir"
sudo find "$app_dir" -type d -exec chmod 755 {} \;
sudo find "$app_dir" -type f -exec chmod 644 {} \;

echo
echo "========== CONFIGURING NGINX =========="

php_socket=$(find /run/php -name "php*-fpm.sock" | head -n 1)

if [[ -z "$php_socket" ]]; then
    echo "FAIL: PHP-FPM socket not found"
    exit 1
fi

sudo tee /etc/nginx/sites-available/myapp > /dev/null <<EOF
server {
    listen 80;
    server_name localhost;

    root /var/www/myapp;
    index index.php index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:$php_socket;
    }

    location ~ /\. {
        deny all;
    }
}
EOF

sudo ln -sfn /etc/nginx/sites-available/myapp /etc/nginx/sites-enabled/myapp
sudo rm -f /etc/nginx/sites-enabled/default

echo
echo "========== STARTING SERVICES =========="

sudo nginx -t

if [[ $? -ne 0 ]]; then
    echo "FAIL: Nginx configuration error"
    exit 1
fi

sudo systemctl enable --now nginx
sudo systemctl reload nginx

echo
echo "========== WEBSITE CHECK =========="

status=$(curl -s -o /dev/null -w "%{http_code}" http://localhost)

echo "HTTP Status: $status"

if [[ "$status" == "200" ]]; then
    echo "PASS: Website is working successfully"
else
    echo "FAIL: Website is not responding correctly"
    exit 1
fi

echo
echo "================================"
echo "       DEPLOYMENT COMPLETED"
echo "================================"
