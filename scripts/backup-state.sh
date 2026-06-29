#!/usr/bin/env bash
# Pull and back up remote/local state to a timestamped file (read-only).
set -euo pipefail
SD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"; source "$SD/lib-common.sh"
require_tf
DIR="$(target_dir "${1:-.}")"
OUT="${2:-state-backup-$(date +%Y%m%d-%H%M%S).json}"
( cd "$DIR" && "$TF" state pull > "$OUT" ) && ok "State backed up to $DIR/$OUT"
