# Lambda
resource "aws_lambda_function" "this" {
  filename      = var.lambda_resources_path
  function_name = var.lambda_name
  role          = var.academy_labrole_arn
  handler       = "${var.lambda_handler_file}.lambda_handler"
  runtime       = "python3.9"

  source_code_hash = filebase64sha256(var.lambda_resources_path)

  tags = {
    Name = var.lambda_name
  }
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.region}:${var.account_id}:${aws_api_gateway_rest_api.rest_api.id}/*/${aws_api_gateway_method.rest_api.http_method}${aws_api_gateway_resource.rest_api.path}"
}

# API Gateway integration
resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.rest_api.id
  http_method             = aws_api_gateway_method.rest_api.http_method
  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.this.invoke_arn
}
