locals {
  aws_vpc_network = "10.0.0.0/16"
  aws_az_count    = 2
  aws_region      = "us-east-1"
  resources_path  = "../resources"
  name_prefix     = "test"
  stage_name = "prod"
  lambda = {
    name           = "hello_lambda"
    description    = "${local.name_prefix} - hello world"
    resources_path = "${local.resources_path}/lambda.zip"
    handler_file   = "another_lambda"
    role_name      = "LabRole"
    
  }

  tables = {
    professionals = {
      name = "professionals"
      attributes = [
        {
          name = "specialty"
          type = "S"
        },
        {
          name = "location"
          type = "S"
        }
      ]
      hash_key  = "specialty"
      range_key = "location"
    },
    users = {
      name = "patients"
      attributes = [
        {
          name = "id",
          type = "N"
        },
        {
          name = "name"
          type = "S"
        }
      ]
      hash_key  = "id"
      range_key = "name"
    },
    appointments = {
      name = "appointments"
      attributes = [
        {
          name = "patient",
          type = "S"
        },
        {
          name = "professional",
          type = "S"
        },
        {
          name = "timestamp",
          type = "N"
        },
      ]
      hash_key = "patient"
      range_key = "timestamp"
      global_secondary_indexes = [
        {
          name               = "appointements-professional"
          hash_key           = "professional"
          range_key          = "timestamp"
          projection_type    = "INCLUDE"
          non_key_attributes = ["patient"]
        }
      ]
    }
  }

}
