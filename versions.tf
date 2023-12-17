terraform {
  required_version = ">= 1.6"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 3.0.2"
    }

    linux = {
      source  = "mavidser/linux"
      version = ">= 1.0.2"
    }
  }
}
