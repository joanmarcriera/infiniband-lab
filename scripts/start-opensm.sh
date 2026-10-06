#!/usr/bin/env bash
# start-opensm.sh - run OpenSM on a simulated HCA (run INSIDE the container).
# Usage: start-opensm.sh [HCA-name] [priority]      (default: HCA01, priority 0)
# OpenSM runs "on" the chosen HCA via SIM_HOST; -g selects that HCA's PORT GUID (node GUID + 1 in
# our topologies). Log (-V = verbose) goes to logs/opensm-<name>.log - follow it to watch
# discovery -> LID assignment -> routing -> LFT programming -> SUBNET UP.
set -euo pipefail
host="${1:-HCA01}"; prio="${2:-0}"
source /lab/scripts/env.sh
pgrep -x ibsim >/dev/null || { echo "ibsim not running: start-lab.sh first" >&2; exit 1; }
# Port GUID of the chosen HCA, looked up from the net file (no hardcoding).
net="/lab/topology/$(cat /lab/logs/ibsim.topology).net"
nodeid=$(grep -E "^Ca .*# \"$host\"" "$net" | sed -E 's/.*"H-([0-9a-f]+)".*/\1/')
[[ -n $nodeid ]] || { echo "no HCA named $host in $net" >&2; exit 2; }
pguid=$(printf '0x%016x' $((16#$nodeid + 1)))
log="/lab/logs/opensm-$host.log"; : > "$log"
(SIM_HOST="$host" nohup opensm -g "$pguid" -p "$prio" -f "$log" -V > "/lab/logs/opensm-$host.out" 2>&1 &)
for _ in {1..40}; do grep -q "SUBNET UP" "$log" && { echo "OpenSM on $host ($pguid): SUBNET UP"; exit 0; }; sleep 0.5; done
echo "no SUBNET UP after 20s - see $log" >&2; exit 1
