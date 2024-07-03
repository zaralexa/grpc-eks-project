output "codebuild_project_name" {
  description = "Nombre del proyecto de CodeBuild"
  value       = aws_codebuild_project.build_project.name
}
