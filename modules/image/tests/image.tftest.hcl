mock_provider "openstack" {}

run "creates_image_with_defaults" {
  command = plan

  variables {
    name             = "test-image"
    image_source_url = "https://example.com/disk.qcow2"
  }

  assert {
    condition     = openstack_images_image_v2.this.name == "test-image"
    error_message = "Image name should match the provided name."
  }

  assert {
    condition     = openstack_images_image_v2.this.container_format == "bare"
    error_message = "container_format should default to bare."
  }

  assert {
    condition     = openstack_images_image_v2.this.disk_format == "qcow2"
    error_message = "disk_format should default to qcow2."
  }

  assert {
    condition     = openstack_images_image_v2.this.visibility == "private"
    error_message = "visibility should default to private."
  }

  assert {
    condition     = openstack_images_image_v2.this.protected == false
    error_message = "protected should default to false."
  }

  assert {
    condition     = output.image_name == "test-image"
    error_message = "image_name output should expose the image name."
  }
}

run "honors_overrides_and_properties" {
  command = plan

  variables {
    name             = "raw-image"
    image_source_url = "http://mirror.local/disk.raw"
    disk_format      = "raw"
    visibility       = "shared"
    protected        = true
    min_disk_gb      = 10
    min_ram_mb       = 2048
    properties       = { os_distro = "centos" }
    tags             = ["a", "b"]
  }

  assert {
    condition     = openstack_images_image_v2.this.disk_format == "raw"
    error_message = "disk_format override should be applied."
  }

  assert {
    condition     = openstack_images_image_v2.this.protected == true
    error_message = "protected override should be applied."
  }

  assert {
    condition     = openstack_images_image_v2.this.min_disk_gb == 10
    error_message = "min_disk_gb override should be applied."
  }

  assert {
    condition     = openstack_images_image_v2.this.properties["os_distro"] == "centos"
    error_message = "Custom image properties should be passed through."
  }
}
