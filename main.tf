#provider
provider "aws" {
    region = var.aws_region
  
}
resource "local_file" "file"{
    filename = "file1.txt"
    content = "this is testing for local_in_tf"
}

resource "local_file" "multiple_file" {
    count = 2
    filename = "file${count.index + 1}.txt"
    content = "this is file${count.index + 1}"
  
}
resource "aws_s3_bucket" "bucket" {
    bucket = var.s3_bucket
  
}

##key 
resource "aws_key_pair" "key" {
    key_name = "tf-key"
    public_key = file("tf-key.pub")
  
}

### make ec2 instance
## vpc
resource "aws_default_vpc" "default" {
  
}
## security group
resource "aws_security_group" "sg" {
    name = "test-sg"
    description = "test"
    vpc_id = aws_default_vpc.default
    #inbound rule
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [aws_default_vpc.default]
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = [aws_default_vpc.default]
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
    }

  
}
## ec2
resource "aws_instance" "ec2" {
    #count = 2
    for_each = tomap({
        test-t2.micro-instance = "t2.micro"
        test-t3-series = "t3.medium"
    })
    depends_on = [ aws_security_group.sg , aws_key_pair.key] # depends_on decide the condition
    key_name = aws_key_pair.key.key_name
    ami = var.instance_ami
    instance_type = each.value
    security_groups = [aws_security_group.sg.name]
    root_block_device {
      volume_size =  var.env == "prod" ? 20 : var.ec2_volume_size
      volume_type = var.ec2_volume_type
    }
    tags = {
        name = each.key
    }
}