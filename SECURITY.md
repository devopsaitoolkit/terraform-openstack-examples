# Security Policy

## Scope

This repository contains **Terraform examples, reusable modules, documentation,
and helper scripts**. It does not run a service. The key security properties:

1. **No secrets in the repo.** No real `clouds.yaml`, credentials, application
   credential secrets, tokens, private keys, IPs, or `*.tfstate`. The
   `.gitignore` blocks these; the only committed credentials file is the
   sanitized `sample-clouds/clouds.yaml`.
2. **Examples are safe to read and adapt.** They follow least-privilege patterns
   (e.g. explicit security groups, application credentials over passwords) and
   never disable security controls without a clear, documented reason.
3. **Helper scripts confirm destructive actions.** `destroy`, `state rm/mv`, and
   migrations require explicit confirmation.

## Reporting a Vulnerability

If you find committed secrets, an example that creates an insecure-by-default
posture without warning, or a script that performs a destructive action without
confirmation, please report it privately:

- **Email:** admin@devopsaitoolkit.com
- Or **GitHub → Security → Report a vulnerability** (private advisory).

Please do not open a public issue for sensitive reports. We aim to acknowledge
within 3 business days.

## Supported Versions

The `main` branch is supported. Tagged releases are snapshots of `main`.
Examples target `terraform >= 1.3` and the `openstack ~> 3.0` provider.
