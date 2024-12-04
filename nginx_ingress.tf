resource "kubernetes_namespace" "ingress" {
  metadata {
    name = "ingress"

    labels = {
      "app.kubernetes.io/name" : "ingress"
    }
  }
}

resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.11.3"
  namespace  = kubernetes_namespace.ingress.metadata[0].name
}
