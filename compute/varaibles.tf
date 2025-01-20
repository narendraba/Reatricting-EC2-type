variable  "ami_id" {
  description   = "AMI ID for the ec2 instance"
  type          = string
}

variable  "instance_type" {
  description   = "instance type for the ec2 instance"
  type          = string
}

variable  "instance_count" {
  description   = "Number of ec2 instance to be launched"
  type          = string
}

variable  "instance_name" {
  description   = "Name of the ec2 instance"
  type          = string
}
