
output "public_dns" {
  value = module.ec2.public_dns
}

output "private_dns" {
  value = module.ec2.private_dns
}

output "public_ip" {
  value = module.ec2.public_ip
}

output "private_ip" {
  value = module.ec2.private_ip
}
