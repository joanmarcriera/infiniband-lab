#!/usr/bin/env python3
"""lft-table.py - pretty-print a switch's Linear Forwarding Table from `ibroute` output.

Usage (inside the container):  ibroute <switch-lid> | lft-table.py
                               ibroute -G <switch-guid> | lft-table.py
Reads only what ibroute printed; adds nothing. Packet logic it illustrates:
  packet carries DLID -> switch indexes this table by DLID -> sends it out the listed port.
Port 0 = the switch itself (management traffic terminates here).
"""
import re, sys

head = re.compile(r"Unicast lids .* of switch Lid (\d+) guid (0x[0-9a-f]+) \((.*?)\)")
row = re.compile(r"^0x([0-9a-f]+)\s+(\d+)\s*:\s*\((.*)\)")
name, rows = "?", []
for line in sys.stdin:
    if m := head.search(line):
        name = f"{m[3]}  (LID {m[1]}, GUID {m[2]})"
    elif m := row.match(line.strip()):
        # "Channel Adapter portguid 0x...: 'HCA01'"  ->  keep the quoted name
        who = re.search(r"'(.*)'", m[3])
        rows.append((int(m[1], 16), int(m[2]), who[1] if who else m[3]))
if not rows:
    sys.exit("no LFT rows found - pipe in `ibroute <switch-lid>` output")
w = max(len(r[2]) for r in rows + [(0, 0, "Destination")])
print(name)
print(f"┌──────┬─────────────┬─{'─' * w}─┐")
print(f"│ DLID │ Egress port │ {'Destination':<{w}} │")
print(f"├──────┼─────────────┼─{'─' * w}─┤")
for dlid, port, who in rows:
    print(f"│ {dlid:<4} │ {port:<11} │ {who:<{w}} │")
print(f"└──────┴─────────────┴─{'─' * w}─┘")
