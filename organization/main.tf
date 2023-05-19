
module "lambda_function" {

  depends_on = [
    module.vpc
  ]
  source                = "../modules/lambda"
  lambda_name           = "hello_lambda"
  lambda_description    = "${local.lambda.name} - hello world"
  lambda_resources_path = local.lambda.resources_path
  lambda_handler_file   = local.lambda.handler_file
  academy_labrole_arn   = "arn:aws:iam::341639355362:role/LabRole"
  role_resources_arn             = [for table in module.dynamodb_table : table.dynamodb_table_arn]
  sg_id                 = module.vpc.sg_id
  subnet_ids    = module.vpc.subnet_ids

}

module "api-gw" {

  source = "../modules/api-gw"
  depends_on = [
    module.lambda_function
  ]
  region              = local.aws_region
  account_id          = 341639355362
  rest_api_name       = "aws-api-gateway-test"
  rest_api_desc       = "Attend request and delegate to lambdas"
  rest_api_tag_name   = "Api Gateway"
  rest_api_stage_name = "dev"
  resource_path_name  = "foo"
  lambda_func_name    = module.lambda_function.lambda_function_name
  lambda_func_arn     = module.lambda_function.lambda_invoke_function_arn
}

module "vpc" {

  source = "../modules/vpc"

  name_prefix = local.name_prefix

  cidr_block  = local.aws_vpc_network
  zones_count = local.aws_az_count



  sg_tag_name       = "g2-vpc-sg"
  ingress_protocol  = -1
  ingress_self      = true
  ingress_from_port = 0
  ingress_to_port   = 0
  egress_from_port  = 0
  egress_to_port    = 0
  egress_protocol   = -1
  egress_cidr       = ["0.0.0.0/0"]

}

module "dynamodb_table" {
  for_each = local.tables
  source   = "terraform-aws-modules/dynamodb-table/aws"

  name                    = each.value.name
  hash_key                = each.value.hash_key
  range_key               = each.value.range_key
  attributes              = each.value.attributes
  global_secondary_indexes = try(each.value.global_secondary_indexes, [])
  tags = {
    Terraform   = "true"
    Environment = "staging"
  }
}

# module "static-site" {
#   source = "../modules/storage"

#   resources   = local.resources_path
#   name_prefix = local.name_prefix
# }
