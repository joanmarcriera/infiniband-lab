#!/usr/bin/env bash
# stop-lab.sh - stop OpenSM(s) and ibsim (run INSIDE the container). Logs are kept.
pkill -x opensm 2>/dev/null; sleep 1
pkill -x ibsim 2>/dev/null
[[ -f /lab/logs/ibsim.fifo-holder ]] && kill "$(cat /lab/logs/ibsim.fifo-holder)" 2>/dev/null
rm -f /lab/logs/ibsim.cmd /lab/logs/ibsim.fifo-holder; echo "stopped."
