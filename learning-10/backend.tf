terraform {
  backend "s3" {
    bucket = "terraform-state-learning-001"
    key    = "learning-10/terraform.tfstate"
    region = "eu-west-2"
  }
}