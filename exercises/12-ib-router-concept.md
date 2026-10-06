# 12 - InfiniBand router / multiple subnets  [CONCEPT - not simulated]
ibsim models **one subnet**: there is no router device, no GRH forwarding, so nothing here can demonstrate inter-subnet routing.
Use what the lab *does* show and reason:
```
Subnet A (prefix fe80:0:0:0)            Subnet B (prefix fe80:0:0:1)
 HCA ... SW ... [IB router] ... SW ... HCA
```
- Inside a subnet: packets carry a **LRH** with SLID/DLID; switches forward on DLID via the LFT (Ex 07) - link layer.
- Between subnets: the packet also carries a **GRH** with SGID/DGID; an **IB router** reads the DGID, picks the next subnet and rewrites the LRH (new LIDs valid in the next subnet) - network layer.
- LIDs are only unique per subnet (Ex 03) - so they cannot be used to address across subnets; GIDs (subnet prefix + GUID, Ex 04) can.
**Questions:** (a) Which header field does a router use? (b) Why did `ibaddr` need to show a GID? (c) Which layer does inter-subnet routing belong to, and which does an LFT lookup belong to?
*AI-factory relevance:* most AI fabrics are one big subnet (LID space is large enough); routers matter for multi-site/very-large designs.
