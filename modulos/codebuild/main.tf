resource "aws_iam_role" "codebuild_service_role" {
  name = "codebuild-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "codebuild.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser",
    "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess",
    "arn:aws:iam::aws:policy/AWSCodePipelineFullAccess",
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  ]
}

resource "aws_codebuild_project" "build_project" {
  name          = "grpc-eks-build-project"
  description   = "Proyecto de CodeBuild para construir y desplegar la aplicación gRPC en EKS"
  service_role  = aws_iam_role.codebuild_service_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
    environment_variables = [
      {
        name  = "AWS_ACCOUNT_ID"
        value = var.aws_account_id
      }
    ]
  }

  source {
    type            = "GITHUB"
    location        = var.github_repository_url
    buildspec       = "cicd/buildspec.yml"
    git_clone_depth = 1
  }

  logs_config {
    cloudwatch_logs {
      group_name = "/aws/codebuild/${aws_codebuild_project.build_project.name}"
      stream_name = "build-log"
    }
  }

  tags = var.tags
}
