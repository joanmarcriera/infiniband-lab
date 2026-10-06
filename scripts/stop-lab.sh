#!/usr/bin/env bash
# stop-lab.sh - stop OpenSM(s) and ibsim (run INSIDE the container). Logs are kept.
pkill -x opensm 2>/dev/null; sleep 1
pkill -x ibsim 2>/dev/null; pkill -x sleep 2>/dev/null
rm -f /lab/logs/ibsim.cmd; echo "stopped."
