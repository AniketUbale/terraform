#VPC
resource "aws_default_vpc" "vpc" {
  
}

#SECURITY GROUP
resource "aws_security_group" "sg-ec2" {
    name = var.sg_name
    description = "test"
    vpc_id = aws_default_vpc.vpc.id
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
#KEY PAIR
resource "aws_key_pair" "ec2-key" {
    key_name = "${var.env}-${var.key_name}"
    public_key = file("terra-ec2-key.pub")
  
}

#EC2
resource "aws_instance" "ec2" {
    for_each = tomap({
        "micro" = "t2.micro"
        "medium" = "t2.medium"
    })
    instance_type = each.value
    key_name = aws_key_pair.ec2-key.key_name
    ami = var.ami
    vpc_security_group_ids = [ aws_security_group.sg-ec2.id]
    user_data = file("install.sh")
    root_block_device {
      volume_size = var.volume_size
      volume_type = var.volume_type
    }
    tags = {
        Name = each.key
    }
}