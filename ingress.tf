resource "kubernetes_namespace" "ingress" {
  metadata {
    name = "ingress"

    labels = {
      "app.kubernetes.io/managed-by" : "terraform"
      "app.kubernetes.io/name" : "ingress"
    }
  }
}

resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.0.5"
  namespace  = kubernetes_namespace.ingress.metadata[0].name
}

data "kubernetes_service" "nginx_ingress_controller" {
  metadata {
    name      = "${helm_release.ingress_nginx.name}-controller"
    namespace = kubernetes_namespace.ingress.metadata[0].name
  }
}
