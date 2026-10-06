# 05 - Subnet Manager: stop / restart  [LAB]
**Commands:** `sminfo`, `pkill -x opensm`, `sminfo`, `ibaddr`, `ibroute 2`, then `start-opensm.sh HCA01`. Also `reset-lab.sh redundant --no-sm` to see a never-configured fabric.
**Questions:** (a) After killing OpenSM, do LIDs and LFTs vanish? (b) What does `sminfo` say and why? (c) On a fabric that never had an SM, what are the LIDs and what happens to `ibroute 2`?
**Why it matters:** the fabric *state* lives in the devices; the SM is the *control loop*. Ex 09 shows what is lost when the loop is gone.
*AI-factory relevance:* in production the SM runs HA on the switches or UFM; an SM outage is silent until the next topology change.
