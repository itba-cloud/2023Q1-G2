resource "aws_iam_role" "role" {
  name               = "${var.lambda_name}-exec"
  assume_role_policy = data.aws_iam_policy_document.lambda_policy_document.json
}

# Lambda
resource "aws_lambda_function" "this" {
  filename      = var.lambda_resources_path
  function_name = var.lambda_name
  role          = aws_iam_role.role.arn
  handler       = "${var.lambda_handler_file}.lambda_handler"
  runtime       = "python3.9"
  vpc_config {
    subnet_ids         = [var.private_subnet_id]
    security_group_ids = [var.lambda_sg_id]
  }
  source_code_hash = filebase64sha256(var.lambda_resources_path)

  tags = {
    Name = var.lambda_name
  }
}
