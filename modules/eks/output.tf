
output "oidc_provider" {
  description = "OpenID Connect provider"
  value       = module.eks.oidc_provider
}

output "oidc_provider_arn" {
  description = "OpenID Connect provider ARN"
  value       = module.eks.oidc_provider_arn
}

output "cluster_id" {
  description = "The ID of the EKS cluster"
  value       = module.eks.cluster_id
}

output "cluster_arn" {
  description = "The ARN of the EKS cluster"
  value       = module.eks.cluster_arn
}

output "cluster_name" {
  description = "Nmame of the EKS cluster"
  value       = module.eks.cluster_name
}

output "cluster_addons" {
  description = " List of the addons enabled on cluster"
  value       = module.eks.cluster_addons
}

output "cluster_endpoint" {
  description = "The API server endpoint of the Kubernetes cluster"
  value       = module.eks.cluster_endpoint
}

output "cluster_version" {
  description = "The Kubernetes version of the cluster"
  value       = module.eks.cluster_version
}

output "cluster_oidc_issuer_url" {
  description = "The OIDC provider URL of the cluster"
  value       = module.eks.cluster_oidc_issuer_url
}

output "cluster_service_cidr" {
  description = "Cluster Service CIDR"
  value       = module.eks.cluster_service_cidr
}

output "aws_lb_controller_role_arn" {
  value = aws_iam_role.aws_lb_controller_role.arn
}

#data "aws_lb" "argocd" {
#  name = module.argocd.lb_name
#}
#
#output "lb_dns_name" {
#  value = data.aws_lb.argocd.dns_name
#}
#
#output "lb_zone_id" {
#  value = data.aws_lb.argocd.zone_id
#}
