#!/bin/bash

echo "=========================================="
echo " Server Performance Stats"
echo " $(date)"
echo "=========================================="

# OS Version
echo -e "\n--- OS Version ---"
if [ -f /etc/os-release ]; then
    grep PRETTY_NAME /etc/os-release | cut -d'"' -f2
else
    uname -a
fi

# Uptime
echo -e "\n--- Uptime ---"
uptime -p

# Load Average
echo -e "\n--- Load Average (1m, 5m, 15m) ---"
uptime | awk -F'load average:' '{print $2}'

# CPU Usage
echo -e "\n--- Total CPU Usage ---"
top -bn1 | grep "Cpu(s)" | awk '{print "User: " $2 "%, System: " $4 "%, Idle: " $8 "%"}'

# Memory Usage
echo -e "\n--- Memory Usage ---"
free -h | awk '/Mem:/ {print "Total: " $2 "  Used: " $3 "  Free: " $4 "  Used%%: " $3/$2*100"%"}'
free -m | awk '/Mem:/ {printf "Used: %sMB / %sMB (%.2f%%)\n", $3, $2, $3/$2*100}'

# Disk Usage
echo -e "\n--- Disk Usage (/) ---"
df -h / | awk 'NR==2 {print "Total: " $2 "  Used: " $3 " (" $5 ")  Free: " $4}'

# Logged in users
echo -e "\n--- Logged In Users ---"
who | awk '{print $1}' | sort | uniq

# Failed login attempts (requires root/sudo to read auth log)
echo -e "\n--- Failed Login Attempts (last 5) ---"
if [ -f /var/log/auth.log ]; then
    grep "Failed password" /var/log/auth.log | tail -5
else
    echo "auth.log not accessible (try running with sudo)"
fi

# Top 5 processes by CPU
echo -e "\n--- Top 5 Processes by CPU Usage ---"
ps aux --sort=-%cpu | head -6

# Top 5 processes by Memory
echo -e "\n--- Top 5 Processes by Memory Usage ---"
ps aux --sort=-%mem | head -6

echo -e "\n=========================================="
echo " End of Report"
echo "=========================================="
