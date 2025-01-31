provider "aws" {
  region = var.region
}

resource "aws_vpc" "one_hundred" {
  cidr_block = var.vpc_cidr_block

}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.one_hundred.id
  cidr_block = var.public_subnet_cidr_block
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.one_hundred.id
  cidr_block = var.private_subnet_cidr_block
}