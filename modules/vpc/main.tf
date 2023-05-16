resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = {
    Name = local.vpc.name
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public" {
  count = var.zones_count

  vpc_id = aws_vpc.this.id

  cidr_block        = cidrsubnet(var.cidr_block, 8, 1 + count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "pub-${local.subnet.name}-${1 + count.index}"
  }
}
