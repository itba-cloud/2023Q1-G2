locals {
  aws_vpc_network = "10.0.0.0/16"
  aws_az_count    = 2
  aws_region      = "us-east-1"
  resources_path  = "../resources"
  name_prefix     = "test"
  stage_name      = "prod"
  account_id = 341639355362
  bucket_name = "g2-20231q-itba-cloud-computing-b"
  # path         = "./../resources"
  # modules_path = "./../modules"
  # region       = "us-east-1"
  az1 = "${local.aws_region}a"

  s3_front = {

    # 1 - Website
    website = {
      bucket_name        = local.bucket_name
      path               = local.resources_path
      bucket_acl         = "public-read"
      index_file         = "index.html"
      public_read_policy = true
      bucket_tag         = "Front Website Bucket"
      objects = {
        index = {
          filename     = "html/index.html"
          content_type = "text/html"
        }
      }
    }

    # 2 - WWW Website
    www-website = {
      bucket_name       = "www.${local.bucket_name}"
      redirect_hostname = "${local.bucket_name}.s3-website-${local.aws_region}.amazonaws.com"
      bucket_acl        = "public-read"
      
      bucket_tag        = "Front www Bucket"
    }

    # 3 - Logs
    website-logs = {
      bucket_name = "${local.bucket_name}-logs"
      bucket_acl  = "private"
      bucket_tag  = "Front Logs Bucket"
    }
  }


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
      hash_key  = "patient"
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
