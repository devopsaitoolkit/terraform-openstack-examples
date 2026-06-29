output "image_id" {
  description = "UUID of the created image."
  value       = module.image.image_id
}

output "image_name" {
  description = "Name of the created image."
  value       = module.image.image_name
}
