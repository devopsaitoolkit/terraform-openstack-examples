#!/usr/bin/env bash
# Validate every example and module in the repo (init -backend=false + validate).
set -euo pipefail
SD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"; source "$SD/lib-common.sh"
require_tf
ROOT="$(cd "$SD/.." && pwd)"
fail=0; count=0
while IFS= read -r d; do
  dir="$(dirname "$d")"
  count=$((count+1))
  if ( cd "$dir" && "$TF" init -backend=false -input=false >/dev/null 2>&1 && "$TF" validate >/dev/null 2>&1 ); then
    ok "$dir"
  else
    err "$dir"; fail=$((fail+1))
  fi
done < <(find "$ROOT/examples" "$ROOT/modules" -name 'versions.tf' -o -name 'main.tf' | sort -u | while read -r f; do echo "$(dirname "$f")/main.tf"; done | sort -u)
echo "checked $count dirs, $fail failed"
[ "$fail" -eq 0 ]
