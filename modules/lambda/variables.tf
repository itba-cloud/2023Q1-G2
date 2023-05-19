

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

variable "role_arn" { 
  description = "Role resources to be accessed"
  type        = list(string)
  default     = []
}

variable "private_subnet_id" {
  type        = string
  description = "Private subnet id for the subnet where the lambda lives"
}

variable "lambda_sg_id" {
  type        = string
  description = "Security Group for the current lambda"
}