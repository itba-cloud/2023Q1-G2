module "lambda_function" {
  source = "./modules/lambda"

  lambda_name           = "hello_lambda"
  lambda_description    = "${var.name_prefix} - hello world"
  lambda_resources_path = var.lambda_resources_path
  lambda_handler_file   = var.lambda_handler_file

  region              = var.region
  account_id          = var.account_id
  academy_labrole_arn = var.academy_labrole_arn
}
