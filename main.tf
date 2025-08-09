resource "docker_container" "server" {

  image = var.image_id
  name  = var.identifier

  must_run = var.enabled
  start    = var.enabled
  restart  = "always"
  # wait   = true

  # shm_size = 256 # MB

  env = [
    "CONFIG_DIRECTORY '${local.container_config_directory}'"
  ]

  dynamic "host" {
    for_each = var.hosts
    content {
      host = host.key
      ip   = host.value
    }
  }

  hostname = var.identifier

  network_mode = "host"

  dynamic "devices" {
    for_each = var.extra_devices
    content {
      container_path = volumes.value.container_path
      host_path      = volumes.value.host_path
      permissions    = volumes.value.permissions
    }
  }

  volumes {
    container_path = local.container_config_directory
    host_path      = local.host_config_directory
    read_only      = false
  }

  dynamic "volumes" {
    for_each = var.extra_volumes
    content {
      container_path = volumes.value.container_path
      host_path      = volumes.value.host_path
      read_only      = volumes.value.read_only
    }
  }

  /* TODO Setup log file mapping (later...) /config/home-assistant.log -> /logs/home-assistant.log

  volumes {
    container_path = local.container_log_filename
    host_path      = local.host_log_filename
    read_only      = false
  } */
}
