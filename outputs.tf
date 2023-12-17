output "app_user" {
  value = linux_user.app
}

output "app_group" {
  value = linux_group.app
}

output "host" {
  value = docker_container.server.hostname
}

output "port" {
  value = var.port
}
