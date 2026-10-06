# InfiniBand cheat sheet (every command run against this lab; see notes/tool-matrix.md)

| Concept | Meaning | Scope | How to inspect |
|---|---|---|---|
| LID | 16-bit local address; unicast 0x0001-0xBFFF; assigned by the SM | one subnet | `ibaddr`, `ibnetdiscover`, `smpquery portinfo <lid> <port>` |
| GUID | 64-bit burned-in identity: system image / node / port | global | `ibnetdiscover`, `ibhosts`, `ibswitches`, `smpquery nodeinfo <lid>` |
| GID | 128-bit = 64-bit subnet prefix + port GUID | global (routable) | `ibaddr` (also `smpquery portinfo` -> GidPrefix) |
| SM | Subnet Manager: discovers, assigns LIDs, computes routes, programs LFTs | one subnet | `sminfo` |
| SA | Subnet Administrator: answers queries from the SM's database | one subnet | `saquery -N`, `saquery -p` |
| LFT | switch table: destination LID -> output port | per switch | `ibroute <switch-lid> \| lft-table.py` |
| Path trace | hop list following the LFTs | subnet | `ibtracert <slid> <dlid>` |
| Link state | port state/width/speed | per link | `iblinkinfo`, `ibstat` (fake `ibsim0`) |
| Counters | error/traffic counters | per port | `perfquery <lid> <port>` (always 0 in ibsim) |
| P_Key | partition membership | subnet | NOT inspectable in ibsim (`smpquery pkey` unsupported) |
| GRH / router | global header + inter-subnet routing on DGID | between subnets | not simulated (concept, Ex 12) |

**Forwarding vs routing vs switching:** a switch *forwards* each packet by LFT lookup on DLID (link layer, LRH);
the SM *routes* (computes the tables, once per change); an IB *router* routes *between* subnets using the GRH DGID (network layer).

**Lab controls:** `lab up|shell|down` (host) - `reset-lab.sh [simple|redundant] [--no-sm]` - `start-lab.sh` - `start-opensm.sh <HCA> [prio]` -
`stop-lab.sh` - `status.sh` - `simhost <node>` (viewpoint) - `simcmd '<ibsim cmd>'` (e.g. `Unlink "S-0002c90000000100"[4]` / `ReLink ...`) - `challenge.sh 1|2|3`.
