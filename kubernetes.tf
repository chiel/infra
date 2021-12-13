resource "digitalocean_kubernetes_cluster" "main" {
  name    = "main"
  region  = "ams3"
  version = "1.21.5-do.0"

  node_pool {
    name       = "main-nodes"
    size       = "s-1vcpu-2gb"
    node_count = 2
  }
}

resource "kubernetes_cluster_role" "deployer" {
  metadata {
    name = "deployer"

    labels = {
      "app.kubernetes.io/managed-by" : "terraform"
      "app.kubernetes.io/name" : "deployer"
    }
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps", "secrets", "services"]
    verbs      = ["create", "get", "patch", "update"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["deployments"]
    verbs      = ["create", "get", "patch", "update"]
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["networkpolicies", "ingresses"]
    verbs      = ["create", "get", "patch", "update"]
  }
}

resource "kubernetes_default_service_account" "default" {
  metadata {
    namespace = "default"

    labels = {
      "app.kubernetes.io/managed-by" : "terraform"
    }
  }

  automount_service_account_token = false
}

resource "kubernetes_network_policy" "default_deny_all" {
  metadata {
    name      = "deny-all"
    namespace = "default"

    labels = {
      "app.kubernetes.io/managed-by" : "terraform"
      "app.kubernetes.io/name" : "deny-all"
    }
  }

  spec {
    pod_selector {}
    policy_types = ["Egress", "Ingress"]
  }
}
