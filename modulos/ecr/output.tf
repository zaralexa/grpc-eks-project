output "repository_url" {
  description = "URL del repositorio ECR"
  value       = aws_ecr_repository.this.repository_url
}
