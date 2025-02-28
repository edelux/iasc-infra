
data "aws_route53_zone" "parent" {
  name         = var.domain
  private_zone = false
}

module "delegation_set" {
  source = "terraform-aws-modules/route53/aws//modules/delegation-sets"

  delegation_sets = {
    "global" = {
      reference_name = "global-delegation"
    }
  }
}

module "zones" {
  source = "terraform-aws-modules/route53/aws//modules/zones"

  zones = {
    "${terraform.workspace}.${var.domain}" = {

      comment           = "${var.domain} (${terraform.workspace})"
      delegation_set_id = module.delegation_set.route53_delegation_set_id["global"]

      tags = {
        Name = "${terraform.workspace}.${var.domain}"
      }
    }
  }
  depends_on = [module.delegation_set]
}

resource "aws_route53_record" "delegation" {
  zone_id = data.aws_route53_zone.parent.zone_id
  name    = terraform.workspace
  type    = "NS"
  ttl     = 300

  records    = module.delegation_set.route53_delegation_set_name_servers["global"]
  depends_on = [module.zones]
}
