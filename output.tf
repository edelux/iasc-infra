
## VPC
output "region" {
  description = "Region"
  value       = var.region
}

output "vpc_id" {
  description = "VPC ID Created"
  value       = module.vpc.vpc_id
}

output "vpc_arn" {
  description = "VPC ARN"
  value       = module.vpc.vpc_arn
}

output "vpc_name" {
  description = "VPC Name"
  value       = module.vpc.vpc_name
}

output "availability_zones" {
  description = "Availability Zones List"
  value       = module.vpc.availability_zones
}

output "private_subnet_ids" {
  description = "Private Subnets list"
  value       = module.vpc.private_subnet_ids
}

output "private_subnet_arns" {
  description = "Private Subnets ARNs list"
  value       = module.vpc.private_subnet_arns
}

output "private_subnet_cidrs" {
  description = "Private Subnets CIDR list"
  value       = module.vpc.private_subnet_cidrs
}

output "public_subnet_ids" {
  description = "Public Subnets list"
  value       = module.vpc.public_subnet_ids
}

output "public_subnet_arns" {
  description = "Public Subnets ARNs list"
  value       = module.vpc.public_subnet_arns
}

output "public_subnet_cidrs" {
  description = "Public Subnets CIDR list"
  value       = module.vpc.public_subnet_cidrs
}

output "database_subnet_ids" {
  description = "Database Subnets list"
  value       = module.vpc.database_subnet_ids
}

output "database_subnet_arns" {
  description = "Database Subnets ARNs list"
  value       = module.vpc.database_subnet_arns
}

output "database_subnet_cidrs" {
  description = "Database Subnets CIDR list"
  value       = module.vpc.database_subnet_cidrs
}

## route53 zones
output "parent_zone_id" {
  description = "route53 zone ID for domain"
  value       = module.zones.parent_zone_id
}

output "parent_zone_arn" {
  description = "route53 zone ARN for domain"
  value       = module.zones.parent_zone_arn
}

output "parent_zone_name" {
  description = "route53 zone Name for domain"
  value       = module.zones.parent_zone_name
}

output "domain_zone_id" {
  description = "route53 zone ARN for subdomain"
  value       = module.zones.domain_zone_id
}

output "domain_zone_name" {
  description = "route53 zone Name for domain"
  value       = module.zones.domain_zone_name
}

output "domain_zone_arn" {
  description = "route53 zone ARN for domain"
  value       = module.zones.domain_zone_arn
}

output "delegation_set_id" {
  description = "Delegation Set ID"
  value       = module.zones.delegation_set_id
}

output "delegation_set_info" {
  description = "Delegation Set complete information"
  value       = module.zones.delegation_set_info
}

output "delegation_set_name_servers" {
  description = "Delegation Set complete information"
  value       = module.zones.delegation_set_name_servers
}

output "zone_ids" {
  value = module.zones.route53_zone_zone_id
}

## ec2
output "bastion_public_dns" {
  description = "Public DNS of the Bastion Host"
  value       = module.ec2.public_dns
}

output "bastion_private_dns" {
  description = "Private DNS of the Bastion Host"
  value       = module.ec2.private_dns
}

output "bastion_public_ip" {
  description = "Public IP of the Bastion Host"
  value       = module.ec2.public_ip
}

output "bastion_private_ip" {
  description = "Private IP of the Bastion Host"
  value       = module.ec2.private_ip
}
