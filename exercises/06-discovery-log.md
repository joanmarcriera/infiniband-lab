# 06 - Watch discovery in the OpenSM log  [LAB]
**Commands:** `reset-lab.sh redundant`, then `grep -nE 'DISCOVERING|Discovered|MASTER|SUBNET UP' logs/opensm-HCA01.log | head -40`; `less logs/opensm-HCA01.log`.
**Inspect:** order of events: DISCOVERING -> `Discovered new Channel Adapter/Switch node` -> `Discovered port num N` for every port -> LID assignment -> routing -> `SUBNET UP`.
Under the hood these are SMPs (NodeInfo, PortInfo, SwitchInfo, then Set(PortInfo) for LIDs and Set(LinearForwardingTable)) sent by *directed route* (hop-by-hop port lists) because LIDs do not exist yet.
**Questions:** (a) Why must discovery use directed-route SMPs? (b) How many ports does the log "discover" on SW01 (8-port switch) - including those with no cable? (c) What changes between `Entering DISCOVERING` and `SUBNET UP`?
