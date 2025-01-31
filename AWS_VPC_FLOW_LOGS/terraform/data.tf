data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = var.vpc_bucket_name
    key    = var.vpc_bucket_key
    region = var.vpc_region
  }
}