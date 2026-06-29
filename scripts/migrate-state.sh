#!/usr/bin/env bash
# Migrate state to a newly-configured backend (after editing backend.tf).
# Backs up first, then runs 'init -migrate-state'.
set -euo pipefail
SD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"; source "$SD/lib-common.sh"
require_tf
DIR="$(target_dir "${1:-.}")"
info "Backing up current state before migration..."
( cd "$DIR" && "$TF" state pull > "state-premigration-$(date +%Y%m%d-%H%M%S).json" || true )
confirm "Migrate state in $DIR to the backend configured in backend.tf?" || exit 1
( cd "$DIR" && "$TF" init -migrate-state )
ok "Migration complete. Verify with 'terraform state list'."
