output "rest_api_url" {
  value = "${aws_api_gateway_deployment.deployment.invoke_url}${aws_api_gateway_stage.stage.stage_name}${aws_api_gateway_resource.resource.path_part}"
}

output "rest_api_domain_name" {
  value = aws_api_gateway_deployment.deployment.invoke_url
}

output "rest_api_path" {
  value = "${aws_api_gateway_stage.stage.stage_name}${aws_api_gateway_resource.resource.path_part}"
}