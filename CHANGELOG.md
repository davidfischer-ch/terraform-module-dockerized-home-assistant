# Changelog


## Release v1.0.4 (2026-11-19)

Diff: https://github.com/davidfischer-ch/terraform-module-dockerized-home-assistant/compare/1.0.3...1.0.4

### Features

Server:

* Add the `container_config_directory` input, where the configuration is mounted and which `CONFIG_DIRECTORY` names (default `/data/config`)

CI:

* Add CI: formatting, validation and the tests, in the GitHub workflow (with the newest Docker provider and its minimum) and in the GitLab pipeline

### Fix and enhancements

Server:

* Set `CONFIG_DIRECTORY`, which a malformed environment entry left unset
    * The container is replaced once on upgrade
    * The official image reads `/config`: set `container_config_directory = "/config"` to mount the configuration there, after checking what that directory holds

Requirements:

* Require Terraform 1.17
* Require the Docker provider 4.7.0

Docs:

* Point the README and the examples at this release


## Release v1.0.3 (2026-03-14)

### Fix and enhancements

* Reorder variables to be consistent

## Release v1.0.2 (2026-03-13)

### Fix and enhancements

* Set `enabled` default to `true`
* Refine variable descriptions, validators, and attribute ordering
* Remove redundant default values from examples and README

## Release v1.0.1 (2026-03-03)

### Features

* Add `extra_devices` variable to expose host devices to the container
* Add `extra_groups` variable to add the container user to additional groups

### Fix and enhancements

* Add `examples/default` with a minimal working configuration
* Fix copy-pasting issues
* Update README

## Release v1.0.0 (2025-01-20)

Initial release
