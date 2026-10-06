# 01 - Discover the topology  [LAB]
**Objective:** read a fabric from `ibnetdiscover`. **Commands:** `ibnetdiscover`, `ibhosts`, `ibswitches`, `iblinkinfo`.
**Inspect:** the `Switch` vs `Ca` blocks; each `[n]` line is "my port n connects to that node's port m".
**Questions:** (a) How many CAs, switches, links? (b) Which port of SW01 faces SW02? (c) Draw it on paper, then run
`ibnetdiscover | topo-dot.py` and compare `topology/current.svg` (it is written inside the repo mount, so it appears in `topology/` on the host; see also `docs/topology-redundant.svg`).
**Why it matters:** in a GPU cluster the first debugging step is always "is the fabric what the design says it is?".
*AI-factory relevance:* a DGX/HGX rail-optimised fabric has hundreds of such links; `ibnetdiscover` diffed against the design is how miscabling is found.
