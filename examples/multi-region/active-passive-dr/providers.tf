# Active-passive DR uses two regions:
#   - region 1 (default provider) runs the live "primary" stack.
#   - region 2 (alias) holds a pre-provisioned "standby" stack, normally scaled
#     to zero instances so it costs almost nothing until you fail over.

provider "openstack" {
  cloud = var.cloud_primary
}

provider "openstack" {
  alias = "standby"
  cloud = var.cloud_standby
}
