# IAM Role for API Gateway to invoke Lambda
resource "aws_iam_role" "api_gateway_role" {
  name = "api_gateway_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "api_gateway_policy" {
  name        = "api_gateway_policy"
  description = "Policy to allow API Gateway to invoke Lambda"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "lambda:InvokeFunction",
        Effect = "Allow",
        Resource = aws_lambda_function.api_gateway_lambda.arn
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "api_gateway_role_policy_attachment" {
  role_name  = aws_iam_role.api_gateway_role.name
  policy_arn = aws_iam_policy.api_gateway_policy.arn
}