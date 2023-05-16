module "vpc" {
  source = "./modules/vpc"

  name_prefix = var.name_prefix

  cidr_block  = local.aws_vpc_network
  zones_count = local.aws_az_count
}
