resource "kubernetes_service_account" "alb-ingress" {
  metadata {
    name = "alb-ingress-controller"
    namespace = "kube-system"
    labels = {
      "app.kubernetes.io/name" = "alb-ingress-controller"
      "app.kubernetes.io/component" = "controller"
    }
    #annotations = {
    #     "eks.amazonaws.com/role-arn" = aws_iam_role.eks_iam_role.arn
    #}
 }
  automount_service_account_token = true
}
