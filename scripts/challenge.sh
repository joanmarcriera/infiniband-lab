#!/usr/bin/env bash
# challenge.sh <1|2|3> - silently break the fabric for the troubleshooting exercise (exercise 11).
# Prints NOTHING about what was done: diagnose with ibnetdiscover/sminfo/ibroute/ibtracert/iblinkinfo.
# Solutions: answers/11-challenge-answers.md (don't peek). Undo everything: reset-lab.sh redundant
set -euo pipefail
source /lab/scripts/env.sh
/lab/scripts/reset-lab.sh redundant >/dev/null 2>&1
sw() { printf 'S-0002c90000000%s00' "$1"; }          # switch node id from digit 1-4
case "${1:?usage: challenge.sh 1|2|3}" in
  1) pkill -x opensm; sleep 2; simcmd "Unlink \"$(sw 1)\"[3]"; sleep 1 ;;
  2) simcmd "Unlink \"$(sw 4)\"[1]"; sleep 14 ;;
  3) simcmd "Unlink \"$(sw 2)\"[2]"; simcmd "Unlink \"$(sw 3)\"[2]"; sleep 14 ;;
  *) echo "pick 1, 2 or 3" >&2; exit 2 ;;
esac
echo "Fault $1 injected. Diagnose it - what is wrong, and why?"
