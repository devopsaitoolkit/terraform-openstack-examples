#!/usr/bin/env bash
# Import an existing OpenStack resource into state.
# Usage: tf-import.sh <dir> <terraform-address> <openstack-id>
set -euo pipefail
SD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"; source "$SD/lib-common.sh"
require_tf; show_cloud
DIR="$(target_dir "${1:-}")"; ADDR="${2:-}"; ID="${3:-}"
[ -z "$ADDR" ] || [ -z "$ID" ] && { err "Usage: tf-import.sh <dir> <address> <id>"; exit 1; }
info "Importing $ID -> $ADDR in $DIR"
( cd "$DIR" && "$TF" init -input=false >/dev/null && "$TF" import "$ADDR" "$ID" )
ok "Imported. Run 'terraform plan' to confirm no diff."
