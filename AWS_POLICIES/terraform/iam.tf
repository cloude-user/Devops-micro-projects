# provider "aws" {
#   region = var.region
# }

# resource "aws_s3_bucket" "secure_bucket" {
#   bucket = "my-secure-bucket-002"
# }
# resource "aws_s3_bucket_policy" "secure_bucket_policy" {
#   bucket = aws_s3_bucket.secure_bucket.id
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       # ✅ Allow TerraformSession role to access S3
#       {
#         Effect = "Allow",
#         Principal = {
#           "AWS": "arn:aws:iam::692859915147:role/sundeep/TerraformSession"
#         },
#         Action = [
#           "s3:GetBucketPolicy",
#           "s3:PutObject",
#           "s3:GetObject",
#           "s3:ListBucket"
#         ],
#         Resource = [
#           "arn:aws:s3:::${aws_s3_bucket.secure_bucket.id}",
#           "arn:aws:s3:::${aws_s3_bucket.secure_bucket.id}/*"
#         ]
#       },
#       # ✅ Allow GitHub Actions OIDC Role to access S3
#       {
#         Effect = "Allow",
#         Principal = {
#           "AWS": "arn:aws:iam::692859915147:role/sundeep"
#         },
#         Action = "s3:*",
#         Resource = [
#           "arn:aws:s3:::${aws_s3_bucket.secure_bucket.id}",
#           "arn:aws:s3:::${aws_s3_bucket.secure_bucket.id}/*"
#         ]
#       },
#       # ❌ Deny all access except specific IPs.
#       {
#         Effect = "Deny",
#         Principal = "*",
#         Action = "s3:*",
#         Resource = [
#           "arn:aws:s3:::${aws_s3_bucket.secure_bucket.id}",
#           "arn:aws:s3:::${aws_s3_bucket.secure_bucket.id}/*"
#         ],
#         Condition = {
#           "NotIpAddress": {
#             "aws:SourceIp": [
#               "192.168.1.171",  # Specific IP
#               "10.0.0.0/8"       # Any IP starting from 10.*
#             ]
#           }
#         }
#       }
#     ]
#   })
# }
