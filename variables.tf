variable "allowed_insytance_types" {
  default = {
    dev   = ["t2.micro", "t3.micro"]
    prod  = ["t2.small", "t3.small"]
    staging  = ["t2.medium", "t3.medium"]
  }
}

variable "aws_region" {
  default =  "ap-south-1a"
}

varaible "oidc_github_repositories" {
  description = "List of github repos allowed to assume this role"
  type = list (string)
  default = ["narendraba/Reatricting-EC2-type"]
}
