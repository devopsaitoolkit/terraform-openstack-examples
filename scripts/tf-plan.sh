#!/usr/bin/env bash
# Init + plan a directory. Usage: tf-plan.sh [dir]
set -euo pipefail
SD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"; source "$SD/lib-common.sh"
require_tf; show_cloud
DIR="$(target_dir "${1:-.}")"
( cd "$DIR" && "$TF" init -input=false && "$TF" plan -out=tfplan.out )
ok "Plan written to $DIR/tfplan.out — review it before applying."
