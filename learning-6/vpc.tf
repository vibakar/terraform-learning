resource "aws_default_vpc" "example" {
  tags = { for k, v in var.TAGS : k => lower(v) }
}

resource "aws_default_security_group" "example" {
  vpc_id = aws_default_vpc.example.id

  dynamic "ingress" {
    for_each = var.SG_RULES_INGRESS
    content {
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      cidr_blocks = split(",", ingress.value["cidr_blocks"])
      protocol    = ingress.value["protocol"]
    }
  }

  dynamic "egress" {
    for_each = var.SG_RULES_EGRESS
    content {
      from_port   = egress.value["from_port"]
      to_port     = egress.value["to_port"]
      cidr_blocks = split(",", egress.value["cidr_blocks"])
      protocol    = egress.value["protocol"]
    }
  }
  
  tags = { for k, v in var.TAGS : k => lower(v) }
}