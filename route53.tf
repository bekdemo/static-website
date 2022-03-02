resource "aws_route53_record" "main" {
  zone_id = var.hosted_zone_id
  name    = var.domain
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "main_www" {
  zone_id = var.hosted_zone_id
  name    = "www.${var.domain}"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = true
  }
}