# Which IB tools work against ibsim (measured 2026-10-06, Ubuntu 24.04 pkgs: ibsim 0.10, opensm 3.3.23, infiniband-diags 50.0)

Run after `reset-lab.sh simple`. Viewpoint = `SIM_HOST` (default HCA01).

| Tool | Verdict | Observed |
|---|---|---|
| ibnetdiscover | fully useful | full topology, names, GUIDs, LIDs (LID 0 before an SM runs) |
| ibhosts / ibswitches | fully useful | node lists with LIDs |
| iblinkinfo | fully useful | per-port state/width; speed is fixed by the net file (4xQDR "10 Gbps" = simulated, not real) |
| ibroute `<lid>` | fully useful | the LFT: DLID -> out port (SW01: DLID5 -> port 3) |
| ibtracert `<slid> <dlid>` | fully useful | hop-by-hop path using the LFTs (bonus, not in the original prompt) |
| sminfo | fully useful | master SM lid/guid/priority/state |
| saquery | fully useful | SA served by OpenSM (NodeRecord etc.) |
| smpquery portinfo/nodeinfo | fully useful | GidPrefix, LID, SMLid, CapMask |
| ibaddr | fully useful | GID `fe80::2:c900:0:31` + LID range |
| ibstat | partial | libumad2sim fakes a CA "ibsim0" from the viewpoint node; real-HW fields are fake (FW 1, "simulator") |
| perfquery | partial | works, counters are 0 (nothing generates traffic/errors) |
| ibping -S | not meaningful | server just blocks; needs real data-plane |
| ibv_devinfo | irrelevant | verbs library/device not provided (not installed); needs real HCA/rdma_rxe |
