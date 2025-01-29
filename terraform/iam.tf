provider "aws" {
  region = var.region
}

# Create the S3 Bucket
resource "aws_s3_bucket" "secure_bucket" {
  bucket = "my-secure-bucket-001"

  tags = {
    Name        = "Secure S3 Bucket"
    Environment = var.env
  }
}

# Enforce Encryption at Rest
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption" {
  bucket = aws_s3_bucket.secure_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Restrict Access to Specific IPs with Exception for Terraform Role
resource "aws_s3_bucket_policy" "secure_policy" {
  bucket = aws_s3_bucket.secure_bucket.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::692859915147:role/sundeep/TerraformSession"
      },
      "Action": [
        "s3:GetBucketPolicy",
        "s3:PutBucketPolicy",
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::my-secure-bucket-001",
        "arn:aws:s3:::my-secure-bucket-001/*"
      ]
    },
    {
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::my-secure-bucket-001",
        "arn:aws:s3:::my-secure-bucket-001/*"
      ],
      "Condition": {
        "NotIpAddress": {
          "aws:SourceIp": ["203.0.113.0/24", "198.51.100.50"]
        },
        "StringNotEqualsIfExists": {
          "aws:PrincipalArn": "arn:aws:iam::692859915147:role/sundeep/TerraformSession"
        }
      }
    }
  ]
}
POLICY
}

# IAM Policy for Terraform Role to Manage S3
resource "aws_iam_policy" "terraform_s3_access" {
  name        = "TerraformS3Access"
  description = "Policy for Terraform execution role to manage S3 bucket"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "s3:GetBucketPolicy",
          "s3:PutBucketPolicy",
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::my-secure-bucket-001",
          "arn:aws:s3:::my-secure-bucket-001/*"
        ]
      }
    ]
  })
}

# Attach the IAM Policy to Terraform Role
resource "aws_iam_role_policy_attachment" "terraform_s3_attach" {
  role       = "sundeep"  # Only "sundeep", not "sundeep/TerraformSession"
  policy_arn = aws_iam_policy.terraform_s3_access.arn
}
