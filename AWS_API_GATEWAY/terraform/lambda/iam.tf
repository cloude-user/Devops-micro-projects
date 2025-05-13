# IAM Role for Lambda Function
resource "aws_iam_role" "lambda_role" {
  name = "api_gateway_lambda_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Lambda Policy - Permissions for Lambda to log to CloudWatch
resource "aws_iam_policy" "lambda_policy" {
  name        = "api_gateway_lambda_policy"
  description = "IAM policy for Lambda function to write logs"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect = "Allow",
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role_name  = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}