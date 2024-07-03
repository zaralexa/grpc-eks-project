output "eks_cluster_id" {
  description = "El ID del cluster de EKS"
  value       = aws_eks_cluster.eks_cluster.id
}

output "eks_cluster_endpoint" {
  description = "El endpoint para el cluster de EKS"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_security_group_id" {
  description = "El ID del security group del cluster de EKS"
  value       = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id
}

output "eks_node_group_name" {
  description = "El nombre del grupo de nodos de EKS"
  value       = aws_eks_node_group.eks_nodes.node_group_name
}

output "alb_dns_name" {
  description = "El nombre DNS del ALB"
  value       = aws_lb.app_alb.dns_name
}
