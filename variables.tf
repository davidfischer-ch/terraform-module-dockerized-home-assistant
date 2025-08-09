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
}

variable "image_id" {
  type        = string
  description = "Home Assistant image's ID."
}

variable "data_directory" {
  type        = string
  description = "Where data will be persisted (volumes will be mounted as sub-directories)."
}

# Devices ------------------------------------------------------------------------------------------

variable "extra_devices" {
  type = map(object({
    container_path = string
    host_path      = string
    permissions    = string
  }))
  default = {}
}

variable "extra_groups" {
  description = "Additional groups for the container user."
  type        = set(string)
  default     = []
}

# Networking ---------------------------------------------------------------------------------------

variable "hosts" {
  type        = map(string)
  default     = {}
  description = "Add entries to container hosts file."
}

variable "port" {
  type    = number
  default = 8123

  validation {
    condition     = var.port == 8123
    error_message = "Having `port` different than 8123 is not yet implemented."
  }
}

# Storage ------------------------------------------------------------------------------------------

variable "extra_volumes" {
  type = map(object({
    container_path = string
    host_path      = string
    read_only      = bool
  }))
  default = {}
}
