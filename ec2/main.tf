resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_range
}

resource "aws_subnet" "subnet_ec2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.availability_zone
  tags = {
    Name = "subnet_ec2"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "mytftestbucket300825"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "my_instance_key"
  public_key = tls_private_key.ec2_key.public_key_openssh
}

resource "aws_security_group" "sg_ec2" {
  name        = "sg_ec2"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sg_ec2"
  }
}


resource "aws_instance" "ec2_instance" {
  ami           = "ami-0360c520857e3138f"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.sg_ec2.id]
  associate_public_ip_address = true
  availability_zone = "us-east-1a" 
  subnet_id = aws_subnet.subnet_ec2.id
  key_name = aws_key_pair.ec2_key.key_name
  tags = {
    name = "ec2_instance"
  }
}