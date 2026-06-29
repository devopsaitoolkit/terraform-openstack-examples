# OpenStack has no native backup scheduler. The durable pattern is to generate a
# wrapper script and schedule it OFF-CLUSTER (cron or a systemd timer on an ops
# host, or a CI cron job). This null_resource writes the wrapper; you then
# install the schedule (see the README for cron and systemd timer snippets).
# Terraform manages only the script file, not the backups it creates.
resource "null_resource" "backup_wrapper" {
  triggers = {
    script_path        = var.script_path
    volume_id          = var.volume_id
    backup_name_prefix = var.backup_name_prefix
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOT
      cat > "${var.script_path}" <<'SCRIPT'
      #!/usr/bin/env bash
      set -euo pipefail
      export OS_CLOUD="${var.cloud}"
      TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
      openstack volume backup create \
        --name "${var.backup_name_prefix}-$${TIMESTAMP}" \
        --incremental \
        --force \
        "${var.volume_id}"
      SCRIPT
      chmod +x "${var.script_path}"
    EOT
  }
}
