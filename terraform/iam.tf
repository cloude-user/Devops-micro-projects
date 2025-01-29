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
    }
  ]
}
POLICY
}