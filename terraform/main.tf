###################################################
# Terraform Entry Point - feature-careportal Project
# Using LOCAL backend (no S3/DynamoDB to avoid cost)
###################################################

terraform {
  required_version = ">= 1.5.0"
}

# Provider, variables, VPC, EKS, ECR, IAM, outputs
# are split into their own *.tf files:
#
# - provider.tf
# - variables.tf
# - vpc.tf
# - eks.tf
# - ecr.tf
# - iam.tf
# - outputs.tf
#
# Terraform will automatically load all *.tf files
# in this folder and manage resources together.
