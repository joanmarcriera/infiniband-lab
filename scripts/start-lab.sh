#!/usr/bin/env bash
# start-lab.sh - start the ibsim fabric simulator (run INSIDE the container).
# Usage: start-lab.sh [simple|redundant]      (default: simple -> topology/simple.net)
# ibsim reads the .net topology and then waits for MADs from tools preloaded with libumad2sim.
# Its interactive console is fed from a FIFO so the process survives without a terminal and you
# can inject commands later (e.g. link failures):  echo "<cmd>" > /lab/logs/ibsim.cmd
set -euo pipefail
topo="${1:-simple}"; net="/lab/topology/${topo}.net"
[[ -f $net ]] || { echo "no such topology: $net" >&2; exit 2; }
pgrep -x ibsim >/dev/null && { echo "ibsim already running (use stop-lab.sh)" >&2; exit 1; }
fifo=/lab/logs/ibsim.cmd; rm -f "$fifo"; mkfifo "$fifo"
echo "$topo" > /lab/logs/ibsim.topology
# env -u LD_PRELOAD: the simulator must not intercept its own calls.
# 'sleep infinity > fifo' keeps the FIFO open so ibsim's console never sees EOF.
(sleep infinity > "$fifo" &)
(env -u LD_PRELOAD nohup ibsim -s "$net" < "$fifo" > /lab/logs/ibsim.log 2>&1 &)
for _ in {1..20}; do grep -q "Network simulator ready" /lab/logs/ibsim.log 2>/dev/null && break; sleep 0.25; done
grep -q "Network simulator ready" /lab/logs/ibsim.log || { echo "ibsim failed to start:" >&2; cat /lab/logs/ibsim.log >&2; exit 1; }
echo "ibsim up with topology '$topo'. Next: start-opensm.sh"
