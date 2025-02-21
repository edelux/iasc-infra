
locals {
  yaml_data = yamldecode(file("config.yaml"))
  env_data  = lookup(local.yaml_data.environments, var.environment, {})

  ## VPC
  cidr              = local.env_data.cidr
  zones_numbers     = local.env_data.zones_numbers
  cidr_subnet_bits  = local.env_data.cidr_subnet_bits
  high_availability = local.env_data.high_availability

  ## ec2
  ssh_keys = local.env_data.ssh_keys
  power-on = local.env_data.bastion-power-on

  ## route53 domain
  domain = local.yaml_data.domain
}

module "vpc" {
  source            = "./modules/vpc"
  cidr              = local.cidr
  zones_numbers     = local.zones_numbers
  cidr_subnet_bits  = local.cidr_subnet_bits
  high_availability = local.high_availability
}

module "security" {
  source   = "./modules/security"
  vpc_cidr = local.cidr
  vpc_id   = module.vpc.vpc_id
}

module "ec2" {
  source            = "./modules/ec2"
  ssh_keys          = local.ssh_keys
  power-on          = local.power-on
  public_subnet_ids = module.vpc.public_subnet_ids
  postgresql_sg_id  = module.security.postgresql_sg_id
  ssh_sg_id         = module.security.ssh_sg_id
}

module "zones" {
  source      = "./modules/zones"
  domain      = local.domain
  environment = var.environment
}

module "eks" {
  source                = "./modules/eks"
  myips                 = var.myips
  cluster_version       = var.cluster_version
  cluster_desired_nodes = var.cluster_desired_nodes
  cluster_max_nodes     = var.cluster_max_nodes
  cluster_min_nodes     = var.cluster_min_nodes
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
}
