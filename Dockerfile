# infiniband-lab: ibsim + OpenSM + infiniband-diags on Ubuntu 24.04.
# ibsim is pure userspace (libumad2sim intercepts umad calls) -> no kernel module, no --privileged.
FROM ubuntu:24.04
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      ibsim-utils opensm infiniband-diags graphviz python3 less procps \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /lab
CMD ["tail", "-f", "/dev/null"]
