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

# Daemon

# Default is an historical value on my Intel NUC while deploying Home Assistant with Ansible

variable "app_uid" {
  type    = number
  default = 997
}

variable "app_gid" {
  type    = number
  default = 997
}

# Networking

variable "port" {
  type    = number
  default = 8123

  validation {
    condition     = var.port == 8123
    error_message = "Having `port` different than 8123 is not yet implemented."
  }
}
