
## SSH
module "ssh_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = "ssh-sg"
  vpc_id      = var.vpc_id
  description = "SSH Security Group"

  ingress_cidr_blocks = var.ip_access_allow

  tags = {
    Terraform   = "true"
    Environment = terraform.workspace
  }
}
