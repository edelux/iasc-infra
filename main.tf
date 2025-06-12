
module "vpc" {
  source            = "./modules/vpc"
  cidr              = local.cidr
  project           = local.project
  zones_numbers     = local.zones_numbers
  cidr_subnet_bits  = local.cidr_subnet_bits
  high_availability = local.high_availability
}

module "zones" {
  source      = "./modules/zones"
  domain      = local.domain
  vpc_id      = module.vpc.vpc_id
  zone_id     = data.aws_route53_zone.parent.zone_id
  environment = var.environment
}

module "ec2" {
  source            = "./modules/ec2"
  name              = local.name
  size              = local.size
  type              = local.type
  distro            = local.distro
  wakeup            = local.wakeup
  domain            = local.domain
  ssh_keys          = local.ssh_keys
  vpc_id            = module.vpc.vpc_id
  ip_access_allow   = local.ip_access_allow
  domain_zone_id    = module.zones.domain_zone_id
  public_zone_id    = module.zones.public_zone_id
  public_subnet_ids = module.vpc.public_subnet_ids
}
