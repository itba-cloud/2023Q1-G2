resource "aws_api_gateway_rest_api" "rest_api" {
  name = local.rest_api_name

  tags = {
    Name = local.rest_api_name
  }
}

resource "aws_api_gateway_resource" "rest_api" {
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = var.lambda_name
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
}

resource "aws_api_gateway_method" "rest_api" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.rest_api.id
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
}
