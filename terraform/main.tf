# Launch an EC2 instance
resource "aws_instance" "ec2_instance" {
  ami           = var.ec2_ami # Replace with a valid AMI ID
  instance_type = "t2.micro"

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "STS-enabled-instance"
  }
}
