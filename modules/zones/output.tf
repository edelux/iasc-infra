
output "zone_id" {
  description = "route53 zone ID"
  value       = module.zones.route53_zone_zone_id
}

output "zone_name" {
  description = "route53 zone Name"
  value       = module.zones.route53_zone_name
}

output "zone_arn" {
  description = "route53 zone arn"
  value       = module.zones.route53_zone_zone_arn
}
