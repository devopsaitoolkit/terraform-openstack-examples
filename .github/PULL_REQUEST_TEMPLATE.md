<!-- Thanks for contributing! -->

## What does this PR do?

<!-- New example? New module? Fix? Docs? -->

## Related issue

<!-- Closes #... -->

## Checklist

- [ ] `terraform fmt -recursive` run (CI enforces formatting).
- [ ] `terraform init -backend=false && terraform validate` passes in each changed dir.
- [ ] New module includes `tests/*.tftest.hcl` using `mock_provider` (runnable without a cloud).
- [ ] Example/module has a complete `README.md` (architecture, inputs, outputs, best practices, security, troubleshooting, cleanup).
- [ ] Targets provider `terraform-provider-openstack/openstack ~> 3.0`; no deprecated syntax.
- [ ] No secrets, real `clouds.yaml`, credentials, IPs, or `*.tfstate` committed.
- [ ] Promotional links (if any) are only in "Further Reading" / "Related Resources" — never in code or troubleshooting steps.
