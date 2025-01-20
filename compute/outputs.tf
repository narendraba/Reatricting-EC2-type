output "ec2_ids" {
  description       = "List of EC2 instance ID's "
  value             = aws_instance.ec2[*].id
}

output "ec2_public_ips" {
  description       = "List of EC2 instance ID's "
  value             = aws_instance.ec2[*].public_ip
}
