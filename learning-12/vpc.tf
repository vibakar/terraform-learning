resource "aws_vpc" "vpc" {
  cidr_block           = var.VPC_CIDR_BLOCK
  enable_dns_hostnames = true

  tags = { for k, v in var.TAGS : k => lower(v) }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.SUBNET_CIDR_BLOCK["${var.SUBNET_AVAILABILITY_ZONE}a"]
  availability_zone = "${var.SUBNET_AVAILABILITY_ZONE}a"

  tags = { for k, v in var.TAGS : k => lower(v) }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.SUBNET_CIDR_BLOCK["${var.SUBNET_AVAILABILITY_ZONE}b"]
  availability_zone = "${var.SUBNET_AVAILABILITY_ZONE}b"

  tags = { for k, v in var.TAGS : k => lower(v) }
}

resource "aws_subnet" "subnet3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.SUBNET_CIDR_BLOCK["${var.SUBNET_AVAILABILITY_ZONE}c"]
  availability_zone = "${var.SUBNET_AVAILABILITY_ZONE}c"

  tags = { for k, v in var.TAGS : k => lower(v) }
}

resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.vpc.id

  tags = { for k, v in var.TAGS : k => lower(v) }
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }

  tags = { for k, v in var.TAGS : k => lower(v) }
}

resource "aws_route_table_association" "example1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.example.id
}

resource "aws_route_table_association" "example2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.example.id
}

resource "aws_route_table_association" "example3" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.example.id
}

resource "aws_security_group" "example" {
  name        = "sg"
  description = "Security group for subnet"
  vpc_id      = aws_vpc.vpc.id

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

resource "aws_network_acl" "example" {
  vpc_id = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.NACL_RULES_INGRESS
    content {
      protocol   = ingress.value["protocol"]
      rule_no    = ingress.value["rule_no"]
      action     = ingress.value["action"]
      cidr_block = ingress.value["cidr_block"]
      from_port  = ingress.value["from_port"]
      to_port    = ingress.value["to_port"]
    }
  }

  dynamic "egress" {
    for_each = var.NACL_RULES_EGRESS
    content {
      protocol   = egress.value["protocol"]
      rule_no    = egress.value["rule_no"]
      action     = egress.value["action"]
      cidr_block = egress.value["cidr_block"]
      from_port  = egress.value["from_port"]
      to_port    = egress.value["to_port"]
    }
  }

  tags = { for k, v in var.TAGS : k => lower(v) }
}

resource "aws_network_acl_association" "example1" {
  network_acl_id = aws_network_acl.example.id
  subnet_id      = aws_subnet.subnet1.id
}

resource "aws_network_acl_association" "example2" {
  network_acl_id = aws_network_acl.example.id
  subnet_id      = aws_subnet.subnet2.id
}

resource "aws_network_acl_association" "example3" {
  network_acl_id = aws_network_acl.example.id
  subnet_id      = aws_subnet.subnet3.id
}