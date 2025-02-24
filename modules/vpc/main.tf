
data "aws_availability_zones" "available" { state = "available" }

locals {
  azs                   = slice(data.aws_availability_zones.available.names, 0, var.zones_numbers)
  public_subnets        = [for i in range(var.zones_numbers) : cidrsubnet(var.cidr, var.cidr_subnet_bits, i + (var.zones_numbers * 0))]
  private_subnets       = [for i in range(var.zones_numbers) : cidrsubnet(var.cidr, var.cidr_subnet_bits, i + (var.zones_numbers * 1))]
  database_subnets      = [for i in range(var.zones_numbers) : cidrsubnet(var.cidr, var.cidr_subnet_bits, i + (var.zones_numbers * 2))]
  private_subnet_names  = [for i in range(var.zones_numbers) : "${terraform.workspace}-private-subnet${i + 1}"]
  public_subnet_names   = [for i in range(var.zones_numbers) : "${terraform.workspace}-public-subnet${i + 1}"]
  database_subnet_names = [for i in range(var.zones_numbers) : "${terraform.workspace}-database-subnet${i + 1}"]
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  azs                    = local.azs
  cidr                   = var.cidr
  name                   = "${terraform.workspace}-vpc"
  enable_dns_hostnames   = true
  enable_dns_support     = true
  enable_nat_gateway     = true
  single_nat_gateway     = var.high_availability ? false : var.zones_numbers <= 3 ? true : false
  one_nat_gateway_per_az = var.high_availability ? false : var.zones_numbers >= 3 ? true : false
  public_subnets         = local.public_subnets
  public_subnet_names    = local.public_subnet_names
  private_subnets        = local.private_subnets
  private_subnet_names   = local.private_subnet_names
  database_subnets       = local.database_subnets
  database_subnet_names  = local.database_subnet_names


  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = {
    Terraform   = "true"
    Environment = terraform.workspace
  }
}
