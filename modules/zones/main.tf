
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
      comment           = "Public zone for ${terraform.workspace}.${var.domain}"
      delegation_set_id = module.delegation_set.route53_delegation_set_id["global"]
      private_zone      = false
    }
  }
  depends_on = [module.delegation_set]
}

resource "aws_route53_record" "delegation" {
  zone_id = var.zone_id
  name    = terraform.workspace
  type    = "NS"
  ttl     = 300

  records    = module.delegation_set.route53_delegation_set_name_servers["global"]
  depends_on = [module.zones]
}
