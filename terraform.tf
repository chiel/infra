terraform {
  required_version = ">= 1.10.1"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.45.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.4.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.16.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.34.0"
    }
  }
}
