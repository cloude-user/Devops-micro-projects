

# # Route Tables
# resource "aws_route_table" "public_route_table" {
#   vpc_id = aws_vpc.one_hundred.id
# }

# resource "aws_route_table" "private_route_table" {
#   vpc_id = aws_vpc.one_hundred.id
# }

# # Route table routes
# resource "aws_route" "public_internet_access" {
#   route_table_id         = aws_route_table.public_route_table.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.igw.id
# }

# resource "aws_route_table_association" "public_association" {
#   subnet_id      = aws_subnet.public_subnet.id
#   route_table_id = aws_route_table.public_route_table.id
# }


# resource "aws_route" "private_nat_access" {
#   route_table_id         = aws_route_table.private_route_table.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.nat.id
# }

# resource "aws_route_table_association" "private_assoc" {
#   subnet_id      = aws_subnet.private_subnet.id
#   route_table_id = aws_route_table.private_route_table.id
# }

