#!/usr/bin/env bash
# Init (no backend) + validate a single example/module directory.
set -euo pipefail
SD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"; source "$SD/lib-common.sh"
require_tf
DIR="$(target_dir "${1:-.}")"
info "Validating $DIR"
( cd "$DIR" && "$TF" init -backend=false -input=false >/dev/null && "$TF" validate )
ok "Valid."
