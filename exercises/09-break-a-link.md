# 09 - Break a link (with and without an SM)  [LAB]
**Setup:** `reset-lab.sh redundant`; note `ibtracert 1 8` and `ibroute 2 | lft-table.py`.
**Part A - with SM:** `simcmd 'Unlink "S-0002c90000000100"[4]'`; wait ~12 s (light sweep); `ibroute 2 | lft-table.py`; `ibtracert 1 8`; `iblinkinfo | grep -i down`; `grep -i sweep logs/opensm-HCA01.log | tail`. Restore: `simcmd 'ReLink "S-0002c90000000100"[4]'`.
**Part B - without SM:** `pkill -x opensm`, cut the same link, wait, `ibroute 2`, `ibtracert 1 8`. Then restart `start-opensm.sh HCA01` and re-cut: compare.
**Questions:** (a) Which DLIDs changed port in A? (b) What does B show for DLID 8 and what does `ibtracert` say? (c) After ReLink are routes identical to before?  (d) What does this say about why SM HA matters?
**Note:** `Unlink` = cable pulled. Real failures also involve port-state traps and error counters, which ibsim only partly models.
*AI-factory relevance:* a flapping link in a training job shows up as an SM sweep + route change; NCCL traffic stalls until LFTs converge.
