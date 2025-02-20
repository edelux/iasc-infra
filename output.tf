
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

## Security Groups
output "postgresql_sg_id" {
  description = "RDS Postgres Security Group ID"
  value       = module.security.postgresql_sg_id
}

output "postgresql_sg_arn" {
  description = "RDS Postgres Security Group ARN"
  value       = module.security.postgresql_sg_arn
}

output "postgresql_sg_name" {
  description = "RDS Postgres Security Group Name"
  value       = module.security.postgresql_sg_name
}

output "ssh_sg_id" {
  description = "SSH Security Group ID"
  value       = module.security.ssh_sg_id
}

output "ssh_sg_arn" {
  description = "SSH Security Group ARN"
  value       = module.security.ssh_sg_arn
}

output "ssh_sg_name" {
  description = "SSH Security Group Name"
  value       = module.security.ssh_sg_name
}

## ec2
output "bastion_public_dns" {
  description = "Public DNS of the Bastion Host"
  value       = module.ec2.bastion_public_dns
}

output "bastion_private_dns" {
  description = "Private DNS of the Bastion Host"
  value       = module.ec2.bastion_private_dns
}

output "bastion_public_ip" {
  description = "Public IP of the Bastion Host"
  value       = module.ec2.bastion_public_ip
}

output "bastion_private_ip" {
  description = "Private IP of the Bastion Host"
  value       = module.ec2.bastion_private_ip
}
