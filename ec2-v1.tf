provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "myinstance01" {
  ami           = "ami-079db87dc4c10ac91"
  instance_type = "t2.micro"
  key_name = "old-lap"
  security_groups = ["allow_ssh"]
  tags = {
    Name = "HelloWorld"
  }
}
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh"
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
