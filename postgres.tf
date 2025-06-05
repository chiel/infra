resource "digitalocean_database_cluster" "kunkels_postgres" {
  name       = "kunkels-postgres"
  engine     = "pg"
  version    = "17"
  size       = "db-s-1vcpu-1gb"
  region     = "ams3"
  node_count = 1
}
