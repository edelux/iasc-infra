
resource "aws_iam_role" "cert_manager_iam_role" {
  name = "${module.eks.cluster_name}-cert-manager"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = module.eks.oidc_provider_arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        "StringEquals" = {
          "${module.eks.oidc_provider}:sub" = "system:serviceaccount:cert-manager:cert-manager"
        }
      }
    }]
  })
}

resource "aws_iam_policy" "cert_manager_acm_policy" {
  name        = "cert-manager-acm-policy"
  path        = "/"
  description = "IAM policy for cert-manager to use AWS ACM"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["acm:RequestCertificate", "acm:DescribeCertificate", "acm:ListCertificates", "acm:DeleteCertificate"]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cert_manager_acm_attach" {
  policy_arn = aws_iam_policy.cert_manager_acm_policy.arn
  role       = aws_iam_role.cert_manager_iam_role.name
}
