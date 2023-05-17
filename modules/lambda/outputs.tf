# =============== API Gateway ===============
output "rest_api_endpoint" {
  description = "Lambda Endpoint path of the REST API"
  value       = try(aws_api_gateway_resource.rest_api.path, null)
}
