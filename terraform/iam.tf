########################################
# ECS Task Execution & Task Role
########################################

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.project_name}-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach AWS managed policy for pulling images + logs
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# (Optional but nice) Task role if app needs AWS APIs (e.g. Secrets Manager)
resource "aws_iam_role" "ecs_task_role" {
  name = "${var.project_name}-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Example of least-privilege to read ONE secret from Secrets Manager
# (create aws_secretsmanager_secret in another file if you want to use this)
# resource "aws_iam_policy" "ecs_read_secret" {
#   name = "${var.project_name}-ecs-read-secret"
#
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Action = ["secretsmanager:GetSecretValue"],
#         Resource = aws_secretsmanager_secret.careportal_api.arn
#       }
#     ]
#   })
# }
#
# resource "aws_iam_role_policy_attachment" "ecs_task_role_secret_policy" {
#   role       = aws_iam_role.ecs_task_role.name
#   policy_arn = aws_iam_policy.ecs_read_secret.arn
# }
