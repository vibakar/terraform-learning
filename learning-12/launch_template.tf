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

resource "aws_launch_template" "bookstore_frontend" {
  name          = "bookstore_frontend"
  image_id      = var.AMI
  instance_type = var.INSTANCE_TYPE
  key_name      = data.aws_key_pair.example.key_name
  user_data     = base64encode(data.cloudinit_config.frontend.rendered)
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = [aws_security_group.example.id]
  }

  tags = { for k, v in var.TAGS : k => lower(v) }
}

resource "aws_launch_template" "bookstore_backend" {
  name          = "bookstore_backend"
  image_id      = var.AMI
  instance_type = var.INSTANCE_TYPE
  key_name      = data.aws_key_pair.example.key_name
  user_data     = base64encode(data.cloudinit_config.backend.rendered)
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = [aws_security_group.example.id]
  }

  tags = { for k, v in var.TAGS : k => lower(v) }
}