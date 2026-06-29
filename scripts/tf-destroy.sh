#!/usr/bin/env bash
# Destroy resources in a directory. Requires explicit confirmation.
set -euo pipefail
SD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"; source "$SD/lib-common.sh"
require_tf; show_cloud
DIR="$(target_dir "${1:-.}")"
warn "This will DESTROY all resources managed by the state in: $DIR"
( cd "$DIR" && "$TF" init -input=false >/dev/null
  "$TF" plan -destroy
  confirm "Proceed with DESTROY in $DIR?" && "$TF" destroy )
