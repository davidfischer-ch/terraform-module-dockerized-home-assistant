variable "identifier" {
  type        = string
  description = "Identifier (must be unique, used to name resources)."

  validation {
    condition     = regex("^[a-z]+(-[a-z0-9]+)*$", var.identifier) != null
    error_message = "Argument `identifier` must match regex ^[a-z]+(-[a-z0-9]+)*$."
  }
}

variable "enabled" {
  type        = bool
  description = "Toggle the containers (started or stopped)."
  default     = true
}

variable "image_id" {
  type        = string
  description = "Home Assistant image's ID."
}

# Devices ------------------------------------------------------------------------------------------

variable "extra_devices" {
  type = map(object({
    container_path = string
    host_path      = string
    permissions    = string
  }))
  description = "Extra devices to expose to the container (e.g. USB, serial)."
  default     = {}
}

variable "extra_groups" {
  type        = set(string)
  description = "Additional groups for the container user."
  default     = []
}

# Networking ---------------------------------------------------------------------------------------

variable "hosts" {
  type        = map(string)
  description = "Add entries to container hosts file."
  default     = {}
}

variable "port" {
  type        = number
  description = "Bind the Home Assistant HTTP port."
  default     = 8123

  validation {
    condition     = var.port == 8123
    error_message = "Having `port` different than 8123 is not yet implemented."
  }
}

# Storage ------------------------------------------------------------------------------------------

variable "data_directory" {
  type        = string
  description = "Where data will be persisted (volumes will be mounted as sub-directories)."
}

variable "extra_volumes" {
  type = map(object({
    container_path = optional(string)
    from_container = optional(string)
    host_path      = optional(string)
    read_only      = optional(bool)
    volume_name    = optional(string)
  }))
  description = "Extra volumes to mount in the container."
  default     = {}
}
