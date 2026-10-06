# 02 - GUID hierarchy  [LAB]
**Commands:** `ibnetdiscover | grep -E 'sysimgguid|switchguid|caguid|^\['`, `smpquery nodeinfo 5`, `ibhosts`.
**Inspect:** a node has a System Image GUID, a Node GUID, and each *port* has a Port GUID. For our HCAs
the port GUID is node GUID + 1 (see the number in parentheses on an HCA link line).
**Questions:** (a) For HCA03 write down system, node and port GUID. Are they equal? (b) For a switch, which GUID appears
on its port 0? (c) Which GUID did OpenSM's `-g` option take, and why that one?
**Why it matters:** the SM keys everything on GUIDs (LIDs are *assigned*, GUIDs are *burned in*); LIDs change, GUIDs identify the hardware.
