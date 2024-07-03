# Proyecto gRPC en EKS

Este proyecto despliega dos aplicaciones en Python que se comunican mediante el protocolo gRPC en un clúster de EKS. Las aplicaciones están expuestas a través de un Application Load Balancer (ALB).

## Estructura del Proyecto

- `applications/`: Contiene las aplicaciones gRPC en Python.
  - `client/`: Aplicación cliente.
  - `server/`: Aplicación servidor.
- `modules/`: Contiene los módulos de Terraform.
  - `networking/`: Módulo de Terraform para la VPC.
  - `eks/`: Módulo de Terraform para el clúster de EKS.
- `k8s/`: Archivos de configuración de Kubernetes.
- `cicd/`: Configuración de CI/CD con CodeBuild.
- `terraform/`: Archivos principales de Terraform.
- `.github/workflows/`: Configuración de GitHub Actions.
- `README.md`: Documentación del proyecto.
- `architecture-diagram.png`: Diagrama de la arquitectura.

## Prerequisitos

- AWS CLI configurado.
- Terraform instalado.
- Docker instalado.
- Credenciales de AWS configuradas.

## Configuración de Secretos en GitHub

1. Ve a tu repositorio en GitHub.
2. Haz clic en "Settings".
3. En el menú lateral, selecciona "Secrets and variables" > "Actions".
4. Añade los siguientes secretos:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `AWS_ACCOUNT_ID`

## Despliegue Automático

Cada vez que se realice un push a la rama `main`, GitHub Actions ejecutará el workflow definido en `.github/workflows/deploy.yml` para construir y desplegar la aplicación en AWS.

## Diagrama de Arquitectura

![Diagrama de Arquitectura](architecture-diagram.png)

## Explicación del Networking

- **VPC**: Proporciona una red privada para los recursos de AWS.
- **Subnets Públicas**: Permiten el acceso a Internet a través del Internet Gateway.
- **Subnets Privadas**: Aisladas del acceso directo a Internet, las instancias de EKS se despliegan aquí.
- **Internet Gateway**: Permite que las instancias en las subnets públicas tengan acceso a Internet.
- **NAT Gateway**: Permite que las instancias en las subnets privadas accedan a Internet para actualizaciones y otras actividades necesarias.
- **Route Tables**: Configuran las rutas para el tráfico entre las subnets y hacia Internet.

## Autores
Creado po Zaret Burgos