# TFLint configuration. Run `tflint --recursive` locally or via CI.
config {
  call_module_type = "local"
}

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}
