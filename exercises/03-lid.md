# 03 - LID  [LAB]
**Commands:** `ibaddr`, `simhost HCA03; ibaddr`, `ibswitches`, `smpquery portinfo 7 1`.
**Inspect:** `LID start/end` (end > start only with LMC>0), and `Lid:` / `SMLid:` in portinfo.
**Questions:** (a) List the LID of every node. (b) Who assigned them? Run `reset-lab.sh redundant --no-sm` then `ibaddr` - what LID now?
(c) Why can the same LID number exist in two different subnets?
**Why it matters:** LID = the address switches forward on (Ex 07). Unicast LID space is 0x0001-0xBFFF (49,151 addresses) per subnet - the hard cap on subnet size.
