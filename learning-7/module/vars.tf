variable "AWS_ACCESS_KEY" {
  type = string
}

variable "AWS_SECRET_KEY" {
  type = string
}

variable "AWS_REGION" {
  type = string
  default = "eu-west-2"
  description = "Region to deploy the resources"
}

variable "AMI" {
  type = string
  description = "AMI to use for creating ec2 instance. Key should be region name and value should be ami id."
}

variable "INSTANCE_TYPE" {
  type = string
  default = "t2.micro"
  description = "Instance type to use for creating ec2 instance"
}

variable "SG_RULES_INGRESS" {
  type = list(object({
    from_port   = number,
    to_port     = number,
    cidr_blocks = string,
    protocol    = string,
    description = string
  }))
  description = "Ingress rules to set for the Security group"
}

variable "SG_RULES_EGRESS" {
  type = list(object({
    from_port   = number,
    to_port     = number,
    cidr_blocks = string,
    protocol    = string,
    description = string
  }))
  description = "Ingress rules to set for the Security group"
}

variable "TAGS" {
  type = map
  description = "Tags to set for the resources"
}