#!/bin/bash
echo "Generating CPU and disk load for dashboard testing..."
# CPU stress
for i in {1..4}; do
    dd if=/dev/zero of=/dev/null &
done
# Disk stress
dd if=/dev/zero of=/tmp/testfile bs=1M count=512
echo "Load test running for 30 seconds..."
sleep 30
kill %1 %2 %3 %4 2>/dev/null
rm -f /tmp/testfile
echo "Load test complete. Check Netdata dashboard for spike."
