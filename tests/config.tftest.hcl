mock_provider "docker" {}

variables {
  identifier     = "home-assistant"
  image_id       = "sha256:0123456789abcdef"
  data_directory = "/data/home-assistant"
}

run "config_directory_reaches_the_image" {
  command = plan

  assert {
    condition = contains(docker_container.server.env, "CONFIG_DIRECTORY=/data/config")
    error_message = join(" ", [
      "CONFIG_DIRECTORY must be set, as NAME=VALUE,",
      "to where the configuration is mounted.",
    ])
  }
}

run "config_directory_is_mounted_where_the_image_reads_it" {
  command = plan

  variables {
    container_config_directory = "/config"
  }

  assert {
    condition     = contains(docker_container.server.env, "CONFIG_DIRECTORY=/config")
    error_message = "CONFIG_DIRECTORY must follow `container_config_directory`."
  }

  assert {
    condition = contains([
      for volume in docker_container.server.volumes : "${volume.host_path}:${volume.container_path}"
    ], "/data/home-assistant/config:/config")
    error_message = "The configuration must be mounted at `container_config_directory`."
  }
}
