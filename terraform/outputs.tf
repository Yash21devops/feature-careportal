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

# output "eks_cluster_name" {
#   value = module.eks.cluster_name
# }

# output "eks_cluster_endpoint" {
#   value = module.eks.cluster_endpoint
# }


output "ecr_repository_url" {
  description = "ECR repository URL for the Java app image"
  value       = aws_ecr_repository.prediction_api.repository_url
}
