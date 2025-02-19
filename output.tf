
## VPC
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

# Outputs de Subnets Privadas
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

# Outputs de Subnets Públicas
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

# Outputs de Subnets de Base de Datos
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
