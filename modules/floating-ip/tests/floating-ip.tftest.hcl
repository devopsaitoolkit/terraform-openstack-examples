mock_provider "openstack" {}

run "allocates_floating_ips" {
  command = plan

  variables {
    pool      = "public"
    fip_count = 2
  }

  assert {
    condition     = length(openstack_networking_floatingip_v2.this) == 2
    error_message = "Should allocate fip_count floating IPs."
  }

  assert {
    condition     = openstack_networking_floatingip_v2.this[0].pool == "public"
    error_message = "Floating IPs should be allocated from the requested pool."
  }

  assert {
    condition     = length(openstack_networking_floatingip_associate_v2.this) == 0
    error_message = "No associations should be created when port_ids is empty."
  }
}

run "associates_ports" {
  command = plan

  variables {
    pool      = "public"
    fip_count = 2
    port_ids  = ["port-a", "port-b"]
  }

  assert {
    condition     = length(openstack_networking_floatingip_associate_v2.this) == 2
    error_message = "One association should be created per supplied port."
  }

  assert {
    condition     = openstack_networking_floatingip_associate_v2.this[0].port_id == "port-a"
    error_message = "Association should target the supplied port by index."
  }
}

run "respects_description" {
  command = plan

  variables {
    pool        = "public"
    fip_count   = 1
    description = "ingress"
  }

  assert {
    condition     = openstack_networking_floatingip_v2.this[0].description == "ingress"
    error_message = "Floating IP should carry the provided description."
  }
}
