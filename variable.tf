variable "aws_region" {
    type = string
    default = "ap-south-1"
  
}
variable "instance_type" {
    type = string
    default = "t3.micro"  
}
variable "instance_ami" {
    type = string
    default = "ajs142733"
  
}
variable "ec2_volume_size" {
    default = 8
    type = string
  
}
variable "ec2_volume_type" {
    default = "gp3"
    type = string
  
}
variable "s3_bucket" {
    type = string
    default = "s3-test-bucket"
  
}
#vpc cidr
variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
  
}
variable "env" {
    default = "dev"
    type = string
  
}