# Salida para el ID de la VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

# Salida para los IDs de las subnets públicas
output "public_subnets" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

# Salida para los IDs de las subnets privadas
output "private_subnets" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.private[*].id
}

# Salida para el ID del NAT Gateway
output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.nat.id
}
