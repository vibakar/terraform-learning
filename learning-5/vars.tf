variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "AWS_REGION" {
  default = "eu-west-2"
}

variable "KEY_PATH" {
  type = map(string)
  default = {
    public = "~/.ssh/id_rsa.pub"
    private = "~/.ssh/id_rsa"
  }
}

variable "AMIS" {
  type = map(string)
  default = {
    eu-west-2 = "ami-03e88be9ecff64781"
  }
}

variable "INSTANCE_TYPE" {
  type    = string
  default = "t2.micro"
}

variable "TAGS" {
  type = map(any)
  default = {
    "name" = "learning"
  }
}