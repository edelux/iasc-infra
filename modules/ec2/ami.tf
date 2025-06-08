
## Amazon Linux 2 AMIs
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

## Amazon Linux 2023 AMIs
data "aws_ami" "al2023_x86_64_latest" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_ami" "al2023_arm64_latest" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-arm64"]
  }
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
}

## Debian AMIs
data "aws_ami" "debian_x86_64_latest" {
  most_recent = true
  owners      = ["136693071363"] # Debian
  filter {
    name   = "name"
    values = ["debian-12-amd64-*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_ami" "debian_arm64_latest" {
  most_recent = true
  owners      = ["136693071363"] # Debian
  filter {
    name   = "name"
    values = ["debian-12-arm64-*"]
  }
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
}

## Ubuntu AMIs
data "aws_ami" "ubuntu_x86_64_latest" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_ami" "ubuntu_arm64_latest" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-arm64-server-*"]
  }
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
}

locals {
  is_graviton = can(regex("^[tc][0-9]g\\.", var.type))
  is_x86      = can(regex("^[tc][0-9]\\.", var.type))

  ami_map = {
    "al2" = {
      user     = "ec2-user"
      "x86_64" = data.aws_ami.al2_x86_64_latest.id
      "arm64"  = data.aws_ami.al2_arm64_latest.id
    }
    "al2023" = {
      user     = "ec2-user"
      "x86_64" = data.aws_ami.al2023_x86_64_latest.id
      "arm64"  = data.aws_ami.al2023_arm64_latest.id
    }
    "ubuntu" = {
      user     = "ubuntu"
      "x86_64" = data.aws_ami.ubuntu_x86_64_latest.id
      "arm64"  = data.aws_ami.ubuntu_arm64_latest.id
    }
    "debian" = {
      user     = "admin"
      "x86_64" = data.aws_ami.debian_x86_64_latest.id
      "arm64"  = data.aws_ami.debian_arm64_latest.id
    }
  }

  architecture = local.is_graviton ? "arm64" : "x86_64"
  selected_ami = local.ami_map[var.distro][local.architecture]
  current_user = local.ami_map[var.distro].user

  user_data = templatefile("${path.module}/user_data_${var.distro}.j2", {
    ssh_keys = var.ssh_keys
    user     = local.current_user
  })
}
