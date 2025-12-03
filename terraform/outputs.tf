output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnets
}


output "ecr_repository_url" {
  description = "ECR repository URL for the Java app image"
  value       = aws_ecr_repository.prediction_api.repository_url
}


output "ecs_cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "ecs_service_name" {
  value = aws_ecs_service.careportal.name
}

output "alb_dns_name" {
  value = aws_lb.api.dns_name
}
