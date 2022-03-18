resource "aws_key_pair" "key" {
  key_name   = "mykey1"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "ec2" {
  ami           = "ami-03e88be9ecff64781"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key.key_name

  network_interface {
    network_interface_id = aws_network_interface.network_interface.id
    device_index         = 0
  }
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_network_interface" "network_interface" {
  subnet_id       = aws_subnet.subnet.id
  security_groups = [aws_security_group.security_group.id]
}

resource "aws_security_group" "security_group" {
  name        = "sg"
  description = "Security group for subnet"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "ip" {
  instance = aws_instance.ec2.id
  vpc      = true
}

output "ec2_ip" {
  value = aws_eip.ip.address
}
