resource "docker_image" "home_assistant" {
  name         = "ghcr.io/home-assistant/home-assistant:2025.1.0"
  keep_locally = true
}

module "home_assistant" {
  source = "git::https://github.com/davidfischer-ch/terraform-module-dockerized-home-assistant.git?ref=1.0.1"

  identifier = "home-assistant"
  image_id   = docker_image.home_assistant.image_id

  # Devices

  extra_devices = {
    zigbee_dongle = {
      container_path = "/dev/serial/by-id/usb-dongle"
      host_path      = "/dev/serial/by-id/usb-dongle"
      permissions    = "rwm"
    }
  }

  extra_groups = ["dialout"]

  # Storage

  data_directory = "/data/home-assistant"
}
