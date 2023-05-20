

# Lambda
resource "aws_lambda_function" "this" {
  filename      = var.lambda_resources_path
  function_name = var.lambda_name
  role          = var.academy_labrole_arn
  handler       = "${var.lambda_handler_file}.lambda_handler"
  runtime       = "python3.9"
  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [var.sg_id]
  }
  source_code_hash = filebase64sha256(var.lambda_resources_path)

  tags = {
    Name = var.lambda_name
  }
}
