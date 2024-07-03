variable "repository_name" {
  description = "Nombre del repositorio ECR"
  type        = string
}

variable "tags" {
  description = "Etiquetas a aplicar al repositorio"
  type        = map(string)
  default     = {}
}
s