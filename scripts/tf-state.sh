#!/usr/bin/env bash
# Thin, safe wrapper around `terraform state` sub-commands.
# Usage: tf-state.sh <dir> list|show|mv|rm|pull  [args...]
set -euo pipefail
SD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"; source "$SD/lib-common.sh"
require_tf
DIR="$(target_dir "${1:-.}")"; shift || true; SUB="${1:-list}"; shift || true
case "$SUB" in
  mv|rm) warn "State-mutating operation: $SUB"; ( cd "$DIR" && confirm "Run 'state $SUB $*'?" && "$TF" state "$SUB" "$@" ) ;;
  list|show|pull) ( cd "$DIR" && "$TF" state "$SUB" "$@" ) ;;
  *) err "Unknown sub-command: $SUB (use list|show|mv|rm|pull)"; exit 1 ;;
esac
