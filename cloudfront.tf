resource "aws_cloudfront_origin_access_identity" "main" {
  comment = "Origin Access Identity for Main Cloudfront"
}

resource "aws_cloudfront_distribution" "main" {
  origin {
    domain_name = aws_s3_bucket.static_web.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.static_web.bucket_regional_domain_name

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.main.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = [ var.domain, "www.${var.domain}"]

  default_cache_behavior {
    allowed_methods  = [ "GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.static_web.bucket_regional_domain_name

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = local.tags

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.domain_cert.arn
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method = "sni-only"
  }
}