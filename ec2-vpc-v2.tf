provider "aws" {
  region = "us-east-1"
}
resource "aws_vpc" "str-vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    "Name" = "str-vpc"
  }
}
resource "aws_subnet" "stc-subnet_01" {
  vpc_id     = aws_vpc.str-vpc.id
  cidr_block = "10.1.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "stc-subnet_01"
  }
}

resource "aws_subnet" "stc-subnet_02" {
  vpc_id     = aws_vpc.str-vpc.id
  cidr_block = "10.1.1.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "stc-subnet_02"
  }
}

resource "aws_internet_gateway" "str-igw" {
  vpc_id = aws_vpc.str-vpc.id

  tags = {
    Name = "str-igw"
  }
}

resource "aws_route_table" "str-route" {
  vpc_id = aws_vpc.str-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.str-igw.id
  }

  tags = {
    Name = "str-route"
  }
}
resource "aws_route_table_association" "str-route-association_1" {
  route_table_id = aws_route_table.str-route.id
  subnet_id = aws_subnet.stc-subnet_01.id
}
resource "aws_route_table_association" "str-route-association_2" {
  route_table_id = aws_route_table.str-route.id
  subnet_id = aws_subnet.stc-subnet_02.id
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh"
  vpc_id = aws_vpc.str-vpc.id
  ingress {
    description      = "allow ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_instance" "myinstance01" {
  ami           = "ami-079db87dc4c10ac91"
  subnet_id = aws_subnet.stc-subnet_01.id
  instance_type = "t2.micro"
  key_name = "old-lap"
  vpc_security_group_ids = [ aws_security_group.allow_ssh.id ]
  tags = {
    Name = "HelloWorld"
  }
}

