# # Internet gateway
# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.one_hundred.id
# }

# # EIP
# resource "aws_eip" "nat_eip" {}

# # NAT gateway
# resource "aws_nat_gateway" "nat" {
#   allocation_id = aws_eip.nat_eip.id
#   subnet_id     = aws_subnet.public_subnet.id
# }

