resource "aws_acm_certificate" "domain_cert" {
  domain_name       = var.domain   # bektemir.com
  subject_alternative_names = [ "www.${var.domain}" ]   # www.bektemir.com, dev.bektemir.com
  validation_method = "DNS"

  tags = local.tags
}

// *.domain.com = wildcard, it covers the subdomains

resource "aws_route53_record" "domain_cert_validation_records" {
  for_each = {
    for names in aws_acm_certificate.domain_cert.domain_validation_options : names.domain_name => {
      name   = names.resource_record_name
      record = names.resource_record_value
      type   = names.resource_record_type
    }
  }

#Iterate

  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.hosted_zone_id
}

resource "aws_acm_certificate_validation" "domain_cert_validation" {
  certificate_arn         = aws_acm_certificate.domain_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.domain_cert_validation_records : record.fqdn]
}