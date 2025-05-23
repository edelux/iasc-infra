
locals {
  yaml_data = yamldecode(file("config.yaml"))
  env_data  = lookup(local.yaml_data.environments, var.environment, {})

  ## VPC
  cidr              = local.env_data.cidr
  zones_numbers     = local.env_data.zones_numbers
  ip_access_allow   = local.env_data.ip_access_allow
  cidr_subnet_bits  = local.env_data.cidr_subnet_bits
  high_availability = local.env_data.high_availability

  ## ec2
  ssh_keys = local.env_data.ssh_keys
  type     = local.env_data.instance-type
  wakeup   = local.env_data.instance-wakeup

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

module "zones" {
  source      = "./modules/zones"
  domain      = local.domain
  vpc_id      = module.vpc.vpc_id
  environment = var.environment
}

module "ec2" {
  source            = "./modules/ec2"
  type              = local.type
  wakeup            = local.wakeup
  domain            = local.domain
  ssh_keys          = local.ssh_keys
  vpc_id            = module.vpc.vpc_id
  ip_access_allow   = local.ip_access_allow
  public_zone_id    = module.zones.public_zone_id
  public_subnet_ids = module.vpc.public_subnet_ids
}
