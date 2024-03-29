resource "aws_acm_certificate" "https_certificate" {
  domain_name       = "*.${var.domain_name}"
  validation_method = "DNS"

  tags = merge(
    var.common_tags,
    var.acm_tags
  )

   lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "acm_validation" {
  for_each = {
    for dvo in aws_acm_certificate.https_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 1
  type            = each.value.type
  zone_id         = data.aws_route53_zone.challa.id
}

resource "aws_acm_certificate_validation" "challa_cloud" {
  certificate_arn         = aws_acm_certificate.https_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_validation : record.fqdn]
}