locals {
  vpc = {
    name = "${var.name_prefix}-vpc"
  }
  subnet = {
    name = "${var.name_prefix}"
  }

  internet_gateway = {
    name = "${var.name_prefix}-igw"
  }

  route_table = {
    name = "${var.name_prefix}-rt"
  }
}
