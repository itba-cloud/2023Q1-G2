# =============== VPC ===============
output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = try(aws_vpc.this.cidr_block, null)
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = try(aws_vpc.this.id, null)
}

# ===== Subnets =====
output "subnet_ids" {
  description = "Public subnet IDs"
  value = [
    for k, v in aws_subnet.public : try(v.id, null)
  ]
}



output "sg_id" {
  description = "Security group's id"
  value       = aws_security_group.sg.id
}