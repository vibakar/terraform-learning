resource "aws_ebs_volume" "example" {
  availability_zone = var.SUBNET_AVAILABILITY_ZONE
  size              = 1
  type              = "gp2"

  tags = { for k, v in var.TAGS : k => lower(v) }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name  = var.INSTANCE_DEVICE_NAME
  volume_id    = aws_ebs_volume.example.id
  instance_id  = aws_instance.example.id
  skip_destroy = true
}
