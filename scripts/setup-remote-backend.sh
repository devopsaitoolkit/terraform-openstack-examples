#!/usr/bin/env bash
# Generate a backend.tf for OpenStack Swift remote state in a directory.
# Usage: setup-remote-backend.sh <dir> <container> [state-name]
set -euo pipefail
SD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"; source "$SD/lib-common.sh"
DIR="$(target_dir "${1:-.}")"; CONTAINER="${2:-}"; NAME="${3:-terraform.tfstate}"
[ -z "$CONTAINER" ] && { err "Usage: setup-remote-backend.sh <dir> <swift-container> [state-name]"; exit 1; }
cat > "$DIR/backend.tf" <<TF
terraform {
  backend "swift" {
    container   = "$CONTAINER"
    state_name  = "$NAME"
    # Auth comes from OS_CLOUD / clouds.yaml, same as the provider.
  }
}
TF
ok "Wrote $DIR/backend.tf (Swift container '$CONTAINER'). Run 'terraform init -migrate-state'."
