# Changelog

All notable changes to this project are documented here. The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Initial public release: 100+ production-quality Terraform examples for
  OpenStack across compute, networking, storage, images, security, identity,
  load balancing, floating IPs, routers, DNS, projects, users, quotas,
  monitoring, backup, snapshots, GPU, high availability, multi-region, and
  Kolla-Ansible.
- Reusable modules (compute, networking, security group, volume, project, user,
  image, router, floating IP, load balancer) with `mock_provider` native tests.
- Documentation: provider configuration, clouds.yaml, application credentials,
  remote state, module design, testing, debugging, importing, state management,
  and version upgrades.
- Mermaid architecture and workflow diagrams.
- Helper scripts for fmt/validate/plan/apply/destroy/import/state with safety
  checks.
- GitHub community health files and CI (fmt, validate, native tests, markdown
  lint, spell check, link check, release).

[Unreleased]: https://github.com/devopsaitoolkit/terraform-openstack-examples/commits/main
