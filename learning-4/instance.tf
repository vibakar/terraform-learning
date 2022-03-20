resource "aws_key_pair" "example" {
  key_name   = "mykey1"
  public_key = file(var.PRIVATE_KEY_PATH)
}

resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.INSTANCE_TYPE
  key_name      = aws_key_pair.example.key_name

  network_interface {
    network_interface_id = aws_network_interface.example.id
    device_index         = 0
  }
}

resource "aws_network_interface" "example" {
  subnet_id       = aws_subnet.example.id
  security_groups = [aws_security_group.example.id]
}

resource "aws_eip" "example" {
  instance = aws_instance.example.id
  vpc      = true
}

output "ec2_ip" {
  value = aws_eip.example.public_ip
}
