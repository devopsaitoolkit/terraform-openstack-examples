# Remote state

Terraform records what it manages in a state file. By default that file lives on
disk as `terraform.tfstate`. The moment more than one person — or a CI runner —
touches a configuration, local state stops being safe: it isn't shared, isn't
backed up, and can be clobbered by concurrent runs. This guide covers moving
state to OpenStack Object Storage (Swift) and migrating safely. For everyday
state surgery see [state management](./state-management.md).

## Why remote state

- **Sharing** — teammates and CI work from one authoritative copy instead of
  passing files around.
- **Durability** — the state lives in object storage, not on one laptop.
- **Secrets** — state can contain sensitive values (passwords, the application
  credential secret). A remote backend keeps it off local disks and lets you
  control access centrally.
- **Consistency** — everyone plans and applies against the same recorded reality.

## The Swift backend

OpenStack clouds expose Swift object storage, and Terraform ships a built-in
`swift` backend. It stores state as an object in a container and authenticates
exactly like the provider — from `OS_CLOUD` / `clouds.yaml` — so there is no
extra credential to manage.

Create a container first:

```bash
export OS_CLOUD=openstack
openstack container create terraform-state
```

Then declare the backend in a `backend.tf`:

```hcl
terraform {
  backend "swift" {
    container  = "terraform-state"
    state_name = "compute/single-instance/terraform.tfstate"
    # Auth comes from OS_CLOUD / clouds.yaml, same as the provider.
  }
}
```

- **`container`** — the Swift container that holds the state object.
- **`state_name`** — the object name (path) within the container. Give each
  configuration a unique `state_name` so they never collide; a path-like name
  mirrors your directory layout.
- Connection details (`auth_url`, region, credentials) are read from your
  environment, just like the provider.

> Note: a backend block cannot use variables or interpolation — values must be
> literals. Supply environment-specific settings via `terraform init
> -backend-config=...` or a `*.tfbackend` file instead.

### Generating backend.tf

The repo provides [`scripts/setup-remote-backend.sh`](../scripts/setup-remote-backend.sh)
to write a `backend.tf` for you:

```bash
# setup-remote-backend.sh <dir> <swift-container> [state-name]
scripts/setup-remote-backend.sh examples/compute/single-instance \
  terraform-state compute/single-instance/terraform.tfstate
```

It prints a reminder to run `terraform init -migrate-state`.

## State locking caveats

Locking prevents two applies from corrupting state at the same time. **The Swift
backend does not implement state locking.** Treat this as the backend's biggest
limitation and compensate operationally:

- Serialise applies — never run two against the same `state_name` concurrently.
- Funnel applies through CI with a concurrency gate (e.g. one job at a time per
  state) rather than ad-hoc local runs.
- Always [back up state](./state-management.md#backups) before risky operations
  (`scripts/backup-state.sh`).

If you need true locking, consider an external backend that supports it (for
example an S3-compatible endpoint with a lock mechanism, where your cloud offers
one). For many small teams, disciplined serialisation of applies is enough.

## Migrating local → remote

Migration moves your existing `terraform.tfstate` into Swift without recreating
anything. Back up first, always.

### Manual steps

```bash
cd examples/compute/single-instance
export OS_CLOUD=openstack

# 1. Back up the current state.
terraform state pull > state-premigration-$(date +%Y%m%d-%H%M%S).json

# 2. Add the backend block (see above, or use setup-remote-backend.sh).

# 3. Re-init and let Terraform copy state into Swift.
terraform init -migrate-state
```

Terraform detects the new backend and offers to copy existing state into it;
confirm. Verify nothing changed:

```bash
terraform state list
terraform plan      # should show "No changes"
```

### Using the helper script

[`scripts/migrate-state.sh`](../scripts/migrate-state.sh) backs up state, asks
for confirmation, then runs `terraform init -migrate-state` for you:

```bash
# After backend.tf is in place:
scripts/migrate-state.sh examples/compute/single-instance
```

It pulls a `state-premigration-*.json` backup before touching anything.

## Going back to local (or to another backend)

The reverse works the same way: remove or change the `backend` block and run
`terraform init -migrate-state` again. To start over from scratch instead of
copying, use `terraform init -reconfigure` (this does **not** move state — only
do it when you intend to lose the backend association).

## Operational checklist

- One `state_name` per configuration; never share state between unrelated dirs.
- Restrict who can read the Swift container — state may hold secrets.
- Back up before migrations, `state rm/mv`, and provider upgrades.
- Serialise applies; the Swift backend won't stop a concurrent run for you.

## Further reading

- [DevOps AI ToolKit](https://devopsaitoolkit.com/blog/)
