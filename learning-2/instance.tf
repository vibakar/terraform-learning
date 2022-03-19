resource "aws_key_pair" "example" {
  key_name   = "mykey1"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "example" {
  ami           = "ami-03e88be9ecff64781"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.example.key_name

  network_interface {
    network_interface_id = aws_network_interface.example.id
    device_index         = 0
  }
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "example" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"
}

resource "aws_default_route_table" "example" {
  default_route_table_id = aws_vpc.example.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }
}

resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id
}

resource "aws_route_table_association" "example" {
  subnet_id      = aws_subnet.example.id
  route_table_id = aws_default_route_table.example.id
}

resource "aws_default_network_acl" "example" {
  default_network_acl_id = aws_vpc.example.default_network_acl_id

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}

resource "aws_default_security_group" "example" {
  vpc_id = aws_vpc.example.id

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

resource "aws_network_interface" "example" {
  subnet_id       = aws_subnet.example.id
  security_groups = [aws_default_security_group.example.id]
}

resource "aws_eip" "example" {
  instance = aws_instance.example.id
  vpc      = true
}

output "ip" {
  value = aws_eip.example.public_ip
}