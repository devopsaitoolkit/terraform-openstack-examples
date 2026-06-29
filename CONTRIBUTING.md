# Contributing to terraform-openstack-examples

Thank you for helping build the best open collection of production Terraform for
OpenStack. Real, battle-tested examples from operators are exactly what makes
this resource valuable.

Ways to contribute:

- ➕ **Add a new example** (the most valuable contribution)
- 🧩 **Add or improve a reusable module**
- 🔧 **Fix** an example that drifted from current provider behavior
- 📝 **Improve docs** or troubleshooting sections
- 💬 **Share a pattern** in Discussions

## Ground rules

1. **Production-quality, not toys.** Examples should reflect real enterprise
   infrastructure: descriptive variable names, sensible defaults, outputs,
   tags, and comments where they earn their keep.
2. **Current provider, no deprecated syntax.** Target
   `terraform-provider-openstack/openstack ~> 3.0` and `terraform >= 1.3`.
3. **Safe by default.** Never commit secrets, a real `clouds.yaml`, credentials,
   IPs, or `*.tfstate`. Promotional links belong only in "Further Reading" /
   "Related Resources" — never in code or troubleshooting steps.
4. **Every example is self-contained** and documents architecture, inputs,
   outputs, best practices, security, troubleshooting, and cleanup.

## Anatomy of an example

```text
examples/<category>/<name>/
├── versions.tf              # required_version + provider constraint
├── providers.tf             # provider "openstack" { cloud = var.cloud }
├── variables.tf             # documented variables with types + defaults
├── main.tf                  # the resources
├── outputs.tf               # documented outputs
├── terraform.tfvars.example # copy to terraform.tfvars (gitignored)
└── README.md                # see the section list below
```

Use [`examples/compute/single-instance`](./examples/compute/single-instance/) as
the reference. Each README has: title + primary search phrase, Architecture
(with a Mermaid diagram), Usage, Inputs table, Outputs table, Best practices
(why / common mistakes / scaling / performance / cost), Security considerations,
Troubleshooting table, Cleanup, and Further reading.

## Anatomy of a module

```text
modules/<name>/
├── versions.tf
├── variables.tf
├── main.tf
├── outputs.tf
├── README.md
├── examples/basic/          # a runnable usage example
└── tests/<name>.tftest.hcl  # native test using mock_provider (no cloud needed)
```

Module tests use `mock_provider "openstack" {}` so `terraform test` runs in CI
without any OpenStack cloud or credentials.

## Local checks (CI runs all of these)

```bash
terraform fmt -recursive .                       # or scripts/tf-fmt.sh
scripts/tf-validate.sh examples/compute/single-instance
terraform -chdir=modules/compute test            # for modules with tests/
npx markdownlint-cli2 "**/*.md"
npx cspell "**/*.md"
```

`scripts/tf-validate-all.sh` validates every example and module at once.

## Developer Certificate of Origin

By contributing you certify you wrote the contribution (or have the right to
submit it) and license it under the repository's [Apache-2.0 License](./LICENSE).

Questions? Open a
[Discussion](https://github.com/devopsaitoolkit/terraform-openstack-examples/discussions).
