echo "================================"
echo "         LOG MONITORING"
echo "================================"
echo "Date: $(date)"
echo

echo "========== FAILED SSH LOGINS =========="

ssh_failed=$(journalctl -u ssh --since "24 hours ago" -q | grep -c "Failed password")

echo "Failed SSH Attempts: $ssh_failed"

if [[ $ssh_failed -ge 5 ]]; then
    echo "WARNING: Multiple failed SSH attempts"
else
    echo "SSH is normal"
fi

echo
echo "========== AUTHENTICATION FAILURES =========="

auth_failed=$(journalctl --since "24 hours ago" -q | grep -c "authentication failure")

echo "Authentication Failures: $auth_failed"

if [[ $auth_failed -ge 5 ]]; then
    echo "WARNING: Multiple authentication failures"
else
    echo "Authentication is normal"
fi

echo
echo "========== SYSTEM ERRORS =========="

errors=$(journalctl -p err --since "24 hours ago" -q | wc -l)

echo "System Errors: $errors"

if [[ $errors -gt 0 ]]; then
    echo "WARNING: System errors detected"
else
    echo "No system errors"
fi

echo
echo "========== APACHE ERRORS =========="

if [[ -f /var/log/apache2/error.log ]]; then
    grep -i "error" /var/log/apache2/error.log | tail -n 5
else
    echo "Apache log not found"
fi

echo
echo "================================"
echo "       LOG CHECK COMPLETE"
echo "================================"
