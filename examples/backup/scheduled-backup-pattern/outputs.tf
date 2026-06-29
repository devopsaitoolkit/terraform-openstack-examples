output "script_path" {
  description = "Absolute path of the generated backup wrapper script."
  value       = var.script_path
}

output "cron_line" {
  description = "Suggested crontab line wiring the schedule to the generated script."
  value       = "${var.schedule} ${var.script_path}"
}
