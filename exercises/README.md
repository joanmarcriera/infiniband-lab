# Exercises

Setup once: `ssh dockerhost`, `cd ~/infiniband-lab`, `scripts/lab shell`, then inside: `reset-lab.sh redundant`.
Default viewpoint is HCA01 (`simhost HCA03` changes it). LIDs below are what this lab assigns on
`redundant` (HCA01=1 SW01=2 SW02=3 SW03=4 SW04=5 HCA02=6 HCA03=7 HCA04=8); yours should match - if not, that is data.
Do them in order. Type the commands yourself; answers are in `../answers/` - try first.

Legend: **[LAB]** observed in the simulator. **[CONCEPT]** explained, not demonstrable in ibsim.
*AI-factory relevance* notes describe real clusters in general terms; ibsim does not reproduce Quantum-switch behaviour.

| # | Topic | Kind |
|---|---|---|
| 01 | Discover the topology | LAB |
| 02 | GUID hierarchy | LAB |
| 03 | LID | LAB |
| 04 | GID | LAB |
| 05 | Subnet Manager: stop / restart | LAB |
| 06 | Watch discovery in the OpenSM log | LAB |
| 07 | Linear Forwarding Table | LAB |
| 08 | Trace a packet HCA01 -> HCA04 | LAB |
| 09 | Break a link (with and without an SM) | LAB |
| 10 | SM vs SA (`saquery`) | LAB |
| 11 | Troubleshooting challenge (`scripts/challenge.sh`) | LAB |
| 12 | InfiniBand router / multiple subnets | CONCEPT |
| 13 | P_Keys vs VLANs | CONCEPT |
| 14 | SM priority / election / failover | LAB |
