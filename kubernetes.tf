resource "digitalocean_kubernetes_cluster" "main" {
  name    = "main"
  region  = "ams3"
  version = "1.21.3-do.0"

  node_pool {
    name       = "main-nodes"
    size       = "s-1vcpu-2gb"
    node_count = 2
  }
}
