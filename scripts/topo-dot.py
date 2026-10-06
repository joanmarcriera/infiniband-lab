#!/usr/bin/env python3
"""topo-dot.py - turn live `ibnetdiscover` output into Graphviz DOT (and SVG if `dot` exists).

Usage (inside the container):  ibnetdiscover | topo-dot.py [outfile-base]   (default /lab/topology/current)
Writes <base>.dot and <base>.svg. Every label comes from ibnetdiscover output only: node name,
node GUID, LID, port numbers on each link end. Nothing is inferred.
"""
import re, subprocess, sys

base = sys.argv[1] if len(sys.argv) > 1 else "/lab/topology/current"
nodes, edges, cur = {}, set(), None
for line in sys.stdin:
    if m := re.match(r'^(Switch|Ca)\s+\d+\s+"([SH]-[0-9a-f]+)"\s*#\s*"([^"]*)"(?:.*lid (\d+))?', line):
        cur = m[2]; nodes[cur] = {"kind": m[1], "name": m[3], "lid": m[4] or "?"}
    elif cur and (m := re.match(r'^\[(\d+)\](?:\((\w+)\))?\s+"([SH]-[0-9a-f]+)"\[(\d+)\]', line)):
        edges.add(tuple(sorted([(cur, m[1]), (m[3], m[4])])))
        # CA port lines carry the CA's own LID right after '#':  [1](portguid) "S-..."[p]  # lid 8 lmc 0 ...
        if nodes[cur]["kind"] == "Ca" and (l := re.search(r"#\s*lid (\d+) lmc", line)):
            nodes[cur]["lid"] = l[1]
dot = ["graph ib {", "  rankdir=LR; node [fontname=Helvetica fontsize=10];"]
for gid, n in nodes.items():
    shape, fill = ("box", "#cfe8ff") if n["kind"] == "Switch" else ("ellipse", "#e6f4d7")
    dot.append(f'  "{gid}" [shape={shape} style=filled fillcolor="{fill}" '
               f'label="{n["name"]}\\n{gid[2:]}\\nLID {n["lid"]}"];')
for (a, pa), (b, pb) in sorted(edges):
    dot.append(f'  "{a}" -- "{b}" [taillabel="p{pa}" headlabel="p{pb}" fontsize=9];')
dot.append("}")
open(base + ".dot", "w").write("\n".join(dot) + "\n")
try:
    subprocess.run(["dot", "-Tsvg", base + ".dot", "-o", base + ".svg"], check=True)
    print(f"wrote {base}.dot and {base}.svg ({len(nodes)} nodes, {len(edges)} links)")
except (FileNotFoundError, subprocess.CalledProcessError) as e:
    print(f"wrote {base}.dot only ({e})")
