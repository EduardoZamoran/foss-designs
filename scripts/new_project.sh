#!/usr/bin/env bash
# UNUSED: kept for future reference only (see scripts/README.md).
# Usage: scripts/new_project.sh <category> <name>
set -euo pipefail
cd "$(dirname "$0")/.."
dir="projects/$1/$2"
mkdir -p "$dir"/{rtl,tb,sim,synth,docs,scripts}
printf 'PASS_MSG := TEST PASSED\ninclude ../../../../scripts/sim.mk\n' > "$dir/sim/Makefile"
printf '# %s\n\n## Description\n\nTODO.\n' "$2" > "$dir/README.md"
echo "Created: $dir"