



variable "domain_name" {
  description = "dns domain for route 53"
  type        = string
}

variable "cloudfront_domain" {
  description = "Domain name of your cloudfront"
  type        = string
}

variable "cloudfront_zone_id" {
    description = "Zone id for your clodufront"
    type = string
}

