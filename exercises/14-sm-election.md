# 14 - SM priority, master/standby, failover  [LAB]
**Commands:** `reset-lab.sh redundant --no-sm`, `start-opensm.sh HCA01 0`, `start-opensm.sh HCA03 5`, wait ~8 s, `sminfo`.
Then `pkill -f 'opensm -g 0x0002c90000000031'` (kills the master), `sminfo` (fails for a while), wait ~60 s, `sminfo` again;
`grep -E 'STANDBY|MASTER' logs/opensm-HCA01.log | tail`.
**Observed in this lab:** the higher *priority* (5) wins master even though it started second; the other SM logs `SM State 2 (STANDBY)` and polls the master every 10 s;
after ~4 failed polls it enters MASTER (`sminfo` shows HCA01, priority 0). During that gap there is **no SM** - the Ex 09 Part B situation.
**Questions:** (a) Which SM wins when priorities tie? (look up: lowest GUID) (b) Why is the takeover not instant, and what does that cost a running job? (c) Which tools identify the master?
*AI-factory relevance:* production SMs run HA pairs on switches/UFM; timers are tuned to keep this gap short.
