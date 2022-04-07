variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "AWS_REGION" {
  default = "eu-west-2"
}

variable "VPC_CIDR_BLOCK" {
  type    = string
  default = "10.0.0.0/16"
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

variable "CLUSTER_NAME" {
  type    = string
  default = "learning_cluster"
}