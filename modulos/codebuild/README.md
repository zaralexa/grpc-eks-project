# Módulo de CodeBuild

Este módulo crea un proyecto de AWS CodeBuild para construir y desplegar aplicaciones gRPC en EKS.

## Uso

Para usar este módulo, inclúyelo en tu configuración de Terraform de la siguiente manera:

```hcl
module "codebuild" {
  source = "../modules/codebuild"
  aws_account_id = "your-aws-account-id"
  github_repository_url = "https://github.com/zaralexa/grpc-eks-project"
  tags = {
    Environment = "Production"
  }
}
