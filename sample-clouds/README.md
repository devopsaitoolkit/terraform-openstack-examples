# sample-clouds

Example `clouds.yaml` files for authenticating the OpenStack Terraform provider.

- [`clouds.yaml`](./clouds.yaml) — password, application-credential, and
  multi-region examples.

> ⚠️ **Never commit a real `clouds.yaml`.** The repo's `.gitignore` blocks
> `clouds.yaml` everywhere except this sample. Prefer **application credentials**
> over username/password — they are scoped and revocable. See
> [docs/application-credentials.md](../docs/application-credentials.md).
