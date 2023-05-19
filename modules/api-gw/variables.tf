variable "rest_api_name" {
  type        = string
  description = "REST API name"
}

variable "region" {
    type = string
    description = "AWS region"
}

variable "account_id" {
  description = "Account ID"
  type        = string
}

variable "rest_api_desc" {
  type        = string
  description = "Short description of what this api is/does"
  default     = ""
}

variable "rest_api_stage_name" {
  type        = string
  description = "The name of the API Gateway stage"
  default     = "prod"
}

//for only one lambda

variable "lambda_func_arn" {
  type        = string
  description = "The ARN of the Lambda function"
}

variable "lambda_func_name" {
  type        = string
  description = "The name of the Lambda function"
}

variable "resource_path_name"{
    type = string
    description = "Then name for the resource path"
}

variable "rest_api_tag_name" {
  type        = string
  description = "Rest api tag for resource identification"
}

# variable "vpc_link_id" {
#   description = "ID of the VPC Link"
#   type        = string
# }