
## VPC
variable "region" {
  description = "AWS region to deploy the resources"
  type        = string
  default     = "us-east-1"
  validation {
    condition     = can(regex("^(us-(east|west)-[12])$", var.region))
    error_message = "The region must be either us-east-1, us-east-2, us-west-1, or us-west-2."
  }
}

variable "environment" { #REQUIRED
  description = "Environment Name (dev, qa, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = can(regex("^(dev|aq|stag|pr[do])[a-z0-9]{0,9}$", var.environment))
    error_message = "The environment name must start with 'dev', 'pro', or 'prd', followed by up to 9 lowercase letters or numbers, with a total length between 3 and 12 characters."
  }

  validation {
    condition     = terraform.workspace == var.environment
    error_message = "Invalid workspace: The active workspace '${terraform.workspace}' does not match the specified environment '${var.environment}'."
  }
}

variable "domain" {
  description = "Route53 Managed DNS"
  type        = string
  default     = "acme.com"
  validation {
    condition     = can(regex("^[a-z0-9.]+$", var.domain))
    error_message = "The domain name must contain only lowercase letters, numbers, or dots (.)."
  }
}

variable "cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "172.0.0.0/16"
  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/(\\d|[12]\\d|3[0-2])$", var.cidr))
    error_message = "The VPC CIDR block must be a valid IPv4 address followed by a / and a subnet mask (1-32)."
  }
}

variable "zones_numbers" {
  description = "Number of AZs in use for the project"
  type        = number
  default     = 2
  validation {
    condition = (
      (var.region == "us-east-1" && var.zones_numbers >= 2 && var.zones_numbers <= 12) ||
      (var.region == "us-east-2" && var.zones_numbers >= 2 && var.zones_numbers <= 6) ||
      (var.region == "us-west-1" && var.zones_numbers >= 2 && var.zones_numbers <= 4) ||
      (var.region == "us-west-2" && var.zones_numbers >= 2 && var.zones_numbers <= 8)
    )
    error_message = "The number of AZs must be between 2 and the allowed maximum for the selected region: us-east-1 (12), us-east-2 (6), us-west-1 (4), us-west-2 (8)."
  }
}

variable "cidr_subnet_bits" {
  description = "Increase the net mask for subnets in bits"
  type        = number
  default     = 6
  validation {
    condition     = var.cidr_subnet_bits >= 4 && var.cidr_subnet_bits <= 12
    error_message = "The subnet_bits_mask must be a number between 4 and 12."
  }
}

variable "high_availability" {
  description = "Redundat networks"
  type        = bool
  default     = false
}

## EC2
variable "ssh_keys" {
  type        = list(string)
  default     = [null]
  description = "Public SSH Keys"
}

variable "bastion-wakeup" {
  description = "Power on Bastion Host"
  type        = bool
  default     = false
}
