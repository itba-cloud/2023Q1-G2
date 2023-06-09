output "id" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com"
  value       = aws_s3_bucket.this.id
}

output "arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname"
  value       = aws_s3_bucket.this.arn
}

output "website_endpoint" {
  description = "The website endpoint, if the bucket is configured with a website. If not, this will be an empty string"
  value       = try(aws_s3_bucket_website_configuration.this[0].website_endpoint,"")
}