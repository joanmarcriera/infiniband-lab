# 08 - Trace a packet HCA01 -> HCA04  [LAB]
**Commands:** `ibtracert 1 8`; then manually: `ibroute 2`, `ibroute 3`/`ibroute 4` (whichever switch ibtracert named), `ibroute 5`.
**Task:** write the hop list yourself from the LFTs only (src HCA01 -> SW01: DLID 8 -> port ? -> next switch -> ...), then confirm with `ibtracert`.
**Questions:** (a) Does the HCA make a routing decision? (b) At each switch, which header field is used? (c) Why might a *different* middle switch (SW02 vs SW03) be chosen than your neighbour got?
**Why it matters:** switching/forwarding (table lookup on DLID, per hop) is not routing (choosing paths, done once by the SM) - keep the three words apart: *forwarding* = per-packet lookup, *routing* = SM path calculation, *switching* = L2 devices doing the former.
