# resource "aws_iam_policy" "ec2_access_policy" {
#   name        = "EC2AccessPolicy"
#   description = "Policy to allow EC2 instance creation and management"
#   policy      = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect   = "Allow"
#         Action   = [
#           "ec2:RunInstances",
#           "ec2:DescribeInstances",
#           "ec2:TerminateInstances",
#           "ec2:StartInstances",
#           "ec2:StopInstances",
#           "ec2:RebootInstances",
#           "ec2:DescribeInstanceStatus",
#           "ec2:DescribeInstances",
#           "ec2:GetAllowedImagesSettings"  # Added permission to get allowed images settings
#         ]
#         Resource = "*"
#       },
#       # Optional: If you want to restrict the user to specific instance types (e.g., t2 instances)
#       {
#         Effect   = "Allow"
#         Action   = "ec2:RunInstances"
#         Resource = "*"
#         Condition = {
#           StringEquals = {
#             "ec2:InstanceType" = "t2."
#           }
#         }
#       }
#     ]
#   })
# }
# resource "aws_iam_policy_attachment" "specif_instance_policy" {
#   policy_arn = aws_iam_policy.ec2_access_policy.arn
#   roles      = ["sundeep"]
#   name       = "siuu"
# }


# resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
#   user       = "Developer_01"  # Replace with your IAM user's name
#   policy_arn = aws_iam_policy.ec2_access_policy.arn
# }

