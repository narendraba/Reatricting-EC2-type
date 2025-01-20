provider "aws" {
  region     = var.aws_region
}

module "compute" {
  source = "./compute"
  ami               =  "ami-053b12d3152c0cc71"
  instance_type     =   var.allowed_instance_types[terraform.workspace][0]
  instance_count    =   1
  instance_name     =   "EC2-${terraform.workspace}"
  
}
