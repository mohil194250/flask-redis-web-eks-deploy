data "tls_certificate" "tls_cert" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.tls_cert.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.oidc_provider.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.oidc_provider.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "eks_iam_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  name               = "irsa_eks"
}

#resource "aws_iam_role_policy_attachment" "iam-policy-attach" {
#  role       = aws_iam_role.eks_iam_role.name
#  policy_arn = aws_iam_policy.alb_ingress_controller_iam_policy.arn
#}
