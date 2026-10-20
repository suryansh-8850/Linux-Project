report="security_audit_report.txt"

{
echo "================================"
echo "       SERVER SECURITY AUDIT"
echo "================================"
echo "Date: $(date)"
echo

echo "========== FIREWALL =========="

if ufw status | grep -q "Status: active"; then
    echo "PASS: Firewall is active"
else
    echo "FAIL: Firewall is inactive"
fi

echo
echo "========== OPEN PORTS =========="

ss -tuln

echo
echo "========== SYSTEM USERS =========="

cut -d: -f1 /etc/passwd

echo
echo "========== LOGGED IN USERS =========="

who

echo
echo "========== RUNNING SERVICES =========="

systemctl list-units --type=service --state=running --no-pager --no-legend

echo
echo "========== SSH SECURITY =========="

if sshd -T 2>/dev/null | grep -q "^permitrootlogin no$"; then
    echo "PASS: Root login disabled"
else
    echo "WARNING: Check SSH root login"
fi

echo
echo "========== FILE PERMISSIONS =========="

ls -l /etc/passwd /etc/shadow

echo
echo "========== SUID FILES =========="

find /usr/bin /usr/sbin -type f -perm -4000 2>/dev/null

echo
echo "========== FAILED SSH LOGINS =========="

failed=$(journalctl -u ssh --since "24 hours ago" -q | grep -c "Failed password")

echo "Failed Attempts: $failed"

if [[ $failed -ge 5 ]]; then
    echo "WARNING: Multiple failed logins"
else
    echo "PASS: No excessive failed logins detected"
fi

echo
echo "================================"
echo "       AUDIT COMPLETED"
echo "================================"

} | tee "$report"

echo "Report saved: $report"
