terraform {
  backend "s3" {
    bucket         = "playback-git-terraform"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "my-table"
  }
}
