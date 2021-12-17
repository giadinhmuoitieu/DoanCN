//VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.cird_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.name}-VPC"
  }
}


//Public Subnet
resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cird_public
  availability_zone       = var.azone_public
  map_public_ip_on_launch = true
  depends_on = [
    aws_vpc.vpc
  ]

  tags = {
    Name = "${var.name}-Public Subnet "
  }
}
//Private Subnet
resource "aws_subnet" "private-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cird_private
  availability_zone       = var.azone_private
    depends_on = [
    aws_vpc.vpc,
    aws_subnet.public-subnet
  ]

  tags = {
    Name = "${var.name}-Private Subnet "
  }
}
//inter nat gate way
resource "aws_eip" "nat_eip" {
  vpc        = true
  tags = {
    Name = "NAT Gateway EIP"
  }
}
resource "aws_nat_gateway" "nat_gateway" {

  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Name = "NAT Gateway"
  }
}

resource "aws_internet_gateway" "internet_gateway" {

  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.name}-IGW"
  }
}
#Route Table Public
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.name}-Public Route Table"
  }
}
#Route Table Private
resource "aws_route_table" "private_route_table" {
depends_on = [
 aws_nat_gateway.nat_gateway,
]
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id =   aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "${var.name}-Private Route Table"
  }
}

#Public association
resource "aws_route_table_association" "public_association" {
  depends_on = [
    aws_route_table.public_route_table,
  ]
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public_route_table.id
}



//sg ssh http https
resource "aws_security_group" "awsgrp1" {
  name        = "awsgrp1"
  description = "allow http,ssh,https wordpress"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 80
    protocol    = "TCP"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow internet"
  }
}


resource "aws_security_group" "awsgrp2" { 
  name        = "Database"
  description = "Database"
  vpc_id      = aws_vpc.vpc.id
   
  ingress {
    from_port   = 3306
    protocol    = "TCP"
    to_port     = 3306
   security_groups = [aws_security_group.awsgrp1.id]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "SQL"
  }
}

resource "aws_security_group" "awsgrp3" {
  name        = "allow ssh"
  description = "allow ssh"
  vpc_id = aws_vpc.vpc.id
  
  ingress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
   cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow ssh"
  }
}

resource "aws_security_group" "awsgrp4" {
  name        = "ssh bastion only"
  description = "ssh bastion only"
  vpc_id = aws_vpc.vpc.id


  ingress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
   security_groups = [aws_security_group.awsgrp3.id]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ssh bastion only"
  }
}
