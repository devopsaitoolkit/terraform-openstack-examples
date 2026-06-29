mock_provider "openstack" {}

run "creates_lb_listener_and_pool" {
  command = plan

  variables {
    name          = "test-lb"
    vip_subnet_id = "subnet-123"
  }

  assert {
    condition     = openstack_lb_loadbalancer_v2.this.name == "test-lb"
    error_message = "Load balancer name should match the provided name."
  }

  assert {
    condition     = openstack_lb_loadbalancer_v2.this.vip_subnet_id == "subnet-123"
    error_message = "Load balancer VIP should be placed on the provided subnet."
  }

  assert {
    condition     = openstack_lb_listener_v2.this.protocol == "HTTP"
    error_message = "Listener protocol should default to HTTP."
  }

  assert {
    condition     = openstack_lb_listener_v2.this.protocol_port == 80
    error_message = "Listener port should default to 80."
  }

  assert {
    condition     = openstack_lb_pool_v2.this.lb_method == "ROUND_ROBIN"
    error_message = "Pool method should default to ROUND_ROBIN."
  }

  assert {
    condition     = length(openstack_lb_member_v2.this) == 0
    error_message = "No members should be created when members is empty."
  }

  assert {
    condition     = length(openstack_lb_monitor_v2.this) == 0
    error_message = "No monitor should be created when monitor is null."
  }
}

run "creates_members_and_monitor" {
  command = plan

  variables {
    name              = "test-lb"
    vip_subnet_id     = "subnet-123"
    listener_protocol = "TCP"
    listener_port     = 443
    pool_method       = "LEAST_CONNECTIONS"
    members = [
      { address = "10.0.0.11", protocol_port = 8080, subnet_id = "subnet-123" },
      { address = "10.0.0.12", protocol_port = 8080, subnet_id = "subnet-123" },
    ]
    monitor = {
      type        = "HTTP"
      delay       = 5
      timeout     = 3
      max_retries = 3
      url_path    = "/healthz"
    }
  }

  assert {
    condition     = openstack_lb_listener_v2.this.protocol_port == 443
    error_message = "Listener port override should be applied."
  }

  assert {
    condition     = openstack_lb_pool_v2.this.lb_method == "LEAST_CONNECTIONS"
    error_message = "Pool method override should be applied."
  }

  assert {
    condition     = length(openstack_lb_member_v2.this) == 2
    error_message = "One member should be created per members entry."
  }

  assert {
    condition     = openstack_lb_member_v2.this["10.0.0.11:8080"].protocol_port == 8080
    error_message = "Member should carry its configured protocol_port."
  }

  assert {
    condition     = length(openstack_lb_monitor_v2.this) == 1
    error_message = "A monitor should be created when monitor is set."
  }

  assert {
    condition     = openstack_lb_monitor_v2.this[0].url_path == "/healthz"
    error_message = "Monitor should carry its configured url_path."
  }
}
