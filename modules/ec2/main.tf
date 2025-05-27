
## ARM64
data "aws_ami" "al2_arm64_latest" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-arm64-gp2"]
  }

  filter {
    name   = "architecture"
    values = ["arm64"]
  }
}

## AMD64 x86_64
data "aws_ami" "al2_x86_64_latest" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

locals {
  ami_is_x86   = can(regex("^([tc][0-9])\\.(nano|micro|medium)$", var.type))
  ami_is_arm   = can(regex("^([tc][0-9]g)\\.(nano|micro|medium)$", var.type))
  selected_ami = local.ami_is_x86 ? data.aws_ami.al2_x86_64_latest.id : local.ami_is_arm ? data.aws_ami.al2_arm64_latest.id : data.aws_ami.al2_x86_64_latest.id
}

module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name          = var.name
  create        = var.wakeup
  instance_type = var.type
  ami           = local.selected_ami
  subnet_id     = var.public_subnet_ids[0]

  associate_public_ip_address = true

  vpc_security_group_ids = [
    module.ssh_security_group.security_group_id,
    aws_security_group.sonarqune_security_group.id,
  ]

  user_data = <<EOF
#!/bin/bash
yum install -y nc tmux
mkdir -p /home/ec2-user/.ssh
touch /home/ec2-user/.hushlogin
amazon-linux-extras install -y postgresql14 ansible2 docker
cat <<EOK>> /home/ec2-user/.ssh/authorized_keys
  ${join("\n", var.ssh_keys)}
EOK
chmod 500 /home/ec2-user/.ssh
chmod 400 /home/ec2-user/.ssh/authorized_keys
chown -R ec2-user:ec2-user /home/ec2-user/.ssh
usermod -aG docker ec2-user
systemctl enable docker
systemctl start  docker
systemctl status docker
EOF

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
  #zone_id = var.domain_zone_id
  name    = "tools"
  type    = "A"
  ttl     = 300
  records = [module.ec2.private_ip]
}
