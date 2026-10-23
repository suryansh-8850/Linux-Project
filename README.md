# Linux Automation Scripts

This repository consists of various Bash scripts for Linux automation. These scripts are created to perform common tasks on Ubuntu Server, such as checking server health, taking backups, monitoring logs, and checking server security. The main purpose of these scripts is to reduce manual work and make Linux server management easier.

##  Bash Automation Scripts

### 1. `health.sh` — Server Health Check

**Purpose -** This script checks the overall health of the Ubuntu server. It checks CPU usage, RAM usage, disk usage, system uptime, running processes, and the status of services such as SSH, Apache, and MySQL. It also checks whether the server has network connectivity.

**Use Case -** This script can be used by a system administrator to check whether the server is working properly or not. It helps to identify problems such as high CPU usage, high RAM usage, low disk space, stopped services, and network connectivity issues.

**Output -**
```
==============================
      SERVER HEALTH CHECK
==============================
Thu Oct 22 23:50:00 IST 2026
Hostname: ubuntu-server
Uptime: up 3 hours, 25 minutes

========== CPU CHECK ==========
CPU Usage: 12.5%

========== RAM CHECK ==========
RAM Usage: 850 MB / 2048 MB (41%)

========== DISK CHECK ==========
Disk Usage: 8.5G / 20G (45%)

========== TOP 5 PROCESSES ==========
    PID COMMAND         %CPU %MEM
   1245 python3          8.5  5.2
    890 nginx            3.2  1.8
    756 mysqld           2.1  8.4
    612 systemd          1.0  0.6
   1450 sshd             0.5  0.3

========== SSH SERVICE ==========
SSH is running

========== APACHE SERVICE ==========
Apache is not running

========== MYSQL SERVICE ==========
MySQL is running

========== NETWORK CHECK ==========
Network is connected

==============================
    HEALTH CHECK COMPLETE
==============================
```
### 2. `deploy.sh` — Application Deployment

**Purpose -** This script is used to deploy a website on Ubuntu Server. It asks the user to enter the location of the website ZIP file. If a website is already deployed, the script automatically creates a ZIP backup of the previous website with the current date and time and stores it in a separate backup folder. After taking the backup, it removes the previous website files, extracts the new website, sets the required permissions, configures Nginx and PHP, and checks whether the website is working using `curl`.

**Use Case -** This script can be used by a system administrator to deploy new websites or update an existing website without manually performing every step. It also helps to keep backups of previously deployed websites so that the old website files can be recovered if required.

**Output -**

```text
========== CHECKING PREVIOUS WEBSITE ==========
Previous website found
Creating backup...
PASS: Backup created successfully
Backup location: /var/www/backup/website_2026-10-22_18-30-00.zip
Removing previous website...

========== EXTRACTING NEW WEBSITE ==========

========== SETTING PERMISSIONS ==========

========== CONFIGURING NGINX ==========

========== STARTING SERVICES ==========

========== WEBSITE CHECK ==========
HTTP Status: 200
PASS: Website is working successfully

================================
       DEPLOYMENT COMPLETED
================================
```

### 3. `backup.sh` — Automated Backup

**Purpose -** This script is used to take backups of important files and folders from the Ubuntu server. It asks the user to enter the path of the file or folder that needs to be backed up. It then creates a compressed backup file with the current date and time and stores it in a separate backup folder.

**Use Case -** This script can be used when a system administrator wants to take a backup of important files, website files, application files, or configuration files. It helps to keep a copy of important data so that it can be recovered if the original data is accidentally deleted or lost.

**Output -**
```
================================
        AUTOMATED BACKUP
================================
Date: Thu Oct 22 23:45:00 IST 2026

Enter folder or file path to backup: /home/surya/Documents/website

========== BACKUP STARTED ==========
Backup completed successfully
Backup File: /home/surya/backup/website_2026-10-22_23-45-00.tar.gz
Backup Size: 2.4M

================================
        BACKUP COMPLETED
================================
```
### 4. `log_monitor.sh` — Log Monitoring

**Purpose -** This script checks the Ubuntu server logs to identify important errors and suspicious activities. It checks failed SSH login attempts, authentication failures, system errors, and Apache server errors. It also displays a warning message if multiple failed login attempts or system errors are detected.

