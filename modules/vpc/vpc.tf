resource "aws_vpc" "haha_iac_vpc" {
  cidr_block = "10.100.0.0/16"
  tags = {
    Name = "${var.project}-vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.haha_iac_vpc.id
  cidr_block              = "10.100.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}a"
  tags = {
    Name = "${var.project}-public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.haha_iac_vpc.id
  cidr_block              = "10.100.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}c"
  tags = {
    Name = "${var.project}-public-subnet-2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.haha_iac_vpc.id
  cidr_block              = "10.100.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "${var.aws_region}a"
  tags = {
    Name = "${var.project}-private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.haha_iac_vpc.id
  cidr_block              = "10.100.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "${var.aws_region}c"
  tags = {
    Name = "${var.project}-private-subnet-2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.haha_iac_vpc.id
  tags = {
    Name = "${var.project}-igw"
  }
}






