
locals {
  yaml_data = yamldecode(file("config.yaml"))
  env_data  = lookup(local.yaml_data.environments, var.environment, {})

  ## VPC
  cidr              = local.env_data.cidr
  zones_numbers     = local.env_data.zones_numbers
  cidr_subnet_bits  = local.env_data.cidr_subnet_bits
  high_availability = local.env_data.high_availability
}

module "vpc" {
  source            = "./modules/vpc"
  cidr              = local.cidr
  zones_numbers     = local.zones_numbers
  cidr_subnet_bits  = local.cidr_subnet_bits
  high_availability = local.high_availability
}
