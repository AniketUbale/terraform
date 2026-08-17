#region 
variable "region" {
    type = string
    default = "ap-south-1"
  
}
variable "env" {
    type = string
    default = "dev"
  
}
variable "key_name" {
    type = string
    default = "terra-ec2-key"
  
}
variable "security_group_name" {
    type = string
    default = "ec2-sg"
  
}
variable "instance_type" {
    type = string
    default = "t3.micro"
  
}
variable "ami" {
    type = string
    default = "ami-01a00762f46d584a1"
}
variable "volume_type" {
    type = string
    default = "gp3"
  
}


