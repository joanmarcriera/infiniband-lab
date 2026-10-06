# infiniband-lab - learn IB management-plane concepts with ibsim + OpenSM

Hands-on companion to the NVIDIA Academy InfiniBand course. A simulated fabric (ibsim) managed by a real OpenSM,
queried with the real `infiniband-diags` tools. **Management plane only** - no data plane, no RDMA, no real speeds.

## Where it runs
Docker container `ib-lab` on **dockerhost** (Ubuntu 24.04), image built from `Dockerfile` (apt: `ibsim-utils 0.10`, `opensm 3.3.23`,
`infiniband-diags 50.0`, graphviz). Needs no kernel module and no privileges. Repo is mounted at `/lab` so logs/topologies persist.
Source of truth: this directory on the Mac; deploy = `rsync -a ./ dockerhost:~/infiniband-lab/`.

## How the pieces fit
`ibsim` loads a topology (`topology/*.net`) and serves MADs on a local socket. `libumad2sim.so`, injected with `LD_PRELOAD`
(see `scripts/env.sh`), replaces the user-space MAD library so `opensm`, `ibnetdiscover`, `ibroute`... talk to ibsim instead of
`/dev/infiniband/umad*`. `SIM_HOST=<node name>` chooses which simulated node a tool "runs on". OpenSM sees a normal fabric,
discovers it, assigns LIDs, computes routes and programs the switches' LFTs through ibsim.

## Start / stop / reset
```
ssh dockerhost; cd ~/infiniband-lab
scripts/lab up          # once: build image + start container
scripts/lab shell       # prompt inside the lab (env already loaded)
reset-lab.sh redundant  # inside: fresh 4-switch diamond + OpenSM on HCA01   (or: simple)
status.sh | stop-lab.sh | scripts/lab down
```

## First five commands
1. `ibnetdiscover` - the fabric: switches, CAs, GUIDs, who plugs into which port.
2. `sminfo` - which node is the master SM (lid 1, state MASTER).
3. `ibaddr` - your port's LID *and* GID.
4. `ibroute 2 | lft-table.py` - SW01's forwarding table (DLID -> port).
5. `ibtracert 1 8` - the hop-by-hop path HCA01 -> HCA04, then cut a link (Ex 09) and run it again.

## Contents
`exercises/` (14 + `nvidia-course-notes.md`) - `answers/` - `CHEATSHEET.md` - `notes/tool-matrix.md` (which tools work) -
`scripts/` (lifecycle, `lft-table.py`, `topo-dot.py`, `gen-net.py`, `challenge.sh`) - `topology/` - `logs/` (git-ignored).

## Validation (run 2026-10-06 on dockerhost)
| Feature | Result |
|---|---|
| ibsim running, topology parsed (0 warnings), simple + redundant | PASS |
| OpenSM against ibsim: DISCOVERING -> LIDs -> LFTs -> SUBNET UP | PASS |
| Nodes/switches visible (ibnetdiscover, ibhosts, ibswitches, iblinkinfo) | PASS |
| LIDs assigned; GID inspectable (`ibaddr`) | PASS |
| LFT visible (`ibroute`, `lft-table.py`), path trace (`ibtracert`) | PASS |
| Link failure -> sweep -> LFT change -> restore | PASS (restored routes may differ from original - documented) |
| SM stop/restart; no-SM black hole | PASS |
| Two SMs: priority election + standby failover (~60 s) | PASS |
| `saquery` (SA) incl. failure when SM is down | PASS |
| Topology DOT/SVG from live data | PASS |
| `ibstat` | PARTIAL (fake `ibsim0` device) |
| `perfquery` | PARTIAL (counters always 0) |
| `ibv_devinfo` / verbs / `ibping` | N/A - needs real HCA |
| P_Keys (`smpquery pkey`) | FAIL by design: unsupported in ibsim (Ex 13 is reading only) |
| Multi-subnet / IB router | N/A - ibsim is one subnet (Ex 12 is conceptual) |
| Error-counter exercises | NOT DONE (ibsim has `Error`/`PerformanceSet` injection; untested) |

## Limitations (need real hardware)
Actual 200/400/800 Gb/s links and RDMA/verbs performance, GPUDirect RDMA, NCCL, SHARP, congestion/adaptive routing at line rate,
ConnectX/BlueField/SuperNIC behaviour, NVLink/NVSwitch, Quantum-specific routing engines. Simulated "10 Gbps 4X" is a number in the topology file.

## Next step
When Ex 01-14 are comfortable (and you can predict `ibtracert` before running it), rent a **2-node IB GPU box** (Hyperstack/Verda/Runpod
with InfiniBand) for one afternoon: `ibstat`, `ibv_devinfo`, `ib_write_bw`, `perfquery` counters under load, `nccl-tests`.
