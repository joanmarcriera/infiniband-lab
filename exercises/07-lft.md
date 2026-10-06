# 07 - Linear Forwarding Table  [LAB]
**Commands:** `ibroute 2`, `ibroute 2 | lft-table.py`, then the same for LIDs 3, 4, 5 (the other switches).
**Inspect:** each row = *Destination LID -> output port*. Port 0 = the switch itself.
**Questions:** (a) On SW01, which port forwards a packet whose DLID is 8 (HCA04)? (b) On SW04 which port? (c) Why does the table have no source address or port-in column? (d) Complete: "An LFT maps a destination ___ to an output switch ___."
**Why it matters:** this single table is the data-plane. Forwarding = look up DLID, send. No routing decision is made by the switch - the SM computed it.
*AI-factory relevance:* same concept in production Quantum fabrics, but routing engines (fat-tree/up-down, adaptive routing) shape the table; ibsim/OpenSM here uses default min-hop.
