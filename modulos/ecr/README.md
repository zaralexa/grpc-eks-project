# Módulo de ECR

Este módulo crea un repositorio de Amazon ECR.

## Uso

Para usar este módulo, inclúyelo en tu configuración de Terraform de la siguiente manera:

```hcl
module "ecr" {
  source          = "../modules/ecr"
  repository_name = "grpc-server"
  tags            = {
    Environment = "Production"
  }
}
