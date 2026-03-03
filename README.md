# Home Assistant Terraform Module (Dockerized)

Manage Home Assistant.

* Runs in host networking mode (required for device discovery and mDNS)
* Persists configuration directory
* Supports extra devices, groups, and volume mounts

## Usage

See [examples/default](examples/default) for a complete working configuration.

```hcl
module "home_assistant" {
  source = "git::https://github.com/davidfischer-ch/terraform-module-dockerized-home-assistant.git?ref=1.0.1"

  identifier     = "home-assistant"
  enabled        = true
  image_id       = docker_image.home_assistant.image_id
  data_directory = "/data/home-assistant"

  extra_devices = {
    zigbee_dongle = {
      container_path = "/dev/serial/by-id/usb-dongle"
      host_path      = "/dev/serial/by-id/usb-dongle"
      permissions    = "rwm"
    }
  }

  extra_groups = ["dialout"]
}
```

## Data layout

All persistent data lives under `data_directory`:

```
data_directory/
└── config/  # Home Assistant configuration
```

## Variables

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `identifier` | `string` | — | Unique name for resources (must match `^[a-z]+(-[a-z0-9]+)*$`). |
| `enabled` | `bool` | — | Start or stop the container. |
| `image_id` | `string` | — | [Home Assistant](https://hub.docker.com/r/homeassistant/home-assistant/tags) Docker image's ID. |
| `data_directory` | `string` | — | Host path for persistent volumes. |
| `extra_devices` | `map(object)` | `{}` | Devices to expose to the container. |
| `extra_groups` | `set(string)` | `[]` | Additional groups for the container user. |
| `hosts` | `map(string)` | `{}` | Extra `/etc/hosts` entries for the container. |
| `port` | `number` | `8123` | Home Assistant port (changing not yet implemented). |
| `extra_volumes` | `map(object)` | `{}` | Extra volumes to mount. |

## Outputs

| Name | Description |
|------|-------------|
| `host` | Container hostname. |
| `port` | Home Assistant port. |

## Requirements

* Terraform >= 1.6
* [kreuzwerker/docker](https://github.com/kreuzwerker/terraform-provider-docker) >= 3.0.2

## References

* https://github.com/home-assistant/core/tags
* https://hub.docker.com/r/homeassistant/home-assistant/tags
* https://www.home-assistant.io/installation/linux#install-home-assistant-container
* https://github.com/davidfischer-ch/ansible-role-home-assistant
