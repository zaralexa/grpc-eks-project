# Módulo de Networking

Este módulo de Terraform configura la red para la arquitectura de EKS, incluyendo una VPC, subnets públicas y privadas, y un NAT Gateway.

## Uso

Para utilizar este módulo, añade el siguiente bloque de código en tu configuración de Terraform:

```hcl
module "networking" {
  source = "./networking"

  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  region              = "us-east-1"
}
