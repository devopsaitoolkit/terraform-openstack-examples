output "secgroup_id" {
  description = "UUID of the default-deny baseline security group."
  value       = openstack_networking_secgroup_v2.baseline.id
}

output "secgroup_name" {
  description = "Name of the baseline security group."
  value       = openstack_networking_secgroup_v2.baseline.name
}

output "egress_rule_ids" {
  description = "UUIDs of the explicitly-allowed egress rules (DNS udp/tcp, HTTPS)."
  value = [
    openstack_networking_secgroup_rule_v2.dns_udp_out.id,
    openstack_networking_secgroup_rule_v2.dns_tcp_out.id,
    openstack_networking_secgroup_rule_v2.https_out.id,
  ]
}
