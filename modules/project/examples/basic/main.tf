module "project" {
  source = "../.."

  name        = "example-research"
  description = "Example research sandbox project"
  enabled     = true
  tags        = ["managed-by:terraform", "example:project-module"]
}
