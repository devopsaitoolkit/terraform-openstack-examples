# Register an EXISTING public key. We deliberately do NOT use a tls_private_key
# resource: that would write the private key into Terraform state in plaintext.
# By supplying only the public half, the secret never enters state, plan output,
# or version control.
resource "openstack_compute_keypair_v2" "managed" {
  name       = var.keypair_name
  public_key = var.public_key
}
