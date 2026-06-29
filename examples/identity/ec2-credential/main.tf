# An EC2 credential issues an AWS-style (access key, secret key) pair for the
# user/project. It is what you use for S3-compatible tooling against Swift (the
# Swift S3 API / "ec2" auth), or anything expecting AWS Signature v2/v4 creds.
#
# With no user_id/project_id it is created for the authenticated user/project
# (no admin needed). Targeting a different user/project requires admin.
resource "openstack_identity_ec2_credential_v3" "ec2" {
  user_id    = var.user_id != "" ? var.user_id : null
  project_id = var.project_id != "" ? var.project_id : null
}
