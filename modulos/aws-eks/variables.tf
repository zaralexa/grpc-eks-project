variable "cluster_name" {
  description = "Nombre del cluster de EKS"
  type        = string
  default     = "my-eks-cluster"
}

variable "cluster_version" {
  description = "Versión del cluster de EKS"
  type        = string
  default     = "1.21"
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "public_subnets" {
  description = "Lista de IDs de subnets públicas"
  type        = list(string)
}

variable "private_subnets" {
  description = "Lista de IDs de subnets privadas"
  type        = list(string)
}

variable "desired_capacity" {
  description = "Número deseado de nodos de trabajo"
  type        = number
  default     = 2
}

variable "max_capacity" {
  description = "Número máximo de nodos de trabajo"
  type        = number
  default     = 3
}

variable "min_capacity" {
  description = "Número mínimo de nodos de trabajo"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "Tipo de instancia EC2 para los nodos de trabajo"
  type        = string
  default     = "t3.medium"
}

variable "region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}
