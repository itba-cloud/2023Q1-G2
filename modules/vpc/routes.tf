resource "aws_route_table" "public" {
  count  = var.zones_count
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "pub-${local.route_table.name}-${1 + count.index}"
  }
}

resource "aws_route_table_association" "public" {
  count = var.zones_count

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}
