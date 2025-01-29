provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "restricted_bucket_001" {
  bucket = "my-secure-bucket-001"

  tags = {
    Name        = "Restricted S3 Bucket"
    Environment = var.env
  }
}

resource "aws_s3_bucket_policy" "restricted_ip_policy" {
  bucket = aws_s3_bucket.restricted_bucket_001.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "IPRestrictPolicy",
    "Statement": [
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
                    "aws:SourceIp": [
                        "203.0.113.0/24",
                        "198.51.100.5",
                        "192.168.58.153"
                      ]
                }
            }
        }
    ]
}
POLICY
}
