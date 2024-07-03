provider "aws" {
  region = var.region
}

# Crear una VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

# Crear un Internet Gateway para la VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# Crear una tabla de rutas pública
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  # Añadir una ruta para el tráfico hacia Internet a través del Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

# Crear subnets públicas
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

# Asociar subnets públicas con la tabla de rutas pública
resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

# Crear subnets privadas
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}

# Crear un NAT Gateway para permitir que las instancias en subnets privadas accedan a Internet
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = element(aws_subnet.public.*.id, 0)

  tags = {
    Name = "main-nat"
  }
}

# Crear una Elastic IP para el NAT Gateway
resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "main-nat-eip"
  }
}

# Crear una tabla de rutas privada
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  # Añadir una ruta para el tráfico hacia Internet a través del NAT Gateway
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-rt"
  }
}

# Asociar subnets privadas con la tabla de rutas privada
resource "aws_route_table_association" "private_subnet_association" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private_rt.id
}

# Obtener las zonas de disponibilidad disponibles en la región especificada
data "aws_availability_zones" "available" {
  state = "available"
}
