#vpc
resource "aws_default_vpc" "vpc" {
}
#key pair
resource "aws_key_pair" "ec2-key" {
    key_name = var.key_name
    public_key = file("terra-ec2-key.pub")

}
#security group
resource "aws_security_group" "ec2-sg" {
    name = "${var.env}-${var.security_group_name}"
    description = "test-ec2"
    vpc_id = aws_default_vpc.vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
    ingress {
        from_port = 8080
        to_port = 8080
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
#ec2
resource "aws_instance" "ec2" {
    count = 1
    instance_type = var.instance_type
    key_name = aws_key_pair.ec2-key.key_name
    ami = var.ami
    vpc_security_group_ids = [aws_security_group.ec2-sg.id]
    root_block_device {
      volume_size = var.env == "prod" ? 20 : 10 
      volume_type = var.volume_type
    }
    tags = {
        Name = "${var.env}-infra-ec2"
        env = var.env
    }
}
