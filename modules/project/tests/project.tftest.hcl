mock_provider "openstack" {}

run "creates_project" {
  command = plan

  variables {
    name        = "research"
    description = "Research sandbox"
    tags        = ["team:research"]
  }

  assert {
    condition     = output.project_name == "research"
    error_message = "project_name output should equal var.name."
  }

  assert {
    condition     = openstack_identity_project_v3.this.enabled == true
    error_message = "Project should be enabled by default."
  }
}

run "can_be_disabled" {
  command = plan

  variables {
    name    = "archived"
    enabled = false
  }

  assert {
    condition     = openstack_identity_project_v3.this.enabled == false
    error_message = "enabled = false should disable the project."
  }
}
