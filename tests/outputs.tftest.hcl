mock_provider "docker" {}

variables {
  identifier     = "home-assistant"
  image_id       = "sha256:0123456789abcdef"
  data_directory = "/data/home-assistant"
}

run "outputs_describe_the_server" {
  command = plan

  assert {
    condition     = output.host == "home-assistant"
    error_message = "`host` must be the container's hostname, its identifier."
  }

  assert {
    condition     = output.port == 8123
    error_message = "`port` must be the Home Assistant HTTP port."
  }
}
