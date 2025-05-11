# ✅ Create VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

# ✅ Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

# ✅ Create Subnet 1 in AZ "us-east-2a"
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
}

# ✅ Create Subnet 2 in AZ "us-east-2b"
resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true
}

# ✅ Update RDS Subnet Group to Include Both Subnets
resource "aws_db_subnet_group" "rds_subnet" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}


# ✅ Route Table for Public Subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.public_rt.id
}

# ✅ Security Group for RDS
resource "aws_security_group" "db_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ✅ Security Group for Redis
resource "aws_security_group" "redis_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# ✅ RDS Instance (MySQL)
resource "aws_db_instance" "rds" {
  allocated_storage      = 20
  engine                = "mysql"
  engine_version        = "8.0"
  instance_class        = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name  = "default.mysql8.0"
  publicly_accessible   = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name  = aws_db_subnet_group.rds_subnet.name
  skip_final_snapshot   = true
}

# ✅ ElastiCache Subnet Group
resource "aws_elasticache_subnet_group" "redis_subnet" {
  name       = "redis-subnet-group"
  subnet_ids = [aws_subnet.subnet1.id]
}

# ✅ ElastiCache Redis Cluster
resource "aws_elasticache_cluster" "redis" {
  cluster_id           = var.redis_cluster_id
  engine              = "redis"
  node_type           = "cache.t3.micro"
  num_cache_nodes     = 1
  parameter_group_name = "default.redis7"
  subnet_group_name   = aws_elasticache_subnet_group.redis_subnet.name
  security_group_ids  = [aws_security_group.redis_sg.id]
}
