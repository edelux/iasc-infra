
module "zones" {
  source = "terraform-aws-modules/route53/aws//modules/zones"

  zones = {
    "${terraform.workspace}.${var.domain}" = {
      comment = "${var.domain} (${terraform.workspace})"

      tags = {
        Name = "${terraform.workspace}.${var.domain}"
      }
    }
  }
}
