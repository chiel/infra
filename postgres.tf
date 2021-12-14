resource "digitalocean_database_cluster" "kunkels_postgres" {
  name       = "kunkels-postgres"
  engine     = "pg"
  version    = "12"
  size       = "db-s-1vcpu-1gb"
  region     = "ams3"
  node_count = 1
}

resource "digitalocean_database_firewall" "kunkels_postgres" {
  cluster_id = digitalocean_database_cluster.kunkels_postgres.id

  rule {
    type  = "k8s"
    value = digitalocean_kubernetes_cluster.main.id
  }

  # temporary, needs to removed when the old cluster is destroyed
  rule {
    type  = "k8s"
    value = "ee2462af-d170-47ee-a2fd-173cd446509f"
  }

  dynamic "rule" {
    for_each = var.POSTGRES_IP_WHITELIST
    content {
      type  = "ip_addr"
      value = rule.value
    }
  }
}
