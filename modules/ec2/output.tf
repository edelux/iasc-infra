
output "bastion_public_dns" {
  value = module.ec2.public_dns
}

output "bastion_private_dns" {
  value = module.ec2.private_dns
}

output "bastion_public_ip" {
  value = module.ec2.public_ip
}

output "bastion_private_ip" {
  value = module.ec2.private_ip
}
