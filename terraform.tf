terraform {
  required_version = ">= 1.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.12.1"
    }
    github = {
      source  = "integrations/github"
      version = "4.16.0"
    }
  }
}
