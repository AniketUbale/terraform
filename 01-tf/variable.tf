variable "env" {
  type    = string
  default = "dev"

}
variable "region" {
  type    = string
  default = "ap-south-1"

}
variable "aws_key_pair" {
  type    = string
  default = "ec2-key"
}

variable "aws_ami" {
  type    = string
  default = "asb15337ahs"

}
variable "volume_type" {
  type    = string
  default = "gp3"

}
