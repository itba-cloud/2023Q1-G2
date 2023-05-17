variable "region" {
  description = "Current region"
  type        = string
}

variable "account_id" {
  description = "Account ID"
  type        = string
}

variable "lambda_name" {
  description = "Lambda function name"
  type        = string
}

variable "lambda_description" {
  description = "Lambda function description"
  type        = string
}

variable "lambda_resources_path" {
  description = "ZIP file with local resources"
  type        = string
}

variable "lambda_handler_file" {
  description = "Filename of files in resources' ZIP containing 'lambda_handler' functions. Note that '.lambda_handler' is automatically appended"
  type        = string
}

variable "academy_labrole_arn" {
  description = "AWS Academy LabRole ARN. IAM > Roles > LabRole"
  type        = string
}
