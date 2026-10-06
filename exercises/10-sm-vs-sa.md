# 10 - SM vs SA (saquery)  [LAB]
**Commands:** `saquery -N` (NodeRecords), `saquery -p` (PortInfoRecords), `saquery --help` (other record types), `sminfo`; then `pkill -x opensm; saquery -N` (verified: `Query SA failed: Connection timed out`).
**Inspect:** these answers do not come from the switches - they come from OpenSM's database via the Subnet Administration class (MADs to the SM's LID).
**Questions:** (a) Which process answers `saquery`, and what dies if it is stopped (try it)? (b) SM *configures* the fabric; SA *answers queries about* it - give one example of each from this lab. (c) Why do clients ask the SA for a *path record* before opening a connection?
