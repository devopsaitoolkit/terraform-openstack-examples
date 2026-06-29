# Look up the target network by name so no cloud-specific UUIDs are hard-coded.
data "openstack_networking_network_v2" "network" {
  name = var.network_name
}

# A port with port security DISABLED.
#
# !!! DANGER !!!
# With port_security_enabled = false:
#   * NO security groups can be applied (hence no_security_groups = true).
#   * NO anti-spoofing / MAC-IP binding is enforced by Neutron.
#   * The attached VM can send/receive ANY source/destination IP and MAC.
# This is intended ONLY for NFV / virtual-appliance / router VMs that perform
# their own packet filtering. See the README security warning before using it.
resource "openstack_networking_port_v2" "no_security" {
  name                  = var.port_name
  network_id            = data.openstack_networking_network_v2.network.id
  admin_state_up        = true
  port_security_enabled = false
  no_security_groups    = true
  tags                  = ["managed-by:terraform", "example:port-security-disabled"]
}
