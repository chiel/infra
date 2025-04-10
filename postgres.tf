resource "digitalocean_database_cluster" "kunkels_postgres" {
  name       = "kunkels-postgres"
  engine     = "pg"
  version    = "17"
  size       = "db-s-1vcpu-1gb"
  region     = "ams3"
  node_count = 1
}

resource "digitalocean_database_firewall" "kunkels_postgres" {
  cluster_id = digitalocean_database_cluster.kunkels_postgres.id

  rule {
    type  = "k8s"
    value = digitalocean_kubernetes_cluster.default.id
  }

  dynamic "rule" {
    for_each = var.POSTGRES_IP_ALLOWLIST
    content {
      type  = "ip_addr"
      value = rule.value
    }
  }
}
