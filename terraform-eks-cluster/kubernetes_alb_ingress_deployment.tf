resource "kubernetes_deployment" "alb-ingress" {
  wait_for_rollout = false
  metadata {
    name = "alb-ingress-controller"
    labels = {
      "app.kubernetes.io/name" = "alb-ingress-controller"
    }
    namespace = "kube-system"
  }

  spec {
    selector {
      match_labels = {
        "app.kubernetes.io/name" = "alb-ingress-controller"
      }
    }

    template {
      metadata {
        labels = {
          "app.kubernetes.io/name" = "alb-ingress-controller"
        }
      }
      spec {
        volume {
          name = kubernetes_service_account.alb-ingress.default_secret_name
          secret {
            secret_name = kubernetes_service_account.alb-ingress.default_secret_name
          }
        }
        container {
          # This is where you change the version when Amazon comes out with a new version of the ingress controller
          image = "docker.io/amazon/aws-alb-ingress-controller:v1.1.4"
          name  = "alb-ingress-controller"
          args = ["--ingress-class=alb",
            "--cluster-name=${aws_eks_cluster.eks.name}",
            "--aws-vpc-id=${aws_vpc.vpc.id}",
            "--aws-region=us-west-2"]
          volume_mount {
            name       = kubernetes_service_account.alb-ingress.default_secret_name
            mount_path = "/var/run/secrets/kubernetes.io/serviceaccount"
            read_only  = true
          }
        }
        service_account_name = "alb-ingress-controller"
      }
    }
  }
}
