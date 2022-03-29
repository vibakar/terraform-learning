resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}

data "aws_availability_zones" "az" {
}

resource "aws_subnet" "public" {
  count                   = length(data.aws_availability_zones.az.names)
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index)
  availability_zone       = data.aws_availability_zones.az.names[count.index]
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  count             = length(data.aws_availability_zones.az.names)
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, length(data.aws_availability_zones.az.names) + count.index)
  availability_zone = data.aws_availability_zones.az.names[count.index]
  vpc_id            = aws_vpc.vpc.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_eip" "ip" {
  count = length(data.aws_availability_zones.az.names)
  vpc   = true
}

resource "aws_nat_gateway" "natgw" {
  count         = length(data.aws_availability_zones.az.names)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  allocation_id = element(aws_eip.ip.*.id, count.index)
}

resource "aws_route_table" "private_route_table" {
  count  = length(data.aws_availability_zones.az.names)
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = element(aws_nat_gateway.natgw.*.id, count.index)
  }
}

resource "aws_route_table_association" "private" {
  count          = length(data.aws_availability_zones.az.names)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
}

output "availability_zones" {
  value = data.aws_availability_zones.az.names
}

output "az_length" {
  value = length(data.aws_availability_zones.az.names)
}