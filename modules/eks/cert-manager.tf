
resource "helm_release" "cert_manager" {
  repository       = "https://charts.jetstack.io"
  name             = "cert-manager"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  version          = "v1.17.1"
  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "extraArgs"
    value = "{--enable-certificate-owner-ref=true}"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.cert_manager_iam_role.arn
  }

  depends_on = [module.eks]
}
