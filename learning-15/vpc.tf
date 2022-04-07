resource "aws_vpc" "eks_vpc" {
  cidr_block = var.VPC_CIDR_BLOCK
  enable_dns_hostnames = true
}

data "aws_availability_zones" "az" {
}

resource "aws_subnet" "eks_subnet_public" {
  count                   = length(data.aws_availability_zones.az.names)
  cidr_block              = cidrsubnet(aws_vpc.eks_vpc.cidr_block, 8, count.index)
  availability_zone       = data.aws_availability_zones.az.names[count.index]
  vpc_id                  = aws_vpc.eks_vpc.id
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id
}

resource "aws_route" "eks_internet_access" {
  route_table_id         = aws_vpc.eks_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.eks_igw.id
}

resource "aws_default_security_group" "eks_sg" {
  vpc_id = aws_vpc.eks_vpc.id

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
}
