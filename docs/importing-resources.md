# Importing existing resources

Sometimes resources exist in OpenStack before Terraform does — created by hand in
Horizon, by a script, or by a previous tool. **Importing** brings them under
Terraform management without recreating them: you write matching configuration,
attach the real resource to it in state, and from then on Terraform manages it
normally. This guide covers both the classic `terraform import` command and the
newer config-driven `import {}` blocks, plus how to find OpenStack IDs.

See also: [state management](./state-management.md) and the import helper
[`scripts/tf-import.sh`](../scripts/tf-import.sh).

## The import workflow in brief

1. Write a `resource` block that will represent the existing resource.
2. Find the resource's OpenStack ID.
3. Import it (command or `import {}` block).
4. Run `terraform plan` and iterate on the config until the diff is empty.

The goal is **no changes** on `plan` — that proves your config faithfully
describes what already exists.

## Finding IDs with the openstack CLI

Terraform imports by the provider's ID, which for OpenStack is almost always the
resource UUID. Find it with the CLI:

```bash
export OS_CLOUD=openstack

openstack server list                 # instances
openstack network list                # networks
openstack subnet list
openstack router list
openstack security group list
openstack volume list
openstack floating ip list
openstack image list
openstack loadbalancer list           # Octavia
```

Get the exact ID of one resource:

```bash
openstack server show web-1 -f value -c id
```

Some resources need a composite ID (parent/child) — for example a subnet's
allocation or a router interface. Check the provider's resource documentation
"Import" section for the expected format before importing those.

## Method 1: `terraform import` (command)

First write the resource block (it can be minimal to start):

```hcl
resource "openstack_compute_instance_v2" "web" {
  name = "web-1"
  # other required arguments filled in as you iterate
}
```

Then import by address and ID:

```bash
cd path/to/config
export OS_CLOUD=openstack

terraform init -input=false
terraform import openstack_compute_instance_v2.web 0a1b2c3d-....-uuid
```

Or use the repo helper, which inits and reminds you to verify:

```bash
# tf-import.sh <dir> <terraform-address> <openstack-id>
scripts/tf-import.sh . openstack_compute_instance_v2.web 0a1b2c3d-....-uuid
```

Now reconcile the config with reality:

```bash
terraform plan
```

If the plan wants to change or replace anything, your config doesn't match yet.
Use `terraform state show openstack_compute_instance_v2.web` to read the imported
attributes and copy the relevant ones into your block. Repeat until `plan` is
clean.

## Method 2: `import {}` blocks (config-driven)

Terraform `>= 1.5` supports declarative import blocks. They live in code, are
reviewable in a PR, run as part of `apply`, and — unlike the command — can
generate a starting configuration for you.

```hcl
import {
  to = openstack_compute_instance_v2.web
  id = "0a1b2c3d-....-uuid"
}

resource "openstack_compute_instance_v2" "web" {
  # you can let Terraform generate this for you (below), then tidy it up
}
```

Generate config automatically, then plan/apply:

```bash
terraform plan -generate-config-out=generated.tf
# review and clean up generated.tf, then:
terraform apply
```

After the import is applied and the resource is in state, **delete the
`import {}` block** — it has done its job. Import blocks are also handy for
bulk-importing many resources with `for_each`.

## Verifying

Whichever method you use, the acceptance test is the same:

```bash
terraform plan      # must report "No changes."
```

A clean plan means Terraform now owns the resource and won't try to alter it.
Keep a [state backup](./state-management.md#backups) from before the import in
case you need to back out.

## Common gotchas

- **Wrong ID type.** Import needs the UUID, not the name. Resolve it first
  (`openstack ... show <name> -f value -c id`).
- **Composite IDs.** Router interfaces, member/pool relationships, and a few
  others use `parent/child` style IDs. Check the resource's Import docs.
- **Default / cloud-managed attributes.** Computed fields (timestamps, generated
  IPs) appear after import; don't set them in config. Use `state show` to see
  what's computed vs. what you must declare.
- **`ignore_changes` mismatches.** The reference example ignores `image_name`;
  when importing instances, mirror such `lifecycle` settings so plan stays clean.
- **One resource at a time (command).** `terraform import` handles a single
  address per call. For many resources, prefer `import {}` blocks with
  `for_each`.
- **Data sources can't be imported.** A `data` block reads existing resources by
  query — if you only need to *reference* something, use a data source instead of
  importing it.
- **Secrets aren't recoverable.** Importing an
  [application credential](./application-credentials.md) won't recover its
  secret; that's only shown at creation.
- **No locking on Swift.** Don't import while another apply runs against the same
  state — see [remote state](./remote-state.md#state-locking-caveats).

## Further reading

- [DevOps AI ToolKit](https://devopsaitoolkit.com/blog/)
