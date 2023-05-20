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
//TODO check values
resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.this.id

  ingress {
    protocol  = var.ingress_protocol  
    self      = var.ingress_self      
    from_port = var.ingress_from_port 
    to_port   = var.ingress_to_port   
  }

  egress {
    from_port   = var.egress_from_port 
    to_port     = var.egress_to_port   
    protocol    = var.egress_protocol  
    cidr_blocks = var.egress_cidr      
  }

  tags = {
    Name = var.sg_tag_name
  }
}