module "volume" {
  source = "../.."

  name         = "example-data"
  size         = 50
  volume_count = 2
  metadata     = { example = "volume-module" }
  # Set attach_to_instance_id to a real instance UUID to attach these volumes.
}
