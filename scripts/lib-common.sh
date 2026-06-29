#!/usr/bin/env bash
# Shared helpers for the Terraform wrapper scripts in this directory.
set -euo pipefail

TF="${TF_BIN:-terraform}"   # set TF_BIN=tofu to use OpenTofu

color() { if [ -t 1 ]; then printf '\033[%sm%s\033[0m' "$1" "$2"; else printf '%s' "$2"; fi; }
info()  { echo "$(color '0;36' '[*]') $*"; }
ok()    { echo "$(color '0;32' '[ok]') $*"; }
warn()  { echo "$(color '0;33' '[!]') $*" >&2; }
err()   { echo "$(color '0;31' '[x]') $*" >&2; }

require_tf() {
  command -v "$TF" >/dev/null 2>&1 || { err "$TF not found (set TF_BIN=terraform|tofu)"; exit 1; }
}

# Resolve the target directory (first non-flag arg, or current dir).
target_dir() {
  local d="${1:-.}"
  [ -d "$d" ] || { err "directory not found: $d"; exit 1; }
  echo "$d"
}

# Ask for explicit confirmation for destructive actions.
confirm() {
  local prompt="${1:-Are you sure?}"
  if [ "${ASSUME_YES:-0}" = "1" ]; then return 0; fi
  read -r -p "$(color '1;33' "$prompt") [y/N] " ans
  case "$ans" in y|Y|yes|YES) return 0 ;; *) warn "Aborted."; return 1 ;; esac
}

show_cloud() {
  if [ -n "${OS_CLOUD:-}" ]; then
    info "OS_CLOUD=$(color '1;37' "$OS_CLOUD")"
  else
    warn "OS_CLOUD is not set — the provider must get credentials another way."
  fi
}
