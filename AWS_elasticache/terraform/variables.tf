variable "aws_region" {
  default = "us-east-2"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "db_username" {
    default = "siuu"
}
variable "db_password" {
    default = "siuu@43"
}

variable "redis_cluster_id" {
  default = "redis-cluster"
}
