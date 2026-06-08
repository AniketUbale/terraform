output "file_content"{
    value = local_file.multiple_file[*].content

}
output "instance_type" {
    value = aws_instance.ec2.instance_type
  
}
output "private_ip" {
    value = aws_instance.ec2.private_ip
  
}
output "ec2_dns" {
    value = aws_instance.ec2.public_dns
  
}

#output for for each
output "e2-ip" {
    value = [
        for instance in aws_aws_instance.ec2 : instance.public_ip
    ]

  
}
