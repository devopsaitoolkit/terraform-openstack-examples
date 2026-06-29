# Snapshot a running Nova instance into a Glance image. There is NO native
# Terraform resource for instance snapshots, so we wrap the CLI. The resulting
# Glance image is NOT tracked by Terraform and survives `terraform destroy`.
resource "null_resource" "instance_snapshot" {
  triggers = {
    instance_id = var.instance_id
    image_name  = var.image_name
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    environment = {
      OS_CLOUD = var.cloud
    }
    command = <<-EOT
      openstack server image create \
        --name "${var.image_name}" \
        ${var.wait ? "--wait" : ""} \
        "${var.instance_id}"
    EOT
  }
}
