#key pair
resource "aws_key_pair" "ec2-key" {
    key_name = "${var.env}-${var.key_pair}"
    public_key = file("terra-ec2-key.pub")  
}
#security group
resource "aws_security_group" "ec2-sg" {
    name = "${var.env}-${var.security_group}"
    description = test 
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
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
         cidr_blocks = ["0.0.0.0/0"]
    }
  
}
#vpc
resource "aws_default_vpc" "ec2-vpc" {
  
}
#ec2
resource "aws_instance" "ec2" {
      for_each = tomap({
        "micro" = "t2.micro"
        "medium" = "t2.medium"
    })
    instance_type = each.value
    ami = var.ami
    key_name = aws_key_pair.ec2-key.key_name
    vpc_security_group_ids = [ aws_security_group.ec2-sg ]
    root_block_device {
      volume_size = var.volume_size
      volume_type = var.volume_type
    }
    tags = {
        Name = each.key
    }
  
}
