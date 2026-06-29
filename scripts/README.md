# Helper scripts

Thin, safe wrappers around Terraform for this repo. Set `TF_BIN=tofu` to use
OpenTofu instead of Terraform.

| Script | Purpose |
|--------|---------|
| `tf-fmt.sh [--check] [dir]` | Format recursively (or check formatting) |
| `tf-validate.sh <dir>` | `init -backend=false` + `validate` one directory |
| `tf-validate-all.sh` | Validate every example and module |
| `tf-plan.sh <dir>` | `init` + `plan -out=tfplan.out` |
| `tf-apply.sh <dir>` | Apply (uses a saved plan if present; confirms otherwise) |
| `tf-destroy.sh <dir>` | Plan-destroy, then destroy **after confirmation** |
| `tf-import.sh <dir> <address> <id>` | Import an existing OpenStack resource |
| `tf-state.sh <dir> list\|show\|mv\|rm\|pull` | Safe `terraform state` wrapper |
| `setup-remote-backend.sh <dir> <container>` | Generate a Swift backend.tf |
| `backup-state.sh <dir>` | Pull and back up state to a timestamped file |
| `migrate-state.sh <dir>` | Back up, then migrate state to a new backend |

> 🔒 Destructive operations (`destroy`, `state rm/mv`, migrate) require explicit
> confirmation. Set `ASSUME_YES=1` only in automation you trust.

Auth comes from your environment (`OS_CLOUD` + `clouds.yaml`), the same as the
provider — see [docs/provider-configuration.md](../docs/provider-configuration.md).
