resource "aws_key_pair" "example" {
  key_name   = "mykey1"
  public_key = file(var.KEY_PATH["private"])

  tags = { for k, v in var.TAGS : k => lower(v) }
}

resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.INSTANCE_TYPE
  key_name      = aws_key_pair.example.key_name

  network_interface {
    network_interface_id = aws_network_interface.example.id
    device_index         = 0
  }

  tags = { for k, v in var.TAGS : k => lower(v) }
}

resource "aws_network_interface" "example" {
  subnet_id       = aws_subnet.example.id
  security_groups = [aws_default_security_group.example.id]

  tags = { for k, v in var.TAGS : k => lower(v) }
}

resource "aws_eip" "example" {
  instance = aws_instance.example.id
  vpc      = true

  tags = { for k, v in var.TAGS : k => lower(v) }
}

output "ip" {
  value = aws_eip.example.public_ip
}