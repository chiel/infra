module "ashesdb" {
  source = "github.com/ashesdb/ashesdb/terraform"

  providers = {
    digitalocean = digitalocean
    github       = github.ashesdb
  }

  ghcr_token = var.ASHESDB_GHCR_TOKEN
  ghcr_user  = var.ASHESDB_GHCR_USER
  ingress_ip = data.kubernetes_service.nginx_ingress_controller.status[0].load_balancer[0].ingress[0].ip
  kube_host  = digitalocean_kubernetes_cluster.main.endpoint
}

module "site" {
  source = "github.com/chiel/site/terraform"

  providers = {
    digitalocean = digitalocean
    github       = github
  }

  ghcr_token = var.SITE_GHCR_TOKEN
  ghcr_user  = var.SITE_GHCR_USER
  ingress_ip = data.kubernetes_service.nginx_ingress_controller.status[0].load_balancer[0].ingress[0].ip
  kube_host  = digitalocean_kubernetes_cluster.main.endpoint
}
