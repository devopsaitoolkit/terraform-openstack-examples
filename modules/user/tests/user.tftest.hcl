mock_provider "openstack" {}

run "creates_user_with_defaults" {
  command = plan

  variables {
    name = "ci-user"
  }

  assert {
    condition     = openstack_identity_user_v3.this.name == "ci-user"
    error_message = "User name should match the provided name."
  }

  assert {
    condition     = openstack_identity_user_v3.this.enabled == true
    error_message = "User should be enabled by default."
  }

  assert {
    condition     = openstack_identity_user_v3.this.password == null
    error_message = "Password should be null when no password is supplied."
  }

  assert {
    condition     = length(openstack_identity_role_assignment_v3.this) == 0
    error_message = "No role assignments should be created when none are requested."
  }

  assert {
    condition     = output.user_name == "ci-user"
    error_message = "user_name output should expose the user name."
  }
}

run "creates_role_assignments" {
  command = plan

  variables {
    name    = "ci-user"
    enabled = false
    role_assignments = [
      { role_name = "member", project_id = "p1" },
      { role_name = "reader", project_id = "p1" },
    ]
  }

  assert {
    condition     = openstack_identity_user_v3.this.enabled == false
    error_message = "User should honor enabled = false."
  }

  assert {
    condition     = length(openstack_identity_role_assignment_v3.this) == 2
    error_message = "Expected one role assignment per requested role."
  }

  assert {
    condition     = openstack_identity_role_assignment_v3.this["member:p1"].project_id == "p1"
    error_message = "Role assignment should target the requested project."
  }
}
