provider "digitalocean" {
  token             = var.DIGITALOCEAN_TOKEN
  spaces_access_id  = var.SPACES_ACCESS_ID
  spaces_secret_key = var.SPACES_SECRET_KEY
}

provider "github" {
  token = var.GITHUB_TOKEN
}

locals {
  kube_config = digitalocean_kubernetes_cluster.main.kube_config[0]
  kube_host   = digitalocean_kubernetes_cluster.main.endpoint
}

provider "helm" {
  kubernetes {
    host                   = local.kube_host
    token                  = local.kube_config.token
    client_certificate     = local.kube_config.client_certificate
    client_key             = local.kube_config.client_key
    cluster_ca_certificate = base64decode(local.kube_config.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = local.kube_host
  token                  = local.kube_config.token
  client_certificate     = local.kube_config.client_certificate
  client_key             = local.kube_config.client_key
  cluster_ca_certificate = base64decode(local.kube_config.cluster_ca_certificate)
}
