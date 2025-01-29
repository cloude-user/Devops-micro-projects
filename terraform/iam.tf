resource "aws_iam_policy" "restrict_to_t2_instances" {
  name        = "RestrictToT2Instances"
  description = "Policy to restrict EC2 instance creation to only t2 instance types"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "ec2:RunInstances"
        Resource = "*"
        Condition = {
          StringLike = {
            "ec2:InstanceType" = [
              "t2.*"  # This will match any t2 instance (t2.micro, t2.small, etc.)
            ]
          }
        }
      },
      {
        Effect   = "Deny"
        Action   = "ec2:RunInstances"
        Resource = "*"
        Condition = {
          StringNotLike = {
            "ec2:InstanceType" = [
              "t2.*"  # Deny all other instances that are not t2.*
            ]
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "specif_instance_policy" {
  policy_arn = aws_iam_policy.restrict_to_t2_instances.arn
  roles      = ["sundeep"]
  name       = "siuu"
}
