resource "aws_route53_zone" "example" {
  name = var.domain_name
}

resource "aws_route53_record" "root_domain" {
  zone_id = aws_route53_zone.example.zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = var.cloudfront_domain
    zone_id                = var.zone_id
    evaluate_target_health = false
  }
}   

resource "aws_route53_record" "www_subdomain" {
  zone_id = aws_route53_zone.example.zone_id
  name    = "www.${var.domain_name}"
  type    = "CNAME"
  ttl     = "300"
  records = [var.cloudfront_domain_name]
}