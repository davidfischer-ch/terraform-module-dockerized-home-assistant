resource "docker_container" "server" {

  image = var.image_id
  name  = var.identifier

  must_run = var.enabled
  start    = var.enabled
  restart  = "always"
  # wait   = true

  # shm_size = 256 # MB

  hostname = var.identifier

  network_mode = "host"

  user = linux_user.app.uid

  volumes {
    container_path = local.container_config_directory
    host_path      = local.host_config_directory
    read_only      = false
  }

  # Setup config directory
  provisioner "local-exec" {
    command = <<EOT
      mkdir -p "${local.host_config_directory}"
      chown "${linux_user.app.name}:${linux_group.app.name}" "${local.host_config_directory}"
    EOT
  }
}
