
data "aws_ami" "latest_amazon_linux" {
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

module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  create                      = var.wakeup
  name                        = "${terraform.workspace}-bastion"
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = "t4g.nano"
  associate_public_ip_address = true
  subnet_id                   = var.public_subnet_ids[0]

  vpc_security_group_ids = [
    var.ssh_sg_id,
    var.postgresql_sg_id,
  ]

  user_data = <<EOF
#!/bin/bash
  yum install -y nc tmux
  amazon-linux-extras install -y postgresql14 ansible2
  mkdir -p /home/ec2-user/.ssh
  cat <<EOK>> /home/ec2-user/.ssh/authorized_keys
    ${join("\n", var.ssh_keys)}
  EOK
  chown -R ec2-user:ec2-user /home/ec2-user/.ssh
  chmod 500 /home/ec2-user/.ssh
  chmod 400 /home/ec2-user/.ssh/authorized_keys
  EOF

  tags = {
    Terraform   = "true"
    Environment = terraform.workspace
  }
}
