
locals {
  yaml_data = yamldecode(file("config.yaml"))
  env_data  = lookup(local.yaml_data.environments, var.environment, {})

  ## Cloud Provider
  provider   = local.env_data.cloud.provider
  region     = local.env_data.cloud.region
  account_id = local.env_data.cloud.account_id

  ## VPC
  cidr              = local.env_data.networking.cidr
  zones_numbers     = local.env_data.networking.zones_numbers
  cidr_subnet_bits  = local.env_data.networking.cidr_subnet_bits
  high_availability = local.env_data.networking.high_availability

  ## route53 domain
  domain = local.yaml_data.domain

  ## Security
  ip_access_allow = local.env_data.security.ip_access_allow
  ssh_keys        = local.env_data.security.ssh_keys

  ## ec2
  name = local.env_data.hosts.name
  wakeup   = local.env_data.hosts.wakeup
  type     = local.env_data.hosts.type
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
  name              = local.name
  type              = local.type
  wakeup            = local.wakeup
  domain            = local.domain
  ssh_keys          = local.ssh_keys
  vpc_id            = module.vpc.vpc_id
  ip_access_allow   = local.ip_access_allow
  domain_zone_id    = module.zones.domain_zone_id
  public_zone_id    = module.zones.public_zone_id
  public_subnet_ids = module.vpc.public_subnet_ids
}
