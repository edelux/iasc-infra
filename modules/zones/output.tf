
output "parent_zone_id" {
  description = "route53 parent domain zone ID"
  value       = data.aws_route53_zone.parent.zone_id
}

output "parent_zone_arn" {
  description = "route53 parent domain zone ARN"
  value       = "arn:aws:route53:::hostedzone/${data.aws_route53_zone.parent.zone_id}"
}

output "parent_zone_name" {
  description = "route53 parent domain zone Name"
  value       = data.aws_route53_zone.parent.name
}

output "domain_zone_id" {
  description = "route53 zone ID"
  value       = module.zones.route53_zone_zone_id
}

output "domain_zone_name" {
  description = "route53 zone Name"
  value       = module.zones.route53_zone_name
}

output "domain_zone_arn" {
  description = "route53 zone arn"
  value       = module.zones.route53_zone_zone_arn
}

output "delegation_set_id" {
  description = "Delegation Set ID"
  value       = module.delegation_set.route53_delegation_set_id
}

output "delegation_set_info" {
  description = "Delegation Set complete information"
  value       = jsonencode(module.delegation_set)
}

output "delegation_set_name_servers" {
  description = "Name servers from the delegation set"
  value       = module.delegation_set.route53_delegation_set_name_servers["global"]
}
