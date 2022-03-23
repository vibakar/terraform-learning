data "aws_key_pair" "example" {
  filter {
    name   = "key-name"
    values = ["aws-key*"]
  }
  filter {
    name   = "tag:learning"
    values = ["data-source"]
  }
}

resource "aws_instance" "example" {
  ami             = var.AMI
  instance_type   = var.INSTANCE_TYPE
  key_name        = data.aws_key_pair.example.key_name
  subnet_id       = aws_subnet.example.id
  security_groups = [aws_security_group.example.id]
  user_data       = data.cloudinit_config.cloudinit-example.rendered

  tags = { for k, v in var.TAGS : k => lower(v) }
}

resource "aws_eip" "example" {
  instance = aws_instance.example.id
  vpc      = true

  tags = { for k, v in var.TAGS : k => lower(v) }
}
