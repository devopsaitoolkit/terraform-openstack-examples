# Version upgrades

Keeping Terraform core and the OpenStack provider current gets you bug fixes,
new resources, and security patches — but upgrades can introduce breaking
changes. This guide covers upgrading Terraform/OpenTofu, migrating the OpenStack
provider from v2 to v3 (what this repo targets with `~> 3.0`), version
constraints, and the `.terraform.lock.hcl` dependency lock file.

See also: [provider configuration](./provider-configuration.md) and
[state management](./state-management.md) for backing up before upgrades.

## Version constraints

Two separate constraints govern what runs:

```hcl
terraform {
  required_version = ">= 1.3"          # Terraform/OpenTofu CORE

  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 3.0"               # the PROVIDER plugin
    }
  }
}
```

- **`required_version`** gates the Terraform binary. This repo requires `>= 1.3`;
  CI runs `1.9.8`.
- **`version` (provider)** uses the pessimistic operator: `~> 3.0` allows any
  `3.x` (`3.0`, `3.1`, …) but **not** `4.0`. This is what lets you pick up
  provider fixes without an unexpected major-version jump.

## The dependency lock file

`.terraform.lock.hcl` records the *exact* provider versions and their checksums
that `terraform init` selected. **Commit it.** It guarantees everyone — and CI —
installs the same provider builds:

```hcl
# .terraform.lock.hcl (generated; commit this file)
provider "registry.terraform.io/terraform-provider-openstack/openstack" {
  version     = "3.1.0"
  constraints = "~> 3.0"
  hashes      = [ "h1:...", ]
}
```

Manage it with `init`:

```bash
terraform init                # honours the lock file
terraform init -upgrade       # re-selects newest allowed by constraints, updates lock
```

For reproducible CI across operating systems, record hashes for multiple
platforms:

```bash
terraform providers lock \
  -platform=linux_amd64 \
  -platform=darwin_arm64
```

CI in this repo caches providers keyed on the hash of `versions.tf`, so changing
a constraint naturally busts the cache.

## Upgrading Terraform core

1. Read the upstream upgrade/changelog notes for the target version.
2. Bump your toolchain (e.g. via `tfenv`, your package manager, or
   `hashicorp/setup-terraform` in CI).
3. Re-init and run the offline checks from [testing](./testing.md):

```bash
terraform version
terraform init
terraform validate
terraform plan      # expect no changes from the upgrade alone
```

Core upgrades are usually smooth because `required_version` keeps you on
compatible versions. If you adopt new core features (`moved {}` needs `>= 1.1`,
`import {}` blocks `>= 1.5`, `terraform test` `>= 1.6`, `removed {}` `>= 1.7`),
raise `required_version` accordingly so collaborators get a clear error rather
than a confusing failure.

### OpenTofu

OpenTofu is a drop-in alternative; the helper scripts honour `TF_BIN=tofu`. Pick
one tool per state file and stick with it — don't alternate between `terraform`
and `tofu` against the same state.

## Upgrading the OpenStack provider

Within the `~> 3.0` range, upgrading is just:

```bash
terraform init -upgrade
git diff .terraform.lock.hcl     # review what changed
terraform plan                   # check for unexpected diffs
```

Always run `plan` after a provider upgrade: a new provider version can change
default values or how an attribute is read, which surfaces as a diff.

## Migrating the provider v2 → v3

The repository standardises on provider **v3** (`~> 3.0`). If you have older
configurations on v2, plan the jump deliberately — major versions carry breaking
changes. The general v2 → v3 migration shape:

- **Use the full source address.** v3 must be referenced as
  `terraform-provider-openstack/openstack` in `required_providers` (the bare
  `openstack` short name is not sufficient).
- **Bump the constraint and re-init:**

  ```hcl
  openstack = {
    source  = "terraform-provider-openstack/openstack"
    version = "~> 3.0"
  }
  ```

  ```bash
  terraform init -upgrade
  ```

- **Review removed/renamed arguments and resources.** Some long-deprecated
  attributes and legacy resource versions were dropped in v3. Run
  `terraform validate`; it will flag arguments that no longer exist so you can
  update each block.
- **Mind authentication defaults.** v3 leans on modern Keystone v3 auth
  (`identity_api_version: 3`, application credentials). Make sure your
  [`clouds.yaml`](./clouds-yaml.md) uses v3 auth, not legacy v2.0.
- **Read the provider's upgrade guide and CHANGELOG** for the precise list of
  breaking changes between the v2 version you're on and v3.

Always check the
[provider upgrade guide and changelog](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs)
for the authoritative, version-specific breaking-change list.

## State compatibility

- State is **forward-compatible within reason** but **not backward-compatible**:
  once a newer Terraform or provider writes your state, older versions may refuse
  to read it. Upgrade everyone (and CI) together.
- **Back up state before any upgrade** — provider upgrades can rewrite state
  representations:

  ```bash
  scripts/backup-state.sh path/to/config
  ```

- With the Swift backend there is no locking
  ([remote state](./remote-state.md#state-locking-caveats)) — make sure no other
  apply runs while you upgrade.

## Safe upgrade checklist

1. Back up state.
2. Read the core and provider upgrade notes / CHANGELOG.
3. Bump constraints (`required_version`, provider `version`).
4. `terraform init -upgrade`; commit the updated `.terraform.lock.hcl`.
5. `terraform validate` and `terraform plan` — expect no changes.
6. Apply during a quiet window; verify, keep the backup until confident.

## Further reading

- [DevOps AI ToolKit](https://devopsaitoolkit.com/blog/)
