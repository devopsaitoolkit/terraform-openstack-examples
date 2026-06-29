#!/usr/bin/env bash
# Init + apply a directory (applies a saved plan if tfplan.out exists).
set -euo pipefail
SD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"; source "$SD/lib-common.sh"
require_tf; show_cloud
DIR="$(target_dir "${1:-.}")"
( cd "$DIR" && "$TF" init -input=false
  if [ -f tfplan.out ]; then info "Applying saved plan tfplan.out"; "$TF" apply tfplan.out
  else confirm "Apply changes in $DIR to the live cloud?" && "$TF" apply; fi )
