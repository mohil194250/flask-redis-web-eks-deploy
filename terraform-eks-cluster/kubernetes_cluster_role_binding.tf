resource "kubernetes_cluster_role_binding" "alb-ingress" {
  metadata {
    name = "alb-ingress-controller"
    labels = {
      "app.kubernetes.io/name" = "alb-ingress-controller"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "alb-ingress-controller"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "alb-ingress-controller"
    namespace = "kube-system"
  }
}
