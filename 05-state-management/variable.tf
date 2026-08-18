variable "env" {
    type = string
    default = "prod"
  
}
variable "key_pair" {
    type = string
    default = "ec2-key"
  
}

variable "security_group" {
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
variable "volume_size" {
    type = string
    default = "9"
  
}
variable "volume_type" {
    type = string
    default = "gp3"
  
}