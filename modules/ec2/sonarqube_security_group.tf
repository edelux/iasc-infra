resource "aws_security_group" "sonarqune_security_group" {
  name        = "sonarqune_security_group"
  description = "Security group for SonarQube web access"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SonarQube Web"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ##cidr_blocks = var.ip_access_allow
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "sonarqune_security_group"
    Terraform   = "true"
    Environment = terraform.workspace
  }
}
