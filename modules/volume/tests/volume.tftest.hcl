mock_provider "openstack" {}

run "creates_unattached_volumes" {
  command = plan

  variables {
    name         = "data"
    size         = 20
    volume_count = 2
  }

  assert {
    condition     = length(output.volume_ids) == 2
    error_message = "volume_count = 2 should create two volumes."
  }

  assert {
    condition     = length(output.attachment_ids) == 0
    error_message = "No attachments should be created without attach_to_instance_id."
  }

  assert {
    condition     = openstack_blockstorage_volume_v3.this[1].name == "data-2"
    error_message = "Multiple volumes should be suffixed with a 1-based index."
  }
}

run "attaches_when_instance_given" {
  command = plan

  variables {
    name                  = "data"
    size                  = 20
    volume_count          = 2
    attach_to_instance_id = "22222222-2222-2222-2222-222222222222"
  }

  assert {
    condition     = length(output.attachment_ids) == 2
    error_message = "One attachment should be created per volume when an instance is given."
  }
}
