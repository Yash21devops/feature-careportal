# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "~> 20.0"
#
#   cluster_name    = "${var.project_name}-eks"
#   cluster_version = var.eks_cluster_version
#
#   vpc_id                   = module.vpc.vpc_id
#   subnet_ids               = module.vpc.private_subnets
#   control_plane_subnet_ids = module.vpc.private_subnets
#
#   cluster_endpoint_public_access = true
#
#   enable_irsa = true
#
#   eks_managed_node_groups = {
#     default = {
#       instance_types = ["t3.medium"]
#       min_size       = 2
#       max_size       = 4
#       desired_size   = 2
#     }
#   }
#
#   tags = {
#     Project = var.project_name
#   }
# }
