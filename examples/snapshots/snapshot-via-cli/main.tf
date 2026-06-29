# The OpenStack Terraform provider has NO native volume-snapshot resource.
# We orchestrate the CLI via null_resource + local-exec. Changing any trigger
# (volume_id or snapshot_name) re-runs the snapshot. Terraform does NOT track
# the snapshot's lifecycle — `terraform destroy` will not delete it.
resource "null_resource" "volume_snapshot" {
  triggers = {
    volume_id     = var.volume_id
    snapshot_name = var.snapshot_name
    force         = tostring(var.force)
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    environment = {
      OS_CLOUD = var.cloud
    }
    command = <<-EOT
      openstack volume snapshot create \
        --volume "${var.volume_id}" \
        --description "${var.snapshot_description}" \
        ${var.force ? "--force" : ""} \
        "${var.snapshot_name}"
    EOT
  }
}
