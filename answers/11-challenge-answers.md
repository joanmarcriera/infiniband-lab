# Challenge answers (spoilers - verified against the lab)
Reset between faults: `reset-lab.sh redundant`.

**1 - SM dead + a link cut (SW01 port 3).** `sminfo` fails (no master). The LFTs still point at the dead port (`ibroute 2`: DLIDs 3,5,7 -> port 3), so `ibtracert 1 7` and `1 8` fail with "can't reach". Nobody is left to recompute routes.
Fix: `start-opensm.sh HCA01`, wait one sweep. Lesson: Ex 09 Part B; an absent SM is silent until something changes.

**2 - HCA03's cable unplugged (SW04 port 1).** SM is fine, `ibtracert 1 8` works, `ibtracert 1 7` fails; `iblinkinfo` shows SW04 port 1 Down. Only that host is gone - a "unreachable destination" with a healthy fabric = look at the last hop. Fix: `simcmd 'ReLink "S-0002c90000000400"[1]'`.

**3 - Both SW04 uplinks cut (SW02[2] and SW03[2]).** SM is fine and master, but SW04 and its HCAs (HCA03, HCA04) form an island: traces to LIDs 7 and 8 fail though every *node* still exists on its own. The topology no longer matches the design (two links missing) - redundancy hid nothing because both paths died. Fix: `simcmd 'ReLink "S-0002c90000000200"[2]'` and same for SW03[2].
