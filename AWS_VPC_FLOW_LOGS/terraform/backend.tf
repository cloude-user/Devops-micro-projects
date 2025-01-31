terraform{
    backend "s3" {
    bucket         = "sundeep43-cloud-terraform43" 
    key            = "one-hundred/vpc-flow-logs/terraform.tfstate"
    region         = "us-east-2"                
    encrypt        = true                      
  }
}