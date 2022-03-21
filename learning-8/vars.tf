variable "AWS_ACCESS_KEY" {
  type = string
}

variable "AWS_SECRET_KEY" {
  type = string
}

variable "AWS_REGION" {
  default = "eu-west-2"
}

variable "AMI" {
  type    = string
  default = "ami-03e88be9ecff64781"
}

variable "INSTANCE_TYPE" {
  type    = string
  default = "t2.micro"
}

variable "TAGS" {
  type = map(any)
  default = {
    name = "learning"
  }
}