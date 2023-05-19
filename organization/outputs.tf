output "cloudfront_domain_name" {
  description = "cloud front domain_name"
  value       = module.cloudfront.cloudfront_distribution
}