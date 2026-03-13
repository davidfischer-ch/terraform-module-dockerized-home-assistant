output "host" {
  description = "Hostname of the Home Assistant container."
  value       = docker_container.server.hostname
}

output "port" {
  description = "HTTP port bound by Home Assistant."
  value       = var.port
}
