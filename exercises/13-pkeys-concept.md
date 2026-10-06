# 13 - P_Keys vs VLANs  [CONCEPT - not exercised]
Verified limitation: `smpquery pkey 8 1` -> `operation 'pkey' not supported` - ibsim does not implement the PKey table, so P_Keys cannot be inspected or enforced here. Reading only.
- A **P_Key** is a 16-bit partition key (top bit = full/limited membership). Every packet carries one in its BTH; ports hold a P_Key table; the receiving port drops packets whose P_Key it is not a member of.
- Configured centrally by the SM (OpenSM `partitions.conf`), enforced in the **endpoints** (and optionally switches), not by tagging frames like an 802.1Q VLAN.
- Difference from VLAN: VLANs separate L2 broadcast domains by a tag in the Ethernet frame; P_Keys are an access-control membership check, and one port can be in several partitions.
**Question:** what does the default partition key 0xFFFF mean, and what would you need (real HCA + `partitions.conf`, `smpquery pkey`/`ibv_devinfo -v`) to see it?
