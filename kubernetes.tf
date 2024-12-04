resource "digitalocean_kubernetes_cluster" "default" {
  name    = "default"
  region  = "ams3"
  version = "1.31.1-do.4"

  node_pool {
    name       = "default-nodes"
    size       = "s-1vcpu-2gb"
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 3
  }
}

resource "kubernetes_default_service_account" "default" {
  metadata {
    namespace = "default"
  }

  automount_service_account_token = false
}
