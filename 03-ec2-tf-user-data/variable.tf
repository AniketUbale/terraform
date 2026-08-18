variable "env" {
    type = string
    default = "dev"
  
}
variable "region" {
    type = string
    default = "ap-south-1"
}

variable "sg_name" {
    type = string
    default = "ec2-sg-03"
  
}
variable "key_name" {
    type = string
    default = "ec2-key"
  
}

variable "instance_type" {
    type = string
    default = "t3.micro"
  
}
variable "ami" {
    type = string
    default = "ami-01a00762f46d584a1"
  
}
variable "volume_size" {
    type = string
    default = "10"
  
}
variable "volume_type" {
    type = string
    default = "gp3"
  
}