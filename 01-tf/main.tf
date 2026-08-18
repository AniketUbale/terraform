provider "aws" {
  region = var.region

}

#VPC
resource "aws_default_vpc" "vpc" {

}

#key pair
resource "aws_key_pair" "ec2-key" {
  key_name   = "${var.env}-${var.aws_key_pair}"
  public_key = file("test-key.pub")

}

#aws security group
resource "aws_security_group" "sg" {
  name        = "${var.env}-sg"
  description = "test-sg"
  vpc_id      = aws_default_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "ssh"
    cidr_blocks = [aws_default_vpc.vpc]
  }
  ingress {
    from_port   = 8080
    to_port     = 80080
    protocol    = "tcp"
    cidr_blocks = [aws_default_vpc.vpc]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
  }

}

# ec2 instance
resource "aws_instance" "ec2" {
  count           = 1
  key_name        = aws_key_pair.ec2-key.key_name
  security_groups = [aws_security_group.sg.name]
  instance_type = "t3.micro"
  ami             = var.aws_ami
  root_block_device {
    volume_size = var.env == "prod" ? 20 : 10
    volume_type = var.volume_type
  }
  tags = {
    name = "${var.env}-infra-ec2"
    env  = var.env
  }
}