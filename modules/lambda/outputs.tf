output "lambda_invoke_function_arn" {
  description = "Lambda's arn for invokation on api-gw"
  value       = aws_lambda_function.this.invoke_arn
}

output "lambda_function_arn" {
  description = "Lambda's arn for identification"
  value       = aws_lambda_function.this.arn
}

output "lambda_function_name" {
  description = "Function name"
  value       = aws_lambda_function.this.function_name
}