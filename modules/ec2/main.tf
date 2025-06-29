
module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name          = var.name
  instance_type = var.type
  create        = var.wakeup
  ami           = local.selected_ami
  subnet_id     = var.public_subnet_ids[0]
  monitoring    = true

  associate_public_ip_address = true

  root_block_device = [
    {
      volume_type           = "gp3"
      volume_size           = var.size
      delete_on_termination = true
      encrypted             = true
    }
  ]

  vpc_security_group_ids = [
    module.ssh_security_group.security_group_id,
    module.wireguard_security_group.security_group_id,
  ]

  user_data = base64encode(local.user_data)

  tags = {
    Terraform   = "true"
    Environment = terraform.workspace
  }
}

resource "aws_route53_record" "bastion" {
  count   = var.wakeup ? 1 : 0
  zone_id = var.public_zone_id
  #zone_id = var.domain_zone_id
  name    = var.name
  type    = "A"
  ttl     = 300
  records = [module.ec2.public_ip]
}

resource "aws_route53_record" "tools" {
  count   = var.wakeup ? 1 : 0
  zone_id = var.public_zone_id
  name    = "tools"
  type    = "A"
  ttl     = 300
  records = [module.ec2.private_ip]
}
