# 04 - GID  [LAB]
**Commands:** `ibaddr`, `simhost HCA04; ibaddr`, `smpquery portinfo 8 1 | grep GidPrefix`, `reset-lab.sh redundant --no-sm; ibaddr`.
**Inspect:** GID = 128 bits = 64-bit **subnet prefix** + 64-bit **port GUID**. Here `fe80::2:c900:0:41` = prefix fe80:0:0:0 + GUID 0x0002c90000000041 (leading zeros elided).
**Questions:** (a) Which half of the GID did the SM contribute? Evidence: run `ibaddr` with no SM, then with. (b) Which GID field would change if this port moved to another subnet? (c) Is the GID stable when the LID changes?
**Why it matters:** the GID is the only address that is meaningful *outside* the subnet (Ex 12). `ibaddr` prints both: LID (local) and GID (global).
