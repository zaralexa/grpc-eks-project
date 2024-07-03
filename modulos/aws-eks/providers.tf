terraform {
  required_version = ">= 1.3, <= 1.5.7"

  required_providers {
    aws = ">= 5.0"
  }
}
provider "aws" {
  region = var.region
}