# Define the OIDC provider for GitHub
resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

# IAM Role for GitHub Actions
resource "aws_iam_role" "github_actions_role" {
  name = "github-actions-${terraform.workspace}"

  assume_role_policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${{ secrets.aws_account_id }}:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringLike": {
          "token.actions.githubusercontent.com:sub": "repo:${{ github.repository }}:*"
        }
      }
    }
  ]
})
}

# IAM Policy to restrict EC2 instance types
resource "aws_iam_policy" "limit_instance_types" {
  name = "LimitInstanceTypes-${terraform.workspace}"
  description = "Policy to allow only specific EC2 instance types for ${terraform.workspace}"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "ec2:RunInstances"
        Resource = "*"
        Condition = {
          StringEqualsIfExists = {
            "ec2:InstanceType" = var.allowed_instance_types[terraform.workspace]
          }
        }
      }
    ]
  })
}

# Attach policy to the role
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role = aws_iam_role.github_actions_role.name
  policy_arn = aws_iam_policy.limit_instance_types.arn
}
