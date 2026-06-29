#!/usr/bin/env bash
# Recursively format Terraform files. Pass --check to verify without writing.
set -euo pipefail
SD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"; source "$SD/lib-common.sh"
require_tf
if [ "${1:-}" = "--check" ]; then
  info "Checking formatting (no changes)..."
  "$TF" fmt -check -recursive "${2:-.}" && ok "All files formatted." || { err "Run scripts/tf-fmt.sh to fix."; exit 1; }
else
  info "Formatting recursively..."
  "$TF" fmt -recursive "${1:-.}"; ok "Done."
fi
