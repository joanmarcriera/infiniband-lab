# env.sh - source me inside the container (the container's .bashrc does this for you).
#
# After sourcing, plain IB commands (ibnetdiscover, ibroute, sminfo ...) talk to the simulator:
#   LD_PRELOAD=libumad2sim.so  intercepts umad (MAD send/recv) calls and forwards them to the
#                              ibsim process over a local socket instead of /dev/infiniband/umad*.
#   SIM_HOST=<node name>       which simulated node your commands "run on" (the viewpoint).
#                              Switch viewpoint with:  simhost HCA03
# ibsim ITSELF must not be preloaded - start-lab.sh strips LD_PRELOAD for it.
export IBSIM_SO=/usr/lib/x86_64-linux-gnu/umad2sim/libumad2sim.so
export LD_PRELOAD="$IBSIM_SO"
export SIM_HOST="${SIM_HOST:-HCA01}"
export LAB=/lab
simhost() { export SIM_HOST="${1:?usage: simhost <node name, e.g. HCA03>}"; echo "viewpoint: $SIM_HOST"; }
# simcmd '<ibsim console command>' - inject a command into the running simulator, e.g.
#   simcmd 'Unlink "S-0002c90000000100"[3]'     (cut a link)     simcmd 'ReLink "S-0002c90000000100"[3]'  (restore)
# Output lands in logs/ibsim.log. 'help' lists every console command.
simcmd() { timeout 3 bash -c 'echo "$1" > /lab/logs/ibsim.cmd' _ "$1"; }
