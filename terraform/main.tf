provider "aws" {
  region = "us-east-1"
}

/*
terraform {
  backend "s3" {
    bucket = "zb-terraform-state-bucket"
    key    = "terraform/eks_project/terraform.tfstate"
    region = "us-east-1"
  }
}
*/

module "s3" {
  source = "./s3"

  bucket = "zb-terraform-state-bucket"
}

module "networking" {
  source = "../modules/networking"

  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  region              = "us-east-1"
}

module "eks" {
  source = "../modules/eks"
  cluster_name = "my-eks-cluster"
  cluster_version = "1.21"
  vpc_id = module.networking.vpc_id
  public_subnets = module.networking.public_subnets
  private_subnets = module.networking.private_subnets
  desired_capacity = 2
  max_capacity = 3
  min_capacity = 1
  instance_type = "t3.medium"
  region = "us-east-1"
}

module "ecr" {
  source = "../modules/ecr"
  repository_name = "grpc-server"
  tags = {
    Environment = "Production"
  }
}

module "codebuild" {
  source = "../modules/codebuild"
  aws_account_id = "471112701387"
  github_repository_url = "https://github.com/zaralexa/grpc-eks-project"
  tags = {
    Environment = "Production"
  }
}
