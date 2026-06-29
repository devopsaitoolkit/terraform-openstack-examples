# The OpenStack Terraform provider has NO native cinder-backup resource. Backups
# are full or incremental copies stored in the Cinder backup backend (Swift by
# default, or NFS/Ceph) and survive deletion of the source volume — unlike
# snapshots, which live with the volume. We orchestrate `openstack volume
# backup create` via null_resource. Terraform does NOT track the backup.
resource "null_resource" "volume_backup" {
  triggers = {
    volume_id   = var.volume_id
    backup_name = var.backup_name
    incremental = tostring(var.incremental)
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    environment = {
      OS_CLOUD = var.cloud
    }
    command = <<-EOT
      openstack volume backup create \
        --name "${var.backup_name}" \
        --description "${var.backup_description}" \
        ${var.incremental ? "--incremental" : ""} \
        ${var.force ? "--force" : ""} \
        "${var.volume_id}"
    EOT
  }
}
