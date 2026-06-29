# State management

Terraform's state file is the source of truth that maps your configuration to
real OpenStack resources. Most of the time you never touch it directly — but when
you refactor, rename, recover from drift, or split configurations, you'll reach
for the `terraform state` commands and `moved {}` blocks. This guide covers them
and the safety habits that keep state surgery from becoming an outage. For
storing state remotely see [remote state](./remote-state.md).

> Golden rule: **back up state before any mutating operation.** Mutating
> commands (`mv`, `rm`, `push`) and refactors can't be undone from memory.

## Inspecting state

```bash
terraform state list                    # all resource addresses in state
terraform state show openstack_compute_instance_v2.instance   # one resource
terraform state pull > current.tfstate  # dump raw state (read-only)
```

The repo's [`scripts/tf-state.sh`](../scripts/tf-state.sh) wraps these safely and
prompts before destructive sub-commands:

```bash
scripts/tf-state.sh examples/compute/single-instance list
scripts/tf-state.sh examples/compute/single-instance show openstack_compute_instance_v2.instance
```

## Moving and renaming resources

`terraform state mv` changes the *address* of a resource in state without
recreating the real resource. Use it when you rename a resource block, move it
into a module, or convert to `for_each`/`count`.

```bash
# Rename a resource block (old_name -> new_name)
terraform state mv \
  openstack_compute_instance_v2.web \
  openstack_compute_instance_v2.app

# Move a resource into a module
terraform state mv \
  openstack_networking_network_v2.net \
  module.networking.openstack_networking_network_v2.net

# Move into a for_each instance key
terraform state mv \
  'openstack_compute_instance_v2.web' \
  'openstack_compute_instance_v2.web["a"]'
```

Always follow with `terraform plan` and confirm it shows **no changes** — that
proves the move matched the config.

## Prefer `moved {}` blocks

For anything that ships in code, prefer a `moved {}` block over a manual
`state mv`. It is declarative, reviewable in a PR, and applied automatically for
every collaborator and CI run — no one has to remember to run a command:

```hcl
moved {
  from = openstack_compute_instance_v2.web
  to   = openstack_compute_instance_v2.app
}
```

This is the right tool when renaming resources or restructuring a
[module](./module-design.md). Keep the block until everyone has applied, then it
can be removed. `moved {}` requires Terraform `>= 1.1` (this repo targets
`>= 1.3`).

## Removing without destroying

`terraform state rm` forgets a resource — Terraform stops managing it, but the
real OpenStack resource keeps running. Use it to hand a resource to another
configuration or to drop something you'll re-[import](./importing-resources.md).

```bash
terraform state rm openstack_compute_instance_v2.app
```

For code-driven removal (Terraform `>= 1.7`), a `removed {}` block forgets a
resource without destroying it on the next apply:

```hcl
removed {
  from = openstack_compute_instance_v2.app
  lifecycle {
    destroy = false   # forget it, do NOT destroy the real instance
  }
}
```

To actually delete the resource, don't use `state rm` — remove the block (or run
`terraform destroy`) so Terraform tears it down properly.

## Recovering from drift

Drift is when reality diverges from state — someone changed a resource in
Horizon, or a resource was deleted out-of-band.

```bash
# See what changed without modifying anything:
terraform plan -refresh-only

# Reconcile state with reality (records drift into state):
terraform apply -refresh-only
```

- If a resource was **deleted** outside Terraform, a refresh marks it gone and
  the next `apply` recreates it.
- If a resource was **changed** outside Terraform, `plan` shows how it will be
  pushed back to match your config — or update the config to accept the change.
- The reference example uses `ignore_changes = [image_name]` so an upstream base
  image rebuild doesn't force-replace a running instance. Use
  `lifecycle { ignore_changes = [...] }` for attributes that legitimately drift.

To pull a single resource's current attributes into state without a full apply:

```bash
terraform apply -refresh-only -target=openstack_compute_instance_v2.app
```

## Pull and push

```bash
terraform state pull > state.json   # download current state
terraform state push state.json     # upload an edited/restored state (DANGER)
```

`state push` overwrites remote state. Use it only to restore a known-good backup,
and only when you understand the consequences — a bad push can orphan or
duplicate resources.

## Backups

```bash
# Repo helper: pull and timestamp the current state (read-only).
scripts/backup-state.sh examples/compute/single-instance
# -> writes state-backup-YYYYmmdd-HHMMSS.json
```

- Local backends auto-write a `terraform.tfstate.backup` on each apply.
- Take a manual backup before `mv`, `rm`, `push`, migrations, and provider
  upgrades. [`scripts/migrate-state.sh`](../scripts/migrate-state.sh) and the
  import helper do this for you.
- Store backups somewhere access-controlled — state can contain secrets.

## Safety checklist

- Back up first (`scripts/backup-state.sh`).
- Prefer `moved {}` / `removed {}` blocks over manual `state mv`/`rm`.
- After any state change, run `terraform plan` and expect **no changes**.
- Never hand-edit raw state JSON; use the commands.
- Serialise operations — with the Swift backend there is no locking
  ([remote state](./remote-state.md#state-locking-caveats)).

## Further reading

- [DevOps AI ToolKit](https://devopsaitoolkit.com/blog/)
