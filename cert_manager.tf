resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"

    labels = {
      "app.kubernetes.io/name" : "cert-manager"
    }
  }
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.16.2"
  namespace  = kubernetes_namespace.cert_manager.metadata[0].name

  set {
    name  = "crds.enabled"
    value = "true"
  }
}

resource "helm_release" "issuers" {
  name      = "issuers"
  chart     = "./helm/issuers"
  namespace = helm_release.cert_manager.namespace

  set {
    name  = "email"
    value = var.EMAIL
  }
}
