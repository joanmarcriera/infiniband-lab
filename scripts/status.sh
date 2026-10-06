#!/usr/bin/env bash
# status.sh - what is running (run INSIDE the container). Process state only; the networking
# questions ("who is the SM? what LIDs?") are for you to answer with the IB commands.
echo "topology: $(cat /lab/logs/ibsim.topology 2>/dev/null || echo none)"
pgrep -ax ibsim   || echo "ibsim:   NOT running"
pgrep -ax opensm  || echo "opensm:  NOT running"
