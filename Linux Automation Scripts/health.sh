
#!/bin/bash

echo "=============================="
echo "      SERVER HEALTH CHECK"
echo "=============================="
date
echo "Hostname: $(hostname)"
echo "Uptime: $(uptime -p)"
echo

echo "========== CPU CHECK =========="

CPU_USED=$(top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8}')
echo "CPU Usage: ${CPU_USED}%"

echo
echo "========== RAM CHECK =========="

RAM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
RAM_USED=$(free -m | awk '/Mem:/ {print $3}')
RAM_PERCENT=$((RAM_USED * 100 / RAM_TOTAL))

echo "RAM Usage: $RAM_USED MB / $RAM_TOTAL MB ($RAM_PERCENT%)"

echo
echo "========== DISK CHECK =========="

DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
DISK_PERCENT=$(df -h / | awk 'NR==2 {print $5}')

echo "Disk Usage: $DISK_USED / $DISK_TOTAL ($DISK_PERCENT)"

echo
echo "========== TOP 5 PROCESSES =========="

ps -eo pid,comm,pcpu,pmem --sort=-pcpu | head -n 6

echo
echo "========== SSH SERVICE =========="

if systemctl is-active --quiet ssh; then
    echo "SSH is running"
else
    echo "SSH is not running"
fi

echo
echo "========== APACHE SERVICE =========="

if systemctl is-active --quiet apache2; then
    echo "Apache is running"
else
    echo "Apache is not running"
fi

echo
echo "========== MYSQL SERVICE =========="

if systemctl is-active --quiet mysql; then
    echo "MySQL is running"
else
    echo "MySQL is not running"
fi

echo
echo "========== NETWORK CHECK =========="

if ping -c 1 -W 2 8.8.8.8 > /dev/null 2>&1; then
    echo "Network is connected"
else
    echo "Network connection failed"
fi

echo
echo "=============================="
echo "    HEALTH CHECK COMPLETE"
echo "=============================="
