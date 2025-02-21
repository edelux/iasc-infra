
module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = "${terraform.workspace}-eks"
  cluster_version = var.cluster_version

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnet_ids
  control_plane_subnet_ids = var.private_subnet_ids

  enable_irsa                          = true
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = var.myips

  eks_managed_node_groups = {
    default = {
      desired_size = var.cluster_desired_nodes
      min_size     = var.cluster_min_nodes
      max_size     = var.cluster_max_nodes

      instance_types = ["t3a.medium", "t2.medium", "t3.medium"]
      capacity_type  = "ON_DEMAND"
      subnet_ids     = var.private_subnet_ids
    }
  }
  tags = {
    Terraform   = "true"
    Environment = terraform.workspace
  }
}
