
module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name           = "${terraform.workspace}-eks"
  cluster_version        = var.cluster_version
  cluster_upgrade_policy = "standard"

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnet_ids
  control_plane_subnet_ids = var.private_subnet_ids

  enable_irsa                          = true
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = length(trimspace(var.allowed_ips)) > 0 ? split(",", trimspace(var.allowed_ips)) : []

  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    coredns                      = { addon_version = "v1.11.4-eksbuild.2" }
    kube-proxy                   = { addon_version = "v1.32.0-eksbuild.2" }
    aws-ebs-csi-driver           = { addon_version = "v1.39.0-eksbuild.1" }
    aws-efs-csi-driver           = { addon_version = "v2.1.4-eksbuild.1" }
    aws-mountpoint-s3-csi-driver = { addon_version = "v1.11.0-eksbuild.1" }
  }

  eks_managed_node_groups = {
    default = {
      desired_size = var.cluster_desired_nodes
      min_size     = var.cluster_min_nodes
      max_size     = var.cluster_max_nodes

      instance_types = ["t3a.medium", "t3.medium", "t2.medium"]
      capacity_type  = "ON_DEMAND"
      subnet_ids     = var.private_subnet_ids
    }
  }

  tags = {
    Terraform   = "true"
    Environment = terraform.workspace
  }
}
