variable "aws_account_id" {
  description = "ID de la cuenta de AWS"
  type        = string
}

variable "github_repository_url" {
  description = "URL del repositorio de GitHub"
  type        = string
}

variable "tags" {
  description = "Etiquetas a aplicar al proyecto de CodeBuild"
  type        = map(string)
  default     = {}
}
