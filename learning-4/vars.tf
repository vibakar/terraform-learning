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

variable "VPC_CIDR_BLOCK" {
  type    = string
  default = "10.0.0.0/16"
}

variable "SUBNET_CIDR_BLOCK" {
  type    = string
  default = "10.0.1.0/24"
}

variable "SUBNET_AVAILABILITY_ZONE" {
  type    = string
  default = "eu-west-2a"
}

variable "SG_RULES_INGRESS" {
  type = list(object({
    from_port   = number,
    to_port     = number,
    cidr_blocks = string,
    protocol    = string,
    description = string
  }))
  default = [
    {
      from_port   = 22
      to_port     = 22
      cidr_blocks = "0.0.0.0/0"
      protocol    = "TCP"
      description = "Allow SSH"
    },
    {
      from_port   = 80
      to_port     = 80
      cidr_blocks = "0.0.0.0/0"
      protocol    = "TCP"
      description = "Allow port 80"
    },
    {
      from_port   = 443
      to_port     = 443
      cidr_blocks = "0.0.0.0/0"
      protocol    = "TCP"
      description = "Allow port 443"
    }
  ]
}

variable "SG_RULES_EGRESS" {
  type = list(object({
    from_port   = number,
    to_port     = number,
    cidr_blocks = string,
    protocol    = string,
    description = string
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      cidr_blocks = "0.0.0.0/0"
      protocol    = "-1"
      description = "Allow All Traffic"
    }
  ]
}

variable "NACL_RULES_INGRESS" {
  type = list(object({
    protocol   = number
    rule_no    = number
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
  default = [
    {
      protocol   = -1
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
    }
  ]
}

variable "NACL_RULES_EGRESS" {
  type = list(object({
    protocol   = number
    rule_no    = number
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
  default = [
    {
      protocol   = -1
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
    }
  ]
}


variable "TAGS" {
  type = map(any)
  default = {
    "name" = "learning"
  }
}
