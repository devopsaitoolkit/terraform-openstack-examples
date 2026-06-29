output "quota_id" {
  description = "Resource ID of the managed block storage quotaset (matches the project ID)."
  value       = openstack_blockstorage_quotaset_v3.this.id
}

output "project_id" {
  description = "Project (tenant) ID the block storage quota applies to."
  value       = openstack_blockstorage_quotaset_v3.this.project_id
}

output "volumes" {
  description = "Configured maximum number of volumes."
  value       = openstack_blockstorage_quotaset_v3.this.volumes
}

output "snapshots" {
  description = "Configured maximum number of snapshots."
  value       = openstack_blockstorage_quotaset_v3.this.snapshots
}

output "gigabytes" {
  description = "Configured maximum total volume storage in GB."
  value       = openstack_blockstorage_quotaset_v3.this.gigabytes
}

output "per_volume_gigabytes" {
  description = "Configured maximum size of any single volume in GB."
  value       = openstack_blockstorage_quotaset_v3.this.per_volume_gigabytes
}

output "backups" {
  description = "Configured maximum number of backups."
  value       = openstack_blockstorage_quotaset_v3.this.backups
}

output "backup_gigabytes" {
  description = "Configured maximum total backup storage in GB."
  value       = openstack_blockstorage_quotaset_v3.this.backup_gigabytes
}
