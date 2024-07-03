# Variable para el CIDR block de la VPC
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Variable para los CIDR blocks de las subnets públicas
variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Variable para los CIDR blocks de las subnets privadas
variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

# Variable para la región de AWS
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