**Use Case -** This script can be used by a system administrator to monitor server logs and identify problems such as repeated failed login attempts, authentication failures, and service errors. It helps the administrator to find problems and take necessary action.

**Output -**
```text
================================
         LOG MONITORING
================================
Date: Thu Oct 22 23:55:00 IST 2026

========== FAILED SSH LOGINS ==========
Failed SSH Attempts: 7
WARNING: Multiple failed SSH attempts

========== AUTHENTICATION FAILURES ==========
Authentication Failures: 2
Authentication is normal

========== SYSTEM ERRORS ==========
System Errors: 3
WARNING: System errors detected

========== APACHE ERRORS ==========
Apache log not found

================================
       LOG CHECK COMPLETE
================================
```
### 5. `security_audit.sh` — Server Security Audit

**Purpose -** This script performs a basic security check of the Ubuntu server. It checks whether the firewall is active, which ports are open, which users exist on the system, who is currently logged in, and which services are running. It also checks SSH security settings, file permissions, SUID files, and failed SSH login attempts. The results are displayed with PASS, WARNING, or FAIL messages and saved in a report file.

**Use Case -** This script can be used by a system administrator to check the basic security configuration of the Ubuntu server. It helps to identify security issues such as an inactive firewall, unnecessary open ports, insecure SSH settings, and multiple failed login attempts.

**Output -**
```text
================================
       SERVER SECURITY AUDIT
================================
Date: Thu Oct 22 23:58:00 IST 2026

========== FIREWALL ==========
PASS: Firewall is active

========== OPEN PORTS ==========
Netid State  Recv-Q Send-Q Local Address:Port Peer Address:Port
udp   UNCONN 0      0      127.0.0.53:53     0.0.0.0:*
tcp   LISTEN 0      128    0.0.0.0:22        0.0.0.0:*
tcp   LISTEN 0      511    0.0.0.0:80        0.0.0.0:*
tcp   LISTEN 0      128    127.0.0.1:3306    0.0.0.0:*

========== SYSTEM USERS ==========
root
daemon
bin
sys
sync
games
man
lp
mail
news
www-data
nobody
systemd-network
systemd-resolve
sshd
mysql
surya

========== LOGGED IN USERS ==========
surya    pts/0    2026-10-22 22:30 ( ip )

========== RUNNING SERVICES ==========
ssh.service          loaded active running OpenBSD Secure Shell server
nginx.service        loaded active running A high performance web server
mysql.service        loaded active running MySQL Community Server
cron.service         loaded active running Regular background program processing daemon
systemd-journald.service loaded active running Journal Service

========== SSH SECURITY ==========
PASS: Root login disabled

========== FILE PERMISSIONS ==========
-rw-r--r-- 1 root root   1850 Oct 20 10:30 /etc/passwd
-rw-r----- 1 root shadow 1050 Oct 20 10:30 /etc/shadow

========== SUID FILES ==========
/usr/bin/passwd
/usr/bin/sudo
/usr/bin/su
/usr/bin/mount
/usr/bin/umount
/usr/bin/chsh
/usr/bin/chfn

========== FAILED SSH LOGINS ==========
Failed Attempts: 2
PASS: No excessive failed logins detected

================================
       AUDIT COMPLETED
================================
Report saved: security_audit_report.txt

## Repository Structure
```

Linux-Projects/
│
├── README.md
│
└── Linux-Automation-Scripts/
    ├── health.sh
    ├── backup.sh
    ├── log_monitor.sh
    ├── security_audit.sh
    └── deploy.sh

## Requirements

- Ubuntu Server
- Bash shell
- Basic Linux commands
- Administrator permissions for certain scripts

## How to Run the Scripts

First, open the Linux Automation Scripts folder in the terminal.

Give execution permission to the scripts.

```bash
chmod +x *.sh
```

Run the required script.

```bash
./health.sh
sudo ./deploy.sh
./backup.sh
sudo ./log_monitor.sh
sudo ./security_audit.sh
```

## Note

These scripts are created for learning and practising Bash scripting and Linux automation. The scripts can be modified and improved according to the requirements of the server.
