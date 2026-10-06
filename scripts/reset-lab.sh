#!/usr/bin/env bash
# reset-lab.sh - back to a pristine fabric (run INSIDE the container).
# Usage: reset-lab.sh [simple|redundant] [--no-sm]   Stops all, wipes logs + OpenSM state, restarts.
set -euo pipefail
topo="${1:-simple}"
/lab/scripts/stop-lab.sh >/dev/null
rm -f /lab/logs/opensm-* /lab/logs/ibsim.log /var/cache/opensm/* 2>/dev/null || true
/lab/scripts/start-lab.sh "$topo"
[[ "${2:-}" == "--no-sm" ]] || /lab/scripts/start-opensm.sh HCA01
