data "aws_key_pair" "key" {
  filter {
    name   = "key-name"
    values = ["aws-key*"]
  }
  filter {
    name   = "tag:learning"
    values = ["data-source"]
  }
}

resource "aws_instance" "public" {
  ami           = var.AMI
  instance_type = var.INSTANCE_TYPE
  key_name      = data.aws_key_pair.key.key_name

  network_interface {
    network_interface_id = aws_network_interface.ni_public.id
    device_index         = 0
  }
}

resource "aws_network_interface" "ni_public" {
  subnet_id       = aws_subnet.public[0].id
  security_groups = [aws_default_security_group.sg.id]
}


resource "aws_instance" "private" {
  ami           = var.AMI
  instance_type = var.INSTANCE_TYPE
  key_name      = data.aws_key_pair.key.key_name

  network_interface {
    network_interface_id = aws_network_interface.ni_private.id
    device_index         = 0
  }
}

resource "aws_network_interface" "ni_private" {
  subnet_id       = aws_subnet.private[0].id
  security_groups = [aws_default_security_group.sg.id]
}