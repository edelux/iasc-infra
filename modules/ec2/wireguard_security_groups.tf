# WireGuard Security Group
# This security group allows WireGuard VPN traffic on port 51820/UDP

module "wireguard_security_group" {
  source  = "terraform-aws-modules/security-group/aws"

  name        = "wireguard-sg"
  description = "Security group for WireGuard VPN server"
  vpc_id      = var.vpc_id

  # WireGuard ingress rule
  ingress_with_cidr_blocks = [
    {
      from_port   = 51820
      to_port     = 51820
      protocol    = "udp"
      description = "WireGuard VPN"
      cidr_blocks = join(",", var.ip_access_allow)
    }
  ]

  # Allow all outbound traffic
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "All outbound traffic"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = terraform.workspace
  }
}
