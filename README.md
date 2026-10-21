# Linux Automation Scripts

This repository consists of various Bash scripts for Linux automation. These scripts are created to perform common tasks on Ubuntu Server, such as checking server health, taking backups, monitoring logs, and checking server security. The main purpose of these scripts is to reduce manual work and make Linux server management easier.

##  Linux Automation Scripts

### 1 `health.sh` — Server Health Check

**Purpose -** This script checks the overall health of the Ubuntu server. It checks CPU usage, RAM usage, disk usage, system uptime, running processes, and the status of services such as SSH, Apache, and MySQL. It also checks whether the server has network connectivity.

**Use Case -** This script can be used by a system administrator to check whether the server is working properly or not. It helps to identify problems such as high CPU usage, high RAM usage, low disk space, stopped services, and network connectivity issues.

### 2 `backup.sh` — Automated Backup

**Purpose -** This script is used to take backups of important files and folders from the Ubuntu server. It asks the user to enter the path of the file or folder that needs to be backed up. It then creates a compressed backup file with the current date and time and stores it in a separate backup folder.

**Use Case -** This script can be used when a system administrator wants to take a backup of important files, website files, application files, or configuration files. It helps to keep a copy of important data so that it can be recovered if the original data is accidentally deleted or lost.

### 3 `log_monitor.sh` — Log Monitoring

**Purpose -** This script checks the Ubuntu server logs to identify important errors and suspicious activities. It checks failed SSH login attempts, authentication failures, system errors, and Apache server errors. It also displays a warning message if multiple failed login attempts or system errors are detected.

**Use Case -** This script can be used by a system administrator to monitor server logs and identify problems such as repeated failed login attempts, authentication failures, and service errors. It helps the administrator to find problems and take necessary action.

### 4 `security_audit.sh` — Server Security Audit

**Purpose -** This script performs a basic security check of the Ubuntu server. It checks whether the firewall is active, which ports are open, which users exist on the system, who is currently logged in, and which services are running. It also checks SSH security settings, file permissions, SUID files, and failed SSH login attempts. The results are displayed with PASS, WARNING, or FAIL messages and saved in a report file.

**Use Case -** This script can be used by a system administrator to check the basic security configuration of the Ubuntu server. It helps to identify security issues such as an inactive firewall, unnecessary open ports, insecure SSH settings, and multiple failed login attempts.

## Repository Structure

```text
GitHub-Repository/
│
├── README.md
│
└── Linux-Automation-Scripts/
    │
    ├── health.sh
    ├── backup.sh
    ├── log_monitor.sh
    └── security_audit.sh
```

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
./backup.sh
sudo ./log_monitor.sh
sudo ./security_audit.sh
```

## Note

These scripts are created for learning and practising Bash scripting and Linux automation. The scripts can be modified and improved according to the requirements of the server.
