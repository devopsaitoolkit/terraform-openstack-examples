# Testing and validation

You can catch most mistakes in Terraform before they ever reach OpenStack.
This repository validates and tests every example and module in CI **without a
real cloud or credentials**, using formatting checks, `terraform validate`,
TFLint, and native `terraform test` with a `mock_provider`. This guide shows how
to run the same checks locally and how the pieces fit together.

See also: [module design](./module-design.md) for the structure these tests
assume, and [Terraform basics](./terraform-basics.md) for the core workflow.

## The layers of checking

| Layer | Command | Needs a cloud? | Catches |
|-------|---------|----------------|---------|
| Format | `terraform fmt` | no | Style/whitespace |
| Validate | `terraform validate` | no | Syntax, types, references |
| Lint | `tflint` | no | Anti-patterns, deprecated usage |
| Test | `terraform test` (mock) | no | Logic, outputs, conditions |
| Plan | `terraform plan` | yes | Real diffs against your cloud |

The first four run offline, so use them liberally and in CI.

## fmt — formatting

```bash
terraform fmt -recursive          # rewrite files to canonical style
terraform fmt -check -recursive   # fail if anything is unformatted (CI mode)
```

Repo helper: [`scripts/tf-fmt.sh`](../scripts/tf-fmt.sh) (`--check` to verify).
CI runs `terraform fmt -check -recursive` and fails on any diff.

## validate — syntax and types

`validate` checks a configuration is internally consistent. Use
`-backend=false` so it never tries to reach the [Swift backend](./remote-state.md),
and it needs no credentials:

```bash
cd examples/compute/single-instance
terraform init -backend=false -input=false
terraform validate
```

Validate one directory or the whole repo with the helpers:

```bash
scripts/tf-validate.sh examples/compute/single-instance
scripts/tf-validate-all.sh     # every example and module
```

## tflint — linting

[TFLint](https://github.com/terraform-linters/tflint) catches issues `validate`
misses (deprecated syntax, unused declarations, provider-specific smells). The
repo config is [`.tflint.hcl`](../.tflint.hcl), which enables the recommended
`terraform` ruleset:

```bash
tflint --init        # install plugins named in .tflint.hcl
tflint --recursive   # lint the whole tree
```

## terraform test with a mock provider

Native testing (`terraform test`, Terraform `>= 1.6`) runs `*.tftest.hcl` files.
Combined with `mock_provider`, it exercises module logic, conditionals, and
outputs **without contacting OpenStack** — the provider's API calls are faked, so
no credentials, no resources, no cost. This is how the modules in this repo are
tested.

Each module keeps tests under `tests/`. A test file declares a mock provider and
one or more `run` blocks:

```hcl
# modules/networking/tests/defaults.tftest.hcl

mock_provider "openstack" {}

run "creates_network_and_subnet" {
  command = plan

  variables {
    name = "test"
    cidr = "10.0.0.0/24"
  }

  assert {
    condition     = openstack_networking_network_v2.this.name == "test"
    error_message = "network name should match the input"
  }
}

run "rejects_bad_cidr" {
  command = plan

  variables {
    name = "test"
    cidr = "not-a-cidr"
  }

  expect_failures = [var.cidr]   # the validation block should reject this
}
```

Run the tests for a module:

```bash
cd modules/networking
terraform init -backend=false -input=false
terraform test
```

Notes:

- `command = plan` checks intent without applying; `command = apply` runs against
  the mock so you can assert on computed/output values.
- `mock_provider` returns synthetic values for unknown attributes; assert on what
  *you* set (names, counts, conditionals) rather than server-generated IDs.
- Use `expect_failures` to prove input `validation {}` blocks reject bad input.
- Put shared setup in a `run` block with `module {}` or in
  [`examples/basic/`](#the-examplesbasic-pattern).

## The examples/basic pattern

Every module ships a runnable [`examples/basic/`](../modules) that calls the
module with minimal inputs. It serves three purposes: living documentation, a
target for `validate`, and a fixture that `terraform test` can reuse via a
`module {}` block. CI validates these alongside everything else, so they can
never silently rot.

## Continuous integration

[`.github/workflows/ci.yml`](../.github/workflows/ci.yml) runs on every push and
pull request and mirrors the local commands above:

1. **fmt** — `terraform fmt -check -recursive`.
2. **validate** — `init -backend=false` + `validate` for every directory
   containing a `main.tf` under `examples/` and `modules/`.
3. **test** — `terraform test` in every directory that has a `tests/` folder
   (mock provider, no cloud).
4. **markdownlint** and **spellcheck** over all `*.md`.

CI pins Terraform `1.9.8` and caches providers keyed on `versions.tf` hashes.
Because nothing needs credentials, every contributor's PR is fully checked
without access to a cloud.

## A pre-commit routine

```bash
scripts/tf-fmt.sh --check .
tflint --recursive
scripts/tf-validate-all.sh
( cd modules/networking && terraform init -backend=false && terraform test )
```

Run the offline four before pushing; reserve `terraform plan` for when you
genuinely want to see the diff against a live cloud.

## Further reading

- [DevOps AI ToolKit](https://devopsaitoolkit.com/blog/)
