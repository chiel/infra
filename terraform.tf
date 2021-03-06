terraform {
  required_version = ">= 1.0.9"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.12.1"
    }
    github = {
      source  = "integrations/github"
      version = "4.16.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.5.0"
    }
  }
}
