# - Not currently used -
# resource "aws_route53_zone" "main" {
#   count = var.create_route53_hosted_zone ? 1 : 0
#   name  = var.domain_name
# }

# # resource "aws_route53_zone" "dev" {
# #   count = var.create_hosted_zone
# #   name = "dev.example.com"
# #   name = "dev.example.com"

# #   tags = {
# #     Environment = "dev"
# #   }
# # }

# resource "aws_route53_record" "main" {
#   # count   = var.create_route53_hosted_zone ? 1 : 0
#   for_each = var.sub_domain_route53_records
#   zone_id  = var.lookup_existing_route53_zone == true ? data.aws_route53_zone.existing[0].zone_id : aws_route53_zone.main[0].zone_id
#   name     = lookup(each.value, "name", null)
#   type     = lookup(each.value, "type", "NS")
#   ttl      = lookup(each.value, "ttl", "30")
#   # type    = "NS"
#   # ttl     = "30"
#   # records = lookup(each.value, "records", aws_route53_zone.main[0].name_servers)
#   records = lookup(each.value, "records", var.lookup_existing_route53_zone == true ? data.aws_route53_zone.existing[0].name_servers : aws_route53_zone.main[0].name_servers)
#   # records = aws_route53_zone.main[0].name_servers
# }

# data "aws_route53_zone" "existing" {
#   count = var.lookup_existing_route53_zone ? 1 : 0
#   name         = var.domain_name
#   private_zone = false
# }
