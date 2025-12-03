resource "aws_iam_role" "github_actions_ecr_role" {
  name = "${var.project_name}-github-ecr-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:Yash21devops/feature-careportal:ref:refs/heads/*"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "ecr_push_policy" {
  name        = "${var.project_name}-ecr-push-policy"
  description = "Policy for GitHub Actions CI to push Docker images to ECR"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect : "Allow",
        Action : [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ],
        Resource : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_ecr_role_attachment" {
  role       = aws_iam_role.github_actions_ecr_role.name
  policy_arn = aws_iam_policy.ecr_push_policy.arn
}

resource "aws_iam_role" "github_actions_eks_deploy_role" {
  name = "${var.project_name}-github-eks-deploy-role"

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          Federated : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
        },
        Action : "sts:AssumeRoleWithWebIdentity",
        Condition : {
          StringLike : {
            "token.actions.githubusercontent.com:sub" = "repo:Yash21devops/feature-careportal:ref:refs/heads/*"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "eks_deploy_policy" {
  name        = "${var.project_name}-eks-deploy-policy"
  description = "Policy to allow GitHub CD to deploy to EKS"

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : [
          "eks:DescribeCluster",
          "eks:ListClusters"
        ],
        Resource : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_eks_role_attachment" {
  role       = aws_iam_role.github_actions_eks_deploy_role.name
  policy_arn = aws_iam_policy.eks_deploy_policy.arn
}
