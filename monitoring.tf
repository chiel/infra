resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"

    labels = {
      "app.kubernetes.io/managed-by" : "terraform"
      "app.kubernetes.io/name" : "monitoring"
    }
  }
}

resource "kubernetes_secret" "grafana_admin_credentials" {
  metadata {
    name      = "grafana-admin-credentials"
    namespace = kubernetes_namespace.monitoring.metadata[0].name

    labels = {
      "app.kubernetes.io/managed-by" : "terraform"
      "app.kubernetes.io/name" : "grafana-admin-credentials"
    }
  }

  data = {
    "admin-user"     = var.GRAFANA_USERNAME
    "admin-password" = var.GRAFANA_PASSWORD
  }
}

resource "digitalocean_record" "grafana" {
  domain = "kunkels.me"
  type   = "A"
  name   = "grafana"
  value  = data.kubernetes_service.nginx_ingress_controller.status[0].load_balancer[0].ingress[0].ip
}

resource "helm_release" "kube_prometheus_stack" {
  depends_on = [
    digitalocean_record.grafana,
    helm_release.cert_manager,
    helm_release.issuers,
  ]

  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "19.0.2"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  values     = [file("./kube-prometheus-stack-values.yaml")]

  set {
    name  = "grafana.admin.existingSecret"
    value = kubernetes_secret.grafana_admin_credentials.metadata[0].name
  }
}
